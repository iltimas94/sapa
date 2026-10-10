<#
.SYNOPSIS
    Build APK release yang tahan terhadap gangguan Google Drive for Desktop.

.DESCRIPTION
    Di Windows, Google Drive for Desktop (GoogleDriveFS.exe) menyuntikkan file
    desktop.ini ke folder di dalam Documents. Folder yang berisi desktop.ini
    otomatis diberi atribut ReadOnly oleh Windows, sehingga task Gradle
    ':app:packageRelease' gagal dengan AccessDeniedException saat menghapus
    folder output lama (build\app\outputs\apk\release\baselineProfiles\0).

    Skrip ini membersihkan atribut ReadOnly dan file desktop.ini terlebih
    dahulu, lalu menjalankan build. Bila build tetap gagal karena kotoran yang
    dibuat ulang di tengah jalan, skrip membersihkan ulang dan mencoba
    sekali lagi.

    Solusi permanen (pilih salah satu):
      1. Pindahkan repo ke luar folder Documents, mis. C:\dev\sapa
      2. Matikan backup Documents di Google Drive for Desktop:
         Settings/Preferences -> "Back up to Google Drive" -> batalkan
         centang Desktop & Documents.

.EXAMPLE
    powershell -ExecutionPolicy Bypass -File tools/build_apk.ps1
#>
param(
    [ValidateSet('release', 'debug')]
    [string]$Mode = 'release',

    [string]$FlutterBat = 'D:\Android\flutter_windows_3.32.7-stable\flutter\bin\flutter.bat'
)

$ErrorActionPreference = 'Stop'
$repoRoot = Split-Path -Parent $PSScriptRoot

function Clear-GoogleDriveJunk {
    # 1. Lepas atribut ReadOnly dari seluruh file & folder (kecuali .git).
    #    Atribut inilah yang membuat Gradle gagal menghapus folder output.
    $attribResult = & attrib -r "$repoRoot\*.*" /s /d 2>&1 |
        Where-Object { $_ -notmatch 'Not resetting hidden file' }
    if ($attribResult) { $attribResult | Select-Object -First 5 }

    # 2. Hapus desktop.ini buatan Google Drive, TETAPI jangan sentuh file yang
    #    sudah ter-track git (mis. android/desktop.ini) agar repo tidak berubah.
    $tracked = @{}
    $lsFiles = git -C $repoRoot ls-files 2>$null
    if ($LASTEXITCODE -eq 0) {
        foreach ($line in @($lsFiles)) { $tracked[$line] = $true }
    }

    $deleted = 0
    Get-ChildItem -Path $repoRoot -Recurse -Force -Filter 'desktop.ini' -ErrorAction SilentlyContinue |
        ForEach-Object {
            $relative = $_.FullName.Substring($repoRoot.Length).TrimStart('\') -replace '\\', '/'
            if ($tracked.ContainsKey($relative)) {
                Write-Host "  Lewati (ter-track git): $relative"
                return
            }
            try {
                Remove-Item -LiteralPath $_.FullName -Force -ErrorAction Stop
                $deleted++
            } catch {
                Write-Warning "Tidak bisa menghapus $($_.FullName): $($_.Exception.Message)"
            }
        }
    Write-Host "Bersih-bersih selesai: $deleted file desktop.ini dihapus, atribut ReadOnly dilepas."
}

Write-Host "=== Persiapan build APK ($Mode) ===" -ForegroundColor Cyan
Clear-GoogleDriveJunk

$maxAttempt = 2
for ($attempt = 1; $attempt -le $maxAttempt; $attempt++) {
    Write-Host "--- Percobaan ${attempt}/${maxAttempt} - flutter build apk --$Mode ---" -ForegroundColor Cyan
    & $FlutterBat build apk "--$Mode" --no-color
    if ($LASTEXITCODE -eq 0) {
        $apk = Get-ChildItem -Path (Join-Path $repoRoot 'build\app\outputs') -Recurse -Filter 'app-*.apk' |
            Sort-Object LastWriteTime -Descending | Select-Object -First 1
        if ($apk) {
            Write-Host "BUILD SUKSES: $($apk.FullName) ($([math]::Round($apk.Length/1MB,1)) MB)" -ForegroundColor Green
        }
        exit 0
    }

    Write-Warning "Build gagal (kode $LASTEXITCODE). Membersihkan ulang sebelum percobaan berikutnya..."
    Clear-GoogleDriveJunk
}

Write-Error 'Build tetap gagal setelah 2 percobaan. Cek keluaran Gradle di atas.'
exit 1
