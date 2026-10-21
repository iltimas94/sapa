import 'package:flutter/material.dart';
import 'materi_kelas8_model.dart';

/// ===========================================================================
///  ISI MATERI KELAS VIII (bersumber dari berkas Kelas_VIII.docx)
///  - Tulis **kata penting** untuk cetak tebal.
///  - Untuk memasang gambar: isi parameter `aset:` pada blok Gambar(...)
///    dan daftarkan foldernya di pubspec.yaml.
/// ===========================================================================
final List<MateriKelas8> daftarMateriKelas8 = [
  // -------------------------------------------------------------------------
  // MATERI 1
  // -------------------------------------------------------------------------
  MateriKelas8(
    id: 'm1',
    nomor: 1,
    judul: 'Kedudukan Pancasila dalam Kehidupan Berbangsa dan Bernegara',
    ringkas:
        'Pancasila sebagai dasar negara, pandangan hidup, dan ideologi negara, dijelaskan lewat analogi fondasi, kacamata, hingga main quest.',
    emoji: '🦅',
    warna: const Color(0xFFB3261E),
    menitBaca: 10,
    kataKunci: [
      'pancasila', 'dasar negara', 'pandangan hidup', 'ideologi', 'fondasi',
      'sumber hukum', 'kompas', 'filter', 'blueprint', 'main quest',
      'antivirus', 'globalisasi', 'liberalisme', 'komunisme', 'gotong royong',
    ],
    bagian: [
      Bagian(
        judul: 'Pancasila, Sahabat Langkahmu',
        emoji: '🤝',
        blok: [
          Paragraf(
              'Pancasila bukan sekadar teks yang dibacakan saat upacara bendera hari Senin. Pancasila adalah **jiwa, napas, dan pedoman utama** bagi kita semua, termasuk kamu yang kini duduk di bangku SMP.'),
          Paragraf(
              'Di usia remaja, pergaulanmu makin luas dan tantanganmu makin beragam. Di sinilah Pancasila hadir sebagai “sahabat” yang memandu langkahmu.'),
          Paragraf(
              'Ada **tiga sudut pandang** untuk memahami kedudukan Pancasila. Ketuk setiap tab untuk melihat peta singkatnya:'),
          TabPerbandingan([
            ItemTab(
              label: 'Dasar Negara',
              emoji: '🏛️',
              judul: 'Untuk pemerintah dan negara',
              isi:
                  'Berbicara tentang **bagaimana negara diurus**. Pancasila menjadi pijakan hukum dan aturan main penyelenggaraan negara.',
              poin: [
                'Fondasi bangunan negara',
                'Sumber dari segala sumber hukum',
                'Kompas bagi pemerintah',
                'Lem perekat keberagaman',
              ],
            ),
            ItemTab(
              label: 'Pandangan Hidup',
              emoji: '👓',
              judul: 'Untuk kamu dan masyarakat',
              isi:
                  'Berbicara tentang **bagaimana kita bersikap, berpikir, dan bertingkah laku** dalam kehidupan sehari-hari.',
              poin: [
                'Kacamata untuk melihat dunia',
                'DNA kepribadian bangsa',
                'Buku panduan bergaul',
                'Filter di era digital',
              ],
            ),
            ItemTab(
              label: 'Ideologi',
              emoji: '🚀',
              judul: 'Untuk masa depan Indonesia',
              isi:
                  'Berbicara tentang **mimpi besar dan misi utama** bangsa, yaitu cita-cita yang ingin dicapai bersama.',
              poin: [
                'Blueprint (cetak biru) masa depan',
                'Main quest bangsa',
                'Antivirus dan firewall negara',
                'Yel-yel penyemangat bangsa',
              ],
            ),
          ]),
        ],
      ),
      Bagian(
        judul: 'Pancasila sebagai Dasar Negara',
        emoji: '🏛️',
        blok: [
          Paragraf(
              'Bagaimana negara sebesar Indonesia, dengan jutaan penduduk dan ribuan pulau, bisa berdiri kokoh dan tidak hancur berantakan? Jawabannya ada pada **dasar negara**. Bagi bangsa Indonesia, dasar negara itu adalah Pancasila.'),
          Gambar(
            deskripsi:
                'Ilustrasi gedung pencakar langit dengan fondasi baja yang kuat di bawah tanah',
            aset: 'assets/images/materi/16.jpg',
          ),
          Paragraf(
              'Dasar negara bisa dipahami lewat empat perumpamaan. Ketuk untuk membukanya:'),
          Akordeon([
            ItemAkordeon(
              emoji: '🏗️',
              judul: 'Fondasi gedung pencakar langit',
              isi:
                  'Negara ibarat gedung megah. Sehebat apa pun desainnya, gedung tidak akan tegak tanpa **fondasi yang tertanam kuat**. Fondasi jarang terlihat, tetapi saat badai atau gempa datang, dialah yang menahan gedung agar tidak ambruk.\n\nPancasila adalah fondasi itu: tempat berpijaknya seluruh kehidupan bernegara, sehingga negara tidak mudah goyah dan terpecah belah.',
            ),
            ItemAkordeon(
              emoji: '📜',
              judul: 'Sumber dari segala sumber hukum',
              isi:
                  'Seperti sepak bola atau game online yang butuh aturan, negara pun butuh hukum. Semua aturan di Indonesia **harus bersumber dari dan tidak boleh bertentangan dengan Pancasila**.\n\nJika sebuah aturan merugikan masyarakat, membeda-bedakan orang, atau tidak adil, aturan itu melanggar dasar negara dan harus dibatalkan. Pancasila menjadi saringan pelindung agar hukum dibuat untuk kebaikan, keadilan, dan kesejahteraan seluruh rakyat.',
            ),
            ItemAkordeon(
              emoji: '🧭',
              judul: 'Kompas penyelenggaraan negara',
              isi:
                  'Bayangkan Indonesia sebagai kapal raksasa dengan lebih dari 270 juta penumpang. Pemerintah adalah kapten dan awak kapalnya. Agar tidak tersesat di tengah kabut dan badai, mereka butuh kompas.\n\n**Pancasila adalah kompas itu**. Setiap program kerja, pembangunan, hingga anggaran negara harus mengarah pada keadilan sosial, kemanusiaan, dan persatuan. Siapa pun presidennya, arah kapal tetap sama.',
            ),
            ItemAkordeon(
              emoji: '🧩',
              judul: 'Lem perekat keberagaman',
              isi:
                  'Ada ribuan suku, ratusan bahasa daerah, dan berbagai agama. Secara logika, negara seperti ini sangat mudah pecah. Namun dari Sabang sampai Merauke kita tetap bangga menjadi orang Indonesia karena **berpijak pada dasar yang sama**.\n\nPancasila memberi titik temu yang diterima semua golongan. Tidak ada suku yang diistimewakan dan tidak ada kelompok yang boleh menindas kelompok lain.',
            ),
          ]),
          Kotak(
            jenis: JenisKotak.info,
            judul: 'Intinya',
            isi:
                'Pancasila bukan sekadar teks hafalan. Ia adalah fondasi tempatmu berdiri aman, sumber aturan yang melindungi hakmu, kompas bagi para pemimpin, dan lem yang membuatmu bisa berteman dengan siapa saja di seluruh Nusantara.',
          ),
        ],
      ),
      Bagian(
        judul: 'Pancasila sebagai Pandangan Hidup Bangsa',
        emoji: '👓',
        blok: [
          Kotak(
            jenis: JenisKotak.tips,
            judul: 'Rumus mudah mengingat',
            isi:
                '**Dasar negara** = bagaimana pemerintah dan negara diurus.\n**Pandangan hidup** = bagaimana kamu, aku, dan kita semua bersikap, berpikir, dan bertingkah laku sehari-hari.',
          ),
          Paragraf('Pilih salah satu perumpamaan di bawah ini:'),
          TabPerbandingan([
            ItemTab(
              label: 'Kacamata',
              emoji: '👓',
              judul: 'Kacamata untuk melihat dunia',
              isi:
                  'Cara kita melihat dunia bergantung pada “kacamata” yang dipakai. Orang berkacamata individualisme berpikir, “Itu masalah dia, bukan urusanku.”\n\nDengan **kacamata Pancasila**, kita melihat, “Dia saudara sebangsaku, aku harus membantunya.” Itulah akar tradisi **gotong royong**.',
            ),
            ItemTab(
              label: 'DNA',
              emoji: '🧬',
              judul: 'DNA kepribadian bangsa',
              isi:
                  'Setiap orang punya kepribadian unik, begitu juga sebuah bangsa. Jauh sebelum merdeka, nenek moyang kita sudah percaya pada Tuhan, ramah, bermusyawarah, dan bekerja sama membangun desa. Kebiasaan baik itulah yang dirumuskan menjadi Pancasila.\n\nSaat kamu sopan kepada guru, menghargai teman yang beribadah, atau menyelesaikan masalah lewat diskusi, kamu sedang **menghidupkan Pancasila**.',
            ),
            ItemTab(
              label: 'Panduan',
              emoji: '📖',
              judul: 'Buku panduan bergaul',
              isi:
                  'Seperti manual book untuk game baru, Pancasila memandu cara kita bergaul di masyarakat. Panduan ini mengajarkan:',
              poin: [
                'Tidak melakukan bullying (nilai kemanusiaan)',
                'Tidak membeda-bedakan teman kaya atau miskin (nilai keadilan)',
                'Mengutamakan kekompakan kelas di atas ego pribadi (nilai persatuan)',
              ],
            ),
            ItemTab(
              label: 'Filter',
              emoji: '🛡️',
              judul: 'Filter di era digital',
              isi:
                  'Lewat internet, budaya dari seluruh dunia masuk ke HP-mu. Itu tidak buruk, tetapi seperti minum air sungai yang deras, harus disaring dulu. Pancasila membantu kita **menyaring budaya asing yang baik dan yang buruk**, supaya kita tetap gaul dan modern tanpa kehilangan identitas.',
            ),
          ]),
          Klasifikasi(
            judul: 'Uji Filter Pancasila',
            petunjuk: 'Apakah hal ini lolos filter Pancasila?',
            labels: ['Lolos ✅', 'Tidak lolos ❌'],
            items: [
              ItemKlas(
                  teks: 'Budaya disiplin waktu dari Jepang',
                  jawaban: 0,
                  alasan: 'Disiplin sejalan dengan semangat kita untuk maju.'),
              ItemKlas(
                  teks: 'Etos kerja keras dan kemajuan teknologi negara Barat',
                  jawaban: 0,
                  alasan: 'Sangat bagus dan sesuai dengan semangat kita untuk maju.'),
              ItemKlas(
                  teks: 'Gaya hidup terlalu bebas yang tidak menghormati orang tua',
                  jawaban: 1,
                  alasan: 'Tidak sesuai dengan “DNA” kesopanan bangsa kita.'),
              ItemKlas(
                  teks: 'Sikap apatis (cuek) terhadap lingkungan sekitar',
                  jawaban: 1,
                  alasan: 'Bertentangan dengan nilai kemanusiaan dan gotong royong.'),
              ItemKlas(
                  teks: 'Berkata-kata kasar di internet',
                  jawaban: 1,
                  alasan: 'Tidak sesuai dengan kepribadian bangsa yang santun.'),
            ],
          ),
          Kotak(
            jenis: JenisKotak.refleksi,
            judul: 'Renungkan',
            isi:
                'Dari perumpamaan kacamata, DNA, buku panduan, atau filter di era digital, mana yang paling menggambarkan tantangan anak muda seusiamu dalam menerapkan Pancasila?\n\nIngat, Pancasila hidup di ruang kelas, di kantin saat kamu mengantre tertib, di lapangan basket saat bermain sportif, dan di kolom komentar media sosial saat kamu mengetik kata-kata positif.',
          ),
        ],
      ),
      Bagian(
        judul: 'Pancasila sebagai Ideologi Negara',
        emoji: '🚀',
        blok: [
          Paragraf(
              'Kata “ideologi” terdengar berat, padahal berasal dari kata idea yang berarti gagasan, konsep, atau cita-cita. Jadi, **ideologi adalah kumpulan cita-cita besar yang ingin dicapai suatu bangsa**.'),
          Paragraf(
              'Jika dasar negara adalah fondasinya dan pandangan hidup adalah kacamata sehari-harinya, maka ideologi adalah **mimpi besar dan misi utama** kita di masa depan. Ketuk kartu untuk membaliknya:'),
          KartuBalik([
            KartuBalikItem(
              emoji: '🎮',
              depan: 'Blueprint (cetak biru) dalam game bangun kota',
              belakang:
                  'Sebelum membangun kota di game, kamu punya bayangan: kota canggih, banyak taman, warga bahagia, tidak macet. Itulah blueprint.\n\nPara pendiri bangsa membuat blueprint bernama Pancasila: negara yang **religius, memanusiakan manusia, bersatu padu, mengutamakan musyawarah, dan berkeadilan sosial**.',
            ),
            KartuBalikItem(
              emoji: '⚔️',
              depan: 'Main quest (misi utama) bangsa',
              belakang:
                  'Dalam game RPG ada side quest dan main quest. Membangun jalan tol, mengajar, mengobati pasien, dan belajar untuk ujian adalah side quest.\n\n**Main quest bangsa Indonesia: keadilan sosial dan kesejahteraan bagi seluruh rakyat.** Itulah yang menggerakkan 270 juta orang menuju garis finish yang sama.',
            ),
            KartuBalikItem(
              emoji: '🦠',
              depan: 'Antivirus dan firewall pelindung negara',
              belakang:
                  'Paham dari luar mudah masuk lewat media sosial. **Liberalisme** sangat membebaskan warganya hingga cenderung individualis. **Komunisme** mengatur warga sangat ketat sehingga kebebasan pribadi terbatas.\n\nSaat ada ajaran yang menyebarkan kebencian, radikalisme, atau memecah belah agama, ideologi Pancasila mendeteksi dan memblokirnya agar kita tidak “dijajah” secara pikiran.',
            ),
            KartuBalikItem(
              emoji: '📣',
              depan: 'Chant (yel-yel) suporter yang menyatukan semangat',
              belakang:
                  'Di stadion, puluhan ribu orang yang tidak saling kenal bisa bernyanyi kompak saat chant dimulai. Di masa sulit seperti krisis, bencana, atau pandemi, nilai ideologi Pancasila diteriakkan kembali untuk **menyatukan semangat**.\n\nSaat satu daerah terkena gempa, daerah lain langsung mengirim bantuan tanpa disuruh. Itu bukti yel-yel Pancasila bekerja di jiwa masyarakat.',
            ),
          ]),
          Kotak(
            jenis: JenisKotak.ringkasan,
            judul: 'Ringkasan tiga kedudukan Pancasila',
            poin: [
              '**Dasar Negara:** aturan main dan fondasi hukum (bagi pemerintah)',
              '**Pandangan Hidup:** pedoman sikap dan tingkah laku sehari-hari (bagi kamu dan masyarakat)',
              '**Ideologi Negara:** cita-cita masa depan, pelindung dari pengaruh buruk, dan penggerak semangat bangsa',
            ],
          ),
          Kotak(
            jenis: JenisKotak.refleksi,
            judul: 'Tantangan untukmu',
            isi:
                'Dari Blueprint, Main Quest, atau Antivirus, mana yang paling mudah kamu jelaskan kepada teman sebangkumu besok di sekolah? Kamu adalah tokoh utama yang akan menyelesaikan blueprint dan menamatkan main quest bangsa ini.',
          ),
        ],
      ),
      Bagian(
        judul: 'Uji Pemahaman',
        emoji: '✅',
        blok: [
          Latihan(judul: 'Kuis Materi 1', soal: [
            Soal(
              pertanyaan:
                  'Dalam analogi gedung pencakar langit, Pancasila sebagai dasar negara berperan sebagai…',
              opsi: [
                'Kaca yang berkilau',
                'Fondasi yang menahan gedung saat badai',
                'Lift yang sangat cepat',
                'Ruangan di dalam gedung',
              ],
              benar: 1,
              penjelasan:
                  'Fondasi jarang terlihat, tetapi dialah yang menahan gedung saat badai dan gempa.',
            ),
            Soal(
              pertanyaan:
                  'Mengapa aturan yang membeda-bedakan orang berdasarkan latar belakangnya harus dibatalkan?',
              opsi: [
                'Karena aturannya terlalu panjang',
                'Karena dibuat oleh pemerintah daerah',
                'Karena melanggar dasar negara, yaitu Pancasila',
                'Karena sudah terlalu lama berlaku',
              ],
              benar: 2,
              penjelasan:
                  'Semua aturan harus bersumber dari dan tidak boleh bertentangan dengan Pancasila.',
            ),
            Soal(
              pertanyaan: 'Pancasila sebagai pandangan hidup berbicara tentang…',
              opsi: [
                'Cara kita bersikap, berpikir, dan bertingkah laku sehari-hari',
                'Cara pemerintah menyusun anggaran negara',
                'Cara DPR membuat undang-undang',
                'Cara menjaga batas wilayah negara',
              ],
              benar: 0,
              penjelasan:
                  'Pandangan hidup adalah pedoman tingkah laku bagi kita semua sebagai rakyat.',
            ),
            Soal(
              pertanyaan: 'Kata “ideologi” berasal dari kata idea yang berarti…',
              opsi: ['Aturan', 'Hukuman', 'Gagasan atau cita-cita', 'Kekuasaan'],
              benar: 2,
              penjelasan:
                  'Ideologi adalah kumpulan ide atau cita-cita besar yang ingin dicapai suatu bangsa.',
            ),
            Soal(
              pertanyaan:
                  'Saat ajaran yang menyebarkan kebencian masuk lewat media sosial, Pancasila berfungsi sebagai…',
              opsi: [
                'Yel-yel suporter',
                'Cetak biru kota',
                'Buku panduan permainan',
                'Antivirus dan firewall ideologi',
              ],
              benar: 3,
              penjelasan:
                  'Seperti antivirus, ideologi Pancasila mendeteksi dan memblokir ajaran yang bertentangan dengan kemanusiaan dan persatuan.',
            ),
          ]),
        ],
      ),
    ],
  ),

  // -------------------------------------------------------------------------
  // MATERI 2
  // -------------------------------------------------------------------------
  MateriKelas8(
    id: 'm2',
    nomor: 2,
    judul: 'UUD Negara Republik Indonesia Tahun 1945',
    ringkas:
        'Perjalanan lahirnya konstitusi dari sidang BPUPKI hingga PPKI, fungsinya sebagai hukum tertinggi, dan cara menjalankannya di sekitarmu.',
    emoji: '📜',
    warna: const Color(0xFF283593),
    menitBaca: 9,
    kataKunci: [
      'uud 1945', 'konstitusi', 'bpupki', 'ppki', 'sidang', 'perumusan',
      'pengesahan', 'hukum dasar', 'pasal 29', 'pasal 30', 'pasal 31',
      'check and balance', 'eksekutif', 'legislatif', 'yudikatif',
      'soepomo', 'soekarno', 'hatta', 'knip', 'proklamasi',
    ],
    bagian: [
      Bagian(
        judul: 'Aturan Main Tertinggi',
        emoji: '⚽',
        blok: [
          Paragraf(
              'Bayangkan sepak bola tanpa aturan, tanpa wasit, dan tanpa garis batas lapangan. Pasti kacau, bukan? Negara pun butuh “aturan main” yang kuat agar bisa berdiri tegak, berjalan teratur, dan melindungi seluruh rakyatnya.'),
          Paragraf(
              'Bagi Indonesia, aturan main tertinggi itu adalah **Undang-Undang Dasar Negara Republik Indonesia (UUD NRI) Tahun 1945**.'),
          Gambar(
            deskripsi: 'Suasana Sidang Perumusan UUD 1945',
            sumber: 'Kompaspedia - Kompas.id',
            aset: 'assets/images/materi/17.jpg',
          ),
          Paragraf(
              'Memahami UUD 1945 bukan sekadar menghafal teks saat upacara. Ini tentang memahami bagaimana fondasi “rumah besar” bernama Indonesia dibangun dan bagaimana kita merawatnya.'),
          Kotak(
            jenis: JenisKotak.info,
            judul: 'Tiga hal yang akan kamu pelajari',
            poin: [
              'Proses perumusan dan pengesahan UUD 1945',
              'Fungsi dan kedudukan UUD 1945',
              'Berani menjalankan UUD 1945 di lingkungan tempat tinggal',
            ],
          ),
        ],
      ),
      Bagian(
        judul: 'Proses Perumusan dan Pengesahan',
        emoji: '⏳',
        blok: [
          Paragraf(
              'Lahirnya UUD 1945 tidak instan. Ada keringat, perdebatan pemikiran yang panjang, dan semangat luar biasa para pendiri bangsa (founding fathers). Prosesnya bahkan dimulai sebelum kemerdekaan diproklamasikan.'),
          Linimasa(items: [
            Peristiwa(
              waktu: '29 Mei – 1 Juni 1945',
              judul: 'Sidang pertama BPUPKI',
              isi:
                  'Fokus pada **perumusan dasar negara**. Para tokoh bertukar gagasan hingga lahir rumusan Pancasila sebagai landasan filosofis yang menjiwai seluruh isi UUD 1945.',
            ),
            Peristiwa(
              waktu: '10 – 17 Juli 1945',
              judul: 'Sidang kedua BPUPKI',
              isi:
                  'Fokus pada bentuk wilayah, bentuk negara, dan perumusan UUD. Dibentuk **Panitia Hukum Dasar** (ketua Ir. Soekarno) dan **Panitia Perancang UUD** (pimpinan Prof. Mr. Dr. Soepomo).',
            ),
            Peristiwa(
              waktu: '16 Juli 1945',
              judul: 'Rancangan UUD diterima',
              isi:
                  'Setelah diskusi dan revisi yang matang, naskah rancangan UUD diterima secara bulat.',
            ),
            Peristiwa(
              waktu: '17 Agustus 1945',
              judul: 'Proklamasi kemerdekaan',
              isi:
                  'Bangsa Indonesia membacakan proklamasi. Negara baru tentu tidak bisa dibiarkan tanpa struktur pemerintahan yang sah.',
            ),
            Peristiwa(
              waktu: '18 Agustus 1945',
              judul: 'Sidang PPKI',
              isi:
                  'Panitia Persiapan Kemerdekaan Indonesia (PPKI) menggelar sidang dengan **tiga keputusan penting** (lihat kotak di bawah).',
            ),
          ]),
          Kotak(
            jenis: JenisKotak.penting,
            judul: 'Tiga keputusan sidang PPKI, 18 Agustus 1945',
            poin: [
              'Mengesahkan UUD 1945 sebagai konstitusi negara Republik Indonesia',
              'Menetapkan Ir. Soekarno sebagai Presiden dan Drs. Mohammad Hatta sebagai Wakil Presiden',
              'Membentuk Komite Nasional Indonesia Pusat (KNIP) untuk membantu tugas Presiden selama MPR dan DPR belum terbentuk',
            ],
          ),
          Paragraf(
              'Sejak ketukan palu sidang PPKI pada 18 Agustus itulah, UUD 1945 resmi menjadi hukum pedoman jalannya pemerintahan bangsa kita. Berikut potret sejarah yang patut kamu kenali:'),
          Gambar(
            deskripsi: 'Gedung Pancasila, Jakarta',
            sumber: 'Republika.id - Kisah Rumah Panglima Belanda jadi Tempat Lahir Pancasila',
            aset: 'assets/images/materi/18.jpg',
          ),
          Gambar(
            deskripsi: 'Naskah asli UUD 1945',
            sumber: 'Wikipedia - Undang-Undang Dasar Negara Republik Indonesia Tahun 1945',
            rasio: 4 / 3,
            aset: 'assets/images/materi/19.jpg',
          ),
          Urutkan(
            judul: 'Susun Urutan Sejarahnya',
            petunjuk:
                'Seret ikon di sisi kanan untuk mengurutkan dari peristiwa paling awal sampai paling akhir.',
            urutanBenar: [
              'Sidang pertama BPUPKI membahas dasar negara',
              'Sidang kedua BPUPKI menyusun rancangan UUD',
              'Proklamasi kemerdekaan 17 Agustus 1945',
              'Sidang PPKI mengesahkan UUD 1945',
            ],
            penjelasan:
                'BPUPKI bersidang sebelum proklamasi, sedangkan PPKI mengesahkan UUD sehari setelah proklamasi.',
          ),
        ],
      ),
      Bagian(
        judul: 'Fungsi dan Kedudukan UUD 1945',
        emoji: '🏛️',
        blok: [
          Paragraf(
              'Di Indonesia ada banyak aturan: Undang-Undang (UU), Peraturan Presiden, Peraturan Pemerintah, hingga Peraturan Daerah (Perda). Dalam piramida peraturan hukum, **UUD NRI Tahun 1945 menempati kedudukan paling tinggi**.'),
          Kotak(
            jenis: JenisKotak.penting,
            judul: 'Hukum dasar tertulis',
            isi:
                'UUD 1945 berstatus sebagai **hukum dasar tertulis**. Setiap aturan lain bersumber padanya dan **sama sekali tidak boleh bertentangan** dengan isinya. Jika ada aturan daerah atau undang-undang yang menyimpang, aturan itu harus dievaluasi dan dibatalkan demi hukum.',
          ),
          Paragraf('UUD 1945 memegang tiga fungsi utama. Ketuk setiap tab:'),
          TabPerbandingan([
            ItemTab(
              label: 'Alat Kontrol',
              emoji: '🔍',
              judul: 'Tolak ukur dan alat pemeriksa',
              isi:
                  'Berfungsi sebagai alat pemeriksa (check and balance). UUD 1945 mengontrol aturan yang lebih rendah agar selalu berpedoman pada nilai keadilan dan konstitusi yang lebih tinggi.',
            ),
            ItemTab(
              label: 'Pengatur',
              emoji: '🧱',
              judul: 'Mendesain bangunan negara',
              isi:
                  'Membagi dan mengatur kekuasaan agar tidak menumpuk pada satu pihak. UUD menetapkan tugas masing-masing lembaga:',
              poin: [
                'Presiden (Pemerintah): **Eksekutif**, menjalankan pemerintahan',
                'DPR: **Legislatif**, pembuat hukum',
                'Pengadilan: **Yudikatif**, ranah peradilan',
              ],
            ),
            ItemTab(
              label: 'Penentu',
              emoji: '🎯',
              judul: 'Penegas hak dan kewajiban kita',
              isi: 'Dari UUD 1945 ditentukan bahwa:',
              poin: [
                'Seluruh anak bangsa berhak mendapat pendidikan yang layak',
                'Kebebasan beragama dijamin',
                'Setiap warga wajib patuh pada hukum',
                'Setiap warga wajib membela negara saat diperlukan',
              ],
            ),
          ]),
        ],
      ),
      Bagian(
        judul: 'Berani Menjalankan UUD di Lingkunganmu',
        emoji: '💪',
        blok: [
          Paragraf(
              'Banyak pelajar mengira UUD hanya urusan pejabat dan politikus di Senayan. Padahal ruh UUD 1945 hidup dalam tindakan sehari-hari. Kamu tidak perlu menunggu dewasa: **mulailah dari lingkungan tempat tinggalmu**.'),
          Paragraf(
              '“Berani menjalankan” berarti tidak sekadar hafal teori, tetapi mau mengambil tindakan nyata. Ketuk untuk melihat contohnya:'),
          Akordeon([
            ItemAkordeon(
              emoji: '🕊️',
              judul: 'Menghargai keberagaman agama (Pasal 29)',
              isi:
                  'Berani bersikap toleran dalam tindakan: tidak berbuat bising saat tetangga beribadah, mengucapkan selamat pada hari rayanya, dan bergaul tanpa membedakan agama atau suku.',
            ),
            ItemAkordeon(
              emoji: '🤲',
              judul: 'Menghidupkan gotong royong',
              isi:
                  'Ikut kerja bakti akhir pekan: menyapu jalan, membersihkan balai warga, atau menjaga kebersihan fasilitas umum. Ini wujud tanggung jawab sosial yang diamanatkan pendiri bangsa.',
            ),
            ItemAkordeon(
              emoji: '📚',
              judul: 'Menjalankan hak pendidikan (Pasal 31)',
              isi:
                  'Negara menjamin pendidikan dasarmu. Balaslah dengan belajar gigih, tidak mudah menyerah, dan tidak membolos. Lebih mulia lagi bila kamu berbagi ilmu kepada adik-adik tetangga yang kesulitan belajar.',
            ),
            ItemAkordeon(
              emoji: '🛡️',
              judul: 'Menjaga keamanan lingkungan (bela negara, Pasal 30)',
              isi:
                  'Bela negara bagi remaja bukan mengangkat senjata, melainkan menjaga ketertiban: mematuhi jam malam, tidak begadang sambil membuat keributan, menjaga taman warga, dan berani melapor kepada Ketua RT/RW jika ada kejadian yang membahayakan.',
            ),
            ItemAkordeon(
              emoji: '✋',
              judul: 'Berani melawan ketidakadilan sosial',
              isi:
                  'Jika ada anak yang dikucilkan atau di-bully, jangan diam saja. Konstitusi menjamin setiap warga bebas dari perlakuan merendahkan. Bantu melerai atau laporkan kepada orang dewasa yang bisa memberi jalan keluar terbaik.',
            ),
          ]),
          Klasifikasi(
            judul: 'Pasal berapa, ya?',
            petunjuk: 'Tindakan ini termasuk mempraktikkan pasal…',
            labels: ['Pasal 29 (agama)', 'Pasal 30 (bela negara)', 'Pasal 31 (pendidikan)'],
            items: [
              ItemKlas(
                  teks: 'Tidak berisik saat tetangga sedang beribadah',
                  jawaban: 0,
                  alasan: 'Menghormati kebebasan beragama adalah praktik Pasal 29.'),
              ItemKlas(
                  teks: 'Melapor kepada Ketua RT jika ada kejadian yang membahayakan',
                  jawaban: 1,
                  alasan: 'Menjaga keamanan lingkungan adalah wujud bela negara (Pasal 30).'),
              ItemKlas(
                  teks: 'Rajin belajar dan tidak membolos',
                  jawaban: 2,
                  alasan: 'Membalas jaminan pendidikan dari negara (Pasal 31).'),
              ItemKlas(
                  teks: 'Mengucapkan selamat hari raya kepada tetangga yang berbeda agama',
                  jawaban: 0,
                  alasan: 'Sikap toleran antarumat beragama (Pasal 29).'),
              ItemKlas(
                  teks: 'Mematuhi jam malam dan tidak membuat keributan di pos ronda',
                  jawaban: 1,
                  alasan: 'Menjaga ketertiban lingkungan termasuk bela negara (Pasal 30).'),
              ItemKlas(
                  teks: 'Berbagi ilmu kepada adik tetangga yang kesulitan belajar',
                  jawaban: 2,
                  alasan: 'Mendukung hak pendidikan bagi sesama (Pasal 31).'),
            ],
          ),
          Kotak(
            jenis: JenisKotak.tips,
            judul: 'Pesan penutup',
            isi:
                'UUD 1945 bukan pajangan atau buku tebal usang. Ia adalah kompas hidup masyarakat. Kamu adalah warga negara terdidik yang merawat tiang-tiang bangunan Republik Indonesia. Mulailah dari hal sekecil apa pun di rumahmu hari ini!',
          ),
        ],
      ),
      Bagian(
        judul: 'Uji Pemahaman',
        emoji: '✅',
        blok: [
          Latihan(judul: 'Kuis Materi 2', soal: [
            Soal(
              pertanyaan:
                  'Badan yang mengadakan dua kali sidang untuk merumuskan dasar negara dan UUD adalah…',
              opsi: ['PPKI', 'BPUPKI', 'KNIP', 'DPR'],
              benar: 1,
              penjelasan:
                  'BPUPKI bersidang pada 29 Mei–1 Juni 1945 dan 10–17 Juli 1945.',
            ),
            Soal(
              pertanyaan:
                  'Siapa yang ditetapkan sebagai Presiden dan Wakil Presiden dalam sidang PPKI 18 Agustus 1945?',
              opsi: [
                'Soepomo dan Soekarno',
                'Mohammad Hatta dan Soepomo',
                'Ir. Soekarno dan Drs. Mohammad Hatta',
                'Djuanda dan Hatta',
              ],
              benar: 2,
              penjelasan:
                  'Ir. Soekarno sebagai Presiden dan Drs. Mohammad Hatta sebagai Wakil Presiden.',
            ),
            Soal(
              pertanyaan: 'UUD 1945 disebut hukum dasar tertulis. Artinya…',
              opsi: [
                'Hanya dibacakan saat upacara bendera',
                'Hanya berlaku bagi Presiden',
                'Boleh diubah oleh Peraturan Daerah',
                'Semua aturan lain bersumber padanya dan tidak boleh bertentangan',
              ],
              benar: 3,
              penjelasan:
                  'Aturan yang lebih rendah harus sejalan dengan UUD 1945.',
            ),
            Soal(
              pertanyaan:
                  'Pembagian tugas Presiden, DPR, dan pengadilan menunjukkan fungsi UUD 1945 sebagai…',
              opsi: [
                'Pengatur',
                'Penghias negara',
                'Penentu hak pendidikan',
                'Penentu batas laut',
              ],
              benar: 0,
              penjelasan:
                  'Sebagai pengatur, UUD membagi kekuasaan: eksekutif, legislatif, dan yudikatif.',
            ),
            Soal(
              pertanyaan:
                  'Membantu melerai atau melaporkan teman yang di-bully termasuk wujud…',
              opsi: [
                'Mengabaikan konstitusi',
                'Menghindari tanggung jawab',
                'Berani melawan ketidakadilan sosial',
                'Menghapus aturan sekolah',
              ],
              benar: 2,
              penjelasan:
                  'Konstitusi menjamin setiap warga bebas dari perlakuan merendahkan.',
            ),
          ]),
        ],
      ),
    ],
  ),

  // -------------------------------------------------------------------------
  // MATERI 3
  // -------------------------------------------------------------------------
  MateriKelas8(
    id: 'm3',
    nomor: 3,
    judul: 'Peraturan Perundang-undangan',
    ringkas:
        'Dari aturan di rumah sampai undang-undang negara: pahami piramida hierarki aturan dan cara menjadi warga yang sadar hukum.',
    emoji: '⚖️',
    warna: const Color(0xFF6A1B9A),
    menitBaca: 9,
    kataKunci: [
      'peraturan', 'perundang-undangan', 'hierarki', 'tata urutan', 'piramida',
      'tap mpr', 'uu', 'perppu', 'pp', 'perpres', 'perda',
      'kesadaran hukum', 'implementasi', 'uu ite', 'hoaks', 'helm', 'sni',
      'kawasan tanpa rokok', 'ktr', 'uu 12 tahun 2011',
    ],
    bagian: [
      Bagian(
        judul: 'Aturan di Sekitarmu',
        emoji: '🏠',
        blok: [
          Paragraf(
              'Setiap lingkungan, dari rumah hingga negara, butuh aturan untuk menjaga ketertiban, keadilan, dan keamanan. Tanpa aturan, setiap orang bertindak hanya demi kepentingan pribadinya dan kehidupan bersama menjadi kacau.'),
          Paragraf(
              'Aturan hidup berdampingan dengan kita setiap hari, dan **ruang lingkupnya makin besar** seiring ke mana kita melangkah. Ketuk tab untuk membandingkan:'),
          TabPerbandingan([
            ItemTab(
              label: 'Rumah',
              emoji: '🏡',
              judul: 'Fondasi pertama kedisiplinan',
              isi: 'Dibuat orang tua atau kesepakatan keluarga untuk menjaga keharmonisan.',
              poin: [
                'Batasan jam menonton televisi',
                'Merapikan tempat tidur sendiri',
                'Berpamitan sebelum keluar rumah',
              ],
            ),
            ItemTab(
              label: 'Sekolah',
              emoji: '🏫',
              judul: 'Tata tertib sekolah',
              isi: 'Dibuat agar proses belajar mengajar lancar dan karakter siswa terbentuk.',
              poin: [
                'Memakai seragam sesuai hari',
                'Datang tepat waktu sebelum bel berbunyi',
                'Dilarang melakukan perundungan (bullying)',
                'Wajib mengerjakan tugas',
              ],
            ),
            ItemTab(
              label: 'Lingkungan',
              emoji: '🏘️',
              judul: 'Kesepakatan warga RT/RW atau desa',
              isi: 'Dibuat agar kehidupan bertetangga aman dan damai.',
              poin: [
                'Tamu yang menginap lebih dari 1x24 jam wajib lapor',
                'Jadwal ronda malam',
                'Membuang sampah pada tempatnya',
              ],
            ),
            ItemTab(
              label: 'Negara',
              emoji: '🇮🇩',
              judul: 'Cakupan paling luas',
              isi:
                  'Dibuat lembaga negara yang berwenang, mengikat seluruh rakyat Indonesia, dan dilengkapi **sanksi tegas** bagi pelanggar.',
              poin: [
                'Wajib memiliki SIM bagi pengendara kendaraan bermotor',
                'Larangan mencuri',
                'Kewajiban membayar pajak',
              ],
            ),
          ]),
          Klasifikasi(
            judul: 'Aturan ini milik siapa?',
            petunjuk: 'Aturan ini berlaku di tingkat…',
            labels: ['Rumah', 'Sekolah', 'Lingkungan', 'Negara'],
            items: [
              ItemKlas(
                  teks: 'Berpamitan sebelum keluar rumah',
                  jawaban: 0,
                  alasan: 'Kesepakatan keluarga untuk menjaga keharmonisan.'),
              ItemKlas(
                  teks: 'Memakai seragam sesuai hari',
                  jawaban: 1,
                  alasan: 'Bagian dari tata tertib sekolah.'),
              ItemKlas(
                  teks: 'Jadwal ronda malam',
                  jawaban: 2,
                  alasan: 'Disepakati warga RT/RW atau desa.'),
              ItemKlas(
                  teks: 'Wajib memiliki SIM saat mengendarai motor',
                  jawaban: 3,
                  alasan: 'Berlaku bagi seluruh rakyat dan memiliki sanksi tegas.'),
              ItemKlas(
                  teks: 'Tamu yang menginap lebih dari 1x24 jam wajib lapor',
                  jawaban: 2,
                  alasan: 'Kesepakatan warga agar lingkungan aman.'),
              ItemKlas(
                  teks: 'Datang tepat waktu sebelum bel berbunyi',
                  jawaban: 1,
                  alasan: 'Tata tertib agar belajar mengajar berjalan lancar.'),
              ItemKlas(
                  teks: 'Larangan mencuri',
                  jawaban: 3,
                  alasan: 'Aturan negara yang mengikat seluruh rakyat.'),
            ],
          ),
        ],
      ),
      Bagian(
        judul: 'Tata Urutan Peraturan Perundang-undangan',
        emoji: '🔺',
        blok: [
          Paragraf(
              'Indonesia memiliki ribuan peraturan, dari undang-undang nasional hingga peraturan daerah. Agar tidak bertabrakan, dibutuhkan sistem yang disebut **Tata Urutan Perundang-undangan**.'),
          Paragraf(
              'Bayangkan sebuah **piramida**: aturan di puncak berkedudukan tertinggi, dan aturan di bawahnya harus bersumber serta patuh pada aturan di atasnya.'),
          Kotak(
            jenis: JenisKotak.penting,
            judul: 'Prinsip utama',
            isi:
                '**Peraturan yang lebih rendah tidak boleh bertentangan dengan peraturan yang lebih tinggi.**\n\nContoh: jika Peraturan Wali Kota bertentangan dengan UUD, aturan daerah itu tidak sah dan harus dibatalkan. Sistem ini memberi **kepastian hukum**: warga tahu aturan mana yang menjadi pedoman utama, dan pembuat kebijakan (DPR dan Presiden) punya rel yang jelas saat merumuskan aturan baru.',
          ),
          Paragraf(
              'Berdasarkan UU No. 12 Tahun 2011 (diubah dengan UU No. 15 Tahun 2019 dan UU No. 13 Tahun 2022), jenis dan hierarkinya dari tertinggi ke terendah adalah sebagai berikut. **Ketuk setiap lapisan** untuk melihat rinciannya:'),
          Piramida([
            LevelPiramida(
              singkat: 'UUD NRI 1945',
              judul: 'Undang-Undang Dasar Negara Republik Indonesia Tahun 1945',
              isi:
                  'Hukum dasar tertulis tertinggi di Indonesia. Memuat prinsip-prinsip dasar negara, bentuk negara, dan hak asasi manusia.',
            ),
            LevelPiramida(
              singkat: 'Tap MPR',
              judul: 'Ketetapan Majelis Permusyawaratan Rakyat',
              pembuat: 'MPR',
              isi:
                  'Keputusan MPR yang berisi hal-hal bersifat makro dan mengikat ke dalam maupun ke luar majelis.',
            ),
            LevelPiramida(
              singkat: 'UU / Perppu',
              judul: 'Undang-Undang / Peraturan Pemerintah Pengganti Undang-Undang',
              pembuat: 'UU: DPR bersama Presiden. Perppu: Presiden',
              isi:
                  'Perppu ditetapkan Presiden dalam kondisi yang sangat genting dan memaksa, namun harus mendapat persetujuan DPR pada masa sidang berikutnya.',
            ),
            LevelPiramida(
              singkat: 'Peraturan Pemerintah (PP)',
              judul: 'Peraturan Pemerintah',
              pembuat: 'Presiden',
              isi:
                  'Dibuat untuk menjalankan Undang-Undang sebagaimana mestinya. PP mengatur teknis pelaksanaan sebuah UU.',
            ),
            LevelPiramida(
              singkat: 'Peraturan Presiden (Perpres)',
              judul: 'Peraturan Presiden',
              pembuat: 'Presiden',
              isi:
                  'Ditetapkan untuk menjalankan perintah peraturan yang lebih tinggi atau dalam menyelenggarakan kekuasaan pemerintahan.',
            ),
            LevelPiramida(
              singkat: 'Perda Provinsi',
              judul: 'Peraturan Daerah Provinsi',
              pembuat: 'DPRD Provinsi bersama Gubernur',
              isi: 'Hanya berlaku di wilayah provinsi tersebut.',
            ),
            LevelPiramida(
              singkat: 'Perda Kabupaten/Kota',
              judul: 'Peraturan Daerah Kabupaten/Kota',
              pembuat: 'DPRD Kabupaten/Kota bersama Bupati atau Wali Kota',
              isi:
                  'Sangat spesifik, menyesuaikan karakteristik, budaya, dan kebutuhan masyarakat di kabupaten atau kota tersebut.',
            ),
          ]),
          Urutkan(
            judul: 'Susun Piramidanya',
            petunjuk:
                'Urutkan dari kedudukan tertinggi (paling atas) sampai terendah (paling bawah).',
            urutanBenar: [
              'UUD NRI 1945',
              'Tap MPR',
              'UU / Perppu',
              'Peraturan Pemerintah (PP)',
              'Peraturan Presiden (Perpres)',
              'Perda Provinsi',
              'Perda Kabupaten/Kota',
            ],
            penjelasan: 'Aturan yang lebih rendah harus bersumber dan patuh pada aturan di atasnya.',
          ),
        ],
      ),
      Bagian(
        judul: 'Implementasi di Kehidupan Nyata',
        emoji: '🚦',
        blok: [
          Paragraf(
              'Peraturan tidak berguna jika hanya menjadi teks di atas kertas. **Implementasi** berarti penerapan atau pelaksanaan aturan dalam kehidupan nyata. Sebuah aturan berhasil diimplementasikan jika tujuannya tercapai.'),
          Kotak(
            jenis: JenisKotak.contoh,
            judul: 'Contoh: wajib helm berstandar SNI',
            isi:
                'UU Lalu Lintas mewajibkan pengendara motor memakai helm berstandar SNI (Standar Nasional Indonesia). Implementasinya melibatkan dua pihak. Ketuk tab di bawah:',
          ),
          TabPerbandingan([
            ItemTab(
              label: 'Aparat',
              emoji: '👮',
              judul: 'Aparat penegak hukum',
              isi:
                  'Polisi lalu lintas melakukan patroli, memberikan tilang bagi pelanggar, dan memberi edukasi keselamatan berkendara di sekolah-sekolah.',
            ),
            ItemTab(
              label: 'Warga',
              emoji: '🧑‍🤝‍🧑',
              judul: 'Warga negara',
              isi:
                  'Masyarakat menyadari bahwa memakai helm bukan sekadar untuk menghindari polisi, melainkan untuk **melindungi kepala dari cedera fatal** saat terjadi kecelakaan, sehingga mereka memakainya secara sadar.',
            ),
          ]),
          Kotak(
            jenis: JenisKotak.contoh,
            judul: 'Contoh di daerah: Perda Kawasan Tanpa Rokok (KTR)',
            isi:
                'Implementasi nyata di lapangan: terpasang rambu larangan merokok di rumah sakit, sekolah, atau angkutan umum, serta adanya petugas Satpol PP yang menindak warga yang nekat merokok di area tersebut.',
          ),
        ],
      ),
      Bagian(
        judul: 'Komitmen: Tangga Kesadaran Hukum',
        emoji: '🪜',
        blok: [
          Paragraf(
              'Membangun negara yang teratur membutuhkan komitmen kuat dari pemerintah dan seluruh warga. Bagi pelajar SMP, komitmen itu diwujudkan lewat **kesadaran hukum**, yang terbentuk melalui empat tahap. Contoh kita: UU ITE yang melarang penyebaran hoaks di media sosial.'),
          Linimasa(items: [
            Peristiwa(
              waktu: 'Tahap 1',
              judul: 'Mengetahui hukum (pengetahuan)',
              isi:
                  'Kamu tahu ada aturan tertentu, misalnya UU ITE yang melarang penyebaran hoaks di media sosial.',
            ),
            Peristiwa(
              waktu: 'Tahap 2',
              judul: 'Memahami hukum (pemahaman)',
              isi:
                  'Kamu mengerti mengapa aturan itu dibuat: hoaks bisa memicu kebencian, merugikan orang lain, dan memecah belah bangsa.',
            ),
            Peristiwa(
              waktu: 'Tahap 3',
              judul: 'Menghargai hukum (sikap)',
              isi:
                  'Kamu membenarkan dan setuju bahwa aturan itu baik dan diperlukan, serta menolak perbuatan melanggar hukum.',
            ),
            Peristiwa(
              waktu: 'Tahap 4',
              judul: 'Berperilaku hukum (tindakan)',
              isi:
                  'Puncak komitmen: kamu patuh dalam tindakan nyata, misalnya menyaring informasi sebelum membagikannya di grup kelas, tidak melakukan cyberbullying, dan menaati tata tertib sekolah meski tidak diawasi guru.',
            ),
          ]),
          Urutkan(
            judul: 'Susun Tangga Kesadaran Hukum',
            petunjuk: 'Urutkan dari tahap pertama sampai tahap terakhir.',
            urutanBenar: [
              'Mengetahui hukum',
              'Memahami hukum',
              'Menghargai hukum',
              'Berperilaku hukum',
            ],
            penjelasan: 'Kesadaran hukum berpuncak pada tindakan nyata sehari-hari.',
          ),
          Kotak(
            jenis: JenisKotak.info,
            judul: 'Aturan bukan untuk mengekang',
            isi:
                'Peraturan perundang-undangan diciptakan **bukan untuk mengekang kebebasanmu**, melainkan untuk **melindungi kebebasanmu** agar tidak diganggu oleh kebebasan orang lain yang tidak bertanggung jawab.',
          ),
        ],
      ),
      Bagian(
        judul: 'Uji Pemahaman',
        emoji: '✅',
        blok: [
          Latihan(judul: 'Kuis Materi 3', soal: [
            Soal(
              pertanyaan: 'Prinsip penting dalam tata urutan peraturan perundang-undangan adalah…',
              opsi: [
                'Peraturan daerah selalu lebih tinggi dari undang-undang',
                'Peraturan yang lebih rendah tidak boleh bertentangan dengan yang lebih tinggi',
                'Semua peraturan kedudukannya setara',
                'Presiden bebas mengubah UUD',
              ],
              benar: 1,
              penjelasan: 'Aturan di bawah harus bersumber dan patuh pada aturan di atasnya.',
            ),
            Soal(
              pertanyaan: 'Undang-Undang (UU) dibuat oleh…',
              opsi: [
                'Gubernur bersama DPRD',
                'Presiden saja',
                'DPR bersama Presiden',
                'Mahkamah Agung',
              ],
              benar: 2,
              penjelasan: 'UU dibuat oleh Dewan Perwakilan Rakyat (DPR) bersama Presiden.',
            ),
            Soal(
              pertanyaan: 'Peraturan Pemerintah (PP) dibuat Presiden untuk…',
              opsi: [
                'Menjalankan Undang-Undang sebagaimana mestinya',
                'Menggantikan UUD',
                'Mengatur tata tertib sekolah',
                'Membentuk DPRD',
              ],
              benar: 0,
              penjelasan: 'PP mengatur teknis pelaksanaan sebuah UU.',
            ),
            Soal(
              pertanyaan: 'Perppu ditetapkan Presiden dalam kondisi…',
              opsi: [
                'Normal dan tenang',
                'Menjelang pemilu saja',
                'Di tingkat desa',
                'Sangat genting dan memaksa, lalu harus disetujui DPR',
              ],
              benar: 3,
              penjelasan:
                  'Perppu harus mendapat persetujuan DPR pada masa sidang berikutnya.',
            ),
            Soal(
              pertanyaan: 'Puncak dari kesadaran hukum adalah…',
              opsi: [
                'Mengetahui hukum',
                'Berperilaku hukum',
                'Memahami hukum',
                'Menghafal pasal',
              ],
              benar: 1,
              penjelasan: 'Berperilaku hukum berarti mematuhi aturan dalam tindakan nyata.',
            ),
          ]),
        ],
      ),
    ],
  ),

  // -------------------------------------------------------------------------
  // MATERI 4
  // -------------------------------------------------------------------------
  MateriKelas8(
    id: 'm4',
    nomor: 4,
    judul: 'Melestarikan Budaya Bangsa',
    ringkas:
        'Bedakan tradisi, kearifan lokal, dan budaya nasional, lalu temukan cara kerenmu menjaga identitas bangsa di era globalisasi.',
    emoji: '🎭',
    warna: const Color(0xFF9A5B00),
    menitBaca: 9,
    kataKunci: [
      'budaya', 'tradisi', 'kearifan lokal', 'budaya nasional', 'batik',
      'wayang', 'subak', 'sasi', 'hombo batu', 'sekaten', 'unesco',
      'jati diri', 'identitas bangsa', 'globalisasi', 'culture experience',
      'culture knowledge', 'angklung', 'pencak silat', 'bahasa indonesia',
      'gotong royong',
    ],
    bagian: [
      Bagian(
        judul: 'Warisan dari Sabang sampai Merauke',
        emoji: '🌏',
        blok: [
          Paragraf(
              'Indonesia adalah negara kepulauan luar biasa yang dihuni ratusan suku bangsa dengan keanekaragaman tradisi, adat istiadat, tarian, lagu daerah, hingga kearifan lokal.'),
          Statistik([
            StatItem(emoji: '🧑‍🤝‍🧑', angka: '1.300+', label: 'suku bangsa'),
            StatItem(emoji: '🗣️', angka: '700+', label: 'bahasa daerah'),
          ]),
          Paragraf(
              'Kekayaan ini bukan sekadar peninggalan masa lalu yang disimpan di museum, melainkan **pilar utama** kehidupan berbangsa dan bernegara hari ini. Sebagai generasi muda SMP, kamu memegang peran kunci sebagai penerus dan penjaga warisan ini agar tidak punah tertelan zaman.'),
        ],
      ),
      Bagian(
        judul: 'Tradisi, Kearifan Lokal, dan Budaya Nasional',
        emoji: '🧭',
        blok: [
          Paragraf(
              'Untuk melestarikan budaya, kenali dulu tiga tingkatannya. Ketuk tab untuk membandingkan:'),
          TabPerbandingan([
            ItemTab(
              label: 'Tradisi',
              emoji: '🥁',
              judul: 'Kebiasaan turun-temurun',
              isi:
                  'Kebiasaan atau tata cara yang **diwariskan turun-temurun** dalam suatu kelompok masyarakat. Tradisi mencerminkan cara nenek moyang memaknai hubungan antara manusia, alam, dan Sang Pencipta.',
              poin: [
                'Upacara adat pernikahan',
                'Potong rambut gimbal di Dieng',
                'Lompat batu (Hombo Batu) di Nias',
                'Sekaten di Yogyakarta dan Surakarta',
              ],
            ),
            ItemTab(
              label: 'Kearifan Lokal',
              emoji: '🌿',
              judul: 'Kebijaksanaan menyikapi lingkungan',
              isi:
                  'Pandangan hidup, pengetahuan, dan gagasan bijak masyarakat lokal untuk menyikapi lingkungan, sering berupa aturan atau ajaran yang peduli pada alam dan sesama.',
              poin: [
                '**Subak (Bali):** irigasi tradisional berasaskan keadilan dan kebersamaan, berfilosofi Tri Hita Karana (harmoni manusia, alam, dan Tuhan)',
                '**Hutan larangan adat:** aturan melarang menebang pohon sembarangan demi ekosistem dan pasokan air',
                '**Sasi (Maluku dan Papua):** menunda panen hasil laut atau darat agar flora dan fauna sempat berkembang biak',
              ],
            ),
            ItemTab(
              label: 'Budaya Nasional',
              emoji: '🇮🇩',
              judul: 'Puncak budaya daerah milik bersama',
              isi:
                  'Puncak-puncak budaya daerah yang **diakui luas** dan menjadi milik bersama seluruh bangsa. Lahir dari pembauran, penyaringan, dan pengangkatan budaya lokal yang bernilai luhur dan memperkuat rasa kebangsaan.',
              poin: [
                'Batik',
                'Wayang kulit',
                'Tari reog',
                'Musik angklung',
                'Pencak silat',
                'Bahasa Indonesia sebagai bahasa persatuan',
              ],
            ),
          ]),
          Klasifikasi(
            judul: 'Termasuk yang mana?',
            petunjuk: 'Golongkan contoh berikut:',
            labels: ['Tradisi', 'Kearifan Lokal', 'Budaya Nasional'],
            items: [
              ItemKlas(
                  teks: 'Hombo Batu (lompat batu) di Nias',
                  jawaban: 0,
                  alasan: 'Kebiasaan yang diwariskan turun-temurun di suatu masyarakat.'),
              ItemKlas(
                  teks: 'Subak di Bali',
                  jawaban: 1,
                  alasan: 'Sistem irigasi bijak yang menjaga hubungan manusia, alam, dan Tuhan.'),
              ItemKlas(
                  teks: 'Batik',
                  jawaban: 2,
                  alasan: 'Diakui luas dan menjadi milik seluruh bangsa.'),
              ItemKlas(
                  teks: 'Sasi di Maluku dan Papua',
                  jawaban: 1,
                  alasan: 'Aturan adat yang menjaga kelestarian alam.'),
              ItemKlas(
                  teks: 'Sekaten di Yogyakarta dan Surakarta',
                  jawaban: 0,
                  alasan: 'Tradisi turun-temurun di daerah tertentu.'),
              ItemKlas(
                  teks: 'Bahasa Indonesia',
                  jawaban: 2,
                  alasan: 'Bahasa persatuan yang menjadi milik bersama seluruh bangsa.'),
              ItemKlas(
                  teks: 'Hutan larangan adat',
                  jawaban: 1,
                  alasan: 'Aturan adat demi menjaga ekosistem dan pasokan air.'),
              ItemKlas(
                  teks: 'Potong rambut gimbal di Dieng',
                  jawaban: 0,
                  alasan: 'Tradisi yang diwariskan turun-temurun.'),
            ],
          ),
        ],
      ),
      Bagian(
        judul: 'Dua Cara Melestarikan Budaya',
        emoji: '🛠️',
        blok: [
          Paragraf(
              'Melestarikan budaya bukan berarti hidup kuno atau menolak kemajuan zaman. Ada dua cara utama. Ketuk kartu untuk membaliknya:'),
          KartuBalik([
            KartuBalikItem(
              emoji: '🥁',
              depan: 'Culture Experience',
              belakang:
                  '**Pelestarian lewat pengalaman langsung.** Terjun langsung mempelajari, mempraktikkan, dan memainkan budaya tersebut.\n\nContoh: bergabung dalam ekstrakurikuler seni tari daerah, belajar memainkan angklung atau gamelan, dan memakai batik dalam kegiatan sehari-hari.',
            ),
            KartuBalikItem(
              emoji: '📱',
              depan: 'Culture Knowledge',
              belakang:
                  '**Pelestarian lewat pengetahuan.** Mempelajari, mendokumentasikan, dan menyebarkan informasi tentang kebudayaan daerah.\n\nDi era digital, kamu bisa membuat konten edukatif seperti video, artikel, atau kiriman media sosial tentang keunikan tradisi di daerahmu.',
            ),
          ]),
        ],
      ),
      Bagian(
        judul: 'Budaya Nasional sebagai Pemersatu Bangsa',
        emoji: '🧵',
        blok: [
          Paragraf(
              'Dengan lebih dari 1.300 suku bangsa dan 700 bahasa daerah, apa yang membuat bangsa kita tetap bersatu? Salah satu perekat utamanya adalah **Budaya Nasional**.'),
          Akordeon([
            ItemAkordeon(
              emoji: '🌉',
              judul: 'Jembatan komunikasi dan nilai bersama',
              isi:
                  'Meski setiap suku punya bahasa daerah sendiri, budaya nasional menciptakan nilai-nilai bersama (shared values). **Bahasa Indonesia** menjembatani komunikasi antarwarga dari suku berbeda. Tanpa bahasa nasional, siswa dari Sumatra akan kesulitan berinteraksi dengan siswa dari Papua.',
            ),
            ItemAkordeon(
              emoji: '🤝',
              judul: 'Penguat gotong royong dan kebersamaan',
              isi:
                  'Banyak budaya daerah mengandung nilai gotong royong dan musyawarah. Ketika diangkat menjadi budaya nasional, seluruh warga merasa punya ikatan kekeluargaan: saling bantu saat musibah, kerja bakti membersihkan lingkungan, dan semangat toleransi beragama.',
            ),
            ItemAkordeon(
              emoji: '🕊️',
              judul: 'Mencegah konflik antardaerah',
              isi:
                  'Saat budaya daerah dipandang sebagai kekayaan bersama, rasa saling menghargai tumbuh. Siswa Jawa yang menghargai Tari Pendet dari Bali, atau siswa Sulawesi yang bangga pada Kain Ulos dari Sumatra Utara, sedang memperkuat persaudaraan nasional. Perbedaan menjadi alasan untuk **saling melengkapi**.',
            ),
          ]),
        ],
      ),
      Bagian(
        judul: 'Identitas dan Jati Diri Bangsa',
        emoji: '🪪',
        blok: [
          Paragraf(
              'Di tengah arus globalisasi, musik pop luar negeri, tarian modern, dan gaya busana barat mudah memengaruhi gaya hidup remaja. Di sinilah pentingnya memahami budaya nasional sebagai **identitas dan jati diri bangsa**.'),
          TabPerbandingan([
            ItemTab(
              label: 'Identitas',
              emoji: '🏷️',
              judul: 'Ciri khas pengenal bangsa',
              isi:
                  'Identitas bangsa adalah ciri khas yang membedakan Indonesia dari bangsa lain. Orang langsung mengenali batik dengan motifnya yang rumit dan bermakna sebagai produk khas Indonesia. Pencak silat dikenal mengutamakan keindahan seni dan ketahanan mental khas Indonesia.',
            ),
            ItemTab(
              label: 'Benteng',
              emoji: '🛡️',
              judul: 'Membentengi diri dari dampak negatif globalisasi',
              isi:
                  'Globalisasi membawa teknologi dan akses informasi cepat, tetapi juga berisiko mengikis nilai lokal. Budaya nasional berfungsi sebagai **filter kultural**.\n\nPelajar bisa memilah budaya luar yang bermanfaat (disiplin kerja, penguasaan teknologi) dan yang tidak sesuai kepribadian bangsa (individualistis dan konsumeristik).',
            ),
            ItemTab(
              label: 'Bangga',
              emoji: '🏅',
              judul: 'Kebanggaan di kancah internasional',
              isi:
                  'Banyak warisan budaya Indonesia diakui UNESCO sebagai **Warisan Budaya Takbenda Dunia** (Intangible Cultural Heritage). Ini membuktikan budaya kita memberi kontribusi berharga bagi peradaban dunia.',
              poin: [
                'Batik',
                'Wayang',
                'Keris',
                'Angklung',
                'Tari Saman',
                'Pencak Silat',
                'Gamelan',
              ],
            ),
          ]),
        ],
      ),
      Bagian(
        judul: 'Aksi Nyata Pelajar SMP',
        emoji: '🚩',
        blok: [
          Paragraf(
              'Kamu tidak perlu menunggu menjadi pejabat atau tokoh masyarakat untuk mulai bergerak. Centang komitmenmu di bawah ini:'),
          Ceklis(
            judul: 'Komitmen Pelestari Budaya',
            items: [
              'Bangga mengenakan batik atau pakaian adat pada momen tertentu dan mencintai kuliner tradisional Indonesia',
              'Aktif mempelajari seni budaya di sekolah: seni tari, musik daerah, atau klub bahasa daerah',
              'Memanfaatkan media sosial secara positif untuk mengenalkan sejarah, tradisi, atau wisata budaya di daerahmu',
              'Menerapkan sikap ramah dan santun sebagai ciri khas kepribadian bangsa',
            ],
          ),
          Kotak(
            jenis: JenisKotak.tips,
            judul: 'Pesan penutup',
            isi:
                'Dengan terus menjaga, mempelajari, dan mencintai kebudayaan sendiri, kamu memastikan identitas bangsa Indonesia tetap tegak berdiri kokoh dan bercahaya, hari ini dan di masa depan.',
          ),
        ],
      ),
      Bagian(
        judul: 'Uji Pemahaman',
        emoji: '✅',
        blok: [
          Latihan(judul: 'Kuis Materi 4', soal: [
            Soal(
              pertanyaan: 'Subak di Bali merupakan contoh…',
              opsi: ['Tradisi', 'Budaya nasional', 'Kearifan lokal', 'Bahasa persatuan'],
              benar: 2,
              penjelasan:
                  'Subak adalah sistem irigasi tradisional yang berfilosofi Tri Hita Karana.',
            ),
            Soal(
              pertanyaan:
                  'Belajar memainkan angklung di ekstrakurikuler termasuk pelestarian melalui…',
              opsi: [
                'Culture Knowledge',
                'Culture Experience',
                'Culture Conflict',
                'Culture Shock',
              ],
              benar: 1,
              penjelasan: 'Culture Experience adalah belajar dan mempraktikkan budaya secara langsung.',
            ),
            Soal(
              pertanyaan: 'Apa fungsi bahasa Indonesia sebagai produk budaya nasional?',
              opsi: [
                'Menggantikan semua bahasa daerah',
                'Melarang budaya asing masuk',
                'Menghapus adat istiadat',
                'Menjembatani komunikasi antarwarga dari suku berbeda',
              ],
              benar: 3,
              penjelasan: 'Bahasa Indonesia menjembatani komunikasi antarsuku di seluruh Nusantara.',
            ),
            Soal(
              pertanyaan: 'Sasi di Maluku dan Papua adalah aturan adat untuk…',
              opsi: [
                'Menunda panen agar flora dan fauna sempat berkembang biak',
                'Mempercepat penebangan hutan',
                'Menentukan batas wilayah laut',
                'Menarik wisatawan',
              ],
              benar: 0,
              penjelasan: 'Sasi menjaga kelestarian alam dengan menunda pemanenan untuk sementara waktu.',
            ),
            Soal(
              pertanyaan:
                  'Lembaga dunia yang mengakui batik, wayang, dan angklung sebagai Warisan Budaya Takbenda adalah…',
              opsi: ['WHO', 'UNICEF', 'UNESCO', 'ASEAN'],
              benar: 2,
              penjelasan: 'UNESCO mengakui sejumlah budaya Indonesia sebagai warisan dunia.',
            ),
          ]),
        ],
      ),
    ],
  ),

  // -------------------------------------------------------------------------
  // MATERI 5  (di berkas Word tertulis "Materi 4" untuk kedua bab terakhir)
  // -------------------------------------------------------------------------
  MateriKelas8(
    id: 'm5',
    nomor: 5,
    judul: 'Wawasan Nusantara',
    ringkas:
        'Cara pandang bangsa Indonesia untuk menjaga keutuhan NKRI: dari Deklarasi Djuanda, enam asas, sampai penerapannya di berbagai bidang.',
    emoji: '🗺️',
    warna: const Color(0xFF00695C),
    menitBaca: 10,
    kataKunci: [
      'wawasan nusantara', 'nkri', 'deklarasi djuanda', 'djuanda',
      'laut teritorial', 'bhinneka tunggal ika', 'sumpah pemuda', 'asas',
      'solidaritas', 'keadilan', 'sishankamrata', 'pemilu', 'umkm', '3t',
      'devide et impera', 'pertahanan', 'keamanan', 'hoaks', 'separatisme',
    ],
    bagian: [
      Bagian(
        judul: 'Memahami Wawasan Nusantara',
        emoji: '🧭',
        blok: [
          Paragraf(
              'Indonesia adalah negara kepulauan terbesar di dunia, membentang dari Sabang sampai Merauke. Keberagaman ini anugerah sekaligus tantangan: tanpa kesadaran untuk bersatu, perbedaan bisa memicu keretakan.'),
          Statistik([
            StatItem(emoji: '🏝️', angka: 'Belasan ribu', label: 'pulau'),
            StatItem(emoji: '🧑‍🤝‍🧑', angka: '1.300+', label: 'suku bangsa'),
            StatItem(emoji: '🗣️', angka: 'Ratusan', label: 'bahasa daerah'),
          ]),
          Paragraf(
              'Karena itu bangsa Indonesia membutuhkan pandangan hidup bersama yang disebut **Wawasan Nusantara** untuk menjaga dan merawat keutuhan Negara Kesatuan Republik Indonesia (NKRI). Mari bedah istilahnya:'),
          TabPerbandingan([
            ItemTab(
              label: 'Wawasan',
              emoji: '👀',
              judul: 'Dari kata “wawas” (bahasa Jawa)',
              isi: 'Berarti pandangan, tinjauan, atau cara pandang indrawi.',
            ),
            ItemTab(
              label: 'Nusantara',
              emoji: '🏝️',
              judul: 'Nusa + antara',
              isi:
                  '**Nusa** berarti pulau atau kepulauan. **Antara** berarti diapit dua hal: **dua benua** (Asia dan Australia) serta **dua samudra** (Pasifik dan Hindia).',
            ),
            ItemTab(
              label: 'Pengertian',
              emoji: '💡',
              judul: 'Pengertian utuh',
              isi:
                  'Cara pandang dan sikap bangsa Indonesia mengenai diri dan lingkungannya yang beragam dan bernilai strategis, dengan mengutamakan **persatuan dan kesatuan bangsa serta kesatuan wilayah** dalam kehidupan bermasyarakat, berbangsa, dan bernegara untuk mencapai tujuan nasional.',
            ),
          ]),
          Kotak(
            jenis: JenisKotak.info,
            judul: 'Satu tekad',
            isi:
                'Melalui Wawasan Nusantara, seluruh rakyat dipersatukan dalam satu tekad: meski berbeda suku, bahasa daerah, dan agama, kita tetap satu bangsa yang tinggal di dalam satu wadah tanah air yang utuh.',
          ),
        ],
      ),
      Bagian(
        judul: 'Mengapa Wawasan Nusantara Lahir?',
        emoji: '🌊',
        blok: [
          Paragraf(
              'Lahirnya Wawasan Nusantara dipengaruhi empat aspek. Ketuk untuk membukanya:'),
          Akordeon([
            ItemAkordeon(
              emoji: '🌊',
              judul: 'Aspek geografis dan wilayah',
              isi:
                  'Sebelum 1957, laut Indonesia mengikuti aturan warisan kolonial Belanda: batas laut teritorial tiap pulau hanya **3 mil** dari garis pantai. Akibatnya laut di antara pulau dianggap laut bebas yang bisa dilalui kapal asing secara bebas, dan ini sangat membahayakan keamanan negara. Lihat linimasa di bawah untuk kelanjutannya.',
            ),
            ItemAkordeon(
              emoji: '🦅',
              judul: 'Aspek falsafah Pancasila',
              isi:
                  'Pancasila menjunjung persatuan, kemanusiaan, musyawarah, dan keadilan sosial. Wawasan Nusantara mengadopsi nilai-nilai ini agar pengelolaan negara berlandaskan keadilan bagi seluruh rakyat dari ujung barat hingga ujung timur.',
            ),
            ItemAkordeon(
              emoji: '📜',
              judul: 'Aspek historis (sejarah)',
              isi:
                  'Bangsa Indonesia pernah dijajah dalam waktu panjang akibat strategi **devide et impera** (adu domba). Pengalaman pahit itu menyadarkan para pendiri bangsa bahwa perpecahan hanya membawa penderitaan, sedangkan persatuan adalah kunci meraih dan mempertahankan kemerdekaan.',
            ),
            ItemAkordeon(
              emoji: '🎎',
              judul: 'Aspek sosial budaya',
              isi:
                  'Lebih dari 1.300 suku bangsa dan ratusan bahasa daerah diikat oleh semboyan **Bhinneka Tunggal Ika**. Perbedaan tidak dijadikan alasan untuk berpisah, melainkan kekayaan yang saling melengkapi.',
            ),
          ]),
          Linimasa(
            judul: 'Dari laut terpisah menjadi laut utuh',
            items: [
              Peristiwa(
                waktu: 'Sebelum 1957',
                judul: 'Aturan warisan kolonial',
                isi:
                    'Berlaku Territoriale Zee en Maritieme Kringen Ordonnantie 1939: laut teritorial hanya 3 mil dari garis pantai setiap pulau.',
              ),
              Peristiwa(
                waktu: '13 Desember 1957',
                judul: 'Deklarasi Djuanda',
                isi:
                    'Perdana Menteri Djuanda Kartawidjaja menyatakan bahwa **laut di antara pulau-pulau Indonesia adalah wilayah teritorial Indonesia**.',
              ),
              Peristiwa(
                waktu: 'Sejak saat itu',
                judul: 'Darat dan laut menyatu',
                isi: 'Daratan dan lautan Indonesia menjadi satu kesatuan wilayah yang utuh.',
              ),
            ],
          ),
          Gambar(
            deskripsi:
                'Peta wilayah laut Indonesia: perbandingan sebelum dan sesudah Deklarasi Djuanda',
            aset: 'assets/images/materi/20.jpg',
          ),
        ],
      ),
      Bagian(
        judul: 'Enam Asas Wawasan Nusantara',
        emoji: '🧱',
        blok: [
          Paragraf(
              'Agar Wawasan Nusantara dihayati seluruh warga negara, ada enam asas yang harus dipegang teguh. Ketuk kartu untuk melihat artinya:'),
          KartuBalik([
            KartuBalikItem(
              emoji: '🎯',
              depan: 'Kepentingan yang sama',
              belakang:
                  'Memiliki tujuan bersama untuk menjaga ketenteraman, keutuhan, dan kemajuan bangsa Indonesia.',
            ),
            KartuBalikItem(
              emoji: '⚖️',
              depan: 'Keadilan',
              belakang:
                  'Pembagian hasil kekayaan negara dan kesempatan pembangunan harus adil bagi seluruh daerah dan masyarakat.',
            ),
            KartuBalikItem(
              emoji: '🔍',
              depan: 'Kejujuran',
              belakang:
                  'Patuh pada aturan serta berani berpikir, berkata, dan bertindak sesuai fakta demi kemajuan bersama.',
            ),
            KartuBalikItem(
              emoji: '🤗',
              depan: 'Solidaritas',
              belakang:
                  'Rasa peduli, mau berkorban, dan saling membantu antarwarga negara tanpa memandang latar belakang.',
            ),
            KartuBalikItem(
              emoji: '🤝',
              depan: 'Kerja sama',
              belakang:
                  'Kemauan untuk bergotong royong dan berkoordinasi demi tercapainya cita-cita nasional.',
            ),
            KartuBalikItem(
              emoji: '✍️',
              depan: 'Kesetiaan terhadap kesepakatan bersama',
              belakang:
                  'Setia pada ikrar bersama yang dimotori **Sumpah Pemuda 1928**, **Proklamasi Kemerdekaan 1945**, dan konsensus bernegara: Pancasila, UUD 1945, NKRI, dan Bhinneka Tunggal Ika.',
            ),
          ]),
        ],
      ),
      Bagian(
        judul: 'Pelaksanaan di Berbagai Bidang',
        emoji: '🧩',
        blok: [
          Paragraf(
              'Wawasan Nusantara bukan konsep teori untuk dihafal, melainkan harus diterapkan secara nyata dalam empat bidang kehidupan. Ketuk tab untuk melihat penerapannya:'),
          TabPerbandingan([
            ItemTab(
              label: 'Politik',
              emoji: '🗳️',
              judul: 'Negara yang sehat, dinamis, dan demokratis',
              isi: 'Tujuannya menciptakan penyelenggaraan negara yang sehat, dinamis, dan demokratis.',
              poin: [
                'Pemilu yang jujur, adil, transparan, dan damai',
                'Musyawarah mufakat dalam keputusan publik, dari RT/RW sampai DPR/MPR',
                'Sikap politik yang menjunjung HAM dan menghormati perbedaan pendapat',
                'Menjaga kedaulatan NKRI dari paham separatisme',
              ],
            ),
            ItemTab(
              label: 'Ekonomi',
              emoji: '💰',
              judul: 'Kekayaan alam milik bersama',
              isi:
                  'Kekayaan alam dan sumber daya di seluruh wilayah Indonesia adalah modal dan milik bersama seluruh bangsa.',
              poin: [
                'Pembangunan merata, tidak hanya terpusat di Jawa, tetapi menjangkau daerah terdepan, terpencil, dan tertinggal (3T)',
                'Pemanfaatan sumber daya alam secara bijak dan berwawasan lingkungan untuk generasi mendatang',
                'Mendorong tumbuhnya UMKM dan partisipasi aktif masyarakat dalam perekonomian nasional',
              ],
            ),
            ItemTab(
              label: 'Sosial Budaya',
              emoji: '🎎',
              judul: 'Saling menghargai keberagaman',
              isi: 'Menciptakan sikap saling menghargai dan mengakui keberagaman sebagai kekayaan nasional.',
              poin: [
                'Mengembangkan dan melestarikan budaya daerah sebagai bagian dari budaya nasional',
                'Menumbuhkan toleransi antarumat beragama dan antaretnis',
                'Pemerataan pendidikan dan layanan kesehatan berkualitas bagi seluruh anak bangsa',
                'Menjaga kearifan lokal dan gotong royong di tengah modernisasi',
              ],
            ),
            ItemTab(
              label: 'Hankam',
              emoji: '🛡️',
              judul: 'Bela negara: hak dan kewajiban setiap warga',
              isi: 'Menumbuhkan kesadaran bahwa membela negara adalah hak dan kewajiban setiap warga negara.',
              poin: [
                '**Sishankamrata:** TNI dan Polri sebagai kekuatan utama, seluruh rakyat sebagai kekuatan pendukung',
                'Meningkatkan kewaspadaan terhadap hoaks, ujaran kebencian, dan kejahatan siber',
                'Menjaga batas wilayah negara, termasuk pulau-pulau terluar agar tidak diklaim negara lain',
              ],
            ),
          ]),
          Klasifikasi(
            judul: 'Masuk bidang apa?',
            petunjuk: 'Penerapan ini termasuk bidang…',
            labels: ['Politik', 'Ekonomi', 'Sosial Budaya', 'Hankam'],
            items: [
              ItemKlas(
                  teks: 'Pemilu yang jujur, adil, dan damai',
                  jawaban: 0,
                  alasan: 'Penyelenggaraan negara yang demokratis adalah bidang politik.'),
              ItemKlas(
                  teks: 'Pembangunan merata hingga daerah 3T',
                  jawaban: 1,
                  alasan: 'Pemerataan pembangunan adalah penerapan di bidang ekonomi.'),
              ItemKlas(
                  teks: 'Menumbuhkan toleransi antarumat beragama',
                  jawaban: 2,
                  alasan: 'Saling menghargai keberagaman termasuk bidang sosial budaya.'),
              ItemKlas(
                  teks: 'Sishankamrata',
                  jawaban: 3,
                  alasan: 'Sistem pertahanan dan keamanan rakyat semesta adalah bidang hankam.'),
              ItemKlas(
                  teks: 'Mendorong tumbuhnya UMKM',
                  jawaban: 1,
                  alasan: 'Partisipasi masyarakat dalam perekonomian nasional.'),
              ItemKlas(
                  teks: 'Musyawarah mufakat dalam keputusan publik',
                  jawaban: 0,
                  alasan: 'Pengambilan keputusan publik adalah bidang politik.'),
              ItemKlas(
                  teks: 'Waspada terhadap hoaks dan kejahatan siber',
                  jawaban: 3,
                  alasan: 'Kewaspadaan terhadap ancaman persatuan termasuk bidang hankam.'),
              ItemKlas(
                  teks: 'Pemerataan pendidikan dan layanan kesehatan',
                  jawaban: 2,
                  alasan: 'Pemerataan kesempatan bagi seluruh anak bangsa masuk bidang sosial budaya.'),
            ],
          ),
        ],
      ),
      Bagian(
        judul: 'Peranmu sebagai Pelajar',
        emoji: '🙋',
        blok: [
          Paragraf(
              'Sebagai pelajar SMP, kamu punya peran penting menjaga keutuhan bangsa lewat tindakan sederhana di sekolah dan tempat tinggalmu. Centang yang sudah kamu lakukan, dan jadikan yang belum sebagai target:'),
          Ceklis(
            judul: 'Aksi Penjaga Persatuan',
            items: [
              '**Menghormati perbedaan di sekolah:** tidak memilih-milih teman berdasarkan suku, agama, atau latar belakang sosial',
              '**Menggunakan bahasa Indonesia dengan baik** saat berinteraksi dengan teman dari latar belakang berbeda',
              '**Menjauhi perundungan (bullying) dan perkelahian:** menyelesaikan masalah dengan berdiskusi atau meminta bantuan guru dan orang tua',
              '**Bangga terhadap karya bangsa:** mencintai produk dalam negeri, giat mempelajari sejarah, dan menjaga lingkungan',
              '**Bijak bermedia sosial:** tidak menyebarkan berita yang belum jelas kebenarannya, tidak melakukan ujaran kebencian, dan menyebarkan konten positif',
            ],
          ),
        ],
      ),
      Bagian(
        judul: 'Uji Pemahaman',
        emoji: '✅',
        blok: [
          Latihan(judul: 'Kuis Materi 5', soal: [
            Soal(
              pertanyaan: 'Kata “antara” pada istilah nusantara bermakna…',
              opsi: [
                'Dikelilingi lautan saja',
                'Diapit dua benua (Asia dan Australia) dan dua samudra (Pasifik dan Hindia)',
                'Terletak di tengah Pulau Jawa',
                'Dibatasi tiga mil laut',
              ],
              benar: 1,
              penjelasan: 'Nusantara berasal dari nusa (pulau) dan antara (diapit dua benua dan dua samudra).',
            ),
            Soal(
              pertanyaan: 'Deklarasi Djuanda dicetuskan pada…',
              opsi: [
                '17 Agustus 1945',
                '28 Oktober 1928',
                '13 Desember 1957',
                '18 Agustus 1945',
              ],
              benar: 2,
              penjelasan: 'Perdana Menteri Djuanda Kartawidjaja mencetuskannya pada 13 Desember 1957.',
            ),
            Soal(
              pertanyaan: 'Isi pokok Deklarasi Djuanda adalah…',
              opsi: [
                'Laut di antara pulau-pulau Indonesia adalah wilayah teritorial Indonesia',
                'Laut teritorial hanya 3 mil dari pantai',
                'Daratan dan lautan Indonesia dipisahkan',
                'Kapal asing bebas melewati laut antarpulau',
              ],
              benar: 0,
              penjelasan: 'Sejak saat itu daratan dan lautan Indonesia menyatu menjadi wilayah yang utuh.',
            ),
            Soal(
              pertanyaan:
                  'Pembangunan yang tidak hanya terpusat di Jawa, tetapi menjangkau daerah 3T, adalah penerapan Wawasan Nusantara di bidang…',
              opsi: ['Politik', 'Sosial budaya', 'Hankam', 'Ekonomi'],
              benar: 3,
              penjelasan: 'Pemerataan pembangunan termasuk bidang ekonomi.',
            ),
            Soal(
              pertanyaan: 'Dalam Sishankamrata, kekuatan utama pertahanan dan keamanan adalah…',
              opsi: [
                'Seluruh rakyat',
                'TNI dan Polri',
                'Pemerintah daerah',
                'Pelajar',
              ],
              benar: 1,
              penjelasan: 'TNI dan Polri menjadi kekuatan utama, sedangkan seluruh rakyat menjadi kekuatan pendukung.',
            ),
          ]),
        ],
      ),
    ],
  ),
];
