import 'package:flutter/material.dart';
import 'materi_model.dart';

Materi buatMateri5() => Materi(
      id: 'k7-m5',
      nomor: 5,
      judul: 'Wilayah Negara Kesatuan Republik Indonesia',
      deskripsi:
          'Unsur negara, batas wilayah darat-laut-udara, negara kesatuan, otonomi daerah, dan menjaga keutuhan NKRI.',
      ikon: Icons.map,
      warna: const Color(0xFF1565C0),
      kataKunci: [
        'wilayah NKRI',
        'unsur negara',
        'otonomi daerah',
        'desentralisasi',
        'laut teritorial',
        'ZEE',
        'deklarasi djuanda',
        'negara kesatuan',
        'kedaulatan',
        'landas kontinen',
      ],
      bab: [
        Bab('Rumah Besar Bernama Indonesia', Icons.home, [
          const Paragraf(
              'Bayangkan Indonesia sebagai **rumah keluarga raksasa**. Mempelajari wilayah NKRI dari Sabang sampai Merauke bukan sekadar menghafal batas di peta, tetapi agar kita **mengenal, mencintai, dan siap menjaga** rumah kebanggaan ini.'),
          const GridIkon([
            ItemGrid(Icons.terrain, 'Wilayah darat',
                'Lantai tempat berpijak: ribuan pulau.'),
            ItemGrid(Icons.water, 'Wilayah laut',
                'Halaman air yang sangat luas penghubung pulau.'),
            ItemGrid(Icons.flight, 'Wilayah udara',
                'Atap pelindung yang tak terbatas di atasnya.'),
          ], kolom: 1),
          const Gambar('Peta: Indonesia dari Sabang sampai Merauke', aset: 'assets/images/materi/15.jpg'),
        ]),
        Bab('Makna Negara dan Unsur-unsurnya', Icons.account_balance, [
          const Paragraf(
              '**Negara** adalah organisasi kekuasaan yang memiliki wilayah tertentu, didiami rakyat, dan memiliki pemerintahan berdaulat untuk mengatur urusan demi tujuan bersama.'),
          const Perbandingan('Sekolah', 'Negara', [
            BarisBanding('', 'Murid', 'Rakyat'),
            BarisBanding('', 'Gedung dan lapangan', 'Wilayah'),
            BarisBanding('', 'Kepala sekolah dan guru', 'Pemerintah'),
            BarisBanding(
                '', 'Diakui dinas pendidikan', 'Pengakuan pihak luar / negara lain'),
          ]),
          const Paragraf(
              'Sebuah negara sah jika memenuhi **empat unsur**: tiga unsur **konstitutif** (mutlak harus ada) dan satu unsur **deklaratif** (pelengkap). Pilih tab:'),
          const TabInfo([
            ItemTab('Rakyat', Icons.people, [
              Paragraf(
                  'Semua orang yang berada di wilayah suatu negara dan taat pada peraturan negara tersebut. Tanpa rakyat tidak ada yang diatur dan tidak ada yang membela negara.'),
              Perbandingan('Penduduk', 'Bukan penduduk', [
                BarisBanding(
                    '',
                    'Menetap: WNI dan WNA yang punya izin tinggal',
                    'Hanya berkunjung sementara, mis. turis asing'),
              ]),
            ]),
            ItemTab('Wilayah', Icons.map, [
              Paragraf(
                  'Ruang tempat rakyat hidup dan pemerintah menjalankan kekuasaannya, tidak hanya tanah.'),
              GridIkon([
                ItemGrid(Icons.terrain, 'Darat',
                    'Dibatasi batas alam (gunung, sungai), batas buatan (pagar, tembok), atau batas astronomis.'),
                ItemGrid(Icons.water, 'Laut',
                    'Lautan di dalam wilayah daratan maupun yang berbatasan dengan perairan internasional.'),
                ItemGrid(Icons.flight, 'Udara',
                    'Ruang udara tepat di atas wilayah darat dan laut.'),
                ItemGrid(Icons.account_balance, 'Ekstrateritorial',
                    'Diakui hukum internasional sebagai wilayah negara meski di negara lain, mis. KBRI di luar negeri atau kapal berbendera Indonesia di laut lepas.'),
              ]),
            ]),
            ItemTab('Pemerintah', Icons.gavel, [
              Paragraf(
                  'Lembaga yang berwenang mengatur kehidupan rakyat dan menjaga wilayah. **Berdaulat** berarti memegang kekuasaan tertinggi.'),
              GridIkon([
                ItemGrid(Icons.arrow_downward, 'Kedaulatan ke dalam',
                    'Kekuasaan tertinggi yang dihormati rakyatnya.'),
                ItemGrid(Icons.arrow_upward, 'Kedaulatan ke luar',
                    'Setara dengan negara lain dan tidak tunduk pada campur tangan negara asing.'),
              ], kolom: 1),
            ]),
            ItemTab('Pengakuan', Icons.verified, [
              Paragraf(
                  'Unsur **deklaratif**: negara tetap butuh pengakuan negara lain agar dapat bekerja sama internasional (berdagang, bertukar duta besar).'),
              Perbandingan('De facto', 'De jure', [
                BarisBanding('', 'Pengakuan berdasarkan fakta bahwa negara itu memang sudah berdiri.',
                    'Pengakuan resmi secara hukum internasional sehingga sah dalam pergaulan global.'),
              ]),
            ], warna: Color(0xFF6A1B9A)),
          ]),
        ]),
        Bab('Wilayah NKRI: Negara Kepulauan Berciri Nusantara', Icons.map, [
          const Kutipan(
              'Negara Kesatuan Republik Indonesia adalah sebuah negara kepulauan yang berciri Nusantara dengan wilayah dan batas-batas serta hak-haknya ditetapkan dengan undang-undang.',
              sumber: 'Pasal 25A UUD 1945'),
          const Paragraf(
              '"Berciri Nusantara" berarti lautan **bukan pemisah** antarpulau, melainkan **pemersatu** yang merangkai ribuan pulau menjadi satu kesatuan utuh.'),
          const AngkaKunci([
            ItemAngka(17000, 'pulau di seluruh Nusantara', akhiran: '+', pisah: true),
            ItemAngka(1957, 'Deklarasi Djuanda (13 Des)'),
            ItemAngka(1982, 'diakui PBB lewat UNCLOS'),
          ]),
          const SubJudul('Batas Darat', ikon: Icons.terrain),
          const GridIkon([
            ItemGrid(Icons.north, 'Utara: Malaysia', 'Di Pulau Kalimantan (Borneo).'),
            ItemGrid(Icons.east, 'Timur: Papua Nugini', 'Di Pulau Papua.'),
            ItemGrid(Icons.south, 'Selatan: Timor Leste', 'Di Pulau Timor.'),
          ], kolom: 1),
          const SubJudul('Batas Laut', ikon: Icons.water),
          const Paragraf(
              'Pembagian perairan penting untuk melindungi kekayaan alam seperti ikan dan minyak bumi.'),
          const ZonaLaut(),
          const Callout(JenisCallout.fakta, 'Posisi Silang Strategis',
              'Indonesia berada di antara dua benua (Asia dan Australia) dan dua samudra (Hindia dan Pasifik), jalur perdagangan internasional yang ramai. Indonesia juga berada di **Ring of Fire** sehingga punya banyak gunung berapi dan tanah subur, tetapi rawan gempa.'),
        ]),
        Bab('Indonesia sebagai Negara Kesatuan', Icons.flag, [
          const Paragraf(
              'Bentuk negara kita adalah **Negara Kesatuan (Unitary State)**, bukan Negara Serikat (Federal) seperti Amerika Serikat. Para pendiri bangsa memilihnya karena paling cocok menyatukan masyarakat yang beragam suku, agama, ras, dan bahasa.'),
          const Perbandingan('Negara Kesatuan (Indonesia)', 'Negara Serikat', [
            BarisBanding('Bendera', 'Satu: Merah Putih',
                'Tiap negara bagian punya bendera sendiri'),
            BarisBanding('Konstitusi', 'Satu: UUD 1945',
                'Tiap negara bagian punya UUD sendiri'),
            BarisBanding('Kepolisian', 'Keamanan dipegang pusat (Polri)',
                'Tiap negara bagian punya kepolisian sendiri'),
          ]),
          const Callout(JenisCallout.penting, 'Tidak ada "negara di dalam negara"',
              'Kedaulatan tertinggi ada di **Pemerintah Pusat**. Hanya ada satu bendera, satu konstitusi, satu kepala negara (Presiden), dan satu lembaga perwakilan nasional (DPR/MPR/DPD).'),
          const Paragraf(
              'Kalau semua urusan dari Aceh sampai Papua harus diurus Presiden di Jakarta, prosesnya lambat dan pembangunan tidak merata. Karena itu Indonesia menerapkan sistem berikut:'),
          const KartuBalik([
            ItemKartuBalik('Desentralisasi',
                'Penyerahan sebagian wewenang pemerintahan dari Pemerintah Pusat kepada Pemerintah Daerah (Provinsi, Kabupaten, dan Kota).',
                ikon: Icons.share_location),
            ItemKartuBalik('Otonomi Daerah',
                'Hak, wewenang, dan kewajiban daerah otonom mengatur dan mengurus sendiri urusan pemerintahan dan kepentingan masyarakat setempat sesuai peraturan perundang-undangan.',
                ikon: Icons.location_city),
          ]),
          const TabInfo([
            ItemTab('Urusan Daerah', Icons.location_city, [
              Paragraf('Contoh yang boleh diurus pemerintah daerah:'),
              Daftar([
                'Membangun sekolah.',
                'Mengatur lalu lintas kota.',
                'Mengembangkan pariwisata daerah.',
                'Mengelola pendapatan daerah (APBD).',
              ]),
            ]),
            ItemTab('Urusan Pusat', Icons.account_balance, [
              Paragraf('Urusan **mutlak** yang tetap dipegang Pemerintah Pusat:'),
              GridIkon([
                ItemGrid(Icons.public, 'Politik luar negeri', ''),
                ItemGrid(Icons.shield, 'Pertahanan (TNI)', ''),
                ItemGrid(Icons.local_police, 'Keamanan (Polri)', ''),
                ItemGrid(Icons.gavel, 'Yustisi (hukum/pengadilan)', ''),
                ItemGrid(Icons.payments, 'Moneter (mencetak uang)', ''),
                ItemGrid(Icons.self_improvement, 'Agama', ''),
              ]),
            ], warna: Color(0xFFC62828)),
          ]),
          const Paragraf(
              'Melalui otonomi daerah, setiap daerah berkembang sesuai potensi dan budayanya, tanpa pernah lepas dari ikatan NKRI.'),
        ]),
        Bab('Upaya Menjaga Keutuhan Wilayah', Icons.shield, [
          const Paragraf(
              'Menjaga keutuhan wilayah bukan hanya tugas tentara atau polisi, tetapi **tanggung jawab seluruh warga negara**, termasuk pelajar SMP. Ancaman masa kini tak hanya penjajahan fisik, tetapi juga perpecahan dari dalam dan serangan non-fisik.'),
          const TabInfo([
            ItemTab('Ancaman Fisik', Icons.warning_amber_rounded, [
              Paragraf('Ancaman fisik / militer:'),
              Daftar([
                'Sengketa perbatasan darat dan laut dengan negara tetangga.',
                'Pencurian ikan oleh kapal asing (illegal fishing).',
                'Gerakan separatisme: kelompok bersenjata yang ingin memisahkan diri dari Indonesia.',
              ]),
            ], warna: Color(0xFFC62828)),
            ItemTab('Non-Fisik', Icons.phone_android, [
              Paragraf('Ancaman non-fisik / non-militer (ideologi, sosial-budaya, siber):'),
              Daftar([
                'Hoaks yang memicu konflik antar-suku atau agama.',
                'Radikalisme.',
                'Tawuran pelajar.',
                'Peredaran narkoba yang merusak generasi muda.',
                'Masuknya budaya asing yang bertentangan dengan nilai Pancasila.',
              ]),
            ]),
          ]),
          const SubJudul('Aksi Nyata Pelajar', ikon: Icons.emoji_events),
          const Akordeon([
            ItemAkordeon('Menerapkan toleransi',
                'Berteman dengan siapa saja tanpa membedakan agama, suku, atau kondisi ekonomi. Tidak merundung teman yang berbeda.',
                ikon: Icons.people),
            ItemAkordeon('Bijak bermedia sosial',
                'Saring sebelum sharing. Jangan menyebar berita provokatif atau ujaran kebencian di TikTok, Instagram, atau WhatsApp.',
                ikon: Icons.phone_android),
            ItemAkordeon('Mempelajari budaya daerah lain',
                'Kenali tarian, bahasa, atau makanan daerah lain untuk menumbuhkan cinta pada keberagaman (Bhinneka Tunggal Ika).',
                ikon: Icons.travel_explore),
            ItemAkordeon('Menggunakan produk dalam negeri',
                'Membeli dan bangga memakai barang buatan Indonesia membantu ekonomi negara tetap kuat dan mandiri.',
                ikon: Icons.shopping_bag),
            ItemAkordeon('Disiplin dan berprestasi',
                'Ikuti upacara bendera dengan khidmat untuk menghormati jasa pahlawan, rajin belajar, dan cetak prestasi akademik, olahraga, atau seni.',
                ikon: Icons.emoji_events),
          ]),
          const Callout(JenisCallout.penting, 'Benteng terkuat',
              'Pelajar yang cerdas dan berkarakter adalah benteng terkuat untuk melindungi masa depan wilayah dan kedaulatan NKRI.'),
        ]),
        Bab('Rangkuman & Uji Pemahaman', Icons.quiz, [
          const Ringkasan([
            'Unsur negara: rakyat, wilayah, pemerintah berdaulat (konstitutif) + pengakuan negara lain (deklaratif).',
            'Wilayah NKRI: darat, laut, udara, dan ekstrateritorial; negara kepulauan berciri Nusantara (Pasal 25A UUD 1945).',
            'Laut teritorial 12 mil laut, ZEE 200 mil laut, ditambah landas kontinen.',
            'NKRI adalah negara kesatuan dengan desentralisasi dan otonomi daerah.',
            'Menjaga keutuhan wilayah adalah tugas semua warga, termasuk pelajar.',
          ]),
          const KuisKilat('Uji Pemahaman: Wilayah NKRI', [
            SoalKilat(
                'Unsur konstitutif (mutlak) sebuah negara adalah ...',
                [
                  'Rakyat, wilayah, pemerintah yang berdaulat',
                  'Rakyat, wilayah, pengakuan negara lain',
                  'Pemerintah, bendera, lagu kebangsaan',
                  'Wilayah, bendera, pengakuan negara lain'
                ],
                0,
                'Tiga unsur konstitutif: rakyat, wilayah, pemerintah berdaulat. Pengakuan negara lain bersifat deklaratif.'),
            SoalKilat(
                'Kantor KBRI di luar negeri termasuk wilayah ...',
                ['Darat', 'Laut', 'Udara', 'Ekstrateritorial'],
                3,
                'Diakui hukum internasional sebagai wilayah Indonesia meski berada di negara lain.'),
            SoalKilat(
                'Lebar laut teritorial Indonesia diukur dari garis pangkal sejauh ...',
                ['12 mil laut', '50 mil laut', '100 mil laut', '200 mil laut'],
                0,
                'Di laut teritorial 12 mil laut, Indonesia berdaulat penuh.'),
            SoalKilat(
                'Di Zona Ekonomi Eksklusif (200 mil laut), yang berhak memanfaatkan sumber daya alamnya adalah ...',
                [
                  'Semua negara',
                  'Hanya Indonesia',
                  'Hanya negara tetangga',
                  'PBB'
                ],
                1,
                'Kapal asing boleh lewat, tetapi hanya Indonesia yang berhak menangkap ikan atau menambang minyak.'),
            SoalKilat(
                'Deklarasi Djuanda dicetuskan pada ...',
                [
                  '17 Agustus 1945',
                  '13 Desember 1957',
                  '1 Juni 1945',
                  '10 November 1945'
                ],
                1,
                'Deklarasi Djuanda 13 Desember 1957, kemudian diakui PBB lewat UNCLOS 1982.'),
            SoalKilat(
                'Negara yang berbatasan darat langsung dengan Indonesia adalah ...',
                [
                  'Singapura, Filipina, Australia',
                  'Malaysia, Papua Nugini, Timor Leste',
                  'Thailand, Vietnam, Brunei',
                  'Malaysia, Singapura, Australia'
                ],
                1,
                'Malaysia (Kalimantan), Papua Nugini (Papua), dan Timor Leste (Timor).'),
            SoalKilat(
                'Urusan yang tetap dipegang Pemerintah Pusat adalah ...',
                [
                  'Membangun sekolah daerah',
                  'Mengatur lalu lintas kota',
                  'Moneter (mencetak uang)',
                  'Mengembangkan pariwisata daerah'
                ],
                2,
                'Enam urusan mutlak pusat: politik luar negeri, pertahanan, keamanan, yustisi, moneter, dan agama.'),
          ]),
        ]),
      ],
    );
