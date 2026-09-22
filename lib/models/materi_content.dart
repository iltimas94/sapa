/// Jenis konten di dalam sebuah materi.
enum MateriBlockType {
  /// Judul sub-bab, contoh: "Latar Belakang Perumusan (Masa BPUPK)".
  heading,

  /// Paragraf penjelasan.
  paragraph,

  /// Poin/butir dengan tanda bulat.
  bullet,

  /// Poin bernomor (teks sudah memuat nomornya, contoh: "1. Kondisi ...").
  numberedItem,
}

/// Satu blok konten materi.
class MateriBlock {
  const MateriBlock(this.type, this.text);

  final MateriBlockType type;
  final String text;
}

/// Satu bab materi (contoh: MATERI 1 - Sejarah Kelahiran Pancasila).
class MateriSection {
  const MateriSection({
    required this.id,
    required this.number,
    required this.title,
    required this.summary,
    required this.blocks,
  });

  /// Id unik materi, dipakai sebagai key widget.
  final String id;

  /// Nomor materi sesuai urutan pada dokumen sumber.
  final int number;

  /// Judul materi.
  final String title;

  /// Paragraf pengantar materi.
  final String summary;

  /// Isi materi secara berurutan.
  final List<MateriBlock> blocks;

  /// Seluruh teks materi (judul, pengantar, dan isi) dalam huruf kecil.
  /// Dipakai untuk fitur pencarian materi.
  String get searchableText {
    final StringBuffer buffer = StringBuffer()
      ..write(title)
      ..write(' ')
      ..write(summary);
    for (final MateriBlock block in blocks) {
      buffer.write(' ');
      buffer.write(block.text);
    }
    return buffer.toString().toLowerCase();
  }

  /// True bila [query] (huruf kecil) ditemukan pada judul, pengantar,
  /// atau isi materi.
  bool matches(String query) => searchableText.contains(query);
}
