<#
.SYNOPSIS
    Mengubah dokumen Word materi (.docx) menjadi file data Dart untuk aplikasi
    Sahabat Pancasila.

.DESCRIPTION
    Skrip ini membaca paragraf dari dokumen .docx, mengelompokkannya menjadi bab
    materi (baris yang diawali "MATERI n: JUDUL") beserta blok isinya (heading,
    paragraph, bullet, numberedItem), lalu menuliskannya ke
    lib/data/materi_kelas<Kelas>.dart.

    Untuk menambah materi kelas 8 atau kelas 9:
      1. Siapkan dokumen materi dengan format judul bab "MATERI 1: JUDUL".
      2. Jalankan skrip ini dengan -Kelas 8 atau -Kelas 9.
      3. Daftar materi di lib/data/materi_kelas8.dart akan otomatis terisi.

.EXAMPLE
    powershell -ExecutionPolicy Bypass -File tools/generate_materi_dart.ps1 `
        -DocxPath "D:/Download/Kelas VII.docx" -Kelas 7
#>
param(
    [Parameter(Mandatory = $true)][string]$DocxPath,
    [Parameter(Mandatory = $true)][int]$Kelas,
    [string]$OutPath
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

if (-not (Test-Path $DocxPath)) { throw "Dokumen tidak ditemukan: $DocxPath" }
if ([string]::IsNullOrWhiteSpace($OutPath)) {
    $repoRoot = Split-Path -Parent $PSScriptRoot
    $OutPath = Join-Path $repoRoot "lib/data/materi_kelas$Kelas.dart"
}

function ConvertTo-DartString([string]$value) {
    $escaped = $value -replace '\\', '\\'
    $escaped = $escaped -replace "'", "\'"
    $escaped = $escaped -replace '\$', '\$'
    $escaped = $escaped -replace '[\x00-\x1F]', ' '
    return $escaped
}

# Mengembalikan singkatan yang rusak akibat konversi Title Case
# (contoh: "Uud" kembali menjadi "UUD").
function Restore-Acronyms([string]$title) {
    $map = [ordered]@{
        'Uud'   = 'UUD'
        'Bpupk' = 'BPUPK'
        'Ppki'  = 'PPKI'
        'Uu'    = 'UU'
        'Dpr'   = 'DPR'
        'Mpr'   = 'MPR'
        'Nkri'  = 'NKRI'
        'Sara'  = 'SARA'
    }
    $result = $title
    foreach ($key in $map.Keys) {
        $result = $result -creplace "\b$([regex]::Escape($key))\b", $map[$key]
    }
    return $result
}

# --- 1. Baca word/document.xml dari dalam file .docx (format zip) ---
Add-Type -AssemblyName System.IO.Compression.FileSystem
$zip = [System.IO.Compression.ZipFile]::OpenRead($DocxPath)
try {
    $entry = $zip.Entries | Where-Object { $_.FullName -eq 'word/document.xml' }
    if ($null -eq $entry) { throw "File word/document.xml tidak ada di dalam dokumen." }
    $reader = New-Object System.IO.StreamReader($entry.Open())
    $xml = $reader.ReadToEnd()
    $reader.Close()
}
finally {
    $zip.Dispose()
}

$paragraphs = [regex]::Matches($xml, '<w:p[ >].*?</w:p>')
$sections = New-Object System.Collections.Generic.List[object]
$current = $null
$pendingSummary = $false

foreach ($paragraph in $paragraphs) {
    $xmlParagraph = $paragraph.Value
    $texts = [regex]::Matches($xmlParagraph, '<w:t(?: [^>]*)?>(.*?)</w:t>')
    $text = ''
    foreach ($match in $texts) { $text += $match.Groups[1].Value }
    $text = $text -replace '&amp;', '&' -replace '&lt;', '<' -replace '&gt;', '>' -replace '&quot;', '"' -replace '&apos;', "'"
    $text = ($text -replace "`t", ' ').Trim()
    if ($text.Length -eq 0) { continue }

    $isListNumbered = $xmlParagraph -match '<w:numPr>'
    $boldRuns = ([regex]::Matches($xmlParagraph, '<w:b[/ ]')).Count

    $titleMatch = [regex]::Match($text, '^MATERI\s+(\d+)\s*:\s*(.+)$')
    if ($titleMatch.Success) {
        if ($null -ne $current) { $sections.Add($current) }
        $number = [int]$titleMatch.Groups[1].Value
        $title = (Get-Culture).TextInfo.ToTitleCase($titleMatch.Groups[2].Value.ToLower())
        $current = [ordered]@{
            number  = $number
            title   = $title
            summary = ''
            blocks  = New-Object System.Collections.Generic.List[object]
        }
        $pendingSummary = $true
        continue
    }

    if ($null -eq $current) { continue } # baris judul dokumen (contoh "KELAS VII")

    $text = $text -replace '\s+', ' '
    if ($isListNumbered) {
        # Bulet/daftar dari Word. Judul pendek yang diakhiri ":" dianggap sub-bab.
        $type = if ($text.Length -le 40 -and $text.EndsWith(':')) { 'heading' } else { 'bullet' }
    }
    elseif ($boldRuns -gt 0) {
        $type = 'heading'
    }
    elseif ($text -match '^\d+\.\s') {
        $type = 'numberedItem'
    }
    else {
        $type = 'paragraph'
    }

    if ($pendingSummary -and $type -eq 'paragraph') {
        $current.summary = $text
        $pendingSummary = $false
        continue
    }
    $pendingSummary = $false
    $current.blocks.Add([pscustomobject]@{ type = $type; text = $text })
}
if ($null -ne $current) { $sections.Add($current) }

if ($sections.Count -eq 0) {
    throw "Tidak ada bab materi yang terbaca. Pastikan judul bab memakai format 'MATERI 1: JUDUL'."
}

# Nomor bab mengikuti urutan dokumen sehingga nomor ganda di dokumen sumber
# (mis. dua "MATERI 4") otomatis diperbaiki dan id unik.
for ($index = 0; $index -lt $sections.Count; $index++) {
    $sections[$index].number = $index + 1
    $sections[$index].title = Restore-Acronyms $sections[$index].title
}

foreach ($section in $sections) {
    $counts = $section.blocks | Group-Object type | ForEach-Object { "$($_.Name)=$($_.Count)" }
    Write-Host "[$($section.number)] $($section.title) | $($counts -join ', ')"
}

# --- 3. Tulis file Dart ---
$builder = New-Object System.Text.StringBuilder
[void]$builder.AppendLine("// File ini di-generate otomatis dari dokumen sumber materi kelas $Kelas.")
[void]$builder.AppendLine('// Jangan diubah manual: sunting dokumen sumber lalu jalankan ulang')
[void]$builder.AppendLine('// tools/generate_materi_dart.ps1 agar format tetap konsisten.')
[void]$builder.AppendLine('')
[void]$builder.AppendLine("import '../models/materi_content.dart';")
[void]$builder.AppendLine('')
[void]$builder.AppendLine("/// Materi PPKn SMP Kelas $Kelas.")
[void]$builder.AppendLine("const List<MateriSection> materiKelas$Kelas = <MateriSection>[")

foreach ($section in $sections) {
    [void]$builder.AppendLine('  MateriSection(')
    [void]$builder.AppendLine("    id: 'kelas$Kelas-materi-$($section.number)',")
    [void]$builder.AppendLine("    number: $($section.number),")
    [void]$builder.AppendLine("    title: '$(ConvertTo-DartString $section.title)',")
    [void]$builder.AppendLine("    summary: '$(ConvertTo-DartString $section.summary)',")
    [void]$builder.AppendLine('    blocks: <MateriBlock>[')
    foreach ($block in $section.blocks) {
        [void]$builder.AppendLine("      MateriBlock(MateriBlockType.$($block.type), '$(ConvertTo-DartString $block.text)'),")
    }
    [void]$builder.AppendLine('    ],')
    [void]$builder.AppendLine('  ),')
}
[void]$builder.AppendLine('];')

$directory = Split-Path -Parent $OutPath
if (-not (Test-Path $directory)) { New-Item -ItemType Directory -Force -Path $directory | Out-Null }
[System.IO.File]::WriteAllText($OutPath, $builder.ToString(), (New-Object System.Text.UTF8Encoding($false)))
Write-Host "Selesai menulis: $OutPath"
