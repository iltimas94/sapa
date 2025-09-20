import 'package:flutter/material.dart';

class PancasilaTopic {
  final String title;
  final String description;
  final String lambang; // Bisa jadi kata kunci atau nama lambang formal
  final List<String> butirPengamalan; // Akan ditampilkan sebagai "Contoh Sikap"

  PancasilaTopic({
    required this.title,
    required this.description,
    required this.lambang,
    required this.butirPengamalan,
  });
}

class SearchPancasilaPage extends StatefulWidget {
  const SearchPancasilaPage({super.key});

  @override
  State<SearchPancasilaPage> createState() => _SearchPancasilaPageState();
}

class _SearchPancasilaPageState extends State<SearchPancasilaPage> {
  final TextEditingController _searchController = TextEditingController();
  List<PancasilaTopic> _searchResults = [];
  bool _hasSearched = false;

  final List<PancasilaTopic> _allPancasilaTopics = [
    // 5 Sila Utama (yang sudah ada, bisa disesuaikan bahasanya jika perlu)
    PancasilaTopic(
      title: 'Sila ke-1: Ketuhanan Yang Maha Esa',
      description:
      'Artinya kita percaya dan takut kepada Tuhan yang menciptakan alam semesta ini.',
      lambang: 'Bintang Tunggal',
      butirPengamalan: [
        'Rajin berdoa sesuai agama masing-masing.',
        'Menghormati teman yang berbeda agama.',
        'Tidak mengganggu teman yang sedang beribadah.',
      ],
    ),
    PancasilaTopic(
      title: 'Sila ke-2: Kemanusiaan yang Adil dan Beradab',
      description:
      'Artinya kita harus saling menyayangi dan menghargai sesama manusia.',
      lambang: 'Rantai Emas',
      butirPengamalan: [
        'Membantu teman yang kesusahan.',
        'Berbicara sopan kepada orang tua dan guru.',
        'Tidak membeda-bedakan teman.',
      ],
    ),
    PancasilaTopic(
      title: 'Sila ke-3: Persatuan Indonesia',
      description:
      'Artinya kita harus bersatu sebagai bangsa Indonesia meskipun berbeda-beda.',
      lambang: 'Pohon Beringin',
      butirPengamalan: [
        'Berteman dengan siapa saja tanpa memandang suku atau daerah.',
        'Mengikuti upacara bendera dengan khidmat.',
        'Bangga menggunakan produk buatan Indonesia.',
      ],
    ),
    PancasilaTopic(
      title: 'Sila ke-4: Kerakyatan yang Dipimpin oleh Hikmat Kebijaksanaan dalam Permusyawaratan/Perwakilan',
      description:
      'Artinya kita menyelesaikan masalah bersama dengan berdiskusi atau musyawarah.',
      lambang: 'Kepala Banteng',
      butirPengamalan: [
        'Menghargai pendapat teman saat berdiskusi.',
        'Menerima hasil keputusan bersama dengan lapang dada.',
        'Ikut serta dalam pemilihan ketua kelas.',
      ],
    ),
    PancasilaTopic(
      title: 'Sila ke-5: Keadilan Sosial bagi Seluruh Rakyat Indonesia',
      description:
      'Artinya semua orang di Indonesia berhak mendapatkan perlakuan yang adil.',
      lambang: 'Padi dan Kapas',
      butirPengamalan: [
        'Berbagi makanan dengan teman.',
        'Menghargai hasil karya orang lain.',
        'Memberi bantuan kepada yang membutuhkan.',
      ],
    ),

    // 10 Materi Tambahan Pertama (yang sudah ada)
    PancasilaTopic(
      title: 'Arti Lambang Bintang (Sila ke-1)',
      description: 'Bintang emas bersudut lima melambangkan cahaya dari Tuhan untuk setiap manusia.',
      lambang: 'Bintang',
      butirPengamalan: [
        'Kita harus selalu ingat kepada Tuhan.',
        'Berbuat baik adalah cara kita mengikuti cahaya Tuhan.',
        'Bintang juga berarti harapan agar Indonesia selalu terang.',
      ],
    ),
    PancasilaTopic(
      title: 'Arti Lambang Rantai (Sila ke-2)',
      description: 'Rantai yang saling berkaitan melambangkan hubungan antarmanusia yang kuat dan tidak terputus.',
      lambang: 'Rantai',
      butirPengamalan: [
        'Setiap mata rantai itu penting, seperti setiap orang penting.',
        'Kita harus saling tolong-menolong seperti rantai yang menyatu.',
        'Persahabatan yang kuat itu seperti rantai.',
      ],
    ),
    PancasilaTopic(
      title: 'Arti Lambang Pohon Beringin (Sila ke-3)',
      description: 'Pohon beringin yang besar dan rindang melambangkan tempat berteduh dan bersatunya seluruh rakyat Indonesia.',
      lambang: 'Pohon Beringin', // Duplikat dari sila ke-3, tapi fokus ke arti lambang
      butirPengamalan: [
        'Pohon beringin itu kuat, seperti Indonesia yang kuat karena bersatu.',
        'Akar yang menjalar kemana-mana artinya Indonesia punya banyak suku tapi tetap satu.',
        'Kita semua bisa berlindung di bawah naungan Indonesia.',
      ],
    ),
    PancasilaTopic(
      title: 'Arti Lambang Kepala Banteng (Sila ke-4)',
      description: 'Banteng adalah hewan sosial yang suka berkumpul, melambangkan musyawarah untuk mengambil keputusan.',
      lambang: 'Kepala Banteng', // Duplikat dari sila ke-4, fokus arti lambang
      butirPengamalan: [
        'Saat berdiskusi, kita harus berani menyampaikan pendapat seperti banteng yang kuat.',
        'Keputusan bersama adalah hasil dari kekuatan bersama.',
        'Jangan takut berbeda pendapat saat musyawarah.',
      ],
    ),
    PancasilaTopic(
      title: 'Arti Lambang Padi dan Kapas (Sila ke-5)',
      description: 'Padi melambangkan makanan (kebutuhan pokok) dan kapas melambangkan pakaian (kebutuhan pokok). Ini berarti keadilan untuk semua.',
      lambang: 'Padi Kapas', // Bisa juga 'Padi dan Kapas'
      butirPengamalan: [
        'Semua orang berhak mendapatkan makanan dan pakaian yang cukup.',
        'Kita tidak boleh serakah, harus berbagi.',
        'Negara berusaha agar semua rakyatnya sejahtera.',
      ],
    ),
    PancasilaTopic(
      title: 'Gotong Royong di Sekolah',
      description: 'Gotong royong adalah bekerja bersama-sama untuk mencapai tujuan bersama. Ini cerminan sila ke-3 dan ke-5.',
      lambang: 'Kerja Sama',
      butirPengamalan: [
        'Membersihkan kelas bersama-sama (piket kelas).',
        'Mengerjakan tugas kelompok dengan kompak.',
        'Menjaga kebersihan lingkungan sekolah bersama.',
      ],
    ),
    PancasilaTopic(
      title: 'Menghargai Perbedaan Teman',
      description: 'Indonesia punya banyak suku, agama, dan budaya. Kita harus saling menghargai. Ini cerminan sila ke-2 dan ke-3.',
      lambang: 'Bhinneka Tunggal Ika',
      butirPengamalan: [
        'Tidak mengejek teman yang berbeda warna kulit atau bahasa.',
        'Mau bermain dengan semua teman.',
        'Menghormati cara teman beribadah.',
      ],
    ),
    PancasilaTopic(
      title: 'Jujur dan Bertanggung Jawab',
      description: 'Berkata benar dan melakukan tugas dengan baik adalah sikap penting. Ini cerminan sila ke-1 dan ke-2.',
      lambang: 'Kejujuran',
      butirPengamalan: [
        'Mengakui kesalahan jika berbuat salah.',
        'Mengerjakan PR sendiri dengan sungguh-sungguh.',
        'Tidak menyontek saat ujian.',
      ],
    ),
    PancasilaTopic(
      title: 'Cinta Tanah Air Indonesia',
      description: 'Menyayangi dan bangga menjadi anak Indonesia. Ini cerminan sila ke-3.',
      lambang: 'Bendera Merah Putih',
      butirPengamalan: [
        'Menghormati bendera Merah Putih.',
        'Mempelajari sejarah Indonesia.',
        'Menjaga nama baik Indonesia.',
      ],
    ),
    PancasilaTopic(
      title: 'Disiplin di Rumah dan Sekolah',
      description: 'Mengikuti aturan yang ada agar semua berjalan tertib. Ini membantu menciptakan keadilan dan persatuan.',
      lambang: 'Aturan Tertib',
      butirPengamalan: [
        'Datang ke sekolah tepat waktu.',
        'Mengerjakan tugas sesuai jadwal.',
        'Mendengarkan guru saat menjelaskan pelajaran.',
      ],
    ),

    // 10 Materi Tambahan Kedua (Baru)
    PancasilaTopic(
      title: 'Menjaga Kebersihan Lingkungan',
      description: 'Lingkungan yang bersih membuat kita sehat dan nyaman. Ini adalah tanggung jawab kita semua.',
      lambang: 'Lingkungan Bersih',
      butirPengamalan: [
        'Tidak membuang sampah sembarangan.',
        'Ikut kerja bakti membersihkan lingkungan rumah atau sekolah.',
        'Menghemat penggunaan air.',
      ],
    ),
    PancasilaTopic(
      title: 'Saling Memaafkan',
      description: 'Setiap orang bisa berbuat salah. Memaafkan membuat hati kita damai. (Sila ke-2)',
      lambang: 'Memaafkan Damai',
      butirPengamalan: [
        'Minta maaf jika berbuat salah kepada teman atau keluarga.',
        'Tidak menyimpan dendam.',
        'Berteman kembali setelah berselisih.',
      ],
    ),
    PancasilaTopic(
      title: 'Menghormati Orang yang Lebih Tua',
      description: 'Orang yang lebih tua, seperti orang tua, guru, dan kakek-nenek, harus kita hormati. (Sila ke-2)',
      lambang: 'Hormat Orang Tua',
      butirPengamalan: [
        'Berbicara dengan sopan kepada orang yang lebih tua.',
        'Mendengarkan nasihat orang tua dan guru.',
        'Membantu orang tua di rumah.',
      ],
    ),
    PancasilaTopic(
      title: 'Belajar dengan Rajin',
      description: 'Belajar adalah kewajiban kita sebagai pelajar untuk masa depan yang lebih baik. (Sila ke-5, sila ke-3)',
      lambang: 'Rajin Belajar Buku',
      butirPengamalan: [
        'Mengerjakan PR dan tugas sekolah tepat waktu.',
        'Memperhatikan penjelasan guru di kelas.',
        'Membaca buku untuk menambah pengetahuan.',
      ],
    ),
    PancasilaTopic(
      title: 'Menjaga Fasilitas Umum',
      description: 'Fasilitas umum seperti taman, halte, atau toilet sekolah adalah milik bersama. Kita harus menjaganya. (Sila ke-5)',
      lambang: 'Jaga Fasilitas Umum',
      butirPengamalan: [
        'Tidak mencoret-coret tembok atau bangku taman.',
        'Menggunakan toilet sekolah dengan bersih.',
        'Membuang sampah pada tempatnya di area publik.',
      ],
    ),
    PancasilaTopic(
      title: 'Berani Mengakui Kesalahan',
      description: 'Jika kita berbuat salah, lebih baik mengakuinya daripada berbohong. (Sila ke-1, Sila ke-2)',
      lambang: 'Berani Jujur',
      butirPengamalan: [
        'Mengaku jika lupa mengerjakan PR.',
        'Tidak menyalahkan orang lain atas kesalahan sendiri.',
        'Menerima konsekuensi dari kesalahan yang dibuat.',
      ],
    ),
    PancasilaTopic(
      title: 'Menghargai Pendapat Orang Lain saat Bermain',
      description: 'Saat bermain bersama, setiap teman mungkin punya ide. Kita harus saling menghargai. (Sila ke-4)',
      lambang: 'Main Bersama Rukun',
      butirPengamalan: [
        'Mendengarkan ide teman saat menentukan permainan.',
        'Tidak memaksakan permainan yang kita mau saja.',
        'Bermain dengan adil dan tidak curang.',
      ],
    ),
    PancasilaTopic(
      title: 'Menolong Hewan yang Kesusahan',
      description: 'Hewan juga makhluk Tuhan yang perlu kita sayangi dan tolong jika mereka butuh bantuan. (Sila ke-1, Sila ke-2)',
      lambang: 'Sayang Hewan Tolong',
      butirPengamalan: [
        'Tidak menyakiti hewan.',
        'Memelihara hewan peliharaan dengan baik jika punya.',
        'Belajar tentang cara merawat hewan.',
      ],
    ),
    PancasilaTopic(
      title: 'Bangga dengan Budaya Indonesia',
      description: 'Indonesia kaya akan budaya, seperti tarian, lagu daerah, dan makanan khas. Kita harus bangga! (Sila ke-3)',
      lambang: 'Budaya Indonesia Bangga',
      butirPengamalan: [
        'Mempelajari tarian atau lagu daerah.',
        'Mencoba makanan khas dari berbagai daerah di Indonesia.',
        'Mengenakan pakaian adat pada acara tertentu.',
      ],
    ),
    PancasilaTopic(
      title: 'Tidak Mudah Putus Asa',
      description: 'Dalam belajar atau melakukan sesuatu, kadang kita gagal. Tapi kita tidak boleh menyerah. (Sila ke-5)',
      lambang: 'Semangat Pantang Menyerah',
      butirPengamalan: [
        'Terus mencoba meskipun gagal saat mengerjakan soal.',
        'Berlatih lagi jika kalah dalam perlombaan.',
        'Tidak takut mencoba hal baru yang sulit.',
      ],
    ),
  ];

  void _performSearch(String query) {
    if (query.isEmpty) {
      setState(() {
        _searchResults = [];
        _hasSearched = false;
      });
      return;
    }

    final lowerCaseQuery = query.toLowerCase();
    final results = _allPancasilaTopics.where((topic) {
      bool titleMatch = topic.title.toLowerCase().contains(lowerCaseQuery);
      bool descMatch = topic.description.toLowerCase().contains(lowerCaseQuery);
      bool lambangMatch = topic.lambang.toLowerCase().contains(lowerCaseQuery);
      bool butirMatch = topic.butirPengamalan.any((butir) => butir.toLowerCase().contains(lowerCaseQuery));

      int? queryNumber;
      try {
        queryNumber = int.parse(lowerCaseQuery);
      } catch (e) {
        // bukan angka
      }

      bool silaNumberMatch = false;
      if (queryNumber != null && topic.title.startsWith('Sila ke-$queryNumber')) {
        silaNumberMatch = true;
      }
      if (lowerCaseQuery.startsWith("sila ") && topic.title.toLowerCase().contains(lowerCaseQuery)) {
        silaNumberMatch = true;
      }

      return titleMatch || descMatch || lambangMatch || butirMatch || silaNumberMatch;
    }).toList();

    setState(() {
      _searchResults = results;
      _hasSearched = true;
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Info Pancasila Anak SD'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              autofocus: true,
              decoration: InputDecoration(
                hintText: 'Ketik kata kunci (misal: "bintang", "jujur", "sila 1")...',
                prefixIcon: const Icon(Icons.search_rounded),
                suffixIcon: _searchController.text.isNotEmpty
                    ? IconButton(
                  icon: const Icon(Icons.clear_rounded),
                  onPressed: () {
                    _searchController.clear();
                    _performSearch('');
                  },
                )
                    : null,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                  borderSide: BorderSide(color: theme.primaryColor),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                  borderSide: BorderSide(color: theme.primaryColor, width: 2.0),
                ),
              ),
              onChanged: _performSearch,
            ),
          ),
          Expanded(
            child: _hasSearched
                ? _searchResults.isEmpty
                ? Center(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/maskot_bingung.png',
                      height: 120,
                      errorBuilder: (ctx, err, st) => Icon(
                          Icons.search_off_rounded,
                          size: 80,
                          color: Colors.grey[400]),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'Yah, tidak ketemu...',
                      style: theme.textTheme.headlineSmall
                          ?.copyWith(fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Coba ketik kata lain ya!',
                      style: theme.textTheme.bodyLarge
                          ?.copyWith(color: Colors.grey[600]),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            )
                : ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
              itemCount: _searchResults.length,
              itemBuilder: (context, index) {
                final topic = _searchResults[index];
                // String initial = topic.lambang.isNotEmpty && topic.lambang.length < 3 ? topic.lambang.substring(0,1).toUpperCase() : topic.title.substring(0,1).toUpperCase();
                // if (topic.lambang.toLowerCase() == "bintang tunggal") initial = "B";
                // if (topic.lambang.toLowerCase() == "rantai emas") initial = "R";
                // if (topic.lambang.toLowerCase() == "pohon beringin") initial = "P";
                // if (topic.lambang.toLowerCase() == "kepala banteng") initial = "K";
                // if (topic.lambang.toLowerCase() == "padi dan kapas") initial = "PK";
                // Logika inisial teks di atas tidak lagi digunakan untuk CircleAvatar utama

                // Tentukan path gambar berdasarkan topic.lambang
                String imagePath;
                switch (topic.lambang.toLowerCase()) {
                  case 'bintang tunggal':
                  case 'bintang': // Tambahkan variasi jika perlu
                    imagePath = 'assets/images/sila 1.png';
                    break;
                  case 'rantai emas':
                  case 'rantai':
                    imagePath = 'assets/images/sila 2.png';
                    break;
                  case 'pohon beringin':
                    imagePath = 'assets/images/sila 3.png';
                    break;
                  case 'kepala banteng':
                    imagePath = 'assets/images/sila 4.png';
                    break;
                  case 'padi dan kapas':
                    imagePath = 'assets/images/sila 5.png';
                    break;
                // Tambahkan case untuk lambang-lambang lainnya jika ada
                // Contoh:
                // case 'sayang hewan tolong':
                //   imagePath = 'assets/images/lambang_sayang_hewan.png'; // Ganti dengan nama file yang sesuai
                //   break;
                  default:
                  // Gambar default jika tidak ada lambang spesifik atau untuk topik umum
                    imagePath = 'assets/images/lambang_default.png'; // Sediakan gambar default
                }

                return Card(
                  elevation: 2,
                  margin: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 8.0),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  child: ExpansionTile(
                    backgroundColor: theme.colorScheme.primaryContainer.withOpacity(0.1),
                    collapsedBackgroundColor: theme.cardColor,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    collapsedShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    leading: CircleAvatar(
                      backgroundColor: theme.colorScheme.primary.withOpacity(0.05), // Mungkin ingin warna yang lebih netral
                      // Hapus child Text
                      // child: Text(
                      //   initial,
                      //   style: TextStyle(
                      //       fontWeight: FontWeight.bold,
                      //       color: theme.colorScheme.primary),
                      // ),
                      // Ganti dengan Image.asset
                      child: Padding(
                        padding: const EdgeInsets.all(4.0), // Beri sedikit padding jika perlu
                        child: Image.asset(
                          imagePath,
                          fit: BoxFit.contain, // Atau BoxFit.cover, sesuaikan
                          errorBuilder: (context, error, stackTrace) {
                            // Fallback jika gambar gagal dimuat, bisa tampilkan inisial teks lagi atau ikon
                            String fallbackInitial = topic.lambang.isNotEmpty && topic.lambang.length < 3
                                ? topic.lambang.substring(0, 1).toUpperCase()
                                : topic.title.substring(0, 1).toUpperCase();
                            if (topic.lambang.toLowerCase() == "bintang tunggal") fallbackInitial = "B";
                            if (topic.lambang.toLowerCase() == "rantai emas") fallbackInitial = "R";
                            if (topic.lambang.toLowerCase() == "pohon beringin") fallbackInitial = "P";
                            if (topic.lambang.toLowerCase() == "kepala banteng") fallbackInitial = "K";
                            if (topic.lambang.toLowerCase() == "padi dan kapas") fallbackInitial = "PK";

                            return Text(
                              fallbackInitial,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18, // Sesuaikan ukuran font jika perlu
                                color: theme.colorScheme.primary,
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    title: Text(
                      topic.title,
                      style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: theme.colorScheme.primary),
                    ),
                    subtitle: Text(
                      'Topik Utama: ${topic.lambang}',
                      style: theme.textTheme.bodySmall
                          ?.copyWith(color: Colors.grey[700]),
                    ),
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.fromLTRB(16.0, 0, 16.0, 16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Divider(height: 12),
                            Text(
                              "Penjelasan:",
                              style: theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold, color: theme.colorScheme.secondary),
                            ),
                            const SizedBox(height: 4.0),
                            Text(
                              topic.description,
                              style: theme.textTheme.bodyMedium
                                  ?.copyWith(height: 1.4),
                            ),
                            const SizedBox(height: 12.0),
                            Text(
                              'Contoh Sikap Sehari-hari:',
                              style: theme.textTheme.titleSmall
                                  ?.copyWith(fontWeight: FontWeight.bold, color: theme.colorScheme.secondary),
                            ),
                            const SizedBox(height: 6.0),
                            ...topic.butirPengamalan.map(
                                  (butir) => Padding(
                                padding: const EdgeInsets.only(left: 0.0, bottom: 5.0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(right: 8.0, top: 2.0),
                                      child: Text(
                                        // Perluas array emoji jika jumlah topik melebihi 10 atau buat logika pemilihan emoji yang lebih baik
                                          ['🌟', '🤝', '🌳', '🐃', '🌾', '🤝', '😊', '👍', '🇮🇩', '⏰', '🧹', '🤗', '👵', '📚', '🏡', '🙋', '⚽', '🐕', '🎭', '💪'][_allPancasilaTopics.indexOf(topic) % 20], // Update modulo dan array emoji
                                          style: const TextStyle(fontSize: 14)
                                      ),
                                    ),
                                    Expanded(
                                      child: Text(butir,
                                          style: theme.textTheme.bodySmall
                                              ?.copyWith(fontSize: 13.5, height: 1.3)),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },

            )
                : Center( // Tampilan awal sebelum search
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.manage_search_rounded, // Menggunakan ikon yang sudah ada dan valid
                        size: 80, color: Colors.grey[400]),
                    const SizedBox(height: 16),
                    Text(
                      'Mau Cari Apa Hari Ini?',
                      style: theme.textTheme.headlineSmall
                          ?.copyWith(fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Ketik tentang Pancasila yang ingin kamu tahu, misalnya "Sila ke-3" atau "tolong teman".',
                      textAlign: TextAlign.center,
                      style: theme.textTheme.bodyLarge
                          ?.copyWith(color: Colors.grey[600]),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
