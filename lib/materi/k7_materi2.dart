import 'package:flutter/material.dart';
import 'materi_model.dart';

Materi buatMateri2() => Materi(
      id: 'k7-m2',
      nomor: 2,
      judul: 'Penerapan Nilai Pancasila',
      deskripsi:
          'Mengubah teks Pancasila menjadi tindakan nyata di sekolah, rumah, dan dunia digital.',
      ikon: Icons.volunteer_activism,
      warna: const Color(0xFFB26A00),
      kataKunci: [
        'penerapan sila',
        'bullying',
        'perundungan',
        'toleransi',
        'media sosial',
        'hoaks',
        'musyawarah',
        'gotong royong',
        'hak dan kewajiban',
        'fanatisme',
        'flexing',
        'empati',
      ],
      bab: [
        Bab('Pancasila: Dari Teks Menjadi Tindakan', Icons.lightbulb, [
          const Paragraf(
              'Penerapan Pancasila berarti mengubah teks yang dibacakan setiap upacara hari Senin menjadi **tindakan nyata** sehari-hari: di ruang kelas, tempat berkumpul, hingga saat bermain media sosial. Pancasila bukan hanya dihafalkan agar lulus ujian, melainkan "buku panduan" atau **kompas** yang mengarahkan cara pelajar berpikir, berbicara, dan bertindak.'),
          const Callout(JenisCallout.tips, 'Analogi: Pancasila itu seperti OS ponsel',
              'Membaca dan menghafal sila = **mengunduh** software. Menerapkannya = **mengaktifkan dan menjalankan** software itu agar ponsel berfungsi baik, aman dari virus (pengaruh buruk), dan bermanfaat. Jika hanya diunduh tanpa dijalankan, software tidak ada gunanya.'),
          const Perbandingan('Menghafal', 'Menerapkan', [
            BarisBanding('Seperti', 'Mengunduh aplikasi', 'Menjalankan aplikasi'),
            BarisBanding('Hasil', 'Hanya tahu bunyi sila',
                'Perilaku baik, aman dari pengaruh buruk, bermanfaat'),
          ]),
          const SubJudul('Bentuk Nyata di Dunia Remaja', ikon: Icons.phone_android),
          const GridIkon([
            ItemGrid(Icons.filter_alt, 'Filter informasi & tren',
                'Memilah mana yang baik dan layak diikuti.'),
            ItemGrid(Icons.people, 'Panduan bergaul & berteman',
                'Menentukan sikap dalam pertemanan.'),
            ItemGrid(Icons.people_outline, 'Resolusi konflik',
                'Cara menyelesaikan masalah dengan adil.'),
          ], kolom: 1),
          const Callout(JenisCallout.penting, 'Tanda sudah menjadi kebiasaan',
              'Penerapan terjadi ketika sikap saling menghargai, adil, jujur, dan beradab menjadi **refleks alami** sehari-hari, tanpa perlu diawasi guru atau orang tua.'),
        ]),
        Bab('Sila 1: Ketuhanan Yang Maha Esa', Icons.star, [
          const Gambar('Lambang Sila 1: Bintang Emas berlatar hitam', aset: 'assets/images/materi/6.jpg'),
          const Paragraf(
              'Sila pertama disimbolkan **Bintang Emas** berlatar hitam. Bagi pelajar, lambang ini bukan sekadar gambar di atas papan tulis, melainkan **kompas** penunjuk arah hidup. Bintang emas bermakna cahaya kerohanian dari Tuhan yang menerangi jalan hidup setiap manusia.'),
          const Callout(JenisCallout.info, 'Mengapa Sila 1 di urutan pertama?',
              'Karena nilai Ketuhanan adalah **"Pondasi Utama"**, dasar moral bagi keempat sila lainnya.'),
          const Akordeon([
            ItemAkordeon('Sila 2 (Kemanusiaan)',
                'Tidak akan berjalan baik jika seseorang tidak memiliki rasa takut pada Tuhan.',
                ikon: Icons.favorite),
            ItemAkordeon('Sila 3 (Persatuan)',
                'Akan hancur lebur jika orang beragama justru saling menyebarkan kebencian dan bermusuhan.',
                ikon: Icons.public),
            ItemAkordeon('Sila 4 (Kerakyatan)',
                'Akan berujung pada kelicikan dan korupsi jika pemimpin dan rakyatnya tidak punya dasar moral keagamaan.',
                ikon: Icons.how_to_vote),
            ItemAkordeon('Sila 5 (Keadilan)',
                'Mustahil tercapai jika manusia tidak diajarkan agamanya untuk jujur dan adil kepada sesama.',
                ikon: Icons.balance),
          ]),
          const SubJudul('Penerapan bagi Pelajar SMP', ikon: Icons.school),
          const Paragraf(
              'Di usia SMP kamu punya banyak teman dari berbagai latar belakang, aktif di media sosial, dan mulai mencari jati diri. Pilih tab di bawah untuk menjelajah.'),
          const TabInfo([
            ItemTab('Makna', Icons.lightbulb, [
              Paragraf(
                  'Sila pertama bukan sekadar agama di Kartu Pelajar atau KTP. Ia mengajarkan **Keyakinan dan Ketakwaan**: percaya Tuhan ada, dan berusaha menjalankan perintah-Nya serta menjauhi larangan-Nya sesuai agama atau kepercayaan masing-masing.'),
              Paragraf(
                  'Bagi anak SMP, takwa berarti sadar bahwa setiap tindakan dilihat Tuhan. Kesadaran ini membuat kita berpikir dua kali sebelum **mencontek**, **berbohong** kepada orang tua, atau **menindas teman**. Agama menjadi rem alami bagi hati nurani.'),
            ]),
            ItemTab('Sekolah', Icons.school, [
              Paragraf('Sekolah adalah miniatur masyarakat. Di sinilah ujian nyata sila pertama.'),
              Akordeon([
                ItemAkordeon('Berdoa sebelum & sesudah belajar',
                    'Berdoalah sungguh-sungguh menurut agama masing-masing. Tidak pantas jika waktu doa dipakai mengobrol atau bermain alat tulis. Doa memohon agar ilmu dipahami dan bermanfaat.',
                    ikon: Icons.self_improvement),
                ItemAkordeon('Menghargai teman yang beribadah',
                    'Saat asyik bermain basket dan teman izin salat Asar, persilakan, bahkan bantu jaga barangnya. Dilarang mengejek atau memaksanya terus bermain.',
                    ikon: Icons.favorite),
                ItemAkordeon('Berteman tanpa memandang agama',
                    'Tidak perlu membuat "geng" yang hanya berisi agama yang sama. Dari teman beda agama kita belajar tradisi hari raya, budaya, dan kebiasaan baik.',
                    ikon: Icons.people),
                ItemAkordeon('Toleransi saat hari raya / puasa',
                    'Tidak makan atau minum sengaja di hadapan yang berpuasa. Sebaliknya, yang berpuasa tidak memaksa kantin ditutup total karena ada siswa lain yang tetap butuh makan siang.',
                    ikon: Icons.balance),
              ]),
            ]),
            ItemTab('Rumah', Icons.home, [
              Paragraf('Keluarga adalah tempat pertama belajar agama dan budi pekerti.'),
              Akordeon([
                ItemAkordeon('Ibadah tanpa disuruh',
                    'Saat SD mungkin orang tua harus terus mengingatkan. Di SMP, tunjukkan kedewasaan: beribadah tepat waktu atas kesadaran sendiri sebagai tanggung jawab kepada Sang Pencipta.',
                    ikon: Icons.alarm),
                ItemAkordeon('Mensyukuri nikmat keluarga',
                    'Mengeluh makanan kurang enak atau marah karena belum dibelikan barang tren adalah kurang bersyukur. Bersyukur membuat hidup lebih tenang, damai, dan bahagia.',
                    ikon: Icons.favorite),
                ItemAkordeon('Menghormati orang tua = perintah agama',
                    'Semua agama yang diakui (Islam, Kristen, Katolik, Hindu, Buddha, Khonghucu) mengajarkan berbakti kepada orang tua. Membantu ibu menyapu atau berbicara sopan kepada ayah berarti menjalankan perintah Tuhan.',
                    ikon: Icons.family_restroom),
              ]),
            ]),
            ItemTab('Digital', Icons.phone_android, [
              Paragraf(
                  'Sebagai Gen-Z, waktu luang banyak dihabiskan di TikTok, Instagram, atau game online. Di ruang tanpa batas ini, sila pertama justru sangat diuji.'),
              Akordeon([
                ItemAkordeon('Hindari candaan SARA',
                    'Meme yang merendahkan simbol agama demi terlihat lucu adalah pelanggaran keras terhadap nilai Pancasila. Menghina Tuhan, kitab suci, nabi, atau ajaran agama lain tidak lucu sama sekali.',
                    ikon: Icons.block),
                ItemAkordeon('Jangan memaksakan keyakinan di komentar',
                    'Tidak perlu memaksakan pendapat sampai memicu "war comment". Indonesia menjamin kebebasan beragama, hargai ruang digital orang lain.',
                    ikon: Icons.forum),
                ItemAkordeon('Berbagi kebaikan',
                    'Sebarkan nilai positif: kutipan semangat menuntut ilmu, kebersihan, kejujuran, atau pesan perdamaian.',
                    ikon: Icons.volunteer_activism),
              ]),
            ]),
            ItemTab('Awas Fanatisme', Icons.warning_amber_rounded, [
              Callout(JenisCallout.peringatan, 'Bahaya fanatisme sempit',
                  'Merasa agamanya paling benar secara mutlak, sehingga berhak merendahkan, menghina, atau membenci penganut agama lain.'),
              Paragraf(
                  'NKRI berdiri di atas keberagaman. Para pendiri bangsa yang berasal dari berbagai agama sepakat bersatu demi kemerdekaan. Membenci orang lain hanya karena agamanya berbeda berarti **mengkhianati perjuangan para pahlawan**.'),
              Paragraf(
                  'Meyakini dalam hati bahwa agama yang dipeluk paling benar adalah kewajiban umat beragama, tetapi **memaksakannya** dan merendahkan agama lain adalah tindakan **intoleran** yang memecah belah persatuan.'),
            ], warna: Color(0xFFE65100)),
          ]),
          const Paragraf(
              'Mulailah dari hal kecil hari ini: niatkan belajar sebagai ibadah, hargai teman di sekitar, dan jadilah **"Bintang Emas"** yang memancarkan energi positif dan kedamaian di lingkungan sekolah.'),
        ]),
        Bab('Sila 2: Kemanusiaan yang Adil dan Beradab', Icons.favorite, [
          const Gambar('Lambang Sila 2: Rantai', aset: 'assets/images/materi/7.jpg'),
          const Paragraf('Memahami sila kedua berarti menguraikan **tiga kata kuncinya**:'),
          const GridIkon([
            ItemGrid(Icons.favorite, 'Kemanusiaan',
                'Kesadaran bahwa setiap individu punya hak, martabat, perasaan, dan kebebasan yang sama. Tidak ada manusia yang lebih rendah karena fisik atau latar belakang keluarga.'),
            ItemGrid(Icons.balance, 'Adil',
                'Memperlakukan semua orang secara proporsional dan rasional; tidak membeda-bedakan status sosial, ekonomi, kepintaran, maupun kondisi fisik.'),
            ItemGrid(Icons.people_outline, 'Beradab',
                'Memiliki budi pekerti, etika, tata krama, dan sopan santun; tahu menempatkan diri dan menjaga lisan agar tidak menyakiti orang lain.'),
          ], kolom: 1),
          const TabInfo([
            ItemTab('Anti-Bullying', Icons.shield, [
              Paragraf(
                  'Penerapan paling krusial sila kedua di usia SMP adalah **zero tolerance** terhadap perundungan (bullying). Banyak remaja mencari pengakuan kelompok dengan cara menjatuhkan orang lain.'),
              Akordeon([
                ItemAkordeon('Menolak kekerasan verbal',
                    'Memanggil teman dengan nama orang tuanya, menjuluki bentuk tubuh (body shaming), atau menghina ras adalah pelanggaran berat nilai kemanusiaan.',
                    ikon: Icons.record_voice_over),
                ItemAkordeon('Mencegah kekerasan relasional',
                    'Mengucilkan siswa, membuat grup tersembunyi untuk menggunjing, atau menghasut membenci seseorang itu tidak beradab. Rangkul teman yang tersisih.',
                    ikon: Icons.groups),
                ItemAkordeon('Berani membela korban',
                    'Jika ada teman difitnah atau diperlakukan sewenang-wenang, beranilah bersuara. Diam saat melihat penindasan sama artinya dengan ikut membiarkan ketidakadilan merajalela.',
                    ikon: Icons.front_hand),
              ]),
              Callout(JenisCallout.peringatan, 'Kapan candaan jadi penindasan?',
                  'Candaan hanya berlaku jika kedua pihak senang. Jika salah satu sakit hati, itu penindasan.'),
            ]),
            ItemTab('Adil di Kelas', Icons.school, [
              Paragraf('Sikap adil berlaku juga di dalam kelas, bukan hanya di ruang sidang.'),
              Akordeon([
                ItemAkordeon('Adil dalam tugas kelompok',
                    'Bagi tugas merata sesuai porsi dan kemampuan. Tidak adil jika satu-dua orang mengerjakan semuanya sementara yang lain bermain game lalu hanya "numpang nama".',
                    ikon: Icons.groups),
                ItemAkordeon('Adil dalam memakai fasilitas',
                    'Mencoret meja dengan tip-x, merusak pintu toilet, atau membuang sampah sembarangan merampas hak warga sekolah lain atas fasilitas yang nyaman dan bersih.',
                    ikon: Icons.cleaning_services),
              ]),
            ]),
            ItemTab('Etika Pergaulan', Icons.people_outline, [
              Paragraf(
                  'Sopan santun tidak hanya untuk kepala sekolah, guru, atau orang tua. Sila kedua menuntut kita **beradab kepada siapa saja** tanpa memandang pekerjaannya.'),
              Daftar([
                'Mengucapkan terima kasih setelah menerima kembalian di kantin.',
                'Menyapa satpam saat memasuki gerbang sekolah.',
                'Membuang sampah pada tempatnya untuk meringankan beban petugas kebersihan.',
              ]),
              Callout(JenisCallout.info, 'Perlakuan setara',
                  'Inilah yang membedakan remaja berintegritas dengan mereka yang hanya sopan demi nilai bagus.'),
            ]),
            ItemTab('Digital', Icons.phone_android, [
              Paragraf(
                  'Di media sosial, adab sering luntur karena merasa berlindung di balik layar dan nama samaran.'),
              Akordeon([
                ItemAkordeon('Saring sebelum sharing',
                    'Tahan diri menyebarkan hoaks, gosip, atau aib orang lain. Menyebar video memalukan milik orang lain sama dengan "membunuh" karakter dan merampas martabatnya.',
                    ikon: Icons.fact_check),
                ItemAkordeon('Komentar yang beretika',
                    'Hindari ujaran kebencian. Kata kasar dan sumpah serapah meninggalkan jejak digital yang selamanya mencerminkan rendahnya adab pelakunya.',
                    ikon: Icons.chat),
                ItemAkordeon('Merespons perbedaan secara dewasa',
                    'Perbedaan pendapat di grup kelas itu wajar. Tanggapi dengan argumen logis tanpa menyerang fisik atau pribadi lawan bicara.',
                    ikon: Icons.psychology),
              ]),
            ]),
            ItemTab('Empati', Icons.volunteer_activism, [
              Paragraf(
                  'Puncak kemanusiaan adalah **empati**: merasakan apa yang dirasakan orang lain. Contohnya meminjamkan catatan kepada teman yang lama sakit, atau ikut penggalangan dana untuk korban bencana alam.'),
              Callout(JenisCallout.tips, 'Kesetaraan bagi teman disabilitas',
                  'Yang dibutuhkan bukan rasa kasihan berlebihan yang membuat mereka merasa lemah, melainkan dukungan dan perlakuan wajar agar merasa setara, diterima, dan mampu berkarya. Inilah esensi **memanusiakan manusia**.'),
            ]),
          ]),
        ]),
        Bab('Sila 3: Persatuan Indonesia', Icons.public, [
          const Gambar('Lambang Sila 3: Pohon Beringin', aset: 'assets/images/materi/8.jpg'),
          const Paragraf(
              'Sila ketiga dilambangkan **Pohon Beringin**. Akar tunjangnya yang kuat menghunjam tanah melambangkan kukuhnya persatuan, sedangkan akar gantungnya yang rimbun mewakili ribuan suku, agama, dan budaya di bawah satu atap NKRI.'),
          const Callout(JenisCallout.penting, 'Bersatu bukan berarti seragam',
              'Persatuan bukan berarti semua orang menjadi sama atau membuang identitas daerahnya. Persatuan justru **merayakan perbedaan sebagai kekuatan bersama**, sesuai Bhinneka Tunggal Ika.'),
          const TabInfo([
            ItemTab('Tanpa "Geng"', Icons.groups, [
              Paragraf(
                  'Kebutuhan diterima teman sangat besar di masa remaja, tetapi sering memunculkan "geng" eksklusif yang membeda-bedakan status.'),
              Akordeon([
                ItemAkordeon('Berbaur tanpa pilih-pilih',
                    'Bersedia duduk, belajar, dan berinteraksi dengan siapa saja: yang menonjol akademik atau olahraga, dari keluarga berada atau sederhana.',
                    ikon: Icons.people),
                ItemAkordeon('Menghapus sentimen daerah',
                    'Logat, warna kulit, atau tradisi berbeda itu lumrah. Mengejek logat teman mencederai persatuan; lihat sebagai jendela mengenal kekayaan budaya nusantara.',
                    ikon: Icons.map),
                ItemAkordeon('Menolak fanatisme almamater yang merusak',
                    'Bangga pada sekolah itu positif, tetapi fanatisme buta yang berujung tawuran adalah pengkhianatan terhadap persatuan bangsa.',
                    ikon: Icons.block),
              ]),
            ]),
            ItemTab('Gotong Royong', Icons.people_outline, [
              Paragraf('Persatuan paling mudah dinilai saat tujuan dicapai bersama.'),
              Akordeon([
                ItemAkordeon('Kekompakan tugas harian',
                    'Piket kelas tanpa membebankan pada satu orang: ada yang menyapu, merapikan meja, membuang sampah.',
                    ikon: Icons.cleaning_services),
                ItemAkordeon('Solidaritas saat class meeting',
                    'Menang bukan satu-satunya tujuan; yang utama bersatu menyusun strategi, saling menyemangati, dan menjunjung sportivitas tanpa merendahkan kelas lawan.',
                    ikon: Icons.emoji_events),
                ItemAkordeon('Pengorbanan waktu dan tenaga',
                    'Ikut kerja bakti menghias kelas jelang 17 Agustus atau pengurus OSIS yang pulang sore menyiapkan acara adalah praktik rela berkorban.',
                    ikon: Icons.celebration),
              ]),
            ]),
            ItemTab('Cinta Tanah Air', Icons.flag, [
              Paragraf(
                  'Nasionalisme kini diwujudkan lewat gaya hidup dan kebanggaan pada karya anak bangsa.'),
              Akordeon([
                ItemAkordeon('Bangga produk dalam negeri',
                    'Banyak merek lokal (sepatu, tas, jaket, perlengkapan sekolah) yang kualitasnya bersaing. Memilihnya berarti memajukan ekonomi bangsa.',
                    ikon: Icons.shopping_bag),
                ItemAkordeon('Menyeimbangkan arus globalisasi',
                    'Menyukai K-Pop, animasi Jepang, atau budaya pop Barat itu wajar, tetapi jangan mematikan rasa hormat pada identitas sendiri: pelajari tarian daerah, pakai batik, jaga bahasa Indonesia.',
                    ikon: Icons.public),
                ItemAkordeon('Mengukir prestasi',
                    'Kompetisi sains, olimpiade matematika, atau turnamen olahraga hingga tingkat nasional mengharumkan nama sekolah dan bangsa.',
                    ikon: Icons.emoji_events),
              ]),
            ]),
            ItemTab('Digital', Icons.phone_android, [
              Paragraf('Internet sering menjadi arena paling mudah untuk memecah belah bangsa lewat ujaran kebencian.'),
              Akordeon([
                ItemAkordeon('Memutus rantai hoaks',
                    'Berita bohong bernarasi provokatif berbahaya bagi persatuan. Verifikasi dulu sebelum mem-forward; menolak menyebar hoaks berarti menyelamatkan lingkungan dari adu domba.',
                    ikon: Icons.fact_check),
                ItemAkordeon('Mencegah perang sentimen di komentar',
                    'Jangan ikut memanaskan debat yang membawa nama suku atau daerah. Tahan jari dari komentar toxic yang memicu permusuhan.',
                    ikon: Icons.forum),
                ItemAkordeon('Representasi positif bangsa',
                    'Di game online atau forum internasional, sikapmu mencerminkan negaramu. Bersikap suportif dan tidak memaki membela martabat Indonesia.',
                    ikon: Icons.sports_esports),
              ]),
            ]),
          ]),
          const Paragraf(
              'Jika persatuan dipupuk sejak SMP, generasi penerus tidak mudah dipecah belah provokasi, dan negara terus berdiri tegak menaungi seluruh rakyatnya.'),
        ]),
        Bab('Sila 4: Kerakyatan yang Dipimpin Hikmat Kebijaksanaan', Icons.how_to_vote, [
          const Gambar('Lambang Sila 4: Kepala Banteng', aset: 'assets/images/materi/9.jpg'),
          const Paragraf(
              'Sila keempat dilambangkan **Kepala Banteng**. Banteng adalah hewan sosial yang suka berkumpul dan lebih kuat dalam kawanan, mencerminkan budaya bangsa yang mengutamakan **musyawarah** dalam mengambil keputusan penting.'),
          const KartuBalik([
            ItemKartuBalik('Musyawarah',
                'Proses membicarakan suatu masalah secara bersama-sama untuk mencari jalan keluar.',
                ikon: Icons.forum),
            ItemKartuBalik('Mufakat',
                'Hasil akhir atau kesepakatan bulat yang dicapai dari musyawarah.',
                ikon: Icons.people_outline),
            ItemKartuBalik('Kebijaksanaan',
                'Menggunakan akal sehat, hati nurani, dan pengendalian emosi selama musyawarah agar keputusan tidak merugikan pihak mana pun.',
                ikon: Icons.psychology),
          ]),
          const Callout(JenisCallout.info, 'Suara setiap siswa berharga',
              'Tidak ada individu, sepintar atau sekaya apa pun keluarganya, yang berhak mendikte atau memaksakan kehendak kepada teman lain.'),
          const TabInfo([
            ItemTab('Di Kelas', Icons.school, [
              Paragraf('Ruang kelas adalah laboratorium demokrasi pertama bagi remaja.'),
              Akordeon([
                ItemAkordeon('Memilih pengurus kelas',
                    'Pemilihan ketua, wakil, sekretaris, dan bendahara dilakukan terbuka (mufakat atau voting). Pilih berdasarkan kecakapan dan tanggung jawab, bukan sekadar populer atau teman satu geng.',
                    ikon: Icons.how_to_vote),
                ItemAkordeon('Menyelesaikan konflik lewat diskusi',
                    'Bila berselisih (misal tema dekorasi lomba), jangan adu mulut atau berkelahi. Duduk bersama, paparkan argumen logis, cari jalan tengah.',
                    ikon: Icons.forum),
                ItemAkordeon('Pembagian tugas kelompok yang proporsional',
                    'Siapa mencari materi, membuat presentasi, dan presentasi dirundingkan bersama. Keputusan sepihak ketua tanpa mendengar kesanggupan anggota melanggar nilai musyawarah.',
                    ikon: Icons.groups),
              ]),
            ]),
            ItemTab('Berani Bicara', Icons.record_voice_over, [
              Paragraf(
                  'Sila keempat bukan berarti diam dan mengangguk pada mayoritas. Demokrasi menuntut **partisipasi aktif**.'),
              Akordeon([
                ItemAkordeon('Berani speak up',
                    'Angkat tangan dan sampaikan idemu saat rapat OSIS, kegiatan Pramuka, atau di tengah pelajaran. Keberanian beropini adalah fondasi kerakyatan yang sehat.',
                    ikon: Icons.front_hand),
                ItemAkordeon('Kritik dengan etika',
                    'Siswa berhak mengkritik kebijakan sekolah atau pengurus kelas, namun dengan bahasa santun, logis, dan idealnya disertai solusi. Kritik yang mencemooh menghilangkan "kebijaksanaan".',
                    ikon: Icons.rule),
              ]),
            ]),
            ItemTab('Terima Keputusan', Icons.verified_user, [
              Callout(JenisCallout.peringatan, 'Ujian terberat Sila 4',
                  'Mudah berdemokrasi saat pendapat kita dipilih. Dibutuhkan kebesaran hati untuk tetap mendukung keputusan saat pendapat kita ditolak.'),
              Akordeon([
                ItemAkordeon('Lapang dada menerima mufakat',
                    'Ngambek, memisahkan diri, atau menyabotase rencana karena idenya tidak dipakai adalah sikap kekanak-kanakan dan anti-demokrasi.',
                    ikon: Icons.sentiment_satisfied),
                ItemAkordeon('Bertanggung jawab menjalankan keputusan',
                    'Setelah diketuk palu, seluruh anggota wajib melaksanakannya, terlepas dari setuju atau tidak sebelumnya.',
                    ikon: Icons.gavel),
              ]),
            ]),
            ItemTab('Digital', Icons.phone_android, [
              Paragraf(
                  'Grup WhatsApp, Line, Discord, hingga kolom komentar adalah ruang musyawarah virtual.'),
              Akordeon([
                ItemAkordeon('Menghargai opini di grup',
                    'Beri kesempatan orang lain mengetik argumennya secara utuh. Membanjiri grup dengan spam stiker agar pesan orang lain tenggelam tidak menghargai hak berpendapat.',
                    ikon: Icons.chat),
                ItemAkordeon('Hindari cancel culture yang destruktif',
                    'Jika ada teman beropini berbeda atau keliru, jangan ramai-ramai menyerang atau mengucilkannya. Sampaikan koreksi dengan santun dan hargai perbedaan pandangan.',
                    ikon: Icons.block),
              ]),
            ]),
          ]),
          const Paragraf(
              'Sila keempat menempatkan kedaulatan di tangan rakyat dengan asas musyawarah untuk mencapai mufakat: utamakan kepentingan bersama, hargai perbedaan pandangan, dan jangan memaksakan kehendak pribadi.'),
        ]),
        Bab('Sila 5: Keadilan Sosial bagi Seluruh Rakyat Indonesia', Icons.balance, [
          const Gambar('Lambang Sila 5: Padi dan Kapas', aset: 'assets/images/materi/10.jpg'),
          const GridIkon([
            ItemGrid(Icons.grass, 'Padi', 'Melambangkan pangan (makanan).'),
            ItemGrid(Icons.checkroom, 'Kapas', 'Melambangkan sandang (pakaian).'),
          ]),
          const Paragraf(
              'Keadilan bukan hanya aturan hukum, tetapi juga **pemenuhan kebutuhan hidup yang layak**. Penerapannya berpusat pada satu prinsip: **keseimbangan antara hak dan kewajiban**.'),
          const Perbandingan('Hak Pelajar', 'Kewajiban Pelajar', [
            BarisBanding(
                'Contoh di sekolah',
                'Fasilitas belajar yang nyaman dan penilaian objektif dari guru',
                'Mengerjakan tugas tepat waktu, mematuhi tata tertib, menjaga kebersihan fasilitas'),
          ]),
          const TabInfo([
            ItemTab('Hak & Kewajiban', Icons.balance, [
              Paragraf(
                  'Seseorang tidak bisa terus menuntut hak tanpa lebih dulu menunaikan kewajiban. Keseimbangan keduanya mengurangi kesenjangan sosial dan menciptakan kehidupan bersama yang harmonis.'),
              Akordeon([
                ItemAkordeon('Kewajiban sebelum hak',
                    'Menuntut nilai sempurna tanpa mau belajar adalah ketidakadilan terhadap diri sendiri dan guru.',
                    ikon: Icons.rule),
                ItemAkordeon('Hindari pilih kasih',
                    'Memilih anggota kelompok hanya karena populer tanpa melihat kemauan bekerja keras menciptakan ketimpangan dan rasa tidak adil.',
                    ikon: Icons.people),
                ItemAkordeon('Hargai karya & jerih payah orang lain',
                    'Beri apresiasi pada teman yang selesai presentasi atau juara. Menjiplak tugas (plagiarisme) atau merusak karya teman adalah perampasan hak.',
                    ikon: Icons.emoji_events),
              ]),
            ]),
            ItemTab('Hidup Sederhana', Icons.savings, [
              Paragraf(
                  'Gaya hidup sederhana dan etos kerja keras menghindarkan kita dari pemborosan dan menghargai setiap keringat perjuangan.'),
              Akordeon([
                ItemAkordeon('Menolak budaya pamer (flexing)',
                    'Memamerkan barang bermerek atau gadget terbaru secara berlebihan dapat melukai perasaan teman yang ekonomi keluarganya kurang beruntung.',
                    ikon: Icons.block),
                ItemAkordeon('Membiasakan menabung',
                    'Menyisihkan uang saku jauh lebih bijak daripada menuruti gengsi. Melatih kemandirian dan menghargai kerja keras orang tua.',
                    ikon: Icons.savings),
                ItemAkordeon('Etos kerja keras',
                    'Keadilan sosial mustahil diraih lewat kemalasan. Belajar tekun, pantang menyerah, dan aktif berkontribusi di sekolah.',
                    ikon: Icons.fitness_center),
              ]),
            ]),
            ItemTab('Digital', Icons.phone_android, [
              Paragraf(
                  'Keadilan di era digital: pemerataan akses teknologi dan ruang digital yang aman, santun, dan bebas disinformasi bagi semua orang tanpa diskriminasi.'),
              Akordeon([
                ItemAkordeon('Menghargai hak cipta',
                    'Mengunduh film, lagu, atau aplikasi bajakan merampas hak ekonomi penciptanya. Pakai platform resmi.',
                    ikon: Icons.copyright),
                ItemAkordeon('Berbagi fasilitas publik',
                    'Di komputer perpustakaan atau Wi-Fi publik, jangan memonopoli internet untuk mengunduh file pribadi yang sangat besar. Orang lain punya hak yang sama.',
                    ikon: Icons.wifi),
              ]),
            ]),
          ]),
          const Paragraf(
              'Ketika setiap orang menakar hak dan kewajibannya dengan tepat serta rela bekerja keras tanpa merugikan orang lain, harmoni, kesetaraan, dan kesejahteraan bersama di sekolah akan tercipta dengan sendirinya.'),
        ]),
        Bab('Rangkuman & Uji Pemahaman', Icons.quiz, [
          const KartuBalik([
            ItemKartuBalik('Sila 1 · Bintang',
                'Kompas moral: takwa, toleransi beragama, dan menjauhi fanatisme sempit.',
                ikon: Icons.star),
            ItemKartuBalik('Sila 2 · Rantai',
                'Zero tolerance bullying, adil, beradab, empati, dan peduli sesama.',
                ikon: Icons.favorite),
            ItemKartuBalik('Sila 3 · Beringin',
                'Berbaur tanpa geng, gotong royong, cinta tanah air, dan memutus hoaks.',
                ikon: Icons.public),
            ItemKartuBalik('Sila 4 · Banteng',
                'Musyawarah, berani berpendapat, dan lapang dada menerima keputusan.',
                ikon: Icons.how_to_vote),
            ItemKartuBalik('Sila 5 · Padi & Kapas',
                'Seimbang hak-kewajiban, hidup sederhana, kerja keras, hargai karya orang.',
                ikon: Icons.balance),
          ], petunjuk: 'Ketuk kartu untuk mengulang inti tiap sila'),
          const KuisKilat('Uji Pemahaman: Penerapan Sila', [
            SoalKilat(
                'Lambang sila ketiga, Persatuan Indonesia, adalah ...',
                ['Bintang', 'Rantai', 'Pohon Beringin', 'Kepala Banteng'],
                2,
                'Pohon Beringin: akar tunjang melambangkan persatuan, akar gantung melambangkan keberagaman.'),
            SoalKilat(
                'Mengapa Sila Ketuhanan diletakkan di urutan pertama?',
                [
                  'Karena paling mudah dihafal',
                  'Karena menjadi pondasi utama / dasar moral bagi sila lainnya',
                  'Karena paling sering diujikan',
                  'Karena paling singkat'
                ],
                1,
                'Nilai Ketuhanan menjadi dasar moral bagi keempat sila lainnya.'),
            SoalKilat(
                'Diam saat melihat teman dirundung sama artinya dengan ...',
                [
                  'Bersikap netral dan bijak',
                  'Menjaga ketenangan kelas',
                  'Ikut membiarkan ketidakadilan merajalela',
                  'Menerapkan sila keempat'
                ],
                2,
                'Pelajar bernilai Pancasila berani bersuara dan membela korban.'),
            SoalKilat(
                'Idemu tidak dipilih dalam musyawarah kelas. Sikap yang tepat adalah ...',
                [
                  'Ngambek dan keluar dari kelompok',
                  'Menerima dengan ikhlas dan ikut melaksanakan keputusan',
                  'Mengajak teman memboikot',
                  'Mengejek ide yang terpilih'
                ],
                1,
                'Lapang dada dan bertanggung jawab menjalankan keputusan adalah inti sila keempat.'),
            SoalKilat(
                'Padi dan Kapas pada lambang sila kelima melambangkan ...',
                [
                  'Pangan dan sandang',
                  'Pendidikan dan kesehatan',
                  'Hukum dan politik',
                  'Agama dan budaya'
                ],
                0,
                'Padi = pangan (makanan), kapas = sandang (pakaian).'),
            SoalKilat(
                'Memamerkan barang mewah berlebihan di media sosial (flexing) bertentangan dengan sila ...',
                ['ke-1', 'ke-2', 'ke-3', 'ke-5'],
                3,
                'Sila kelima menentang gaya hidup boros dan pamer yang dapat melukai teman kurang mampu.'),
            SoalKilat(
                'Yang dimaksud fanatisme sempit adalah ...',
                [
                  'Bangga pada agama sendiri dengan tetap menghormati yang lain',
                  'Merasa agamanya paling benar mutlak sehingga merasa berhak merendahkan agama lain',
                  'Rajin beribadah tepat waktu',
                  'Berteman dengan semua agama'
                ],
                1,
                'Fanatisme sempit memicu kebencian dan memecah persatuan.'),
          ]),
          const Ringkasan([
            'Pancasila harus dijalankan, bukan hanya dihafal.',
            'Setiap sila punya lambang dan penerapan di sekolah, rumah, dan dunia digital.',
            'Tolok ukurnya: sikap baik menjadi kebiasaan tanpa harus diawasi.',
          ]),
        ]),
      ],
    );
