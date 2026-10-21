import 'package:flutter/material.dart';
import 'materi_model.dart';

Materi buatMateri3() => Materi(
      id: 'k7-m3',
      nomor: 3,
      judul: 'Norma dan Keadilan',
      deskripsi:
          'Mengenal norma agama, kesusilaan, kesopanan, dan hukum sebagai aturan main hidup bersama.',
      ikon: Icons.balance,
      warna: const Color(0xFF303F9F),
      kataKunci: [
        'norma',
        'norma agama',
        'norma hukum',
        'kesusilaan',
        'kesopanan',
        'sanksi',
        'zoon politikon',
        'kaidah',
      ],
      bab: [
        Bab('Mengapa Manusia Butuh Norma?', Icons.groups, [
          const Paragraf(
              'Manusia adalah makhluk sosial (**zoon politikon**): tidak dapat hidup sendiri dan selalu membutuhkan orang lain. Dalam interaksi di rumah, sekolah, maupun masyarakat, setiap orang punya keinginan, kepentingan, dan karakter yang berbeda.'),
          const Callout(JenisCallout.peringatan, 'Tanpa aturan, apa yang terjadi?',
              'Jika setiap orang bertindak sesuka hati, perselisihan, kekacauan, dan benturan kepentingan akan mudah terjadi. Karena itu masyarakat membutuhkan pedoman bertingkah laku yang disebut **norma**.'),
          const Gambar('Ilustrasi: aktivitas bersama di lingkungan masyarakat', aset: 'assets/images/materi/11.jpg'),
        ]),
        Bab('Pengertian Norma', Icons.menu_book, [
          const GridIkon([
            ItemGrid(Icons.carpenter, 'Bahasa Latin: norma',
                'Berarti siku-siku, alat tukang kayu untuk mengukur apakah sudut sudah lurus dan presisi.'),
            ItemGrid(Icons.translate, 'Bahasa Arab: kaidah',
                'Berarti aturan atau pedoman.'),
          ]),
          const Callout(JenisCallout.info, 'Definisi',
              'Norma adalah kaidah, aturan, atau pedoman hidup yang **disepakati masyarakat** untuk mengatur tingkah laku manusia dalam berinteraksi.'),
          const Callout(JenisCallout.tips, 'Analogi: aturan main',
              'Dalam sepak bola ada aturan yang melarang pemain memegang bola dengan tangan (kecuali kiper) atau menakel lawan secara berbahaya. Tanpa aturan main, pertandingan tidak adil, aman, maupun menyenangkan. Begitu pula kehidupan nyata: norma melindungi hak dan memastikan kewajiban dijalankan dengan tanggung jawab.'),
        ]),
        Bab('Fungsi Utama Norma', Icons.rule, [
          const Paragraf(
              'Memahami fungsi norma membuat kita menjalankan peran dengan penuh kesadaran dan tanggung jawab sosial.'),
          const GridIkon([
            ItemGrid(Icons.security, 'Ketertiban & keamanan',
                'Mengatur lalu lintas hubungan antarmanusia agar tidak saling merugikan.'),
            ItemGrid(Icons.explore, 'Petunjuk arah',
                'Batasan jelas tindakan yang boleh dilakukan dan harus dihindari.'),
            ItemGrid(Icons.favorite, 'Keharmonisan sosial',
                'Mencegah konflik akibat perbedaan kepentingan.'),
            ItemGrid(Icons.balance, 'Wadah keadilan',
                'Memastikan setiap warga mendapat perlakuan sama dan seimbang.'),
          ]),
        ]),
        Bab('Empat Jenis Norma', Icons.layers, [
          const Paragraf(
              'Berdasarkan sumber, sifat, dan sanksinya, norma dibagi menjadi **empat jenis**. Pilih tab untuk mempelajari masing-masing.'),
          const TabInfo([
            ItemTab('Agama', Icons.self_improvement, [
              Paragraf(
                  'Kaidah atau petunjuk hidup yang bersumber langsung dari **wahyu Tuhan Yang Maha Esa**, disampaikan melalui nabi dan rasul serta dihimpun dalam kitab suci.'),
              GridIkon([
                ItemGrid(Icons.lock, 'Sifat',
                    'Dogmatis dan mutlak: tidak boleh diubah, dikurangi, atau ditawar manusia. Berlaku bagi seluruh pemeluk agama di mana pun.'),
                ItemGrid(Icons.hourglass_bottom, 'Sanksi',
                    'Spiritual dan tidak langsung dirasakan di dunia: dosa dan balasan di akhirat sesuai ajaran agamanya.'),
              ], kolom: 1),
              SubJudul('Contoh penerapan'),
              Daftar([
                'Beribadah tepat waktu sesuai agama (salat, kebaktian, puja bakti).',
                'Membaca dan mempelajari kitab suci.',
                'Menjauhi larangan agama: mencuri, berbohong, memfitnah, menyakiti sesama makhluk hidup.',
                'Menghormati dan berbakti kepada orang tua.',
              ]),
            ], warna: Color(0xFF00897B)),
            ItemTab('Kesusilaan', Icons.favorite, [
              Paragraf(
                  'Aturan hidup yang bersumber dari **hati nurani**. Setiap manusia dibekali dorongan alamiah mencintai kebaikan dan membenci keburukan; hati nurani menjadi "kompas moral" internal.'),
              GridIkon([
                ItemGrid(Icons.public, 'Sifat',
                    'Universal: diakui seluruh manusia tanpa memandang suku, bangsa, agama, atau budaya. Contoh: kejujuran dianggap positif di mana pun.'),
                ItemGrid(Icons.sentiment_dissatisfied, 'Sanksi',
                    'Dari dalam diri: rasa bersalah, penyesalan mendalam, malu, gelisah, dan ketidaktenangan batin.'),
              ], kolom: 1),
              SubJudul('Contoh penerapan'),
              Daftar([
                'Menolak mencontek saat ulangan meski ada kesempatan.',
                'Mengembalikan barang berharga atau uang milik orang lain yang ditemukan di jalan.',
                'Mengaku jujur saat bersalah tanpa melempar kesalahan ke orang lain.',
                'Berempati dan menolong teman yang kesulitan.',
              ]),
            ], warna: Color(0xFFD81B60)),
            ItemTab('Kesopanan', Icons.emoji_people, [
              Paragraf(
                  'Aturan bertingkah laku yang bersumber dari **kebiasaan, pergaulan, dan tata krama** yang tumbuh dalam suatu kelompok masyarakat. Mengatur etika pergaulan sehari-hari agar hubungan sosial menyenangkan dan saling menghargai.'),
              GridIkon([
                ItemGrid(Icons.map, 'Sifat',
                    'Relatif dan kedaerahan: yang sopan di satu tempat belum tentu sopan di tempat lain; dipengaruhi tradisi dan bisa berubah seiring zaman.'),
                ItemGrid(Icons.groups, 'Sanksi',
                    'Sosial: cemoohan, teguran, celaan, dianggap tidak beradat, hingga dikucilkan dari pergaulan.'),
              ], kolom: 1),
              SubJudul('Contoh penerapan'),
              Daftar([
                'Mengucap salam dan mencium tangan atau membungkuk saat berpapasan dengan orang tua atau guru.',
                'Berkata santun dan menolak bahasa kasar.',
                'Makan dan minum dengan tangan kanan; tidak memakai topi di dalam kelas saat pelajaran.',
                'Menghormati yang lebih tua dan menyayangi yang lebih muda.',
              ]),
            ], warna: Color(0xFFEF6C00)),
            ItemTab('Hukum', Icons.gavel, [
              Paragraf(
                  'Aturan yang dibuat **lembaga resmi negara** yang berwenang (seperti DPR dan Pemerintah) untuk mengatur ketertiban hidup bermasyarakat, berbangsa, dan bernegara.'),
              GridIkon([
                ItemGrid(Icons.policy, 'Sifat',
                    'Mengikat, tegas, dan memaksa (coercive). Berlaku untuk seluruh warga tanpa kecuali; negara punya alat seperti polisi, jaksa, dan hakim untuk menindak pelanggar.'),
                ItemGrid(Icons.local_police, 'Sanksi',
                    'Nyata, tegas, dan terukur secara tertulis: penjara, kurungan, denda uang, hingga pencabutan hak tertentu.'),
              ], kolom: 1),
              SubJudul('Contoh penerapan'),
              Daftar([
                'Mematuhi lalu lintas: helm standar saat naik motor, punya SIM bagi yang cukup umur.',
                'Dilarang tindak pidana: mencuri, merusak fasilitas umum, penganiayaan, membunuh.',
                'Wajib membayar pajak sesuai perundang-undangan.',
                'Menjaga ketertiban umum dan menolak perusakan atau tawuran.',
              ]),
            ], warna: Color(0xFF1565C0)),
          ]),
          const SubJudul('Tabel Perbandingan', ikon: Icons.table_chart),
          const TabelData([
            'Norma',
            'Sumber',
            'Sifat',
            'Sanksi'
          ], [
            [
              'Agama',
              'Wahyu Tuhan (kitab suci)',
              'Dogmatis & mutlak',
              'Dosa dan balasan di akhirat'
            ],
            [
              'Kesusilaan',
              'Hati nurani',
              'Universal',
              'Rasa bersalah, malu, gelisah'
            ],
            [
              'Kesopanan',
              'Kebiasaan & tata krama masyarakat',
              'Relatif & kedaerahan',
              'Cemoohan, teguran, dikucilkan'
            ],
            [
              'Hukum',
              'Lembaga negara berwenang',
              'Mengikat, tegas, memaksa',
              'Penjara, kurungan, denda, pencabutan hak'
            ],
          ]),
        ]),
        Bab('Satu Perbuatan, Empat Norma', Icons.sync_alt, [
          const Paragraf(
              'Keempat norma tidak berdiri sendiri, tetapi **saling melengkapi**. Contohnya tindakan **mencuri**. Ketuk kartu untuk melihat sudut pandang tiap norma:'),
          const KartuBalik([
            ItemKartuBalik('Norma Agama',
                'Mencuri adalah perbuatan dosa yang dilarang Tuhan.',
                ikon: Icons.self_improvement),
            ItemKartuBalik('Norma Kesusilaan',
                'Mencuri membuat hati nurani merasa bersalah dan malu.',
                ikon: Icons.favorite),
            ItemKartuBalik('Norma Kesopanan',
                'Mencuri adalah perbuatan yang sangat tercela dalam pergaulan.',
                ikon: Icons.emoji_people),
            ItemKartuBalik('Norma Hukum',
                'Mencuri akan ditangkap polisi dan diancam hukuman penjara.',
                ikon: Icons.gavel),
          ]),
          const Callout(JenisCallout.penting, 'Tertib lahir dan batin',
              'Ketika keempat norma dipatuhi seimbang, tercipta lingkungan yang aman secara hukum, tenang secara batin, santun dalam budaya, dan terarah secara spiritual.'),
        ]),
        Bab('Pentingnya Mematuhi Norma bagi Pelajar SMP', Icons.school, [
          const Paragraf(
              'Bagi remaja, patuh norma bukan pembatasan kebebasan, melainkan **latihan membentuk integritas moral dan karakter**. Pelajar yang terbiasa tertib sejak dini tumbuh menjadi pribadi bertanggung jawab, disukai dalam pergaulan, dan siap menjadi warga negara beradab.'),
          const SubJudul('Mulai dari langkah kecil', ikon: Icons.directions_walk),
          const Daftar([
            'Hormati guru dan orang tua.',
            'Bersikap jujur saat ulangan.',
            'Gunakan media sosial dengan santun.',
            'Patuhi tata tertib sekolah.',
          ], bernomor: true),
          const Callout(JenisCallout.tips, 'Investasi terbaik',
              'Kepatuhan terhadap norma adalah investasi terbaik untuk masa depan diri sendiri dan bangsa.'),
        ]),
        Bab('Rangkuman & Uji Pemahaman', Icons.quiz, [
          const Ringkasan([
            'Norma = pedoman hidup yang disepakati masyarakat; berasal dari kata Latin yang berarti siku-siku.',
            'Ada 4 norma: agama, kesusilaan, kesopanan, dan hukum.',
            'Sanksi norma agama bersifat spiritual, kesusilaan dari hati nurani, kesopanan sosial, hukum tegas dan memaksa.',
            'Satu perbuatan bisa melanggar keempat norma sekaligus.',
          ]),
          const KuisKilat('Tebak Jenis Norma', [
            SoalKilat(
                'Beribadah tepat waktu sesuai agama yang dianut termasuk penerapan norma ...',
                ['Agama', 'Kesusilaan', 'Kesopanan', 'Hukum'],
                0,
                'Ibadah bersumber dari ajaran agama sehingga masuk norma agama.'),
            SoalKilat(
                'Menolak mencontek meski ada kesempatan karena takut merasa bersalah adalah norma ...',
                ['Agama', 'Kesusilaan', 'Kesopanan', 'Hukum'],
                1,
                'Sumbernya hati nurani, sanksinya rasa bersalah dan malu dari dalam diri.'),
            SoalKilat(
                'Mencium tangan guru saat berpapasan adalah contoh norma ...',
                ['Kesusilaan', 'Hukum', 'Agama', 'Kesopanan'],
                3,
                'Tata krama pergaulan bersifat relatif dan kedaerahan: norma kesopanan.'),
            SoalKilat(
                'Memakai helm standar saat naik motor diatur oleh norma ...',
                ['Hukum', 'Kesopanan', 'Agama', 'Kesusilaan'],
                0,
                'Dibuat lembaga negara dan bersanksi tegas: norma hukum.'),
            SoalKilat(
                'Norma yang bersifat universal, diakui semua manusia tanpa memandang suku dan agama, adalah ...',
                ['Kesopanan', 'Kesusilaan', 'Hukum', 'Agama'],
                1,
                'Kejujuran dianggap baik oleh semua masyarakat: ciri norma kesusilaan.'),
            SoalKilat(
                'Sanksi berupa cemoohan, teguran, dan dikucilkan berasal dari pelanggaran norma ...',
                ['Agama', 'Hukum', 'Kesopanan', 'Kesusilaan'],
                2,
                'Sanksi sosial adalah ciri norma kesopanan.'),
            SoalKilat(
                'Sumber norma agama adalah ...',
                [
                  'Hati nurani',
                  'Kebiasaan masyarakat',
                  'DPR dan Pemerintah',
                  'Wahyu Tuhan melalui nabi dan rasul'
                ],
                3,
                'Norma agama bersumber langsung dari wahyu Tuhan yang dihimpun dalam kitab suci.'),
          ]),
        ]),
      ],
    );
