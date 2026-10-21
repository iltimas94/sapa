// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
// =============================================================================
//  SAPA – isi materi Pendidikan Pancasila Kelas IX
//  Tempat gambar: cari  Gambar('...')  lalu tambahkan  asset: 'assets/images/k9/nama.png'
// =============================================================================

import 'package:flutter/material.dart';
import 'materi_core.dart';

final List<Materi> materiKelas9 = [
  // ═══════════════════════════════════════════════════════════════════════════
  //  MATERI 1
  // ═══════════════════════════════════════════════════════════════════════════
  Materi(
    id: 'k9-m1',
    nomor: 1,
    judul:
        'Hubungan Pancasila dengan UUD NRI Tahun 1945, Bhinneka Tunggal Ika, dan Negara Kesatuan Republik Indonesia',
    judulPendek: 'Pancasila dan Empat Pilar Kebangsaan',
    ringkasan:
        'Pancasila, UUD 1945, Bhinneka Tunggal Ika, dan NKRI: empat pilar yang saling menguatkan, dan bagaimana Pancasila menjadi jantung yang menghubungkannya.',
    ikon: Icons.account_balance_rounded,
    warna: Color(0xFFC62828),
    kataKunci: [
      'Empat pilar',
      'UUD 1945',
      'Bhinneka Tunggal Ika',
      'NKRI',
      'separatisme',
      'toleransi',
    ],
    pembuka: [
      Callout(
        JenisCallout.analogi,
        'Ibarat sebuah rumah yang kokoh, Indonesia butuh pondasi, tiang, atap, dan pengikat agar tidak runtuh saat diterpa badai. “Rumah” itu dibangun oleh **Empat Pilar Kebangsaan**. Keempatnya bukan hal yang terpisah, melainkan sistem yang saling menguatkan.',
        judul: 'Bayangkan sebuah rumah…',
      ),
      RumahPilar(
        atap: ItemTab('NKRI', Icons.map_rounded, [
          Teks(
              '**NKRI** adalah bentuk fisik negara kita, dari Sabang sampai Merauke. Ia adalah *wadah* yang menaungi seluruh warganya.'),
        ]),
        tiangKiri: ItemTab('UUD NRI 1945', Icons.menu_book_rounded, [
          Teks(
              '**UUD 1945** adalah *aturan main* di dalam rumah, yaitu hukum dasar tertulis tertinggi di Indonesia.'),
        ]),
        tiangKanan: ItemTab('Bhinneka Tunggal Ika', Icons.groups_rounded, [
          Teks(
              '**Bhinneka Tunggal Ika** adalah *sifat para penghuni rumah*: beragam, tetapi tetap satu keluarga.'),
        ]),
        pondasi: ItemTab('Pancasila', Icons.star_rounded, [
          Teks(
              '**Pancasila** adalah *pondasi sekaligus ruh* yang memastikan rumah berdiri kokoh, rukun, dan punya tujuan yang jelas.'),
        ]),
      ),
    ],
    bagian: [
      Bagian('Semangat Pancasila dalam Kehidupan Bernegara', Icons.flag_rounded, [
        Teks(
            'Pancasila bukan sekadar teks yang dibacakan setiap upacara hari Senin. Pancasila adalah *ideologi* dan *dasar negara*. Artinya, cara kita berpikir, bertindak, dan membuat peraturan di Indonesia harus mencerminkan kelima sila. Tanpa semangat Pancasila, negara sebesar ini mudah kehilangan arah.'),
        Callout(
          JenisCallout.contoh,
          'Pemerintah membangun jalan tol, tetapi menggusur rumah warga **tanpa ganti rugi yang adil**. Itu melanggar Sila ke-2 (Kemanusiaan yang adil dan beradab) dan Sila ke-5 (Keadilan sosial).',
        ),
        Teks('**Penerapan semangat Pancasila di berbagai tingkatan:**'),
        TabKonten([
          ItemTab('Negara', Icons.account_balance_rounded, [
            Poin([
              ItemPoin(
                  'Membuat kebijakan yang mengutamakan rakyat kecil (Sila ke-5).'),
              ItemPoin('Menghargai kebebasan beragama (Sila ke-1).'),
              ItemPoin(
                  'Menyelesaikan masalah politik lewat pemilu yang demokratis (Sila ke-4).'),
            ]),
          ]),
          ItemTab('Masyarakat', Icons.diversity_3_rounded, [
            Poin([
              ItemPoin('Gotong royong membersihkan lingkungan.'),
              ItemPoin('Membayar pajak tepat waktu.'),
              ItemPoin(
                  'Tidak menyebarkan *hoax* yang bisa memecah belah bangsa (Sila ke-3).'),
            ]),
          ]),
          ItemTab('Sekolah', Icons.school_rounded, [
            Poin([
              ItemPoin(
                  'Berteman dengan siapa saja tanpa membedakan status sosial atau agama.'),
              ItemPoin('Berdiskusi saat kerja kelompok.'),
              ItemPoin('Menghormati guru.'),
            ]),
          ]),
        ]),
        Callout(
          JenisCallout.ringkas,
          'Pancasila adalah **kompas**. Sejauh apa pun Indonesia melangkah dan semodern apa pun teknologinya, kompas ini menjaga kita dari tersesat.',
        ),
        KuisMini(
          'Pemerintah menggusur rumah warga untuk jalan tol tanpa ganti rugi yang adil. Sila yang dilanggar adalah…',
          [
            'Sila ke-1 dan ke-3',
            'Sila ke-2 dan ke-5',
            'Sila ke-3 dan ke-4',
            'Sila ke-4 dan ke-5',
          ],
          1,
          'Menggusur tanpa keadilan melanggar Sila ke-2 (kemanusiaan yang adil dan beradab) dan Sila ke-5 (keadilan sosial).',
        ),
      ]),
      Bagian('Hubungan Pancasila dengan UUD NRI Tahun 1945', Icons.menu_book_rounded, [
        Teks(
            'Jika Pancasila adalah **ruh** atau nyawa negara, maka UUD NRI Tahun 1945 adalah **raga**-nya. UUD 1945 adalah hukum dasar tertulis tertinggi di Indonesia. Hubungan keduanya erat dan tak terpisahkan, seperti dua sisi mata uang.'),
        KartuBalik([
          ItemKartu('1. Sumber dari segala sumber hukum',
              'Tidak boleh ada satu pun pasal dalam UUD 1945, bahkan undang-undang di bawahnya seperti **UU Lalu Lintas** atau **UU ITE**, yang bertentangan dengan Pancasila. Aturan yang tidak adil atau menindas harus dihapus.'),
          ItemKartu('2. Pancasila terdapat di dalam UUD 1945',
              'Rumusan lima sila tertulis resmi di **alinea keempat** Pembukaan UUD 1945. Karena memuat dasar dan tujuan negara, Pembukaan bersifat **tetap dan abadi**, tidak boleh diubah siapa pun, termasuk MPR. Mengubahnya sama artinya dengan membubarkan negara Indonesia.'),
          ItemKartu('3. Dijabarkan melalui pasal-pasal UUD 1945',
              'Nilai Pancasila yang masih umum diperinci menjadi aturan yang jelas. Contoh: **Sila ke-1** dijabarkan dalam **Pasal 29** (kemerdekaan memeluk agama dan beribadah). **Sila ke-4** dijabarkan dalam pasal tentang Pemilu serta keanggotaan DPR/MPR.'),
        ]),
        KuisMini(
          'Rumusan resmi kelima sila Pancasila tertulis pada…',
          [
            'Pasal 1 UUD 1945',
            'Pasal 29 UUD 1945',
            'Alinea keempat Pembukaan UUD 1945',
            'Penjelasan UU Lalu Lintas',
          ],
          2,
          'Rumusan Pancasila ada di alinea keempat Pembukaan UUD 1945. Pembukaan ini tetap dan tidak boleh diubah.',
        ),
      ]),
      Bagian('Hubungan Pancasila dengan Bhinneka Tunggal Ika', Icons.groups_rounded, [
        Teks(
            'Semboyan di pita cengkeraman burung Garuda ini berarti *“Berbeda-beda tetapi tetap satu jua”*. Perbedaan bisa menjadi kekayaan, tetapi juga bisa menjadi bom waktu pemicu konflik, seperti tawuran antar-kampung atau perang antar-suku. Di sinilah peran Pancasila.'),
        Callout(
          JenisCallout.tahukah,
          'Indonesia punya lebih dari **1.300 suku bangsa** dan **700 bahasa daerah**, serta beragam agama dan kepercayaan.',
        ),
        Gambar('Peta persebaran suku dan bahasa daerah di Indonesia', asset: 'assets/images/materi/21.jpg'),
        Poin([
          ItemPoin(
              'Bhinneka Tunggal Ika adalah *kenyataan* keberagaman kita, sedangkan Pancasila adalah *alat pemersatunya*. Sila ke-3 memerintahkan kita menempatkan kepentingan bangsa di atas kepentingan suku atau golongan.',
              judul: 'Pancasila sebagai tali pengikat',
              ikon: Icons.link_rounded),
          ItemPoin(
              'Kelompok yang jumlahnya lebih besar tidak boleh semena-mena terhadap yang lebih kecil. Semua warga punya hak yang sama di mata hukum.',
              judul: 'Mencegah mayoritas menindas minoritas',
              ikon: Icons.balance_rounded),
          ItemPoin(
              'Membiarkan temanmu yang berbeda agama beribadah di tengah kerja kelompok berarti kamu mempraktikkan Bhinneka Tunggal Ika yang dijiwai Sila ke-1 dan ke-2.',
              judul: 'Toleransi sehari-hari',
              ikon: Icons.handshake_rounded),
        ]),
        Callout(
          JenisCallout.ringkas,
          'Bhinneka Tunggal Ika menyadarkan kita bahwa kita *berbeda-beda*. Pancasila memberi tahu *bagaimana* cara hidup rukun di tengah perbedaan itu.',
        ),
        KuisMini(
          'Terhadap keberagaman bangsa, Pancasila berperan sebagai…',
          [
            'Pembeda antar suku',
            'Tali pengikat dan pemersatu',
            'Penentu kelompok terbesar',
            'Pengganti bahasa daerah',
          ],
          1,
          'Bhinneka Tunggal Ika adalah faktanya, Pancasila adalah alat pemersatunya.',
        ),
      ]),
      Bagian('Hubungan Pancasila dengan NKRI', Icons.map_rounded, [
        Teks(
            'NKRI adalah bentuk fisik negara kita, dari Sabang sampai Merauke, dari Miangas sampai Pulau Rote. Bentuk negara kita adalah **Kesatuan** (bukan serikat/federal seperti Amerika Serikat). Kekuasaan tertinggi ada di pemerintah pusat, tetapi daerah diberi kebebasan mengurus wilayahnya sendiri (**otonomi daerah**).'),
        Poin([
          ItemPoin(
              'Bentuk negaranya NKRI, sedangkan ideologi yang mengisi dan menggerakkannya adalah Pancasila. Tanpa Pancasila, wilayah yang terpisah lautan ini mungkin sudah lama pecah menjadi negara-negara kecil.',
              judul: 'NKRI adalah wadah, Pancasila adalah isinya',
              ikon: Icons.inventory_2_rounded),
          ItemPoin(
              'Sila ke-3 (Persatuan Indonesia) dan Sila ke-5 (Keadilan Sosial) adalah kunci menghadapi kelompok yang ingin memisahkan diri. Jika jalan, sekolah, dan rumah sakit bagus dibangun juga di Papua, Kalimantan, dan pulau terluar, seluruh rakyat merasa diperhatikan dan ingin tetap bersatu.',
              judul: 'Menangkal separatisme',
              ikon: Icons.shield_rounded),
          ItemPoin(
              'Menjaga NKRI bukan hanya tugas TNI dan polisi. Sebagai pelajar kelas IX, kamu bisa belajar giat, mencintai produk dalam negeri, dan berprestasi membawa nama Indonesia, misalnya lewat olimpiade sains atau olahraga.',
              judul: 'Bela negara kapan saja',
              ikon: Icons.emoji_events_rounded),
        ]),
        Callout(
          JenisCallout.ringkas,
          'NKRI adalah rumah fisiknya. UUD 1945 adalah aturan main di dalamnya. Bhinneka Tunggal Ika adalah sifat para penghuninya. Pancasila adalah pondasi dan ruhnya.',
        ),
        KuisMini(
          'Bentuk negara Indonesia adalah “Kesatuan”. Artinya…',
          [
            'Tiap daerah setara dengan pusat seperti negara federal',
            'Kekuasaan tertinggi di pemerintah pusat, daerah tetap punya otonomi',
            'Daerah boleh membentuk negara sendiri',
            'Hanya Pulau Jawa yang diatur pemerintah pusat',
          ],
          1,
          'Negara kesatuan: kekuasaan tertinggi di pusat, daerah diberi otonomi untuk mengurus wilayahnya.',
        ),
      ]),
    ],
    penutup:
        'Memahami hubungan keempat pilar bukan hanya modal ujian PPKn, tetapi bekalmu sebagai generasi penerus bangsa.',
  ),

  // ═══════════════════════════════════════════════════════════════════════════
  //  MATERI 2
  // ═══════════════════════════════════════════════════════════════════════════
  Materi(
    id: 'k9-m2',
    nomor: 2,
    judul: 'Hak dan Kewajiban Warga Negara',
    judulPendek: 'Hak dan Kewajiban Warga Negara',
    ringkasan:
        'Bedanya hak, kewajiban, dan HAM; cara menyeimbangkannya; pasal-pasal UUD 1945 yang mengaturnya; serta tantangan pelaksanaannya.',
    ikon: Icons.balance_rounded,
    warna: Color(0xFF1565C0),
    kataKunci: [
      'Hak',
      'Kewajiban',
      'HAM',
      'Pasal 27',
      'Pasal 31',
      'pajak',
      'korupsi',
    ],
    pembuka: [
      Callout(
        JenisCallout.analogi,
        'Kamu membeli tiket taman hiburan. Kamu **berhak** menikmati semua wahana, toilet yang bersih, dan rasa aman. Tetapi kamu juga **wajib** membayar tiket, mengantre tertib, dan membuang sampah pada tempatnya. Begitulah cara kita hidup sebagai warga negara.',
        judul: 'Bayangkan taman hiburan…',
      ),
    ],
    bagian: [
      Bagian('Hak dan Kewajiban', Icons.swap_horiz_rounded, [
        Teks(
            'Dalam kehidupan bernegara, kita perlu membedakan hak, kewajiban, dan hak asasi. Ketuk tiap tab:'),
        TabKonten([
          ItemTab('Hak warga negara', Icons.verified_user_rounded, [
            Teks(
                'Segala sesuatu yang pantas, mutlak, dan sah didapatkan seseorang **sebagai anggota sebuah negara**. Hak ini dibatasi oleh status kewarganegaraan.'),
            Callout(JenisCallout.contoh,
                'Warga Negara Asing (WNA) yang tinggal di Indonesia tidak berhak ikut mencoblos dalam Pemilu.'),
          ]),
          ItemTab('Kewajiban', Icons.assignment_turned_in_rounded, [
            Teks(
                'Tindakan atau sikap yang harus dilakukan warga negara **dengan penuh tanggung jawab**, sesuai peraturan perundang-undangan yang berlaku.'),
          ]),
          ItemTab('HAM', Icons.favorite_rounded, [
            Teks(
                '**Hak Asasi Manusia** melekat pada setiap manusia sejak lahir, tidak peduli dari negara mana ia berasal. Contohnya hak untuk hidup.'),
          ]),
        ]),
        Callout(
          JenisCallout.penting,
          '**Semua hak asasi adalah hak warga negara, tetapi tidak semua hak warga negara adalah hak asasi.**',
        ),
        KuisMini(
          'Pernyataan yang benar tentang HAM dan hak warga negara adalah…',
          [
            'Hak untuk memilih dalam Pemilu adalah HAM yang dimiliki semua orang di dunia',
            'HAM hanya dimiliki warga negara Indonesia',
            'HAM melekat pada manusia sejak lahir, sedangkan sebagian hak warga negara dibatasi status kewarganegaraan',
            'Hak warga negara sama persis dengan HAM',
          ],
          2,
          'HAM berlaku untuk setiap manusia. Hak tertentu, seperti mencoblos di Pemilu, hanya untuk warga negara.',
        ),
      ]),
      Bagian('Pelaksanaan Hak dan Kewajiban secara Seimbang', Icons.scale_rounded, [
        Teks(
            'Hak dan kewajiban ibarat **dua sisi satu koin**. Kamu tidak bisa terus menuntut hak jika mengabaikan kewajiban. Di negara demokrasi, kebebasan bukanlah kebebasan tanpa batas.'),
        Kutipan('“Hakmu dibatasi oleh hak orang lain.”',
            sumber: 'Prinsip keseimbangan hak dan kewajiban'),
        TabKonten([
          ItemTab('Di rumah', Icons.home_rounded, [
            Teks(
                'Kamu **berhak** mendapat kasih sayang orang tua, tetapi **wajib** menghormati mereka dan membantu pekerjaan rumah.'),
          ]),
          ItemTab('Di sekolah', Icons.school_rounded, [
            Teks(
                'Kamu **berhak** mendapat pengajaran yang baik dan fasilitas kelas yang layak, tetapi **wajib** menaati tata tertib, mengerjakan tugas, dan tidak merusak meja atau kursi.'),
          ]),
          ItemTab('Di masyarakat', Icons.people_rounded, [
            Teks(
                'Kamu **berhak** mendengarkan musik favoritmu. Tetapi menyalakannya dengan *speaker* besar pukul 11 malam melanggar hak tetanggamu untuk beristirahat dengan tenang.'),
          ]),
        ]),
        KuisMini(
          'Menyalakan speaker besar pukul 11 malam melanggar prinsip…',
          [
            'Hak dan kewajiban harus seimbang; hakmu dibatasi hak orang lain',
            'Hak lebih penting daripada kewajiban',
            'Kewajiban hanya berlaku di sekolah',
            'Kebebasan tidak boleh ada sama sekali',
          ],
          0,
          'Hakmu memutar musik berhenti ketika mengganggu hak tetangga untuk beristirahat.',
        ),
      ]),
      Bagian('Hak dan Kewajiban dalam UUD NRI Tahun 1945', Icons.gavel_rounded, [
        Teks(
            'UUD 1945 secara tegas mengatur hak dan kewajiban kita. Jika pemerintah gagal memenuhi hak, atau rakyat menolak menjalankan kewajiban, berlaku sanksi hukum. Ketuk tiap pasal untuk melihat isinya:'),
        TabelPasal([
          ItemPasal(
              'Pasal 27 ayat (1)',
              'Diperlakukan sama di hadapan hukum dan pemerintahan.',
              'Wajib menjunjung tinggi hukum dan pemerintahan tanpa pengecualian.'),
          ItemPasal(
              'Pasal 27 ayat (2)',
              'Mendapat pekerjaan dan penghidupan yang layak.',
              'Fokus pasal ini ada pada pemenuhan hak oleh negara.'),
          ItemPasal(
              'Pasal 27 ayat (3)',
              'Berhak ikut serta dalam upaya pembelaan negara.',
              'Wajib ikut serta dalam upaya pembelaan negara.'),
          ItemPasal(
              'Pasal 28 dan 28E',
              'Kebebasan berserikat, berkumpul, dan mengeluarkan pendapat.',
              'Menghargai pendapat orang lain dan tidak menyebarkan fitnah atau hoaks.'),
          ItemPasal(
              'Pasal 29 ayat (2)',
              'Kemerdekaan memeluk agama dan beribadah.',
              'Menghormati agama dan kepercayaan orang lain (toleransi).'),
          ItemPasal(
              'Pasal 31 ayat (1) dan (2)',
              'Berhak mendapat pendidikan.',
              'Wajib mengikuti pendidikan dasar (SD–SMP); negara wajib membiayainya.'),
          ItemPasal(
              'Pasal 23A',
              'Menikmati fasilitas umum (jalan, jembatan) hasil dari pajak.',
              'Wajib membayar pajak dan pungutan resmi lainnya kepada negara.'),
        ]),
        KuisMini(
          'Menurut Pasal 31 UUD 1945, pendidikan dasar (SD–SMP)…',
          [
            'Hanya hak, tidak ada kewajiban',
            'Wajib diikuti warga negara dan negara wajib membiayainya',
            'Dibiayai sepenuhnya oleh orang tua',
            'Hanya untuk yang mampu',
          ],
          1,
          'Pasal 31 ayat (1) dan (2): setiap warga berhak mendapat pendidikan, wajib mengikuti pendidikan dasar, dan negara wajib membiayainya.',
        ),
      ]),
      Bagian('Tantangan Pemenuhan Hak dan Kewajiban', Icons.warning_amber_rounded, [
        Teks(
            'Meski aturannya jelas, kita masih sering melihat **pelanggaran hak** (perundungan di sekolah, anak putus sekolah karena biaya) dan **pengingkaran kewajiban** (mencontek, membuang sampah di sungai, tidak membayar pajak). Tantangannya datang dari dua arah:'),
        TabKonten([
          ItemTab('Internal', Icons.person_rounded, [
            Poin([
              ItemPoin(
                  'Selalu menuntut hak, tetapi sengaja melupakan kewajiban terhadap orang lain.',
                  judul: 'Sikap egois berlebihan'),
              ItemPoin(
                  'Meremehkan hukum, misalnya pelajar berkendara tanpa helm atau menerobos lampu merah karena merasa “tidak ada polisi”.',
                  judul: 'Rendahnya kesadaran berbangsa'),
              ItemPoin(
                  'Merasa kelompok, ras, atau agamanya paling benar sehingga memicu diskriminasi yang merampas hak orang lain.',
                  judul: 'Sikap tidak toleran'),
            ]),
          ]),
          ItemTab('Eksternal', Icons.public_rounded, [
            Poin([
              ItemPoin(
                  'Pelanggar yang tidak ditindak tegas dan adil membuat masyarakat kehilangan rasa hormat pada hukum.',
                  judul: 'Aparat penegak hukum kurang tegas'),
              ItemPoin(
                  'Korupsi pejabat adalah perampasan hak rakyat: dana untuk sekolah atau puskesmas masuk kantong pribadi.',
                  judul: 'Penyalahgunaan kekuasaan'),
              ItemPoin(
                  'Internet dan media sosial sering disalahgunakan untuk *cyberbullying*, penipuan daring, dan ujaran kebencian.',
                  judul: 'Penyalahgunaan teknologi'),
            ]),
          ]),
        ]),
        KuisMini(
          'Pejabat memakai dana pembangunan sekolah untuk kepentingan pribadi. Ini contoh tantangan…',
          [
            'Internal: sikap egois',
            'Eksternal: penyalahgunaan kekuasaan (korupsi)',
            'Internal: sikap tidak toleran',
            'Eksternal: penyalahgunaan teknologi',
          ],
          1,
          'Korupsi termasuk penyalahgunaan kekuasaan, dan merampas hak rakyat atas fasilitas publik.',
        ),
      ]),
    ],
    penutup:
        'Keseimbangan hak dan kewajiban tidak hanya diurus presiden atau polisi. Negara yang damai dan tertib dimulai dari ruang kelasmu: dari caramu menghargai teman sebangku dan disiplin pada aturan-aturan kecil setiap hari.',
  ),

  // ═══════════════════════════════════════════════════════════════════════════
  //  MATERI 3
  // ═══════════════════════════════════════════════════════════════════════════
  Materi(
    id: 'k9-m3',
    nomor: 3,
    judul: 'Kemerdekaan Berpendapat Warga Negara pada Era Keterbukaan Informasi',
    judulPendek: 'Kemerdekaan Berpendapat di Era Digital',
    ringkasan:
        'Cara menyuarakan pendapat dengan benar, aman, dan berdampak: dasar hukumnya, bentuk-bentuknya, keterbukaan informasi, dan etika di media sosial.',
    ikon: Icons.record_voice_over_rounded,
    warna: Color(0xFF00897B),
    kataKunci: [
      'Pendapat',
      'Hoaks',
      'UU ITE',
      'Demonstrasi',
      'Informasi publik',
      'Media sosial',
    ],
    pembuka: [
      Callout(
        JenisCallout.analogi,
        'Pernahkah kamu tidak setuju dengan aturan baru di sekolah, atau punya ide brilian untuk *class meeting* tetapi takut menyampaikannya? Di negara demokrasi, bersuara bukan kesalahan, melainkan **hak yang dijamin konstitusi**.',
        judul: 'Pernah ingin bersuara?',
      ),
    ],
    bagian: [
      Bagian('Makna Kemerdekaan Berpendapat', Icons.mic_rounded, [
        Teks(
            'Kemerdekaan berpendapat adalah hak setiap warga negara untuk menyampaikan pikiran, gagasan, atau kritik, **lisan maupun tulisan**, secara bebas dan bertanggung jawab tanpa tekanan pihak mana pun. Kebebasan ini adalah “oksigen” bagi demokrasi: tanpa itu, pemerintah bisa bertindak semena-mena karena tak ada rakyat yang berani mengawasi.'),
        Callout(
          JenisCallout.contoh,
          'Di sekolah, kebebasan berpendapat terlihat saat kamu berani mengangkat tangan untuk menyanggah jawaban teman, atau saat pengurus OSIS mengusulkan program baru kepada kepala sekolah.',
        ),
        Callout(
          JenisCallout.penting,
          'Kata kuncinya: **Bebas dan Bertanggung Jawab.** Bebas bukan berarti boleh berkata kasar, menyebarkan fitnah, atau menghina orang lain. Pendapat harus punya dasar kuat dan disampaikan dengan beradab.',
        ),
        KuisMini(
          'Kata kunci kemerdekaan berpendapat adalah…',
          [
            'Bebas sebebas-bebasnya',
            'Bebas dan bertanggung jawab',
            'Hanya boleh mengkritik pemerintah',
            'Tergantung izin tetangga',
          ],
          1,
          'Kebebasan berpendapat harus disertai tanggung jawab: berdasar fakta dan disampaikan dengan beradab.',
        ),
      ]),
      Bagian('Jaminan Kemerdekaan Berpendapat di Indonesia', Icons.gavel_rounded, [
        Teks(
            'Kamu tidak perlu takut bersuara, karena negara melindunginya lewat hukum dasar kita:'),
        Kutipan(
            '“Kemerdekaan berserikat dan berkumpul, mengeluarkan pikiran dengan lisan dan tulisan dan sebagainya ditetapkan dengan undang-undang.”',
            sumber: 'UUD NRI 1945 Pasal 28'),
        Kutipan(
            '“Setiap orang berhak atas kebebasan berserikat, berkumpul, dan mengeluarkan pendapat.”',
            sumber: 'UUD NRI 1945 Pasal 28E ayat (3)'),
        Callout(
          JenisCallout.ringkas,
          '**UU No. 9 Tahun 1998** secara khusus mengatur Kemerdekaan Menyampaikan Pendapat di Muka Umum.',
        ),
        Teks('Meski dijamin kuat, kebebasanmu berhenti ketika pendapat itu:'),
        Poin([
          ItemPoin('Melanggar hak orang lain.'),
          ItemPoin('Mengganggu ketertiban umum.'),
          ItemPoin('Melanggar nilai moral atau agama.'),
          ItemPoin('Mengancam keutuhan NKRI.'),
        ], bernomor: true),
        KuisMini(
          'Undang-undang yang khusus mengatur penyampaian pendapat di muka umum adalah…',
          [
            'UU No. 9 Tahun 1998',
            'UU No. 14 Tahun 2008',
            'UU Lalu Lintas',
            'UU Perpajakan',
          ],
          0,
          'UU No. 9 Tahun 1998. Sedangkan UU No. 14 Tahun 2008 mengatur Keterbukaan Informasi Publik.',
        ),
      ]),
      Bagian('Bentuk-Bentuk Penyampaian Pendapat', Icons.campaign_rounded, [
        Teks('Secara umum, pendapat disampaikan lewat tiga jalur:'),
        TabKonten([
          ItemTab('Lisan', Icons.mic_rounded, [
            Teks(
                'Menyampaikan langsung dengan suara. Contoh: **berpidato**, **wawancara**, atau **berdiskusi** di forum kelas.'),
          ]),
          ItemTab('Tulisan', Icons.edit_rounded, [
            Teks(
                'Menyampaikan lewat teks atau gambar. Contoh: menulis artikel di **mading sekolah**, membuat **petisi**, membentangkan **spanduk**, hingga membuat **postingan di media sosial**.'),
          ]),
          ItemTab('Di muka umum', Icons.campaign_rounded, [
            Poin([
              ItemPoin(
                  'Kegiatan seseorang atau kelompok menyampaikan pikiran secara lisan atau tulisan di tempat umum.',
                  judul: 'Unjuk rasa / demonstrasi'),
              ItemPoin('Penyampaian pendapat dengan arak-arakan di jalan umum.',
                  judul: 'Pawai'),
              ItemPoin(
                  'Penyampaian pendapat di tempat terbuka yang disediakan khusus.',
                  judul: 'Mimbar bebas'),
            ]),
            Callout(JenisCallout.penting,
                'Unjuk rasa wajib dilakukan **damai**, **tidak merusak fasilitas umum** (anarkis), dan **memberitahukan kepolisian** terlebih dahulu.'),
          ]),
        ]),
        KuisMini(
          'Syarat unjuk rasa yang benar adalah…',
          [
            'Boleh merusak fasilitas umum asal tujuannya baik',
            'Tidak perlu memberi tahu polisi',
            'Damai, tidak anarkis, dan memberitahu kepolisian lebih dulu',
            'Hanya boleh dilakukan malam hari',
          ],
          2,
          'Aksi harus damai, tidak merusak fasilitas umum, dan diberitahukan kepada kepolisian.',
        ),
      ]),
      Bagian('Keterbukaan Informasi Publik', Icons.lock_open_rounded, [
        Teks(
            'Bagaimana memberi kritik yang bagus kalau kita tidak tahu apa yang sedang terjadi? Karena itu ada **Keterbukaan Informasi Publik (KIP)**: pemerintah sebagai badan publik wajib membuka akses informasi tentang kebijakan, anggaran, dan program kerjanya. Diatur dalam **UU No. 14 Tahun 2008**.'),
        Teks('**Mengapa penting?**'),
        Poin([
          ItemPoin(
              'Jika rakyat bisa melihat laporan keuangan daerah, pejabat takut mencuri uang negara.',
              judul: 'Mencegah korupsi',
              ikon: Icons.security_rounded),
          ItemPoin(
              'Rakyat yang mendapat informasi utuh bisa memberi masukan yang solutif.',
              judul: 'Meningkatkan partisipasi rakyat',
              ikon: Icons.groups_rounded),
          ItemPoin(
              'Pemerintah yang transparan lebih dipercaya warganya.',
              judul: 'Membangun kepercayaan',
              ikon: Icons.thumb_up_rounded),
        ]),
        Callout(
          JenisCallout.penting,
          'Tidak *semua* informasi boleh dibuka. Pemerintah berhak merahasiakan **strategi pertahanan negara**, **rahasia intelijen**, dan **data pribadi warga** yang bersifat privasi.',
        ),
        KuisMini(
          'Informasi yang boleh dirahasiakan pemerintah adalah…',
          [
            'Laporan anggaran daerah',
            'Program kerja pemerintah',
            'Strategi pertahanan negara dan data pribadi warga',
            'Kebijakan pembangunan sekolah',
          ],
          2,
          'Strategi pertahanan, intelijen, dan data pribadi warga dikecualikan dari keterbukaan informasi.',
        ),
      ]),
      Bagian('Praktik Mengemukakan Pendapat di Era Digital', Icons.phone_android_rounded, [
        Teks(
            'Dengan *smartphone*, siapa saja, termasuk kamu yang masih SMP, bisa berbicara kepada dunia. Satu cuitan atau video bisa viral dalam hitungan jam. **Kebebasan besar datang dengan tanggung jawab besar.** Ketuk kartu untuk membaca lima etikanya:'),
        KartuBalik(
          [
            ItemKartu('Saring sebelum sharing',
                'Sebelum mengomentari berita, pastikan beritanya benar (bukan **hoaks**). Berpendapat berdasarkan informasi palsu hanya mempermalukan diri sendiri dan memicu kegaduhan.'),
            ItemKartu('Gunakan bahasa yang beradab',
                'Hindari makian, cacian, atau *body shaming*. **Kritiklah ide atau tindakannya**, bukan fisik atau latar belakang orangnya.'),
            ItemKartu('Hindari isu SARA',
                'Jangan menyampaikan ujaran kebencian (*hate speech*) yang merendahkan Suku, Agama, Ras, dan Antargolongan. Bukan hanya tidak etis, tetapi juga **bisa dipenjara**.'),
            ItemKartu('Siap menerima perbedaan',
                'Saat melempar pendapat ke publik, siaplah jika ada yang tidak setuju. Berdebatlah dengan sehat, dan jangan marah bila pendapatmu dipatahkan argumen yang lebih logis.'),
            ItemKartu('Pahami batasan hukum (UU ITE)',
                '**Jejak digital itu abadi.** UU ITE melarang penyebaran berita bohong, pencemaran nama baik, dan ancaman kekerasan di dunia maya. Pikir dua kali sebelum menekan *post* atau *send*.'),
          ],
        ),
        KuisMini(
          'Kamu menerima kabar heboh yang memojokkan satu kelompok di grup kelas. Langkah pertama yang tepat adalah…',
          [
            'Langsung meneruskan ke grup lain',
            'Menambahkan komentar pedas',
            'Mengecek kebenarannya dulu sebelum menyebarkan',
            'Mengabaikan semua berita',
          ],
          2,
          'Saring sebelum sharing. Menyebarkan berita yang belum jelas dapat memicu kegaduhan dan melanggar UU ITE.',
        ),
      ]),
    ],
    penutup:
        'Kemerdekaan berpendapat adalah hak istimewa yang diperjuangkan dengan susah payah oleh para pendiri bangsa. Gunakan hakmu dengan cerdas untuk membawa perubahan positif bagi sekolahmu, lingkunganmu, dan Indonesia.',
  ),

  // ═══════════════════════════════════════════════════════════════════════════
  //  MATERI 4
  // ═══════════════════════════════════════════════════════════════════════════
  Materi(
    id: 'k9-m4',
    nomor: 4,
    judul:
        'Menjaga dan Melestarikan Tradisi, Kearifan Lokal, serta Budaya dalam Masyarakat Global',
    judulPendek: 'Tradisi, Kearifan Lokal, dan Budaya',
    ringkasan:
        'Bagaimana menjadi warga dunia yang modern tanpa kehilangan akar identitas sebagai orang Indonesia: wayang, Rambu Solo’, Hutan Larangan, dan aksi nyatamu.',
    ikon: Icons.palette_rounded,
    warna: Color(0xFFEF6C00),
    kataKunci: [
      'Budaya',
      'Kearifan lokal',
      'Wayang',
      'Batik',
      'Globalisasi',
      'Soft power',
    ],
    pembuka: [
      Callout(
        JenisCallout.analogi,
        'Kamu bisa menonton konser K-Pop *live* dari kamar, memesan barang dari luar negeri, atau meniru gaya hidup ala Barat dengan mudah. Pertanyaannya: bagaimana menjadi “warga dunia” yang modern **tanpa kehilangan akar identitas** sebagai orang Indonesia?',
        judul: 'Warga dunia, tetap berakar',
      ),
    ],
    bagian: [
      Bagian('Makna Tradisi, Kearifan Lokal, dan Budaya', Icons.park_rounded, [
        Teks(
            'Tiga kata ini sering diucapkan bersamaan, tetapi maknanya berbeda. Ibarat sebuah **pohon besar**, ketiganya saling melengkapi agar pohon berdiri kokoh dan berbuah.'),
        Gambar('Ilustrasi pohon: akar = kearifan lokal, cabang = tradisi, pohon = budaya',
            rasio: 4 / 3, asset: 'assets/images/materi/22.jpg'),
        TabKonten([
          ItemTab('Budaya (pohon)', Icons.park_rounded, [
            Teks(
                'Segala sesuatu yang diciptakan akal budi manusia untuk bertahan hidup dan membuat hidup lebih baik. Cakupannya luas: bahasa, rumah adat, pakaian, seni tari, makanan, hingga sistem kepercayaan dan hukum.'),
          ]),
          ItemTab('Tradisi (cabang)', Icons.account_tree_rounded, [
            Teks(
                'Kebiasaan, adat istiadat, atau ritual yang **diwariskan turun-temurun** dan masih dilakukan hingga kini. Tradisi adalah *tindakan nyata* dari sebuah budaya.'),
            Callout(JenisCallout.contoh,
                '*Budaya* masyarakat Jawa menghormati orang tua; *tradisinya* diwujudkan dalam **sungkeman** saat Lebaran.'),
          ]),
          ItemTab('Kearifan lokal (akar)', Icons.eco_rounded, [
            Teks(
                'Nilai, filosofi, atau “kecerdasan tersembunyi” masyarakat setempat yang **teruji waktu**, biasanya untuk menjaga keseimbangan alam atau menyelesaikan konflik sosial. Ia adalah inti pelajaran dari sebuah tradisi.'),
          ]),
        ]),
        Callout(
          JenisCallout.ringkas,
          'Budaya adalah payung besarnya. Tradisi adalah cara kita mempraktikkannya berulang-ulang. Kearifan lokal adalah kebijaksanaan di balik praktik itu.',
        ),
        KuisMini(
          'Sungkeman saat Lebaran adalah contoh…',
          ['Budaya', 'Tradisi', 'Kearifan lokal', 'Globalisasi'],
          1,
          'Sungkeman adalah praktik nyata yang diwariskan turun-temurun, jadi ia tradisi. Nilai menghormati orang tua adalah budayanya.',
        ),
      ]),
      Bagian('Contoh Tradisi, Kearifan Lokal, dan Budaya di Indonesia', Icons.public_rounded, [
        Teks('Beberapa contoh nyata, bahkan ada yang diakui dunia:'),
        TabKonten([
          ItemTab('Wayang kulit', Icons.theater_comedy_rounded, [
            Gambar('Pertunjukan wayang kulit dengan dalang dan gamelan', asset: 'assets/images/materi/23.jpg'),
            Callout(JenisCallout.ringkas, 'Contoh **budaya** (Jawa)'),
            Teks(
                'Wayang kulit bukan sekadar boneka bayangan. Ia memuat **seni pahat** (wayang dari kulit kerbau), **seni musik** (gamelan), dan **seni sastra** (epik Ramayana/Mahabharata), sekaligus sarana pendidikan moral.'),
            Callout(JenisCallout.tahukah,
                'UNESCO menetapkan Wayang Kulit sebagai *Masterpiece of the Oral and Intangible Heritage of Humanity*.'),
          ]),
          ItemTab('Rambu Solo’', Icons.people_rounded, [
            Gambar('Upacara adat Rambu Solo’ di Tana Toraja', asset: 'assets/images/materi/24.jpg'),
            Callout(JenisCallout.ringkas,
                'Contoh **tradisi** (Tana Toraja, Sulawesi Selatan)'),
            Teks(
                'Upacara pemakaman adat yang megah dan bisa berlangsung berhari-hari. Keluarga menyembelih puluhan kerbau dan babi sebagai penghormatan terakhir. Bagi orang luar tampak boros, tetapi tradisi ini mengajarkan **gotong royong** tingkat tinggi, kekeluargaan, dan penghormatan kepada leluhur.'),
          ]),
          ItemTab('Hutan Larangan', Icons.forest_rounded, [
            Gambar('Hutan Larangan (Leuweung Larangan) Kampung Naga', asset: 'assets/images/materi/25.jpg'),
            Callout(JenisCallout.ringkas,
                'Contoh **kearifan lokal** (Kampung Naga, Tasikmalaya)'),
            Teks(
                'Warga Kampung Naga tidak boleh masuk, menebang pohon, atau berburu di *Leuweung Larangan* karena dianggap keramat (*pamali*).'),
            Callout(JenisCallout.tahukah,
                'Secara ekologis, “keramat” ini cara cerdas leluhur **melindungi sumber mata air** dari kekeringan dan **mencegah longsor**. Tanpa belajar sains modern, mereka sudah tahu konservasi alam!'),
          ]),
        ]),
        KuisMini(
          'Secara ekologis, Hutan Larangan di Kampung Naga berfungsi…',
          [
            'Tempat wisata berbayar',
            'Melindungi sumber mata air dan mencegah longsor',
            'Lahan berburu warga',
            'Tempat menebang kayu',
          ],
          1,
          'Larangan masuk menjaga hutan sehingga mata air terlindungi dan tanah tidak mudah longsor.',
        ),
      ]),
      Bagian('Peran Budaya Lokal dalam Masyarakat Global', Icons.language_rounded, [
        Teks(
            'Mengapa harus repot melestarikan semua ini di zaman AI, *smartphone*, dan budaya pop yang seragam? Ketuk kartu untuk melihat empat perannya:'),
        KartuBalik([
          ItemKartu('1. Filter budaya asing',
              'Globalisasi membawa nilai yang tak selalu cocok dengan karakter bangsa (hidup bebas tanpa aturan, individualisme ekstrem, materialisme). Kearifan lokal menjadi **saringan**: kita ambil teknologi dan ilmunya, tetapi tetap menjunjung sopan santun, religiusitas, dan kekeluargaan.'),
          ItemKartu('2. Solusi krisis global',
              'Dunia pusing menghadapi pemanasan global, dan negara maju mulai menoleh ke kearifan masyarakat adat. Contoh: tradisi **Sasi** di Maluku dan Papua yang melarang menangkap ikan pada bulan tertentu, kini diakui sebagai cara efektif mencegah kepunahan biota laut.'),
          ItemKartu('3. Kekuatan soft power dan diplomasi',
              'Korea Selatan menaklukkan dunia lewat *soft power* (K-Pop, K-Drama, kosmetik). Indonesia juga bisa: **Batik** menjadi pakaian diplomasi internasional, **gamelan** diajarkan di universitas top di Amerika dan Eropa.'),
          ItemKartu('4. Penggerak ekonomi kreatif',
              'Candi Borobudur, Desa Adat Penglipuran di Bali, dan kain Tenun Sumba menggerakkan **pariwisata**. Turis datang untuk melihat keaslian budaya kita, bukan gedung pencakar langit.'),
        ]),
        KuisMini(
          'Tradisi Sasi di Maluku dan Papua berperan sebagai…',
          [
            'Filter budaya asing',
            'Solusi krisis global (melindungi biota laut)',
            'Alat diplomasi lewat musik',
            'Pusat belanja',
          ],
          1,
          'Sasi melarang penangkapan ikan pada waktu tertentu sehingga biota laut lestari, dan kini diakui secara global.',
        ),
      ]),
      Bagian('Komitmen Menjaga dan Melestarikan Tradisi', Icons.favorite_rounded, [
        Teks(
            'Kamu mungkin berpikir, *“Saya kan masih SMP, apa yang bisa saya lakukan?”* Melestarikan budaya tidak harus menjadi seniman maestro. Kamu bisa menerapkan **glokalisasi**: berpikir global, bertindak lokal.'),
        Poin([
          ItemPoin(
              'Jangan hanya tahu nama tariannya, coba praktikkan. Ikut ekstrakurikuler kesenian, cicipi makanan tradisional daerah lain. Pengalaman langsung menumbuhkan rasa cinta.',
              judul: 'Cultural experience (terlibat langsung)'),
          ItemPoin(
              'Saat memakai batik, cari tahu nama motif dan maknanya. Misalnya motif *Mega Mendung* melambangkan keteduhan hati. Yang paham sejarahnya tak mudah terpengaruh ketika negara lain mencoba mengklaimnya.',
              judul: 'Cultural knowledge (memahami maknanya)'),
          ItemPoin(
              'Ini kekuatan terbesarmu. Perkenalkan budaya daerahmu lewat TikTok, Instagram, atau YouTube: transisi *make-up* dengan pakaian adat, *vlog* pasar tradisional, atau *remix* lagu daerah dengan musik modern.',
              judul: 'Manfaatkan teknologi dan media sosial'),
          ItemPoin(
              'Jika produk luar negeri mengambil motif tradisional kita tanpa kredit atau merendahkan maknanya, berani bersuara dengan cara yang beradab.',
              judul: 'Tolak cultural appropriation'),
          ItemPoin(
              'Pilih sepatu, tas, atau pakaian karya UMKM lokal yang memuat unsur budaya, seperti jaket aksen tenun atau tas anyaman rotan. Bangga memakainya adalah langkah terkecil tapi berdampak.',
              judul: 'Bangga memakai produk lokal'),
        ], bernomor: true),
        Ceklis(
          'Yang sudah pernah kamu lakukan',
          [
            'Mencoba tarian, musik, atau kesenian daerah',
            'Mencari tahu makna motif batik atau kain adat',
            'Membagikan konten budaya daerah di media sosial',
            'Memakai produk UMKM lokal',
          ],
          pesanSelesai: 'Hebat! Kamu sudah menjadi pelestari budaya.',
        ),
      ]),
    ],
    penutup:
        'Jati diri bangsa tidak diukur dari banyaknya gedung tinggi, tetapi dari seberapa kuat kita berpijak pada akar sejarah. Jadilah generasi global yang fasih berbahasa Inggris, jago *coding*, namun tetap santun dan bangga menjadi orang Indonesia.',
  ),

  // ═══════════════════════════════════════════════════════════════════════════
  //  MATERI 5
  // ═══════════════════════════════════════════════════════════════════════════
  Materi(
    id: 'k9-m5',
    nomor: 5,
    judul: 'Menjaga Keutuhan Wilayah Negara Kesatuan Republik Indonesia',
    judulPendek: 'Menjaga Keutuhan Wilayah NKRI',
    ringkasan:
        'Komitmen, upaya, tantangan, dan peran aktifmu sebagai pelajar dalam menjaga “kapal Nusantara” agar tetap utuh dan berlayar.',
    ikon: Icons.sailing_rounded,
    warna: Color(0xFF6A1B9A),
    kataKunci: [
      'NKRI',
      'Separatisme',
      'Natuna',
      'Sumpah Pemuda',
      'Bela negara',
      'Ketahanan nasional',
    ],
    pembuka: [
      Callout(
        JenisCallout.analogi,
        'Indonesia adalah kapal pesiar raksasa bernama **“Nusantara”**, membawa lebih dari 270 juta penumpang dari ratusan suku, ras, dan agama. Jika sekelompok orang melubangi lambung kapal, entah karena egois, bertengkar, atau tak peduli, **yang tenggelam seluruh kapal**. Menjaganya adalah tugas semua penumpang, termasuk kamu.',
        judul: 'Kapal bernama Nusantara',
      ),
      Gambar('Ilustrasi kapal “Nusantara” yang berlayar membawa beragam penumpang', asset: 'assets/images/materi/26.jpg'),
    ],
    bagian: [
      Bagian('Komitmen Menjaga Keutuhan Wilayah NKRI', Icons.anchor_rounded, [
        Teks(
            'Komitmen bukan sekadar janji saat upacara, tetapi tekad yang diwujudkan dalam tindakan nyata secara terus-menerus. Indonesia adalah **negara kepulauan terbesar di dunia**, sehingga ribuan pulau yang dipisahkan laut rentan terpecah. Para pendiri bangsa mengunci komitmen ini dalam UUD 1945:'),
        Kutipan(
            '“Khusus mengenai bentuk Negara Kesatuan Republik Indonesia tidak dapat dilakukan perubahan.”',
            sumber: 'UUD NRI 1945 Pasal 37 ayat (5)'),
        Callout(
          JenisCallout.tahukah,
          'Inilah satu-satunya pasal yang tidak boleh diubah. Seberapa pun majunya teknologi dan siapa pun presidennya, bentuk negara harus tetap **Kesatuan**, bukan serikat atau federal yang bisa memisahkan diri sewaktu-waktu.',
        ),
        Teks(
            'Semangat ini tumbuh jauh sebelum merdeka. Pemuda dari Jong Java, Jong Ambon, Jong Sumatranen Bond, dan lainnya membuang ego kesukuan dan bersumpah dalam **Sumpah Pemuda 1928**:'),
        Poin([
          ItemPoin('Bertumpah darah satu', ikon: Icons.map_rounded),
          ItemPoin('Berbangsa satu', ikon: Icons.flag_rounded),
          ItemPoin('Menjunjung bahasa persatuan, Indonesia',
              ikon: Icons.translate_rounded),
        ]),
        KuisMini(
          'Pasal 37 ayat (5) UUD 1945 menegaskan bahwa yang tidak dapat diubah adalah…',
          [
            'Masa jabatan presiden',
            'Bentuk Negara Kesatuan Republik Indonesia',
            'Jumlah anggota DPR',
            'Nama ibu kota negara',
          ],
          1,
          'Pasal itu mengunci bentuk NKRI agar tidak dapat diubah.',
        ),
      ]),
      Bagian('Upaya Mempertahankan Kesatuan dan Persatuan NKRI', Icons.shield_rounded, [
        Teks(
            'Mempertahankan kesatuan bukan hanya tugas TNI dan Polri di perbatasan. Negara memakai pendekatan menyeluruh bernama **ketahanan nasional** yang mencakup berbagai bidang:'),
        TabKonten([
          ItemTab('Ideologi', Icons.star_rounded, [
            Teks(
                'Menanamkan nilai Pancasila sejak dini lewat pendidikan. Pancasila adalah **“lem”** yang merekatkan perbedaan. Tanpa Pancasila, mayoritas akan menindas minoritas dan negara hancur.'),
          ]),
          ItemTab('Politik', Icons.how_to_vote_rounded, [
            Teks(
                'Melaksanakan pemilu secara **damai dan demokratis**. Persatuan terjaga bila suara rakyat dihargai dan pemimpin tidak semena-mena.'),
          ]),
          ItemTab('Ekonomi', Icons.trending_up_rounded, [
            Teks(
                'Dulu pembangunan berpusat di Pulau Jawa (*Jawa-sentris*), sehingga daerah luar Jawa merasa dianaktirikan dan muncul bibit keinginan memisahkan diri. Kini dibangun **pembangunan merata**: Jalan Trans-Papua, bendungan di NTT, dan pelabuhan di pulau terluar, agar keadilan sosial dirasakan seluruh rakyat.'),
          ]),
          ItemTab('Sosial budaya', Icons.diversity_3_rounded, [
            Teks(
                'Menghargai kebudayaan daerah lain dan menjadikannya kekayaan nasional, **bukan alat menyombongkan suku sendiri** (*etnosentrisme*).'),
          ]),
        ]),
        KuisMini(
          'Pembangunan Jalan Trans-Papua dan bendungan di NTT termasuk upaya di bidang…',
          ['Ideologi', 'Politik', 'Ekonomi (pembangunan merata)', 'Sosial budaya'],
          2,
          'Pembangunan infrastruktur yang merata menjadi upaya di bidang ekonomi agar keadilan sosial terasa di seluruh daerah.',
        ),
      ]),
      Bagian('Tantangan Mempertahankan Wilayah NKRI', Icons.warning_amber_rounded, [
        Teks(
            'Semakin besar sebuah negara, semakin besar pula angin yang menerpanya. Musuh kita kini bukan hanya pasukan bersenjata yang terlihat jelas, melainkan tantangan dari dalam dan luar negeri.'),
        TabKonten([
          ItemTab('Dari dalam negeri', Icons.home_rounded, [
            Callout(JenisCallout.penting,
                'Tantangan dari dalam sering lebih berbahaya karena bisa memicu perang saudara.'),
            Poin([
              ItemPoin(
                  'Kelompok yang ingin memisahkan diri lewat pemberontakan bersenjata, seperti KKB di Papua. Mereka memanfaatkan isu ketidakadilan masa lalu hingga menimbulkan korban jiwa warga sipil dan aparat.',
                  judul: 'Ancaman separatisme'),
              ItemPoin(
                  'Kelompok ekstrem yang memaksakan kehendak dan tak bisa menerima perbedaan agama atau pandangan, sambil menyebarkan kebencian.',
                  judul: 'Intoleransi dan radikalisme'),
              ItemPoin(
                  'Hoaks bermuatan SARA bisa viral dalam hitungan menit dan memicu kerusuhan di dunia nyata.',
                  judul: 'Hoaks dan ujaran kebencian'),
            ]),
          ]),
          ItemTab('Dari luar negeri', Icons.public_rounded, [
            Poin([
              ItemPoin(
                  'Laut dan pulau terluar yang kaya sumber daya sering diklaim negara tetangga. Contohnya ketegangan di **perairan Natuna Utara**, ketika kapal nelayan asing yang dikawal *coast guard* mengambil ikan secara ilegal di Zona Ekonomi Eksklusif (ZEE) Indonesia.',
                  judul: 'Sengketa perbatasan'),
              ItemPoin(
                  'Penjajahan gaya baru: bukan menjajah tanah, tetapi **pikiran** generasi muda lewat budaya pop, gaya hidup materialistis, dan individualisme yang mengikis gotong royong.',
                  judul: 'Invasi budaya (neokolonialisme)'),
            ]),
          ]),
        ]),
        KuisMini(
          'Ketegangan di perairan Natuna Utara termasuk tantangan…',
          [
            'Internal: intoleransi',
            'Internal: hoaks',
            'Eksternal: sengketa perbatasan',
            'Eksternal: invasi budaya',
          ],
          2,
          'Kapal asing yang menangkap ikan secara ilegal di ZEE Indonesia adalah bentuk sengketa perbatasan, tantangan dari luar negeri.',
        ),
      ]),
      Bagian('Menumbuhkan Kesadaran Menjaga Keutuhan NKRI', Icons.lightbulb_rounded, [
        Teks(
            'Kesadaran tidak bisa dipaksakan; ia harus tumbuh dari dalam hati. Tiga cara menumbuhkannya:'),
        Poin([
          ItemPoin(
              'Kemerdekaan tidak diberikan gratis. Jutaan pahlawan gugur agar kamu bisa sekolah dengan tenang. Membaca dan menonton dokumenter sejarah menumbuhkan empati dan rasa utang budi pada negara.',
              judul: 'Memahami sejarah darah dan air mata',
              ikon: Icons.history_edu_rounded),
          ItemPoin(
              'Ruang digital adalah medan perang modern. Dengan literasi digital baik, emosimu tidak mudah diaduk narasi provokatif di TikTok atau Instagram yang sengaja memecah belah.',
              judul: 'Meningkatkan literasi digital',
              ikon: Icons.devices_rounded),
          ItemPoin(
              'Bukan “nasionalisme buta” yang menganggap negara sendiri paling benar, melainkan mencintai negara dengan **memperbaiki kekurangannya**, taat pajak kelak saat bekerja, dan mengkritik kebijakan yang keliru lewat jalur beradab.',
              judul: 'Nasionalisme rasional',
              ikon: Icons.psychology_rounded),
        ]),
        KuisMini(
          'Nasionalisme rasional berarti…',
          [
            'Menganggap negara sendiri selalu benar',
            'Mencintai negara sambil memperbaiki kekurangannya lewat jalur beradab',
            'Menolak semua budaya asing',
            'Tidak pernah mengkritik pemerintah',
          ],
          1,
          'Nasionalisme rasional mencintai negara dengan cara memperbaiki kekurangannya dan mengkritik secara beradab.',
        ),
      ]),
      Bagian('Peran Aktif Peserta Didik Menjaga Keutuhan NKRI', Icons.emoji_events_rounded, [
        Teks(
            'Kamu tidak perlu menunggu jadi presiden atau jenderal. Sebagai siswa kelas IX, kamu sudah di garis depan lewat tindakan sehari-hari. Ketuk kartu untuk melihat lima aksinya:'),
        KartuBalik([
          ItemKartu('Hancurkan rantai bullying',
              '*Bullying* karena fisik, suku, atau agama adalah bibit perpecahan bangsa. Berani membela teman yang ditindas dan menciptakan kelas yang aman berarti mempraktikkan **Sila ke-2 dan ke-3**.'),
          ItemKartu('Jadi agen “saring sebelum sharing”',
              'Jangan jadikan jarimu senjata pemusnah massal. Jika menerima informasi panas yang memojokkan kelompok tertentu, **jangan langsung di-*forward***. Cari tahu kebenarannya dulu. Memutus rantai hoaks adalah bela negara di era digital.'),
          ItemKartu('Berprestasi membawa nama harum bangsa',
              'Bela negara bagi pelajar adalah **belajar sungguh-sungguh**. Menang olimpiade sains, kejuaraan olahraga, atau festival seni meningkatkan martabat NKRI di mata dunia.'),
          ItemKartu('Bergabung di organisasi kepemudaan',
              'Pramuka, OSIS, Paskibra, atau PMR melatih **disiplin, kepemimpinan, dan kerja sama** lintas latar belakang, seperti belajar mengatur miniatur negara.'),
          ItemKartu('Cintai produk dalam negeri',
              'Membeli sepatu buatan pabrik lokal atau tas kreasi UMKM daerahmu **menyelamatkan lapangan kerja** rakyat Indonesia. Ekonomi yang kuat membuat negara tak mudah diombang-ambingkan kekuatan asing.'),
        ]),
        Ceklis(
          'Aksi yang sudah kamu lakukan',
          [
            'Membela atau menemani teman yang di-bully',
            'Mengecek kebenaran berita sebelum meneruskannya',
            'Ikut lomba atau berprestasi di sekolah',
            'Aktif di Pramuka, OSIS, Paskibra, atau PMR',
            'Memakai produk karya UMKM lokal',
          ],
          pesanSelesai: 'Luar biasa! Kamu sudah memegang erat tali persatuan Nusantara.',
        ),
      ]),
    ],
    penutup:
        'Keutuhan NKRI bukan turun dari langit, melainkan hasil keringat dan kedisiplinan setiap warga. Setiap kali kamu menghargai teman yang berbeda agama, membuang sampah pada tempatnya, dan menolak menyebarkan kebencian di media sosial, kamu memegang teguh tali persatuan yang menjaga kapal Nusantara tetap berlayar gagah mengarungi tantangan zaman.',
  ),
];
