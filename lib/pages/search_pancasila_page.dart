import 'package:flutter/material.dart';

class SearchPancasilaPage extends StatefulWidget {
  const SearchPancasilaPage({super.key});

  @override
  State<SearchPancasilaPage> createState() => _SearchPancasilaPageState();
}

class _SearchPancasilaPageState extends State<SearchPancasilaPage> {
  final TextEditingController _searchController = TextEditingController();

  // Data ini bisa juga dipindahkan ke file model atau constants jika sangat besar/kompleks
  final List<Map<String, dynamic>> _allPancasilaTopics = [
    {
      'title': 'Apa itu Pancasila?',
      'icon': Icons.help_outline_rounded,
      'color': Colors.blue[100],
      'detailContent':
      'Pancasila adalah dasar negara Republik Indonesia. Terdiri dari lima sila yang menjadi pedoman hidup berbangsa dan bernegara. Seru kan belajar Pancasila!',
    },
    {
      'title': 'Garuda, Lambang Negaraku!',
      'icon': Icons.security_rounded,
      'color': Colors.amber[100],
      'detailContent':
      'Burung Garuda Pancasila adalah lambang negara kita! Di dadanya ada perisai yang berisi simbol-simbol sila Pancasila. Keren ya!',
    },
    {
      'title': 'Sila ke-1: Bintang Emas',
      'icon': Icons.star_border_rounded,
      'color': Colors.yellow[100],
      'detailContent':
      'Sila pertama, "Ketuhanan Yang Maha Esa", dilambangkan bintang emas. Artinya kita percaya dan takwa kepada Tuhan, serta menghormati agama lain. Contohnya, rajin berdoa dan tidak mengganggu teman yang sedang beribadah.',
    },
    {
      'title': 'Sila ke-2: Rantai Baja',
      'icon': Icons.link_rounded,
      'color': Colors.grey[300],
      'detailContent':
      'Sila kedua, "Kemanusiaan yang Adil dan Beradab", dilambangkan rantai. Artinya kita harus saling menyayangi sesama manusia, adil, dan sopan. Contohnya, menolong teman yang kesulitan dan berbicara dengan baik kepada semua orang.',
    },
    {
      'title': 'Sila ke-3: Pohon Beringin',
      'icon': Icons.park_rounded,
      'color': Colors.green[100],
      'detailContent':
      'Sila ketiga, "Persatuan Indonesia", dilambangkan pohon beringin. Artinya kita harus bersatu meskipun berbeda-beda suku, agama, dan budaya. Contohnya, bermain bersama teman dari berbagai daerah dan bangga menjadi anak Indonesia.',
    },
    {
      'title': 'Sila ke-4: Kepala Banteng',
      'icon': Icons.filter_vintage_rounded,
      'color': Colors.red[100],
      'detailContent':
      'Sila keempat, "Kerakyatan yang Dipimpin oleh Hikmat Kebijaksanaan dalam Permusyawaratan/Perwakilan", dilambangkan kepala banteng. Artinya kita menyelesaikan masalah dengan musyawarah untuk mufakat. Contohnya, memilih ketua kelas dengan berdiskusi bersama.',
    },
    {
      'title': 'Sila ke-5: Padi dan Kapas',
      'icon': Icons.grass_rounded,
      'color': Colors.lightGreen[100],
      'detailContent':
      'Sila kelima, "Keadilan Sosial bagi Seluruh Rakyat Indonesia", dilambangkan padi dan kapas. Artinya semua rakyat Indonesia berhak mendapatkan keadilan dan kesejahteraan. Contohnya, tidak boros dan menghargai hasil karya orang lain.',
    },
    {
      'title': 'Hari Lahir Pancasila',
      'icon': Icons.cake_rounded,
      'color': Colors.pink[100],
      'detailContent':
      'Hari Lahir Pancasila diperingati setiap tanggal 1 Juni. Ini adalah hari penting untuk mengingat kembali nilai-nilai luhur Pancasila. Biasanya ada upacara bendera dan kegiatan seru lainnya!',
    },
    {
      'title': 'Butir-Butir Pengamalan Pancasila',
      'icon': Icons.list_alt_rounded,
      'color': Colors.teal[50],
      'detailContent':
      'Butir-butir pengamalan Pancasila adalah contoh nyata bagaimana kita bisa menerapkan nilai-nilai Pancasila dalam kehidupan sehari-hari. Ada banyak sekali contohnya untuk setiap sila, yuk kita pelajari bersama!',
    },
  ];
  List<Map<String, dynamic>> _filteredPancasilaTopics = [];

  @override
  void initState() {
    super.initState();
    _filteredPancasilaTopics = List.from(_allPancasilaTopics);
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    if (!mounted) return;
    String query = _searchController.text.toLowerCase().trim();
    setState(() {
      if (query.isEmpty) {
        _filteredPancasilaTopics = List.from(_allPancasilaTopics);
      } else {
        _filteredPancasilaTopics = _allPancasilaTopics
            .where((topic) =>
            (topic['title'] as String).toLowerCase().contains(query))
            .toList();
      }
    });
  }

  void _showMaterialDetail(BuildContext context, Map<String, dynamic> topicData) {
    String topicTitle = topicData['title'] as String;
    String content = topicData['detailContent'] as String? ??
        'Maaf, penjelasan untuk topik ini belum tersedia.';
    IconData iconData = topicData['icon'] as IconData? ?? Icons.menu_book_rounded;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0)),
          title: Row(
            children: [
              Icon(iconData, color: Theme.of(context).primaryColor),
              const SizedBox(width: 10),
              Expanded(
                  child: Text(topicTitle,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 18))),
            ],
          ),
          content: SingleChildScrollView(
              child: Text(content,
                  style: const TextStyle(fontSize: 15, height: 1.5))),
          actions: <Widget>[
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.secondary,
                  foregroundColor: Colors.black87),
              child: const Text('Asiiik, Paham!'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(title: const Text('Cari Materi Seru!')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: _searchController,
              style: const TextStyle(fontSize: 16),
              decoration: InputDecoration(
                hintText: 'Mau cari apa, jagoan?',
                prefixIcon: Icon(Icons.search_rounded,
                    color: Theme.of(context).primaryColor, size: 28),
                suffixIcon: _searchController.text.isNotEmpty
                    ? IconButton(
                    icon: const Icon(Icons.clear_rounded, color: Colors.grey),
                    onPressed: () {
                      _searchController.clear();
                    })
                    : null,
                filled: true,
                fillColor: Colors.white,
                contentPadding: const EdgeInsets.symmetric(
                    vertical: 15.0, horizontal: 20.0),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    borderSide: BorderSide.none),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    borderSide:
                    BorderSide(color: Colors.grey[300]!, width: 1.5)),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    borderSide: BorderSide(
                        color: Theme.of(context).primaryColor, width: 2.0)),
              ),
            ),
            const SizedBox(height: 25),
            Expanded(
              child: _filteredPancasilaTopics.isEmpty &&
                  _searchController.text.isNotEmpty
                  ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('assets/images/maskot_bingung.png',
                        height: 100,
                        errorBuilder: (context, error, stackTrace) =>
                            Icon(Icons.sentiment_dissatisfied_rounded,
                                size: 80, color: Colors.grey[400])),
                    const SizedBox(height: 15),
                    Text(
                      'Ups, "${_searchController.text}" tidak ketemu nih...',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.grey[600],
                          fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Coba kata kunci lain ya!',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 16, color: Colors.grey[500]),
                    ),
                  ],
                ),
              )
                  : ListView.builder(
                itemCount: _filteredPancasilaTopics.length,
                itemBuilder: (context, index) {
                  final topic = _filteredPancasilaTopics[index];
                  return Card(
                    color: (topic['color'] as Color? ?? Colors.white)
                        .withOpacity(0.85),
                    margin: const EdgeInsets.symmetric(vertical: 7.0),
                    child: ListTile(
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 15.0),
                      leading: CircleAvatar(
                        backgroundColor: (topic['color'] as Color? ??
                            Colors.grey[200])
                            ?.withAlpha(200),
                        child: Icon(
                            topic['icon'] as IconData? ??
                                Icons.school_rounded,
                            color: Theme.of(context).primaryColorDark,
                            size: 28),
                        radius: 28,
                      ),
                      title: Text(
                        topic['title'] as String,
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16.5,
                            color: Colors.grey[850]),
                      ),
                      trailing: Icon(Icons.arrow_forward_ios_rounded,
                          color: Colors.grey[400], size: 18),
                      onTap: () {
                        _showMaterialDetail(context, topic); // Mengirim seluruh data topik
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
