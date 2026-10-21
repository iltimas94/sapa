import 'package:flutter/material.dart';

/// Hapus penanda tebal (**) agar teks bisa dipakai untuk pencarian.
String bersihkanTanda(String s) => s.replaceAll('**', '');

/// ---------------------------------------------------------------------------
///  BLOK KONTEN
///  Setiap bagian materi tersusun dari blok-blok. Tambah blok baru dengan
///  membuat class turunan Blok lalu menambahkannya di BlokView (widgets).
///  Di dalam teks, tulis **kata penting** untuk mencetak tebal.
/// ---------------------------------------------------------------------------
abstract class Blok {
  const Blok();
  String get teksCari;
}

class Paragraf extends Blok {
  final String teks;
  const Paragraf(this.teks);
  @override
  String get teksCari => bersihkanTanda(teks);
}

class SubJudul extends Blok {
  final String teks;
  const SubJudul(this.teks);
  @override
  String get teksCari => teks;
}

/// Kotak gambar. Isi [aset] dengan path gambar, mis.
/// 'assets/images/kelas8/gedung_pancasila.png'. Selama [aset] null,
/// yang tampil adalah kotak placeholder berisi [deskripsi].
class Gambar extends Blok {
  final String deskripsi;
  final String? aset;
  final String? sumber;
  final double rasio;
  const Gambar({
    required this.deskripsi,
    this.aset,
    this.sumber,
    this.rasio = 16 / 9,
  });
  @override
  String get teksCari => '';
}

enum JenisKotak { info, penting, tips, contoh, refleksi, ringkasan }

class Kotak extends Blok {
  final JenisKotak jenis;
  final String judul;
  final String isi;
  final List<String> poin;
  const Kotak({
    required this.jenis,
    required this.judul,
    this.isi = '',
    this.poin = const [],
  });
  @override
  String get teksCari => bersihkanTanda('$judul $isi ${poin.join(' ')}');
}

class Poin extends Blok {
  final List<String> items;
  const Poin(this.items);
  @override
  String get teksCari => bersihkanTanda(items.join(' '));
}

class ItemAkordeon {
  final String emoji;
  final String judul;
  final String isi;
  const ItemAkordeon({required this.emoji, required this.judul, required this.isi});
}

/// Daftar kartu yang bisa dibuka-tutup.
class Akordeon extends Blok {
  final List<ItemAkordeon> items;
  const Akordeon(this.items);
  @override
  String get teksCari =>
      bersihkanTanda(items.map((e) => '${e.judul} ${e.isi}').join(' '));
}

class ItemTab {
  final String label;
  final String emoji;
  final String judul;
  final String isi;
  final List<String> poin;
  const ItemTab({
    required this.label,
    required this.emoji,
    required this.judul,
    this.isi = '',
    this.poin = const [],
  });
}

/// Tab untuk membandingkan beberapa konsep.
class TabPerbandingan extends Blok {
  final List<ItemTab> tab;
  const TabPerbandingan(this.tab);
  @override
  String get teksCari => bersihkanTanda(
      tab.map((e) => '${e.label} ${e.judul} ${e.isi} ${e.poin.join(' ')}').join(' '));
}

class Peristiwa {
  final String waktu;
  final String judul;
  final String isi;
  const Peristiwa({required this.waktu, required this.judul, required this.isi});
}

/// Linimasa / langkah berurutan.
class Linimasa extends Blok {
  final String? judul;
  final List<Peristiwa> items;
  const Linimasa({this.judul, required this.items});
  @override
  String get teksCari => bersihkanTanda(
      '${judul ?? ''} ${items.map((e) => '${e.waktu} ${e.judul} ${e.isi}').join(' ')}');
}

class LevelPiramida {
  final String singkat;
  final String judul;
  final String pembuat;
  final String isi;
  const LevelPiramida({
    required this.singkat,
    required this.judul,
    this.pembuat = '',
    required this.isi,
  });
}

/// Piramida interaktif: ketuk lapisan untuk melihat rincian.
class Piramida extends Blok {
  final List<LevelPiramida> level;
  const Piramida(this.level);
  @override
  String get teksCari => bersihkanTanda(
      level.map((e) => '${e.judul} ${e.pembuat} ${e.isi}').join(' '));
}

class KartuBalikItem {
  final String emoji;
  final String depan;
  final String belakang;
  const KartuBalikItem({
    required this.emoji,
    required this.depan,
    required this.belakang,
  });
}

/// Kartu yang dibalik saat diketuk (depan: judul, belakang: penjelasan).
class KartuBalik extends Blok {
  final List<KartuBalikItem> items;
  const KartuBalik(this.items);
  @override
  String get teksCari =>
      bersihkanTanda(items.map((e) => '${e.depan} ${e.belakang}').join(' '));
}

class Soal {
  final String pertanyaan;
  final List<String> opsi;
  final int benar; // indeks opsi yang benar (mulai dari 0)
  final String penjelasan;
  const Soal({
    required this.pertanyaan,
    required this.opsi,
    required this.benar,
    required this.penjelasan,
  });
}

/// Kuis pilihan ganda satu per satu + skor akhir.
class Latihan extends Blok {
  final String judul;
  final List<Soal> soal;
  const Latihan({required this.judul, required this.soal});
  @override
  String get teksCari => '';
}

/// Game menyusun urutan (seret untuk mengurutkan).
class Urutkan extends Blok {
  final String judul;
  final String petunjuk;
  final List<String> urutanBenar;
  final String penjelasan;
  const Urutkan({
    required this.judul,
    required this.petunjuk,
    required this.urutanBenar,
    required this.penjelasan,
  });
  @override
  String get teksCari => '';
}

class StatItem {
  final String emoji;
  final String angka;
  final String label;
  const StatItem({required this.emoji, required this.angka, required this.label});
}

class Statistik extends Blok {
  final List<StatItem> items;
  const Statistik(this.items);
  @override
  String get teksCari => items.map((e) => '${e.angka} ${e.label}').join(' ');
}

class ItemKlas {
  final String teks;
  final int jawaban; // indeks label yang benar
  final String alasan;
  const ItemKlas({required this.teks, required this.jawaban, required this.alasan});
}

/// Game menggolongkan: kartu ditampilkan satu per satu, pemain memilih label.
class Klasifikasi extends Blok {
  final String judul;
  final String petunjuk;
  final List<String> labels;
  final List<ItemKlas> items;
  const Klasifikasi({
    required this.judul,
    required this.petunjuk,
    required this.labels,
    required this.items,
  });
  @override
  String get teksCari => '';
}

/// Daftar komitmen yang bisa dicentang.
class Ceklis extends Blok {
  final String judul;
  final List<String> items;
  const Ceklis({required this.judul, required this.items});
  @override
  String get teksCari => items.join(' ');
}

/// ---------------------------------------------------------------------------
///  BAGIAN & MATERI
/// ---------------------------------------------------------------------------
class Bagian {
  final String judul;
  final String emoji;
  final List<Blok> blok;
  Bagian({required this.judul, this.emoji = '📌', required this.blok});

  late final String teksAsli =
      '$judul. ${blok.map((b) => b.teksCari).where((t) => t.isNotEmpty).join(' ')}';
  late final String teksCari = teksAsli.toLowerCase();
  late final String judulCari = judul.toLowerCase();

  int get jumlahInteraktif => blok
      .where((b) => b is Latihan || b is Urutkan || b is Klasifikasi || b is Ceklis)
      .length;
}

class MateriKelas8 {
  final String id;
  final int nomor;
  final String judul;
  final String ringkas;
  final String emoji;
  final Color warna;
  final List<String> kataKunci;
  final int menitBaca;

  /// Path gambar sampul (opsional), mis. 'assets/images/kelas8/sampul_1.png'.
  final String? sampul;
  final List<Bagian> bagian;

  MateriKelas8({
    required this.id,
    required this.nomor,
    required this.judul,
    required this.ringkas,
    required this.emoji,
    required this.warna,
    required this.kataKunci,
    required this.menitBaca,
    this.sampul,
    required this.bagian,
  });

  late final String judulCari = judul.toLowerCase();
  late final String ringkasCari = ringkas.toLowerCase();
  late final String kunciCari = kataKunci.join(' ').toLowerCase();

  int get jumlahInteraktif =>
      bagian.fold(0, (jumlah, b) => jumlah + b.jumlahInteraktif);
}
