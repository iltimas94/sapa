class VideoInfo {
  final String title;
  final String path; // Bisa berupa path aset atau URL
  final bool isAsset;
  final String? thumbnailAsset; // Tambahkan ini jika Anda mau menambahkan thumbnail

  const VideoInfo({
    required this.title,
    required this.path,
    this.isAsset = false,
    this.thumbnailAsset, // Tambahkan ini
  });
}