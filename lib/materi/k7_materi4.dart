import 'package:flutter/material.dart';
import 'materi_model.dart';

Materi buatMateri4() => Materi(
      id: 'k7-m4',
      nomor: 4,
      judul: 'Keragaman dalam Bingkai Persatuan',
      deskripsi:
          'Memahami SARA, faktor penyebab keragaman, Bhinneka Tunggal Ika, dan sikap toleransi.',
      ikon: Icons.people_alt,
      warna: const Color(0xFF00796B),
      kataKunci: [
        'SARA',
        'keragaman',
        'bhinneka tunggal ika',
        'suku',
        'ras',
        'toleransi',
        'antargolongan',
        'Sutasoma',
      ],
      bab: [
        Bab('Taman Bunga Bernama Indonesia', Icons.local_florist, [
          const Paragraf(
              'Indonesia adalah negara kepulauan terbesar dengan kekayaan budaya luar biasa. Ibarat **taman bunga** yang indah bukan karena satu warna, melainkan beraneka warna dan jenis bunga yang tumbuh harmonis.'),
          const Gambar('Ilustrasi: anak-anak berbagai daerah dengan pakaian adat', aset: 'assets/images/materi/12.jpg'),
          const Callout(JenisCallout.info, 'SARA',
              'Singkatan dari **S**uku, **A**gama, **R**as, dan **A**ntargolongan, keanekaragaman yang dibahas dalam materi PPKn.'),
          const Paragraf(
              'Memahami SARA penting agar kamu mampu membedakan **keunikan budaya yang harus disyukuri** dan **potensi konflik yang harus dihindari**. Keragaman bukan alasan untuk memisahkan diri, melainkan identitas utama bangsa yang diikat semangat persatuan.'),
          const AngkaKunci([
            ItemAngka(300, 'kelompok suku bangsa', akhiran: '+'),
            ItemAngka(6, 'agama yang diakui negara'),
          ]),
        ]),
        Bab('Empat Unsur Keragaman (SARA)', Icons.groups, [
          const Paragraf('Keragaman masyarakat Indonesia mencakup empat aspek utama. Pilih tab:'),
          const TabInfo([
            ItemTab('Suku', Icons.groups, [
              Paragraf(
                  'Sekelompok manusia dengan kesamaan **budaya, bahasa daerah, asal-usul, dan adat istiadat** yang diwariskan turun-temurun. Setiap suku memiliki tarian tradisional, rumah adat, pakaian adat, dan lagu daerah yang unik.'),
              GridIkon([
                ItemGrid(Icons.terrain, 'Jawa', 'Pulau Jawa'),
                ItemGrid(Icons.terrain, 'Batak', 'Sumatra Utara'),
                ItemGrid(Icons.terrain, 'Dayak', 'Kalimantan'),
                ItemGrid(Icons.terrain, 'Bugis', 'Sulawesi'),
                ItemGrid(Icons.terrain, 'Asmat', 'Papua'),
              ]),
            ]),
            ItemTab('Agama', Icons.self_improvement, [
              Paragraf(
                  'Sila pertama Pancasila menjamin kebebasan beragama. Negara mengakui **enam agama utama** dan memberi ruang bagi penghayat kepercayaan.'),
              Daftar(['Islam', 'Kristen', 'Katolik', 'Hindu', 'Buddha', 'Khonghucu'],
                  bernomor: true),
              Callout(JenisCallout.tips, 'Perbedaan bukan pemisah',
                  'Perbedaan ritual ibadah, kitab suci, dan hari besar adalah pelajaran tentang indahnya saling menghargai keyakinan orang lain.'),
            ]),
            ItemTab('Ras', Icons.face, [
              Paragraf(
                  'Pengelompokan manusia berdasarkan **ciri fisik luar yang diturunkan secara biologis** (warna kulit, bentuk rambut, bentuk mata, tinggi badan). Kelompok ras dominan di Indonesia:'),
              Akordeon([
                ItemAkordeon('Malayan-Mongoloid',
                    'Kulit sawo matang, rambut lurus atau berombak, mata hitam. Tersebar di sebagian besar Sumatra, Jawa, Bali, NTB, Kalimantan, dan Sulawesi.',
                    ikon: Icons.map),
                ItemAkordeon('Melanesoid',
                    'Kulit gelap, rambut keriting, bibir agak tebal. Sebagian besar mendiami Papua, Maluku, dan NTT.',
                    ikon: Icons.map),
                ItemAkordeon('Asiatic Mongoloid',
                    'Warga keturunan Tionghoa, Korea, atau Jepang; kulit kuning langsat dan mata sipit.',
                    ikon: Icons.map),
                ItemAkordeon('Kaukasoid',
                    'Warga keturunan Timur Tengah, India, atau Eropa yang mendiami berbagai wilayah Indonesia.',
                    ikon: Icons.map),
              ]),
            ]),
            ItemTab('Antargolongan', Icons.work, [
              Paragraf(
                  'Perbedaan **kedudukan sosial, struktur ekonomi, tingkat pendidikan, profesi, serta organisasi** dalam masyarakat.'),
              Daftar(['Petani', 'Nelayan', 'Pedagang', 'Pegawai negeri', 'Pengusaha']),
              Callout(JenisCallout.info, 'Saling membutuhkan',
                  'Keragaman antargolongan mengajarkan bahwa setiap profesi dan peran saling membutuhkan agar roda kehidupan tetap berputar.'),
            ]),
          ]),
        ]),
        Bab('Mengapa Indonesia Begitu Beragam?', Icons.travel_explore, [
          const Paragraf('Keberagaman dipengaruhi **lima faktor utama**. Ketuk untuk membuka:'),
          const Gambar('Peta: Indonesia di antara dua benua dan dua samudra', aset: 'assets/images/materi/13.jpg'),
          const Akordeon([
            ItemAkordeon('a. Letak strategis',
                'Indonesia berada di antara dua samudra (Hindia dan Pasifik) dan dua benua (Asia dan Australia). Letaknya menjadikannya jalur perdagangan internasional yang dilewati bangsa asing pembawa budaya, agama, dan ras berbeda.',
                ikon: Icons.explore),
            ItemAkordeon('b. Kondisi negara kepulauan',
                'Ribuan pulau yang dipisahkan laut membuat tiap kelompok tumbuh menjadi suku bangsa dengan budaya, bahasa, dan kebiasaan sendiri karena terisolasi secara geografis di masa lalu.',
                ikon: Icons.sailing),
            ItemAkordeon('c. Perbedaan kondisi alam',
                'Masyarakat pesisir berkembang menjadi nelayan yang berkarakter terbuka. Masyarakat pegunungan menjadi petani dengan budaya yang menyesuaikan suhu dingin dan lahan pertanian.',
                ikon: Icons.terrain),
            ItemAkordeon('d. Transportasi dan komunikasi',
                'Mudah atau sulitnya sarana transportasi dan komunikasi memengaruhi seberapa cepat masyarakat menerima pengaruh luar atau berinteraksi dengan kelompok lain.',
                ikon: Icons.directions_bus),
            ItemAkordeon('e. Penerimaan terhadap perubahan',
                'Ada kelompok yang sangat terbuka pada budaya baru, ada pula yang teguh memegang tradisi tanpa mau dipengaruhi budaya luar (seperti suku Baduy).',
                ikon: Icons.change_circle),
          ], bukaPertama: true),
        ]),
        Bab('Bhinneka Tunggal Ika: Bingkai Persatuan', Icons.flag, [
          const Gambar('Lambang Garuda Pancasila dengan pita Bhinneka Tunggal Ika', aset: 'assets/images/materi/14.jpg'),
          const Paragraf(
              'Di bawah kaki burung Garuda Pancasila, tercengkeram pita putih bertuliskan **"Bhinneka Tunggal Ika"**.'),
          const Kutipan('Berbeda-beda tetapi tetap satu jua.',
              sumber: 'Kitab Sutasoma karya Mpu Tantular, zaman Majapahit'),
          const Paragraf(
              'Semboyan ini adalah **bingkai perekat** seluruh elemen SARA. Persatuan tidak berarti menghilangkan identitas suku, agama, atau budaya asli, melainkan menaruh **rasa bangga dan cinta tanah air di atas kepentingan kelompok atau golongan pribadi**.'),
          const Perbandingan('Dikelola dengan baik', 'Diwarnai keegoisan', [
            BarisBanding(
                'Hasilnya',
                'Kekayaan nasional yang luar biasa, daya tarik wisata dunia, dan benteng kekuatan bangsa.',
                'Isu SARA mudah dimanfaatkan pihak tidak bertanggung jawab untuk memicu perselisihan dan konflik horizontal.'),
          ], warnaKiri: Color(0xFF2E9E5B), warnaKanan: Color(0xFFE53935)),
        ]),
        Bab('Sikap Toleransi bagi Pelajar', Icons.volunteer_activism, [
          const Paragraf(
              'Agar keberagaman tetap dalam bingkai persatuan, praktikkan toleransi setiap hari:'),
          const Akordeon([
            ItemAkordeon('Toleransi beragama',
                'Tidak mengganggu teman yang beribadah, tidak memaksakan ajaran sendiri kepada pemeluk agama lain, dan menjaga ketenangan saat hari raya agama lain.',
                ikon: Icons.self_improvement),
            ItemAkordeon('Menolak perundungan berbasis rasisme',
                'Tidak mengejek warna kulit, bentuk rambut, atau logat teman dari daerah lain. Hindari candaan yang merendahkan fisik atau suku tertentu.',
                ikon: Icons.shield),
            ItemAkordeon('Pertemanan inklusif',
                'Terbuka berteman dan bekerja sama dengan siapa saja tanpa membuat kelompok eksklusif sesama suku atau agama.',
                ikon: Icons.groups),
            ItemAkordeon('Bijak di media sosial',
                'Tidak menyebarkan ujaran kebencian, hoaks, atau meme yang memecah belah persatuan suku dan agama.',
                ikon: Icons.phone_android),
          ]),
          const Callout(JenisCallout.penting, 'Anugerah Tuhan',
              'Keragaman SARA adalah anugerah terbesar dari Tuhan Yang Maha Esa bagi bangsa Indonesia: bukan penghambat kemajuan, melainkan **modal utama** membangun bangsa yang besar dan kuat.'),
        ]),
        Bab('Rangkuman & Uji Pemahaman', Icons.quiz, [
          const Ringkasan([
            'SARA = Suku, Agama, Ras, Antargolongan.',
            'Penyebab keragaman: letak strategis, negara kepulauan, kondisi alam, transportasi dan komunikasi, serta penerimaan terhadap perubahan.',
            'Bhinneka Tunggal Ika (Sutasoma, Mpu Tantular) = berbeda-beda tetapi tetap satu jua.',
            'Toleransi dan sikap inklusif menjaga keragaman tetap menjadi kekuatan.',
          ]),
          const KuisKilat('Uji Pemahaman: Keragaman', [
            SoalKilat(
                'SARA adalah singkatan dari ...',
                [
                  'Suku, Agama, Ras, Antargolongan',
                  'Sosial, Agama, Rakyat, Adat',
                  'Suku, Adat, Ras, Aturan',
                  'Sosial, Aturan, Rakyat, Antargolongan'
                ],
                0,
                'SARA = Suku, Agama, Ras, Antargolongan.'),
            SoalKilat(
                'Semboyan Bhinneka Tunggal Ika berasal dari kitab ...',
                ['Negarakertagama', 'Sutasoma', 'Pararaton', 'Arjunawiwaha'],
                1,
                'Kitab Sutasoma karangan Mpu Tantular pada zaman Majapahit.'),
            SoalKilat(
                'Suku Baduy yang teguh memegang tradisi adalah contoh faktor ...',
                [
                  'Letak strategis',
                  'Kondisi alam',
                  'Penerimaan masyarakat terhadap perubahan',
                  'Transportasi'
                ],
                2,
                'Sebagian masyarakat memilih tidak dipengaruhi budaya luar.'),
            SoalKilat(
                'Ras Melanesoid terutama mendiami wilayah ...',
                [
                  'Jawa dan Bali',
                  'Papua, Maluku, dan NTT',
                  'Sumatra dan Kalimantan',
                  'Sulawesi'
                ],
                1,
                'Ciri: kulit gelap, rambut keriting; banyak di Papua, Maluku, dan NTT.'),
            SoalKilat(
                'Perbedaan profesi dan tingkat ekonomi termasuk unsur ...',
                ['Suku', 'Agama', 'Ras', 'Antargolongan'],
                3,
                'Antargolongan mencakup kedudukan sosial, ekonomi, pendidikan, profesi.'),
            SoalKilat(
                'Mengapa letak strategis Indonesia membuatnya beragam?',
                [
                  'Karena wilayahnya kecil',
                  'Karena menjadi jalur perdagangan yang membawa budaya, agama, dan ras berbeda',
                  'Karena tidak pernah dikunjungi bangsa asing',
                  'Karena hanya memiliki satu samudra'
                ],
                1,
                'Posisi di antara dua benua dan dua samudra menjadikannya jalur perdagangan internasional.'),
          ]),
        ]),
      ],
    );
