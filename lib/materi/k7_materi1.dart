import 'package:flutter/material.dart';
import 'materi_model.dart';

Materi buatMateri1() => Materi(
      id: 'k7-m1',
      nomor: 1,
      judul: 'Sejarah Kelahiran Pancasila',
      deskripsi:
          'Dari janji kemerdekaan Jepang, sidang BPUPK, hingga Pancasila disahkan PPKI.',
      ikon: Icons.history_edu,
      warna: const Color(0xFFB71C1C),
      kataKunci: [
        'BPUPK',
        'PPKI',
        'Piagam Jakarta',
        'Panitia Sembilan',
        '1 Juni 1945',
        'Soekarno',
        'Yamin',
        'Soepomo',
        'Hatta',
        'Radjiman',
        'Jepang',
        'Hari Lahir Pancasila',
      ],
      bab: [
        Bab('Pancasila Tidak Lahir dalam Semalam', Icons.lightbulb, [
          const Paragraf(
              'Pancasila adalah hasil **perenungan panjang**, perdebatan gagasan, dan pengorbanan ego sektoral demi berdirinya sebuah negara yang merdeka dan bersatu. Yuk telusuri prosesnya langkah demi langkah!'),
          const Gambar('Ilustrasi: suasana persidangan para pendiri bangsa', aset: 'assets/images/materi/1.jpg'),
          const SubJudul('Peta Waktu Singkat', ikon: Icons.timeline),
          const Linimasa([
            LangkahLinimasa('7 September 1944', 'Janji Kemerdekaan Jepang',
                'PM Jepang Kuniaki Koiso menjanjikan kemerdekaan bagi Indonesia karena Jepang terdesak dalam Perang Pasifik.',
                ikon: Icons.flag),
            LangkahLinimasa('1 Maret 1945', 'BPUPK diumumkan',
                'Letjen Kumakichi Harada mengumumkan pembentukan Badan Penyelidik Usaha-Usaha Persiapan Kemerdekaan (BPUPK).',
                ikon: Icons.groups),
            LangkahLinimasa('29 April 1945', 'BPUPK diresmikan',
                'Susunan BPUPK diresmikan, bertepatan dengan ulang tahun Kaisar Hirohito.',
                ikon: Icons.account_balance),
            LangkahLinimasa(
                '29 Mei – 1 Juni 1945',
                'Sidang Pertama BPUPK',
                'Para tokoh berpidato menjawab pertanyaan: "Di atas dasar apakah Negara Indonesia Merdeka ini akan didirikan?"',
                ikon: Icons.record_voice_over),
            LangkahLinimasa('22 Juni 1945', 'Piagam Jakarta',
                'Panitia Sembilan menghasilkan dokumen kompromi bersejarah (Jakarta Charter).',
                ikon: Icons.article),
            LangkahLinimasa('7 Agustus 1945', 'PPKI dibentuk',
                'Jepang membubarkan BPUPK dan menggantinya dengan PPKI, diketuai Ir. Soekarno dan wakil Moh. Hatta.',
                ikon: Icons.swap_horiz),
            LangkahLinimasa('17 Agustus 1945', 'Proklamasi & krisis sore hari',
                'Perwakilan Indonesia Bagian Timur menyampaikan keberatan atas tujuh kata dalam sila pertama Piagam Jakarta.',
                ikon: Icons.warning_amber_rounded),
            LangkahLinimasa('18 Agustus 1945', 'Pancasila disahkan',
                'PPKI mengesahkan UUD 1945. Pembukaan alinea keempat memuat rumusan final dasar negara.',
                ikon: Icons.gavel),
          ]),
        ]),
        Bab('Latar Belakang: Jepang Terdesak', Icons.flag, [
          const Paragraf(
              'Memasuki tahun **1944**, posisi tentara Jepang dalam Perang Asia Pasifik (Perang Dunia II) semakin terdesak oleh pasukan Sekutu. Banyak wilayah kekuasaan Jepang yang jatuh.'),
          const Paragraf(
              'Menyadari posisinya melemah, Perdana Menteri Jepang **Kuniaki Koiso** memberikan **"Janji Kemerdekaan"** kepada bangsa Indonesia pada **7 September 1944**.'),
          const Callout(JenisCallout.penting, 'Murni taktik politik',
              'Tujuan janji itu agar rakyat Indonesia mau membantu Jepang melawan Sekutu, bukan karena Jepang tulus memberi kemerdekaan.'),
          const Gambar('Ilustrasi: Perang Pasifik dan Janji Kemerdekaan 1944', aset: 'assets/images/materi/2.jpg'),
        ]),
        Bab('Pembentukan BPUPK', Icons.groups, [
          const Paragraf(
              'Sebagai realisasi janji tersebut, pada **1 Maret 1945** Letnan Jenderal **Kumakichi Harada** mengumumkan pembentukan **Badan Penyelidik Usaha-Usaha Persiapan Kemerdekaan (BPUPK)** atau Dokuritsu Junbi Cosakai.'),
          const AngkaKunci([
            ItemAngka(67, 'anggota seluruhnya'),
            ItemAngka(60, 'tokoh Indonesia'),
            ItemAngka(7, 'anggota istimewa Jepang (tanpa hak suara)'),
          ]),
          const Akordeon([
            ItemAkordeon('Ketua', 'Dr. K.R.T. Radjiman Wedyodiningrat',
                ikon: Icons.star),
            ItemAkordeon('Ketua Muda (Wakil)',
                'Ichibangase Yosio (orang Jepang) dan Raden Pandji Soeroso.',
                ikon: Icons.people),
            ItemAkordeon('Tujuan',
                'Mempelajari dan menyelidiki hal-hal krusial terkait pembentukan negara Indonesia merdeka: aspek politik, ekonomi, hukum, hingga dasar negara.',
                ikon: Icons.flag),
          ], bukaPertama: true),
          const Callout(JenisCallout.info, 'Peresmian',
              'Susunan BPUPK baru diresmikan pada 29 April 1945 (bertepatan dengan hari ulang tahun Kaisar Hirohito).'),
        ]),
        Bab('Sidang Pertama BPUPK', Icons.record_voice_over, [
          const Paragraf(
              'Sidang berlangsung pada **29 Mei – 1 Juni 1945** di Gedung Chuo Sangi In (sekarang **Gedung Pancasila** di Jakarta). Sidang dibuka dengan pertanyaan yang sangat mendasar dari sang Ketua:'),
          const Kutipan(
              'Di atas dasar apakah Negara Indonesia Merdeka ini akan didirikan?',
              sumber: 'dr. Radjiman Wedyodiningrat'),
          const Paragraf(
              'Pertanyaan inilah yang memicu para tokoh bangsa memeras otak dan berpidato mengemukakan gagasannya.'),
          const Gambar('Foto: Gedung Chuo Sangi In (sekarang Gedung Pancasila)', aset: 'assets/images/materi/3.jpg'),
        ]),
        Bab('Tiga Tokoh Perumus Dasar Negara', Icons.people, [
          const Paragraf(
              'Puluhan tokoh berbicara selama sidang pertama, tetapi ada **tiga tokoh utama** yang secara komprehensif merumuskan rancangan dasar negara.'),
          const KartuGeser([
            KartuInfo('29 Mei 1945', 'Mr. Mohammad Yamin',
                'Tokoh pertama yang berpidato. Ia menekankan dasar negara harus berasal dari peradaban dan kebudayaan Indonesia sendiri, bukan meniru luar negeri.',
                poin: [
                  'Mengaku mengusulkan: Peri Kebangsaan, Peri Kemanusiaan, Peri Ketuhanan, Peri Kerakyatan, dan Kesejahteraan Rakyat.',
                  'Pidatonya berjudul "Asas dan Dasar Negara Kebangsaan Republik Indonesia".',
                  'Menelusuri kejayaan Sriwijaya dan Majapahit sebagai bukti tradisi ketatanegaraan yang kuat.',
                  'Menolak negara kerajaan/feodal; mengusulkan Negara Kesatuan (Republik) berakar pada peradaban Timur.',
                ],
                ikon: Icons.menu_book),
            KartuInfo('31 Mei 1945', 'Prof. Dr. Mr. Soepomo',
                'Pakar hukum adat yang menyampaikan gagasan tentang struktur sosial bangsa Indonesia.',
                poin: [
                  'Teori Negara Integralistik: menolak individualisme (Eropa) dan komunisme (Soviet).',
                  'Mengusulkan "Negara Kekeluargaan".',
                  'Negara tidak memihak satu golongan atau mayoritas, melainkan bersatu dengan seluruh rakyatnya.',
                  'Pemimpin dan rakyat ibarat bapak dan anak dalam keluarga besar: persatuan, gotong royong, musyawarah.',
                ],
                ikon: Icons.gavel),
            KartuInfo('1 Juni 1945', 'Ir. Soekarno',
                'Tokoh yang akhirnya menjawab pertanyaan dr. Radjiman secara sistematis, konseptual, dan konkret.',
                poin: [
                  'Berpidato tanpa teks dan mengemukakan lima prinsip dasar negara.',
                  'Atas petunjuk seorang teman ahli bahasa, ia menamakannya Pancasila.',
                  'Hari pidato ini ditetapkan sebagai tonggak Hari Lahir Pancasila.',
                ],
                ikon: Icons.star),
          ]),
          const Callout(JenisCallout.fakta, 'Fakta Sejarah yang Diluruskan',
              'Berbeda dengan buku teks lama, Yamin ternyata dalam pidatonya tidak menyampaikan rumusan lima asas (Peri Kebangsaan dll.). Pidato aslinya berfokus pada bentuk negara dan tinjauan sejarah.'),
          const Gambar('Ilustrasi: Yamin, Soepomo, dan Soekarno', aset: 'assets/images/materi/4.jpg', rasio: 2),
        ]),
        Bab('Lima Dasar Soekarno & Lahirnya Istilah Pancasila', Icons.star, [
          const Paragraf(
              'Pada **1 Juni 1945** Soekarno berpidato tanpa teks dan mengemukakan lima prinsip. Ketuk kartu untuk melihat penjelasannya!'),
          const KartuBalik([
            ItemKartuBalik('1. Kebangsaan Indonesia',
                'Bukan chauvinisme, melainkan nasionalisme yang kuat.',
                ikon: Icons.flag),
            ItemKartuBalik('2. Internasionalisme / Perikemanusiaan',
                'Nasionalisme yang diimbangi persaudaraan dunia.',
                ikon: Icons.public),
            ItemKartuBalik('3. Mufakat atau Demokrasi',
                'Perwakilan politik bagi seluruh golongan.',
                ikon: Icons.how_to_vote),
            ItemKartuBalik('4. Kesejahteraan Sosial',
                'Keadilan ekonomi, tidak ada kemiskinan di alam merdeka.',
                ikon: Icons.favorite),
            ItemKartuBalik('5. Ketuhanan yang Berkebudayaan',
                'Ketuhanan yang saling menghormati antarumat beragama.',
                ikon: Icons.star),
          ]),
          const Callout(JenisCallout.penting, '1 Juni = Hari Lahir Pancasila',
              'Hari pidato inilah yang ditetapkan sebagai tonggak Hari Lahir Pancasila.'),
          const Gambar('Ilustrasi: Ir. Soekarno berpidato pada 1 Juni 1945', aset: 'assets/images/materi/5.jpg'),
        ]),
        Bab('Reses dan Panitia Sembilan', Icons.groups, [
          const Paragraf(
              'Hingga akhir sidang 1 Juni belum ada kesepakatan tentang dasar negara karena **perdebatan tajam** antara dua golongan. Untuk memecahkan kebuntuan, BPUPK reses dan dibentuklah panitia kecil beranggotakan **9 orang** yang diketuai **Ir. Soekarno**.'),
          const AngkaKunci([
            ItemAngka(9, 'anggota panitia'),
            ItemAngka(5, 'golongan nasionalis'),
            ItemAngka(4, 'golongan Islam'),
          ]),
          const Perbandingan('Golongan Nasionalis Sekuler', 'Golongan Islam', [
            BarisBanding('Keinginan', 'Negara kebangsaan',
                'Negara berdasarkan syariat Islam'),
            BarisBanding(
                'Anggota Panitia Sembilan',
                'Soekarno, Moh. Hatta, M. Yamin, A.A. Maramis, Achmad Soebardjo',
                'KH Wahid Hasyim, Kahar Muzakkir, Haji Agus Salim, Abikusno Tjokrosujoso'),
          ]),
        ]),
        Bab('Piagam Jakarta (22 Juni 1945)', Icons.article, [
          const Paragraf(
              'Panitia Sembilan bersidang dengan alot, namun akhirnya menghasilkan dokumen kompromi bersejarah bernama **Jakarta Charter (Piagam Jakarta)** yang menyatukan dua golongan tersebut. Rumusan dasar negaranya:'),
          const Daftar([
            'Ketuhanan, **dengan kewajiban menjalankan syari\'at Islam bagi pemeluk-pemeluknya.**',
            'Kemanusiaan yang adil dan beradab.',
            'Persatuan Indonesia.',
            'Kerakyatan yang dipimpin oleh hikmat kebijaksanaan dalam permusyawaratan/perwakilan.',
            'Keadilan sosial bagi seluruh rakyat Indonesia.',
          ], bernomor: true),
        ]),
        Bab('Dari BPUPK ke PPKI', Icons.swap_horiz, [
          const Paragraf(
              'Setelah tugas BPUPK menyusun rancangan UUD selesai, Jepang membubarkannya dan menggantinya dengan PPKI pada **7 Agustus 1945**.'),
          const Perbandingan('BPUPK', 'PPKI', [
            BarisBanding('Nama Jepang', 'Dokuritsu Junbi Cosakai',
                'Dokuritsu Junbi Inkai'),
            BarisBanding('Ketua', 'Dr. K.R.T. Radjiman Wedyodiningrat',
                'Ir. Soekarno (wakil: Moh. Hatta)'),
            BarisBanding('Keanggotaan',
                '67 orang: 60 tokoh Indonesia + 7 anggota istimewa Jepang tanpa hak suara',
                'Murni orang Indonesia, tanda kemerdekaan sepenuhnya di tangan bangsa Indonesia'),
          ]),
        ]),
        Bab('Krisis Sore Hari, 17 Agustus 1945', Icons.warning_amber_rounded, [
          const Paragraf(
              'Setelah Proklamasi dibacakan pagi hari, **sore harinya** Moh. Hatta didatangi seorang perwira Angkatan Laut Jepang. Ia menyampaikan aspirasi perwakilan rakyat **Indonesia Bagian Timur** (seperti Maluku, Minahasa, dan lainnya yang mayoritas beragama Kristen/Katolik). Mereka keberatan dengan **tujuh kata** dalam sila pertama Piagam Jakarta.'),
          const Kutipan(
              'Jika tujuh kata itu tidak dihilangkan, kami lebih baik berdiri di luar Republik Indonesia.',
              sumber: 'Aspirasi perwakilan Indonesia Bagian Timur'),
          const Callout(JenisCallout.peringatan, 'Tujuh kata yang dipersoalkan',
              '"dengan kewajiban menjalankan syari\'at Islam bagi pemeluk-pemeluknya"'),
        ]),
        Bab('Lobi Pagi 18 Agustus 1945', Icons.forum, [
          const Paragraf(
              'Menyadari Republik yang baru berumur satu hari terancam pecah, pada pagi **18 Agustus 1945** (sebelum sidang perdana PPKI) Moh. Hatta berinisiatif mengumpulkan tokoh-tokoh Islam:'),
          const Daftar([
            'Ki Bagus Hadikusumo',
            'KH Wahid Hasyim',
            'Mr. Kasman Singodimedjo',
            'Teuku Mohammad Hasan',
          ]),
          const Paragraf(
              'Hatta melobi mereka memikirkan keutuhan Indonesia dari **Sabang sampai Merauke**. Melalui diskusi yang mencerminkan jiwa besar, **toleransi yang tinggi**, dan semangat persatuan, para tokoh Islam dengan ikhlas setuju menghapus tujuh kata tersebut.'),
        ]),
        Bab('Sidang PPKI 18 Agustus 1945: Pancasila Disahkan', Icons.gavel, [
          const Paragraf('Keputusan penting yang diambil pada sidang tersebut:'),
          const Daftar([
            'Mengesahkan Undang-Undang Dasar (UUD 1945).',
            'Memilih Ir. Soekarno sebagai Presiden dan Moh. Hatta sebagai Wakil Presiden.',
            'Membentuk Komite Nasional Indonesia Pusat (KNIP) untuk membantu tugas Presiden.',
          ], bernomor: true),
          const Paragraf(
              'Pembukaan UUD 1945 **Alinea Keempat** memuat rumusan dasar negara yang final, sah, dan berlaku hingga kini. Bandingkan dengan Piagam Jakarta:'),
          const Perbandingan('Piagam Jakarta (22 Juni)',
              'Pembukaan UUD 1945 (18 Agustus)', [
            BarisBanding(
                'Sila 1',
                'Ketuhanan, dengan kewajiban menjalankan syari\'at Islam bagi pemeluk-pemeluknya',
                'Ketuhanan Yang Maha Esa'),
            BarisBanding('Sila 2 – 5',
                'Kemanusiaan yang adil dan beradab; Persatuan Indonesia; Kerakyatan...; Keadilan sosial...',
                'Tidak berubah'),
          ]),
          const Callout(JenisCallout.penting, 'Pancasila resmi menjadi Dasar Negara',
              'Dengan disahkannya UUD 1945, secara hukum tata negara Pancasila resmi menjadi Dasar Negara Republik Indonesia. Kuncinya: semangat **Gotong Royong, Musyawarah, dan Toleransi** para pendiri bangsa (Founding Fathers).'),
        ]),
        Bab('Rangkuman & Uji Pemahaman', Icons.quiz, [
          const Ringkasan([
            'Janji Kemerdekaan Jepang (7 Sep 1944) hanyalah taktik politik.',
            'BPUPK membahas dasar negara; Yamin, Soepomo, dan Soekarno adalah tiga perumus utama.',
            'Soekarno menamai Pancasila pada 1 Juni 1945 (Hari Lahir Pancasila).',
            'Panitia Sembilan melahirkan Piagam Jakarta (22 Juni 1945).',
            'Pada 18 Agustus 1945 PPKI mengesahkan UUD 1945 dan Pancasila dengan semangat toleransi.',
          ]),
          const KuisKilat('Uji Pemahaman: Sejarah Pancasila', [
            SoalKilat(
                'Siapa Perdana Menteri Jepang yang memberi "Janji Kemerdekaan" pada 7 September 1944?',
                [
                  'Kuniaki Koiso',
                  'Kumakichi Harada',
                  'Ichibangase Yosio',
                  'Radjiman Wedyodiningrat'
                ],
                0,
                'Kuniaki Koiso memberi janji itu sebagai taktik agar rakyat Indonesia membantu Jepang melawan Sekutu.'),
            SoalKilat(
                'Tanggal 1 Juni 1945 ditetapkan sebagai ...',
                [
                  'Hari Proklamasi',
                  'Hari Lahir Pancasila',
                  'Hari Kesaktian Pancasila',
                  'Hari Pahlawan'
                ],
                1,
                'Pidato Soekarno pada 1 Juni 1945 menjadi tonggak Hari Lahir Pancasila.'),
            SoalKilat(
                'Gagasan "Negara Kekeluargaan" (Integralistik) disampaikan oleh ...',
                ['Mohammad Yamin', 'Soepomo', 'Soekarno', 'Moh. Hatta'],
                1,
                'Soepomo menolak individualisme dan komunisme, serta mengusulkan negara kekeluargaan.'),
            SoalKilat(
                'Dokumen kompromi hasil kerja Panitia Sembilan pada 22 Juni 1945 disebut ...',
                [
                  'Piagam Jakarta',
                  'Teks Proklamasi',
                  'Dekrit Presiden',
                  'Janji Koiso'
                ],
                0,
                'Piagam Jakarta (Jakarta Charter) menyatukan golongan nasionalis dan golongan Islam.'),
            SoalKilat(
                'Apa hasil lobi Moh. Hatta pada pagi 18 Agustus 1945?',
                [
                  'Tokoh Islam menolak perubahan apa pun',
                  'Sidang PPKI ditunda',
                  'Tokoh Islam ikhlas menghapus tujuh kata demi persatuan',
                  'Indonesia Timur keluar dari Republik'
                ],
                2,
                'Dengan toleransi dan jiwa besar, tujuh kata dihapus sehingga Indonesia tetap utuh.'),
            SoalKilat(
                'Manakah yang BUKAN keputusan sidang PPKI 18 Agustus 1945?',
                [
                  'Mengesahkan UUD 1945',
                  'Memilih Presiden dan Wakil Presiden',
                  'Membentuk KNIP',
                  'Membacakan teks Proklamasi'
                ],
                3,
                'Proklamasi dibacakan pada 17 Agustus 1945, bukan dalam sidang PPKI 18 Agustus.'),
          ]),
        ]),
      ],
    );
