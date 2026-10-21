// =============================================================================
// materi_model.dart
// Model data materi SAPA (Sahabat Pancasila) — dipakai ulang untuk kelas 7, 8, 9.
// Tidak butuh package tambahan (hanya Flutter SDK). 100% offline.
// =============================================================================
import 'package:flutter/material.dart';

// ─────────────────────────────────────────────────────────────────────────────
// BLOK KONTEN
// Setiap bagian materi disusun dari "blok". Tinggal susun blok di file data.
// Teks mendukung **tebal** (apit dengan dua tanda bintang).
// ─────────────────────────────────────────────────────────────────────────────
abstract class Blok {
  const Blok();
}

/// Paragraf biasa. Gunakan **teks** untuk menebalkan.
class Paragraf extends Blok {
  final String teks;
  const Paragraf(this.teks);
}

/// Anak judul di dalam bab.
class SubJudul extends Blok {
  final String teks;
  final IconData? ikon;
  const SubJudul(this.teks, {this.ikon});
}

/// KOTAK GAMBAR. Isi [aset] dengan path gambar (mis. 'assets/materi/k7/yamin.png')
/// kalau gambarnya sudah ada. Selama [aset] kosong / file belum ada,
/// otomatis tampil kotak placeholder bergaris putus berisi [label].
class Gambar extends Blok {
  final String label;
  final String? aset;
  final double rasio; // lebar / tinggi
  const Gambar(this.label, {this.aset, this.rasio = 16 / 9});
}

/// Kutipan / pidato penting.
class Kutipan extends Blok {
  final String teks;
  final String? sumber;
  const Kutipan(this.teks, {this.sumber});
}

enum JenisCallout { info, penting, fakta, tips, peringatan }

/// Kotak sorotan berwarna (info / penting / fakta / tips / peringatan).
class Callout extends Blok {
  final JenisCallout jenis;
  final String judul;
  final String isi;
  const Callout(this.jenis, this.judul, this.isi);
}

/// Daftar poin (berbutir atau bernomor).
class Daftar extends Blok {
  final List<String> item;
  final bool bernomor;
  const Daftar(this.item, {this.bernomor = false});
}

class LangkahLinimasa {
  final String waktu;
  final String judul;
  final String isi;
  final IconData ikon;
  const LangkahLinimasa(this.waktu, this.judul, this.isi,
      {this.ikon = Icons.circle});
}

/// Linimasa vertikal, tiap langkah bisa diketuk untuk membuka detail.
class Linimasa extends Blok {
  final List<LangkahLinimasa> langkah;
  const Linimasa(this.langkah);
}

class KartuInfo {
  final String label; // mis. tanggal / kategori kecil di header kartu
  final String judul;
  final String isi;
  final List<String> poin;
  final IconData ikon;
  const KartuInfo(this.label, this.judul, this.isi,
      {this.poin = const [], this.ikon = Icons.person});
}

/// Kartu yang digeser ke samping (carousel), cocok untuk tokoh.
class KartuGeser extends Blok {
  final List<KartuInfo> kartu;
  const KartuGeser(this.kartu);
}

class ItemAkordeon {
  final String judul;
  final String isi;
  final List<String> poin;
  final IconData? ikon;
  const ItemAkordeon(this.judul, this.isi, {this.poin = const [], this.ikon});
}

/// Daftar yang bisa dibuka-tutup.
class Akordeon extends Blok {
  final List<ItemAkordeon> item;
  final bool bukaPertama;
  const Akordeon(this.item, {this.bukaPertama = false});
}

class ItemTab {
  final String label;
  final IconData ikon;
  final List<Blok> isi;
  final Color? warna;
  const ItemTab(this.label, this.ikon, this.isi, {this.warna});
}

/// Tab bergeser; tiap tab berisi blok-blok lain.
class TabInfo extends Blok {
  final List<ItemTab> tab;
  const TabInfo(this.tab);
}

class ItemKartuBalik {
  final String depan;
  final String belakang;
  final IconData ikon;
  const ItemKartuBalik(this.depan, this.belakang, {this.ikon = Icons.lightbulb});
}

/// Kartu yang bisa dibalik dengan ketukan (istilah → arti).
class KartuBalik extends Blok {
  final String petunjuk;
  final List<ItemKartuBalik> kartu;
  const KartuBalik(this.kartu, {this.petunjuk = 'Ketuk kartu untuk membalik'});
}

class BarisBanding {
  final String label;
  final String kiri;
  final String kanan;
  const BarisBanding(this.label, this.kiri, this.kanan);
}

/// Tabel perbandingan dua sisi.
class Perbandingan extends Blok {
  final String judulKiri;
  final String judulKanan;
  final List<BarisBanding> baris;
  final Color? warnaKiri;
  final Color? warnaKanan;
  const Perbandingan(this.judulKiri, this.judulKanan, this.baris,
      {this.warnaKiri, this.warnaKanan});
}

class ItemGrid {
  final IconData ikon;
  final String judul;
  final String isi;
  const ItemGrid(this.ikon, this.judul, this.isi);
}

/// Kotak-kotak ikon. [kolom] 1 = baris memanjang, 2 = dua kolom.
class GridIkon extends Blok {
  final List<ItemGrid> item;
  final int kolom;
  const GridIkon(this.item, {this.kolom = 2});
}

class ItemAngka {
  final int nilai;
  final String label;
  final String akhiran;
  final bool pisah; // true -> 17.000
  const ItemAngka(this.nilai, this.label, {this.akhiran = '', this.pisah = false});
}

/// Angka besar yang berhitung naik saat tampil di layar.
class AngkaKunci extends Blok {
  final List<ItemAngka> item;
  const AngkaKunci(this.item);
}

class SoalKilat {
  final String tanya;
  final List<String> pilihan;
  final int benar; // indeks pilihan yang benar
  final String jelas;
  const SoalKilat(this.tanya, this.pilihan, this.benar, this.jelas);
}

/// Kuis mini (cek pemahaman) langsung di dalam materi.
class KuisKilat extends Blok {
  final String judul;
  final List<SoalKilat> soal;
  const KuisKilat(this.judul, this.soal);
}

/// Kotak intisari di akhir materi.
class Ringkasan extends Blok {
  final String judul;
  final List<String> poin;
  const Ringkasan(this.poin, {this.judul = 'Intisari'});
}

/// Tabel data (bisa digeser ke samping).
class TabelData extends Blok {
  final List<String> kolom;
  final List<List<String>> baris;
  const TabelData(this.kolom, this.baris);
}

/// Diagram interaktif zona laut (khusus Materi Wilayah NKRI).
class ZonaLaut extends Blok {
  const ZonaLaut();
}

// ─────────────────────────────────────────────────────────────────────────────
// BAB & MATERI
// ─────────────────────────────────────────────────────────────────────────────
class Bab {
  final String judul;
  final IconData ikon;
  final List<Blok> isi;
  Bab(this.judul, this.ikon, this.isi);

  /// Teks polos seluruh bab (untuk pencarian & cuplikan).
  late final String teks = isi.map(teksBlok).join('\n');
  late final String teksKecil = teks.toLowerCase();
  late final String judulKecil = judul.toLowerCase();
}

class Materi {
  final String id;
  final int nomor;
  final String judul;
  final String deskripsi;
  final IconData ikon;
  final Color warna;
  final List<String> kataKunci;
  final List<Bab> bab;

  Materi({
    required this.id,
    required this.nomor,
    required this.judul,
    required this.deskripsi,
    required this.ikon,
    required this.warna,
    required this.kataKunci,
    required this.bab,
  });

  late final int jumlahKata = bab.fold<int>(
      0,
      (s, b) =>
          s +
          b.teks
              .split(RegExp(r'\s+'))
              .where((e) => e.isNotEmpty)
              .length);

  /// Perkiraan waktu baca (menit), ±160 kata/menit untuk bacaan pelajar.
  late final int menitBaca = (jumlahKata / 160).round().clamp(1, 999);

  late final String kataKunciKecil = kataKunci.join(' ').toLowerCase();
  late final String judulKecil = judul.toLowerCase();
}

// ─────────────────────────────────────────────────────────────────────────────
// EKSTRAKSI TEKS & PENCARIAN
// ─────────────────────────────────────────────────────────────────────────────
String teksBlok(Blok b) {
  final s = StringBuffer();
  void t(String? x) {
    if (x == null || x.isEmpty) return;
    s.write(x.replaceAll('**', ''));
    s.write('\n');
  }

  if (b is Paragraf) {
    t(b.teks);
  } else if (b is SubJudul) {
    t(b.teks);
  } else if (b is Kutipan) {
    t(b.teks);
    t(b.sumber);
  } else if (b is Callout) {
    t(b.judul);
    t(b.isi);
  } else if (b is Daftar) {
    b.item.forEach(t);
  } else if (b is Linimasa) {
    for (final l in b.langkah) {
      t(l.waktu);
      t(l.judul);
      t(l.isi);
    }
  } else if (b is KartuGeser) {
    for (final k in b.kartu) {
      t(k.label);
      t(k.judul);
      t(k.isi);
      k.poin.forEach(t);
    }
  } else if (b is Akordeon) {
    for (final i in b.item) {
      t(i.judul);
      t(i.isi);
      i.poin.forEach(t);
    }
  } else if (b is TabInfo) {
    for (final tb in b.tab) {
      t(tb.label);
      for (final x in tb.isi) {
        s.write(teksBlok(x));
      }
    }
  } else if (b is KartuBalik) {
    for (final k in b.kartu) {
      t(k.depan);
      t(k.belakang);
    }
  } else if (b is Perbandingan) {
    t(b.judulKiri);
    t(b.judulKanan);
    for (final r in b.baris) {
      t(r.label);
      t(r.kiri);
      t(r.kanan);
    }
  } else if (b is GridIkon) {
    for (final i in b.item) {
      t(i.judul);
      t(i.isi);
    }
  } else if (b is AngkaKunci) {
    for (final i in b.item) {
      t(i.label);
    }
  } else if (b is Ringkasan) {
    t(b.judul);
    b.poin.forEach(t);
  } else if (b is TabelData) {
    b.kolom.forEach(t);
    for (final r in b.baris) {
      r.forEach(t);
    }
  } else if (b is ZonaLaut) {
    t('Laut teritorial 12 mil laut Zona Ekonomi Eksklusif ZEE 200 mil laut Landas kontinen');
  }
  // Gambar & KuisKilat sengaja tidak ikut dicari.
  return s.toString();
}

/// Memecah kalimat pencarian jadi kata-kata kecil tanpa tanda baca.
List<String> pecahKataCari(String q) {
  final re = RegExp(r'[^\p{L}\p{N}]', unicode: true);
  return q
      .toLowerCase()
      .split(RegExp(r'\s+'))
      .map((e) => e.replaceAll(re, ''))
      .where((e) => e.isNotEmpty)
      .toList();
}

class HasilCari {
  final Materi materi;
  final int indeksMateri;
  final Bab bab;
  final int indeksBab;
  final int skor;
  final String cuplikan;
  const HasilCari(this.materi, this.indeksMateri, this.bab, this.indeksBab,
      this.skor, this.cuplikan);
}

int _hitung(String sumber, String kata, {int batas = 6}) {
  var n = 0;
  var pos = 0;
  while (n < batas) {
    final i = sumber.indexOf(kata, pos);
    if (i < 0) break;
    n++;
    pos = i + kata.length;
  }
  return n;
}

String _cuplik(String teks, String teksKecil, List<String> kata) {
  var idx = -1;
  for (final k in kata) {
    final i = teksKecil.indexOf(k);
    if (i >= 0 && (idx < 0 || i < idx)) idx = i;
  }
  String ambil;
  if (idx < 0 || teks.length != teksKecil.length) {
    ambil = teks.length > 150 ? teks.substring(0, 150) : teks;
    return ambil.replaceAll('\n', ' ').trim() + (teks.length > 150 ? '…' : '');
  }
  var mulai = idx - 55;
  if (mulai < 0) {
    mulai = 0;
  } else {
    final sp = teks.indexOf(' ', mulai);
    if (sp >= 0 && sp < idx) mulai = sp + 1;
  }
  var akhir = idx + 120;
  if (akhir > teks.length) akhir = teks.length;
  ambil = teks.substring(mulai, akhir).replaceAll('\n', ' ').trim();
  return (mulai > 0 ? '…' : '') + ambil + (akhir < teks.length ? '…' : '');
}

/// Cari di seluruh bab. Semua kata harus ditemukan (AND). Hasil diurutkan
/// berdasarkan skor (judul > kata kunci > isi).
List<HasilCari> cariMateri(List<Materi> daftar, String query,
    {int? hanyaMateri}) {
  final kata = pecahKataCari(query);
  if (kata.isEmpty) return const [];
  final hasil = <HasilCari>[];
  for (var m = 0; m < daftar.length; m++) {
    if (hanyaMateri != null && hanyaMateri != m) continue;
    final materi = daftar[m];
    for (var b = 0; b < materi.bab.length; b++) {
      final bab = materi.bab[b];
      var skor = 0;
      var cocok = true;
      for (final k in kata) {
        var s = 0;
        if (bab.judulKecil.contains(k)) s += 12;
        if (materi.kataKunciKecil.contains(k)) s += 5;
        if (materi.judulKecil.contains(k)) s += 3;
        s += _hitung(bab.teksKecil, k);
        if (s == 0) {
          cocok = false;
          break;
        }
        skor += s;
      }
      if (!cocok) continue;
      hasil.add(HasilCari(materi, m, bab, b, skor,
          _cuplik(bab.teks, bab.teksKecil, kata)));
    }
  }
  hasil.sort((a, b) {
    final c = b.skor.compareTo(a.skor);
    if (c != 0) return c;
    final d = a.indeksMateri.compareTo(b.indeksMateri);
    return d != 0 ? d : a.indeksBab.compareTo(b.indeksBab);
  });
  return hasil;
}

// ─────────────────────────────────────────────────────────────────────────────
// PROGRES BELAJAR (sederhana, in-memory)
// Agar tersimpan permanen, hubungkan dengan shared_preferences:
//
//   final prefs = await SharedPreferences.getInstance();
//   ProgresMateri.instance.muat(prefs.getStringList('materi_selesai') ?? []);
//   ProgresMateri.instance.onSimpan =
//       (ids) => prefs.setStringList('materi_selesai', ids);
// ─────────────────────────────────────────────────────────────────────────────
class ProgresMateri extends ChangeNotifier {
  ProgresMateri._();
  static final ProgresMateri instance = ProgresMateri._();

  final Set<String> _selesai = <String>{};
  void Function(List<String> ids)? onSimpan;

  bool apakahSelesai(String id) => _selesai.contains(id);

  void muat(Iterable<String> ids) {
    _selesai
      ..clear()
      ..addAll(ids);
    notifyListeners();
  }

  void atur(String id, bool selesai) {
    final berubah = selesai ? _selesai.add(id) : _selesai.remove(id);
    if (!berubah) return;
    onSimpan?.call(_selesai.toList());
    notifyListeners();
  }
}
