// =============================================================================
//  SAPA – Sahabat Pancasila
//  materi_core.dart  →  mesin halaman materi (dipakai ulang untuk kelas 7, 8, 9)
//
//  • Tanpa package tambahan, tanpa internet (100% Flutter SDK).
//  • Isi materi ada di file terpisah (mis. materi_kelas9_data.dart).
//  • Butuh Flutter 3.16+ (memakai TextScaler).
// =============================================================================

import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// ─────────────────────────────────────────────────────────────────────────────
//  UTIL
// ─────────────────────────────────────────────────────────────────────────────

Color _tint(Color c, double o) => c.withAlpha((o * 255).round());

bool _gelap(BuildContext c) => Theme.of(c).brightness == Brightness.dark;

/// Warna aksen yang tetap terbaca di mode gelap.
Color _aksen(BuildContext c, Color w) =>
    _gelap(c) ? Color.lerp(w, Colors.white, .55)! : w;

Color _lebihGelap(Color c, [double v = .22]) =>
    Color.lerp(c, Colors.black, v)!;

String _bersih(String s) => s.replaceAll('*', '');

List<String> _token(String q) => q
    .toLowerCase()
    .split(RegExp(r'\s+'))
    .where((e) => e.isNotEmpty)
    .toList();

bool _semuaToken(String hay, List<String> t) => t.every(hay.contains);

TextStyle _gayaTeks(BuildContext c) =>
    (Theme.of(c).textTheme.bodyMedium ?? const TextStyle())
        .copyWith(fontSize: 15.5, height: 1.6);

/// Mendukung **tebal** dan *miring* di dalam string materi.
List<InlineSpan> _spans(String s, TextStyle base, Color aksen) {
  final out = <InlineSpan>[];
  final buf = StringBuffer();
  var tebal = false, miring = false;
  void flush() {
    if (buf.isEmpty) return;
    out.add(TextSpan(
      text: buf.toString(),
      style: base.copyWith(
        fontWeight: tebal ? FontWeight.w700 : null,
        fontStyle: miring ? FontStyle.italic : null,
        color: tebal ? aksen : null,
      ),
    ));
    buf.clear();
  }

  for (var k = 0; k < s.length; k++) {
    if (s.startsWith('**', k)) {
      flush();
      tebal = !tebal;
      k++;
    } else if (s[k] == '*') {
      flush();
      miring = !miring;
    } else {
      buf.write(s[k]);
    }
  }
  flush();
  return out;
}

/// Menyorot kata pencarian di dalam teks.
List<TextSpan> _sorot(
    String teks, List<String> token, TextStyle base, Color warnaSorot) {
  if (token.isEmpty) return [TextSpan(text: teks, style: base)];
  final lower = teks.toLowerCase();
  final rentang = <List<int>>[];
  for (final t in token) {
    var mulai = 0;
    while (true) {
      final i = lower.indexOf(t, mulai);
      if (i < 0) break;
      rentang.add([i, i + t.length]);
      mulai = i + t.length;
    }
  }
  if (rentang.isEmpty) return [TextSpan(text: teks, style: base)];
  rentang.sort((a, b) => a[0].compareTo(b[0]));
  final gabung = <List<int>>[rentang.first];
  for (final r in rentang.skip(1)) {
    if (r[0] <= gabung.last[1]) {
      gabung.last[1] = math.max(gabung.last[1], r[1]);
    } else {
      gabung.add(r);
    }
  }
  final out = <TextSpan>[];
  var kursor = 0;
  for (final r in gabung) {
    if (r[0] > kursor) {
      out.add(TextSpan(text: teks.substring(kursor, r[0]), style: base));
    }
    out.add(TextSpan(
      text: teks.substring(r[0], r[1]),
      style: base.copyWith(
          backgroundColor: warnaSorot, fontWeight: FontWeight.w700),
    ));
    kursor = r[1];
  }
  if (kursor < teks.length) {
    out.add(TextSpan(text: teks.substring(kursor), style: base));
  }
  return out;
}

// ─────────────────────────────────────────────────────────────────────────────
//  MODEL KONTEN
//  Semua jenis "blok" yang bisa dipakai di dalam sebuah bagian materi.
// ─────────────────────────────────────────────────────────────────────────────

abstract class Blok {
  const Blok();
  String get teksCari;
}

/// Paragraf. Pakai **tebal** dan *miring*.
class Teks extends Blok {
  final String isi;
  const Teks(this.isi);
  @override
  String get teksCari => _bersih(isi);
}

class ItemPoin {
  final String? judul;
  final String isi;
  final IconData? ikon;
  const ItemPoin(this.isi, {this.judul, this.ikon});
}

/// Daftar poin (bulat / bernomor / dengan ikon).
class Poin extends Blok {
  final List<ItemPoin> item;
  final bool bernomor;
  const Poin(this.item, {this.bernomor = false});
  @override
  String get teksCari =>
      _bersih(item.map((e) => '${e.judul ?? ''} ${e.isi}').join(' '));
}

enum JenisCallout { tahukah, penting, contoh, analogi, ringkas, tips }

/// Kotak sorotan berwarna (tahukah kamu, penting, contoh, dst).
class Callout extends Blok {
  final JenisCallout jenis;
  final String isi;
  final String? judul;
  const Callout(this.jenis, this.isi, {this.judul});
  @override
  String get teksCari => _bersih('${judul ?? ''} $isi');
}

/// Kotak gambar. Isi [asset] nanti, mis. 'assets/images/k9/wayang.png'.
/// Selama [asset] null (atau file belum ada), tampil kotak penanda.
class Gambar extends Blok {
  final String deskripsi;
  final String? asset;
  final double rasio;
  const Gambar(this.deskripsi, {this.asset, this.rasio = 16 / 9});
  @override
  String get teksCari => deskripsi;
}

class ItemKartu {
  final String depan;
  final String belakang;
  const ItemKartu(this.depan, this.belakang);
}

/// Kartu yang bisa dibalik dengan sekali ketuk.
class KartuBalik extends Blok {
  final String? petunjuk;
  final List<ItemKartu> kartu;
  const KartuBalik(this.kartu, {this.petunjuk});
  @override
  String get teksCari =>
      _bersih(kartu.map((e) => '${e.depan} ${e.belakang}').join(' '));
}

class ItemTab {
  final String label;
  final IconData ikon;
  final List<Blok> isi;
  const ItemTab(this.label, this.ikon, this.isi);
}

/// Pilihan tab/chip; isi berubah sesuai pilihan.
class TabKonten extends Blok {
  final List<ItemTab> tab;
  const TabKonten(this.tab);
  @override
  String get teksCari => tab
      .map((t) => '${t.label} ${t.isi.map((b) => b.teksCari).join(' ')}')
      .join(' ');
}

class ItemPasal {
  final String pasal;
  final String hak;
  final String kewajiban;
  const ItemPasal(this.pasal, this.hak, this.kewajiban);
}

/// Daftar pasal yang bisa dibuka satu per satu (hak vs kewajiban).
class TabelPasal extends Blok {
  final List<ItemPasal> baris;
  const TabelPasal(this.baris);
  @override
  String get teksCari =>
      baris.map((e) => '${e.pasal} ${e.hak} ${e.kewajiban}').join(' ');
}

/// Kuis cepat satu soal pilihan ganda, langsung ada pembahasan.
class KuisMini extends Blok {
  final String tanya;
  final List<String> opsi;
  final int benar;
  final String penjelasan;
  const KuisMini(this.tanya, this.opsi, this.benar, this.penjelasan);
  @override
  String get teksCari => '';
}

/// Kutipan (bunyi pasal, semboyan, dsb).
class Kutipan extends Blok {
  final String isi;
  final String? sumber;
  const Kutipan(this.isi, {this.sumber});
  @override
  String get teksCari => '$isi ${sumber ?? ''}';
}

/// Ceklis refleksi: siswa mengetuk aksi yang sudah ia lakukan.
class Ceklis extends Blok {
  final String judul;
  final List<String> item;
  final String pesanSelesai;
  const Ceklis(this.judul, this.item,
      {this.pesanSelesai = 'Keren! Semua sudah kamu lakukan.'});
  @override
  String get teksCari => '$judul ${item.join(' ')}';
}

/// Diagram "rumah" interaktif: atap, dua tiang, dan pondasi.
class RumahPilar extends Blok {
  final ItemTab atap;
  final ItemTab tiangKiri;
  final ItemTab tiangKanan;
  final ItemTab pondasi;
  const RumahPilar({
    required this.atap,
    required this.tiangKiri,
    required this.tiangKanan,
    required this.pondasi,
  });
  @override
  String get teksCari => [atap, tiangKiri, tiangKanan, pondasi]
      .map((t) => '${t.label} ${t.isi.map((b) => b.teksCari).join(' ')}')
      .join(' ');
}

/// Satu sub-bab di dalam materi.
class Bagian {
  final String judul;
  final IconData ikon;
  final List<Blok> blok;
  Bagian(this.judul, this.ikon, this.blok);

  String? _cari;
  String get cari => _cari ??=
      _bersih('$judul ${blok.map((b) => b.teksCari).join(' ')}').toLowerCase();
}

/// Satu materi (satu entri di bank materi).
class Materi {
  final String id;
  final int nomor;
  final String judul;
  final String judulPendek;
  final String ringkasan;
  final IconData ikon;
  final Color warna;
  final List<String> kataKunci;
  final List<Blok> pembuka;
  final List<Bagian> bagian;
  final String penutup;

  Materi({
    required this.id,
    required this.nomor,
    required this.judul,
    required this.judulPendek,
    required this.ringkasan,
    required this.ikon,
    required this.warna,
    required this.kataKunci,
    required this.pembuka,
    required this.bagian,
    required this.penutup,
  });

  String? _hay;
  String get hay => _hay ??= _bersih([
        judul,
        judulPendek,
        ringkasan,
        kataKunci.join(' '),
        pembuka.map((b) => b.teksCari).join(' '),
        bagian.map((b) => b.cari).join(' '),
        penutup,
      ].join(' ')).toLowerCase();

  int get menit {
    final kata = hay.split(RegExp(r'\s+')).length;
    return math.max(1, (kata / 150).ceil());
  }

  bool cocok(List<String> token) => _semuaToken(hay, token);

  /// Potongan kalimat tempat kata pencarian ditemukan.
  String? cuplik(List<String> token) {
    if (token.isEmpty) return null;
    for (final b in bagian) {
      final teks = b.cari;
      for (final t in token) {
        final i = teks.indexOf(t);
        if (i < 0) continue;
        final a = math.max(0, i - 45);
        final z = math.min(teks.length, i + t.length + 70);
        return '${a > 0 ? '…' : ''}${teks.substring(a, z).trim()}${z < teks.length ? '…' : ''}';
      }
    }
    return null;
  }
}

// ─────────────────────────────────────────────────────────────────────────────
//  PROGRES BELAJAR (disimpan di memori selama aplikasi terbuka)
//  Mau permanen? Isi toggle() dengan shared_preferences (lihat panduan).
// ─────────────────────────────────────────────────────────────────────────────

class ProgresMateri extends ChangeNotifier {
  ProgresMateri._();
  static final ProgresMateri instance = ProgresMateri._();

  final Map<String, Set<int>> _selesai = {};

  int jumlah(String idMateri) => _selesai[idMateri]?.length ?? 0;
  bool sudah(String idMateri, int bagian) =>
      _selesai[idMateri]?.contains(bagian) ?? false;

  void toggle(String idMateri, int bagian) {
    final s = _selesai.putIfAbsent(idMateri, () => <int>{});
    if (!s.add(bagian)) s.remove(bagian);
    notifyListeners();
    // TODO (opsional): simpan ke shared_preferences di sini.
  }
}

// ─────────────────────────────────────────────────────────────────────────────
//  HALAMAN 1 – BANK MATERI + PENCARIAN
// ─────────────────────────────────────────────────────────────────────────────

class MateriBankPage extends StatefulWidget {
  final String judulKelas; // contoh: 'Kelas IX'
  final List<Materi> daftarMateri;

  const MateriBankPage({
    super.key,
    required this.judulKelas,
    required this.daftarMateri,
  });

  @override
  State<MateriBankPage> createState() => _MateriBankPageState();
}

class _MateriBankPageState extends State<MateriBankPage> {
  final _ctrl = TextEditingController();
  List<String> _token0 = [];

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  void _cari(String q) => setState(() => _token0 = _token(q));

  void _isi(String q) {
    _ctrl.text = q;
    _ctrl.selection = TextSelection.collapsed(offset: q.length);
    _cari(q);
  }

  List<Materi> get _hasil => _token0.isEmpty
      ? widget.daftarMateri
      : widget.daftarMateri.where((m) => m.cocok(_token0)).toList();

  List<String> get _saran {
    final s = <String>[];
    for (final m in widget.daftarMateri) {
      s.addAll(m.kataKunci.take(2));
    }
    return s;
  }

  void _buka(Materi m) {
    FocusScope.of(context).unfocus();
    Navigator.of(context).push(MaterialPageRoute(
      builder: (_) => MateriDetailPage(materi: m, kueri: _ctrl.text),
    ));
  }

  @override
  Widget build(BuildContext context) {
    final hasil = _hasil;
    final tema = Theme.of(context);
    final utama = tema.colorScheme.primary;
    final totalBagian =
        widget.daftarMateri.fold<int>(0, (a, m) => a + m.bagian.length);

    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: CustomScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          slivers: [
            // ── Kepala halaman
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(8, 4, 20, 0),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () => Navigator.maybePop(context),
                      icon: const Icon(Icons.arrow_back_rounded),
                      tooltip: 'Kembali',
                    ),
                    Expanded(
                      child: Text('Bank Materi ${widget.judulKelas}',
                          style: tema.textTheme.titleLarge
                              ?.copyWith(fontWeight: FontWeight.w800)),
                    ),
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 4, 20, 14),
                child: Text(
                  '${widget.daftarMateri.length} materi, $totalBagian bagian. '
                  'Ketik kata apa saja, misalnya “hoaks” atau “Pasal 31”.',
                  style: tema.textTheme.bodyMedium?.copyWith(
                      height: 1.4,
                      color: tema.textTheme.bodyMedium?.color
                          ?.withAlpha(190)),
                ),
              ),
            ),
            // ── Kolom pencarian
            SliverPersistentHeader(
              pinned: true,
              delegate: _PencarianDelegate(
                child: Container(
                  color: tema.scaffoldBackgroundColor,
                  padding: const EdgeInsets.fromLTRB(16, 6, 16, 10),
                  child: TextField(
                    controller: _ctrl,
                    onChanged: _cari,
                    textInputAction: TextInputAction.search,
                    decoration: InputDecoration(
                      hintText: 'Cari materi, pasal, atau kata kunci…',
                      prefixIcon: const Icon(Icons.search_rounded),
                      suffixIcon: _ctrl.text.isEmpty
                          ? null
                          : IconButton(
                              icon: const Icon(Icons.close_rounded),
                              tooltip: 'Hapus pencarian',
                              onPressed: () => _isi(''),
                            ),
                      filled: true,
                      fillColor: _tint(utama, _gelap(context) ? .18 : .08),
                      contentPadding: const EdgeInsets.symmetric(vertical: 0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(18),
                        borderSide: BorderSide.none,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(18),
                        borderSide: BorderSide(color: utama, width: 1.6),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            // ── Saran kata kunci
            if (_token0.isEmpty)
              SliverToBoxAdapter(
                child: SizedBox(
                  height: 44,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: _saran.length,
                    separatorBuilder: (_, __) => const SizedBox(width: 8),
                    itemBuilder: (_, i) => ActionChip(
                      label: Text(_saran[i]),
                      avatar: const Icon(Icons.north_west_rounded, size: 15),
                      onPressed: () => _isi(_saran[i]),
                    ),
                  ),
                ),
              )
            else
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 2, 20, 4),
                  child: Text(
                    hasil.isEmpty
                        ? 'Tidak ada materi yang cocok'
                        : '${hasil.length} materi cocok dengan “${_ctrl.text.trim()}”',
                    style: tema.textTheme.labelLarge,
                  ),
                ),
              ),
            // ── Daftar materi
            if (hasil.isEmpty)
              SliverFillRemaining(
                hasScrollBody: false,
                child: _KosongView(
                    saran: _saran.take(6).toList(), onPilih: _isi),
              )
            else
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(16, 10, 16, 32),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (c, i) => _MasukAnimasi(
                      key: ValueKey(hasil[i].id),
                      urutan: i,
                      child: _KartuMateri(
                        materi: hasil[i],
                        token: _token0,
                        onTap: () => _buka(hasil[i]),
                      ),
                    ),
                    childCount: hasil.length,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _PencarianDelegate extends SliverPersistentHeaderDelegate {
  final Widget child;
  _PencarianDelegate({required this.child});
  @override
  double get minExtent => 68;
  @override
  double get maxExtent => 68;
  @override
  Widget build(BuildContext c, double s, bool o) => child;
  @override
  bool shouldRebuild(covariant _PencarianDelegate old) => true;
}

class _MasukAnimasi extends StatelessWidget {
  final int urutan;
  final Widget child;
  const _MasukAnimasi({super.key, required this.urutan, required this.child});

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: 1),
      duration: Duration(milliseconds: 280 + urutan * 70),
      curve: Curves.easeOutCubic,
      builder: (_, v, c) => Opacity(
        opacity: v,
        child: Transform.translate(offset: Offset(0, 18 * (1 - v)), child: c),
      ),
      child: child,
    );
  }
}

class _KosongView extends StatelessWidget {
  final List<String> saran;
  final ValueChanged<String> onPilih;
  const _KosongView({required this.saran, required this.onPilih});

  @override
  Widget build(BuildContext context) {
    final tema = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.all(32),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.search_off_rounded,
              size: 72, color: _tint(tema.colorScheme.primary, .5)),
          const SizedBox(height: 12),
          Text('Belum ketemu',
              style: tema.textTheme.titleMedium
                  ?.copyWith(fontWeight: FontWeight.w700)),
          const SizedBox(height: 6),
          const Text(
            'Coba kata yang lebih singkat, atau pilih salah satu kata kunci di bawah ini.',
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            alignment: WrapAlignment.center,
            children: [
              for (final s in saran)
                ActionChip(label: Text(s), onPressed: () => onPilih(s)),
            ],
          ),
        ],
      ),
    );
  }
}

class _KartuMateri extends StatelessWidget {
  final Materi materi;
  final List<String> token;
  final VoidCallback onTap;
  const _KartuMateri(
      {required this.materi, required this.token, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final tema = Theme.of(context);
    final w = materi.warna;
    final aksen = _aksen(context, w);
    final judulGaya = tema.textTheme.titleMedium!
        .copyWith(fontWeight: FontWeight.w800, height: 1.25);
    final isiGaya = tema.textTheme.bodyMedium!.copyWith(height: 1.4);
    final sorot = _tint(const Color(0xFFFFC107), .55);
    final cuplik = materi.cuplik(token);
    final cocokBagian = token.isEmpty
        ? <int>[]
        : [
            for (var i = 0; i < materi.bagian.length; i++)
              if (_semuaToken(materi.bagian[i].cari, token)) i
          ];

    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Material(
        color: tema.cardColor,
        borderRadius: BorderRadius.circular(22),
        child: InkWell(
          borderRadius: BorderRadius.circular(22),
          onTap: onTap,
          child: Ink(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(22),
              border: Border.all(color: _tint(w, .35), width: 1.2),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 56,
                        height: 56,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(18),
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [w, _lebihGelap(w, .3)],
                          ),
                        ),
                        child: Icon(materi.ikon, color: Colors.white, size: 30),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Materi ${materi.nomor}',
                                style: tema.textTheme.labelMedium?.copyWith(
                                    color: aksen, fontWeight: FontWeight.w700)),
                            const SizedBox(height: 2),
                            Text.rich(TextSpan(
                                children: _sorot(materi.judulPendek, token,
                                    judulGaya, sorot))),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text.rich(
                    TextSpan(
                        children:
                            _sorot(materi.ringkasan, token, isiGaya, sorot)),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                  if (cuplik != null) ...[
                    const SizedBox(height: 10),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: _tint(w, .09),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text.rich(
                        TextSpan(
                            children: _sorot(
                                cuplik,
                                token,
                                isiGaya.copyWith(
                                    fontSize: 13, fontStyle: FontStyle.italic),
                                sorot)),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                  if (cocokBagian.isNotEmpty) ...[
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 6,
                      runSpacing: 6,
                      children: [
                        for (final i in cocokBagian.take(3))
                          Container(
                            constraints: const BoxConstraints(maxWidth: 240),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 4),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(color: _tint(w, .5)),
                            ),
                            child: Text(
                              materi.bagian[i].judul,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(fontSize: 11.5, color: aksen),
                            ),
                          ),
                      ],
                    ),
                  ],
                  const SizedBox(height: 12),
                  AnimatedBuilder(
                    animation: ProgresMateri.instance,
                    builder: (_, __) {
                      final j = ProgresMateri.instance.jumlah(materi.id);
                      final n = materi.bagian.length;
                      return Row(
                        children: [
                          Icon(Icons.timer_outlined,
                              size: 15, color: tema.hintColor),
                          const SizedBox(width: 4),
                          Text('${materi.menit} menit baca',
                              style: tema.textTheme.bodySmall),
                          const SizedBox(width: 14),
                          Expanded(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(6),
                              child: LinearProgressIndicator(
                                value: n == 0 ? 0 : j / n,
                                minHeight: 7,
                                color: w,
                                backgroundColor: _tint(w, .15),
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(j == n ? 'Tuntas' : '$j/$n',
                              style: tema.textTheme.bodySmall?.copyWith(
                                  fontWeight: FontWeight.w700,
                                  color: j == n ? Colors.green : null)),
                        ],
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
//  HALAMAN 2 – ISI MATERI PENUH
// ─────────────────────────────────────────────────────────────────────────────

class MateriDetailPage extends StatefulWidget {
  final Materi materi;
  final String kueri; // kata pencarian dari bank materi (boleh kosong)
  const MateriDetailPage({super.key, required this.materi, this.kueri = ''});

  @override
  State<MateriDetailPage> createState() => _MateriDetailPageState();
}

class _MateriDetailPageState extends State<MateriDetailPage> {
  late final List<GlobalKey> _keys;
  final Set<int> _buka = {};
  final _scroll = ScrollController();
  late final List<String> _token0;
  double _skala = 1.0;
  static const _skalaPilihan = [1.0, 1.15, 1.3, 0.9];

  Materi get m => widget.materi;

  @override
  void initState() {
    super.initState();
    _keys = List.generate(m.bagian.length, (_) => GlobalKey());
    _token0 = _token(widget.kueri);
    final cocok = <int>[
      if (_token0.isNotEmpty)
        for (var i = 0; i < m.bagian.length; i++)
          if (_semuaToken(m.bagian[i].cari, _token0)) i
    ];
    if (cocok.isNotEmpty) {
      _buka.addAll(cocok);
      WidgetsBinding.instance
          .addPostFrameCallback((_) => _gulirKe(cocok.first, tunda: 450));
    } else if (m.bagian.isNotEmpty) {
      _buka.add(0);
    }
  }

  @override
  void dispose() {
    _scroll.dispose();
    super.dispose();
  }

  void _gulirKe(int i, {int tunda = 120}) {
    Future.delayed(Duration(milliseconds: tunda), () {
      final ctx = _keys[i].currentContext;
      if (!mounted || ctx == null) return;
      Scrollable.ensureVisible(ctx,
          duration: const Duration(milliseconds: 450),
          curve: Curves.easeOutCubic,
          alignment: .08);
    });
  }

  void _lompat(int i) {
    setState(() => _buka.add(i));
    _gulirKe(i);
  }

  void _ubahUkuran() {
    final idx = _skalaPilihan.indexOf(_skala);
    setState(() => _skala = _skalaPilihan[(idx + 1) % _skalaPilihan.length]);
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(
        duration: const Duration(milliseconds: 900),
        content: Text('Ukuran teks ${(_skala * 100).round()}%'),
      ));
  }

  @override
  Widget build(BuildContext context) {
    final w = m.warna;
    final mq = MediaQuery.of(context);
    final tema = Theme.of(context);
    final n = m.bagian.length;

    return MediaQuery(
      data: mq.copyWith(
          textScaler: TextScaler.linear(_skala * mq.textScaler.scale(1))),
      child: Scaffold(
        body: CustomScrollView(
          controller: _scroll,
          slivers: [
            SliverAppBar(
              pinned: true,
              expandedHeight: 250,
              backgroundColor: _lebihGelap(w, .12),
              foregroundColor: Colors.white,
              title: Text('Materi ${m.nomor}',
                  style: const TextStyle(fontWeight: FontWeight.w700)),
              actions: [
                IconButton(
                  tooltip: 'Ubah ukuran teks',
                  icon: const Icon(Icons.text_fields_rounded),
                  onPressed: _ubahUkuran,
                ),
              ],
              bottom: PreferredSize(
                preferredSize: const Size.fromHeight(5),
                child: AnimatedBuilder(
                  animation: ProgresMateri.instance,
                  builder: (_, __) => LinearProgressIndicator(
                    value: n == 0
                        ? 0
                        : ProgresMateri.instance.jumlah(m.id) / n,
                    minHeight: 5,
                    color: const Color(0xFFFFD54F),
                    backgroundColor: Colors.white24,
                  ),
                ),
              ),
              flexibleSpace: FlexibleSpaceBar(
                collapseMode: CollapseMode.parallax,
                background: _KepalaMateri(materi: m),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 18, 16, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    BlokList(m.pembuka, w),
                    // ── Lompat ke bagian
                    Text('Isi materi',
                        style: tema.textTheme.titleMedium
                            ?.copyWith(fontWeight: FontWeight.w800)),
                    const SizedBox(height: 8),
                    SizedBox(
                      height: 40,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: n,
                        separatorBuilder: (_, __) => const SizedBox(width: 8),
                        itemBuilder: (_, i) => ActionChip(
                          avatar: CircleAvatar(
                            backgroundColor: w,
                            child: Text('${i + 1}',
                                style: const TextStyle(
                                    fontSize: 11, color: Colors.white)),
                          ),
                          label: ConstrainedBox(
                            constraints: const BoxConstraints(maxWidth: 170),
                            child: Text(m.bagian[i].judul,
                                maxLines: 1, overflow: TextOverflow.ellipsis),
                          ),
                          onPressed: () => _lompat(i),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton.icon(
                        onPressed: () => setState(() {
                          if (_buka.length == n) {
                            _buka.clear();
                          } else {
                            _buka.addAll(List.generate(n, (i) => i));
                          }
                        }),
                        icon: Icon(
                            _buka.length == n
                                ? Icons.unfold_less_rounded
                                : Icons.unfold_more_rounded,
                            size: 20),
                        label: Text(_buka.length == n
                            ? 'Tutup semua'
                            : 'Buka semua'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
              sliver: SliverToBoxAdapter(
                child: AnimatedBuilder(
                  animation: ProgresMateri.instance,
                  builder: (_, __) => Column(
                    children: [
                      for (var i = 0; i < n; i++)
                        KeyedSubtree(
                          key: _keys[i],
                          child: _BagianCard(
                            no: i + 1,
                            bagian: m.bagian[i],
                            warna: w,
                            token: _token0,
                            buka: _buka.contains(i),
                            selesai: ProgresMateri.instance.sudah(m.id, i),
                            onToggle: () => setState(() {
                              if (!_buka.add(i)) _buka.remove(i);
                            }),
                            onSelesai: () {
                              HapticFeedback.lightImpact();
                              ProgresMateri.instance.toggle(m.id, i);
                              final lanjut = i + 1;
                              if (ProgresMateri.instance.sudah(m.id, i) &&
                                  lanjut < n) {
                                setState(() => _buka
                                  ..remove(i)
                                  ..add(lanjut));
                                _gulirKe(lanjut, tunda: 250);
                              }
                            },
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 40),
                child: _PenutupMateri(materi: m),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _KepalaMateri extends StatelessWidget {
  final Materi materi;
  const _KepalaMateri({required this.materi});

  Widget _chip(String t, IconData i) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
          color: Colors.white.withAlpha(46),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(mainAxisSize: MainAxisSize.min, children: [
          Icon(i, size: 14, color: Colors.white),
          const SizedBox(width: 5),
          Text(t, style: const TextStyle(color: Colors.white, fontSize: 12)),
        ]),
      );

  @override
  Widget build(BuildContext context) {
    final w = materi.warna;
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [w, _lebihGelap(w, .38)],
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            right: -30,
            top: 20,
            child: Icon(materi.ikon,
                size: 190, color: Colors.white.withAlpha(30)),
          ),
          Positioned(
            left: 20,
            right: 20,
            bottom: 22,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Wrap(spacing: 8, runSpacing: 6, children: [
                  _chip('${materi.bagian.length} bagian',
                      Icons.layers_outlined),
                  _chip('±${materi.menit} menit', Icons.timer_outlined),
                ]),
                const SizedBox(height: 10),
                Text(
                  materi.judul,
                  maxLines: 4,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 19,
                    height: 1.25,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _PenutupMateri extends StatelessWidget {
  final Materi materi;
  const _PenutupMateri({required this.materi});

  @override
  Widget build(BuildContext context) {
    final w = materi.warna;
    return AnimatedBuilder(
      animation: ProgresMateri.instance,
      builder: (_, __) {
        final tuntas = ProgresMateri.instance.jumlah(materi.id) ==
            materi.bagian.length;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 400),
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            gradient: LinearGradient(
              colors: tuntas
                  ? [const Color(0xFF2E7D32), const Color(0xFF1B5E20)]
                  : [w, _lebihGelap(w, .3)],
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(children: [
                Icon(tuntas ? Icons.emoji_events_rounded : Icons.format_quote,
                    color: const Color(0xFFFFD54F), size: 30),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                      tuntas ? 'Materi ini tuntas!' : 'Pesan penutup',
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 17,
                          fontWeight: FontWeight.w800)),
                ),
              ]),
              const SizedBox(height: 10),
              Text(materi.penutup,
                  style: const TextStyle(
                      color: Colors.white, height: 1.55, fontSize: 15)),
              if (tuntas) ...[
                const SizedBox(height: 14),
                Text(
                    'Semua ${materi.bagian.length} bagian sudah kamu tandai paham. Lanjut ke materi berikutnya atau uji dirimu di menu Kuis.',
                    style: TextStyle(
                        color: Colors.white.withAlpha(220),
                        height: 1.5,
                        fontSize: 13.5)),
              ],
            ],
          ),
        );
      },
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
//  KARTU BAGIAN (bisa dibuka-tutup)
// ─────────────────────────────────────────────────────────────────────────────

class _BagianCard extends StatelessWidget {
  final int no;
  final Bagian bagian;
  final Color warna;
  final List<String> token;
  final bool buka;
  final bool selesai;
  final VoidCallback onToggle;
  final VoidCallback onSelesai;

  const _BagianCard({
    required this.no,
    required this.bagian,
    required this.warna,
    required this.token,
    required this.buka,
    required this.selesai,
    required this.onToggle,
    required this.onSelesai,
  });

  @override
  Widget build(BuildContext context) {
    final tema = Theme.of(context);
    final aksen = _aksen(context, warna);
    const hijau = Color(0xFF2E7D32);
    final judulGaya = tema.textTheme.titleMedium!
        .copyWith(fontWeight: FontWeight.w800, height: 1.25);

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: tema.cardColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: selesai ? _tint(hijau, .6) : _tint(warna, buka ? .55 : .25),
          width: buka ? 1.6 : 1.1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          InkWell(
            borderRadius: BorderRadius.circular(20),
            onTap: onToggle,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(14, 14, 10, 14),
              child: Row(
                children: [
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 250),
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: selesai ? hijau : warna,
                    ),
                    child: selesai
                        ? const Icon(Icons.check_rounded,
                            color: Colors.white, size: 22)
                        : Icon(bagian.ikon, color: Colors.white, size: 20),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Bagian $no',
                            style: tema.textTheme.labelSmall
                                ?.copyWith(color: aksen)),
                        Text.rich(TextSpan(
                            children: _sorot(bagian.judul, token, judulGaya,
                                _tint(const Color(0xFFFFC107), .55)))),
                      ],
                    ),
                  ),
                  AnimatedRotation(
                    turns: buka ? .5 : 0,
                    duration: const Duration(milliseconds: 250),
                    child: Icon(Icons.keyboard_arrow_down_rounded,
                        size: 28, color: aksen),
                  ),
                ],
              ),
            ),
          ),
          AnimatedSize(
            duration: const Duration(milliseconds: 280),
            curve: Curves.easeOutCubic,
            alignment: Alignment.topCenter,
            child: buka
                ? Padding(
                    padding: const EdgeInsets.fromLTRB(14, 2, 14, 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        BlokList(bagian.blok, warna),
                        selesai
                            ? OutlinedButton.icon(
                                onPressed: onSelesai,
                                icon: const Icon(Icons.undo_rounded),
                                label: const Text('Batalkan tanda paham'),
                              )
                            : FilledButton.icon(
                                style: FilledButton.styleFrom(
                                    backgroundColor: warna,
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 14)),
                                onPressed: onSelesai,
                                icon: const Icon(Icons.check_circle_outline),
                                label: const Text('Saya sudah paham'),
                              ),
                      ],
                    ),
                  )
                : const SizedBox(width: double.infinity),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
//  RENDER BLOK
// ─────────────────────────────────────────────────────────────────────────────

class BlokList extends StatelessWidget {
  final List<Blok> blok;
  final Color warna;
  const BlokList(this.blok, this.warna, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        for (final b in blok)
          Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: BlokView(b, warna),
          ),
      ],
    );
  }
}

class BlokView extends StatelessWidget {
  final Blok blok;
  final Color warna;
  const BlokView(this.blok, this.warna, {super.key});

  @override
  Widget build(BuildContext context) {
    final b = blok;
    if (b is Teks) return _TeksView(b.isi, warna);
    if (b is Poin) return _PoinView(b, warna);
    if (b is Callout) return _CalloutView(b);
    if (b is Gambar) return _GambarView(b, warna);
    if (b is KartuBalik) return _KartuBalikView(b, warna);
    if (b is TabKonten) return _TabView(b, warna);
    if (b is TabelPasal) return _PasalView(b, warna);
    if (b is KuisMini) return _KuisView(b, warna);
    if (b is Kutipan) return _KutipanView(b, warna);
    if (b is Ceklis) return _CeklisView(b, warna);
    if (b is RumahPilar) return _RumahView(b, warna);
    return const SizedBox.shrink();
  }
}

class _TeksView extends StatelessWidget {
  final String isi;
  final Color warna;
  const _TeksView(this.isi, this.warna);

  @override
  Widget build(BuildContext context) {
    return Text.rich(TextSpan(
        children: _spans(isi, _gayaTeks(context), _aksen(context, warna))));
  }
}

class _PoinView extends StatelessWidget {
  final Poin data;
  final Color warna;
  const _PoinView(this.data, this.warna);

  @override
  Widget build(BuildContext context) {
    final gaya = _gayaTeks(context);
    final aksen = _aksen(context, warna);
    return Column(
      children: [
        for (var i = 0; i < data.item.length; i++)
          Padding(
            padding: EdgeInsets.only(bottom: i == data.item.length - 1 ? 0 : 12),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 28,
                  height: 28,
                  margin: const EdgeInsets.only(top: 1),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle, color: _tint(warna, .16)),
                  child: Center(
                    child: data.item[i].ikon != null
                        ? Icon(data.item[i].ikon, size: 16, color: aksen)
                        : data.bernomor
                            ? Text('${i + 1}',
                                style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w800,
                                    color: aksen))
                            : Icon(Icons.circle, size: 8, color: aksen),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (data.item[i].judul != null)
                        Text(data.item[i].judul!,
                            style: gaya.copyWith(
                                fontWeight: FontWeight.w800, height: 1.35)),
                      Text.rich(TextSpan(
                          children: _spans(data.item[i].isi, gaya, aksen))),
                    ],
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}

class _InfoCallout {
  final IconData ikon;
  final String label;
  final Color warna;
  const _InfoCallout(this.ikon, this.label, this.warna);
}

_InfoCallout _infoCallout(JenisCallout j) {
  switch (j) {
    case JenisCallout.tahukah:
      return const _InfoCallout(
          Icons.lightbulb_rounded, 'Tahukah kamu?', Color(0xFFF9A825));
    case JenisCallout.penting:
      return const _InfoCallout(
          Icons.priority_high_rounded, 'Penting diingat', Color(0xFFD32F2F));
    case JenisCallout.contoh:
      return const _InfoCallout(
          Icons.pin_drop_rounded, 'Contoh nyata', Color(0xFF00897B));
    case JenisCallout.analogi:
      return const _InfoCallout(
          Icons.auto_awesome_rounded, 'Bayangkan', Color(0xFF5E35B1));
    case JenisCallout.ringkas:
      return const _InfoCallout(
          Icons.bookmark_rounded, 'Intinya', Color(0xFF1E88E5));
    case JenisCallout.tips:
      return const _InfoCallout(
          Icons.tips_and_updates_rounded, 'Tips', Color(0xFF43A047));
  }
}

class _CalloutView extends StatelessWidget {
  final Callout data;
  const _CalloutView(this.data);

  @override
  Widget build(BuildContext context) {
    final info = _infoCallout(data.jenis);
    final aksen = _aksen(context, info.warna);
    return Container(
      padding: const EdgeInsets.fromLTRB(14, 14, 14, 14),
      decoration: BoxDecoration(
        color: _tint(info.warna, _gelap(context) ? .16 : .09),
        borderRadius: BorderRadius.circular(16),
        border: Border(left: BorderSide(color: info.warna, width: 5)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(children: [
            Icon(info.ikon, size: 20, color: aksen),
            const SizedBox(width: 8),
            Expanded(
              child: Text(data.judul ?? info.label,
                  style: TextStyle(
                      fontWeight: FontWeight.w800, fontSize: 14.5, color: aksen)),
            ),
          ]),
          const SizedBox(height: 8),
          Text.rich(TextSpan(
              children: _spans(data.isi, _gayaTeks(context), aksen))),
        ],
      ),
    );
  }
}

class _GambarView extends StatelessWidget {
  final Gambar data;
  final Color warna;
  const _GambarView(this.data, this.warna);

  Widget _placeholder(BuildContext context) {
    final aksen = _aksen(context, warna);
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        color: _tint(warna, .08),
        border: Border.all(color: _tint(warna, .45), width: 1.4),
      ),
      padding: const EdgeInsets.all(16),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.image_outlined, size: 40, color: aksen),
            const SizedBox(height: 6),
            Text(data.deskripsi,
                textAlign: TextAlign.center,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    fontSize: 13, fontStyle: FontStyle.italic, color: aksen)),
            const SizedBox(height: 2),
            Text('(tempat gambar)',
                style: TextStyle(fontSize: 11, color: _tint(aksen, .7))),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final imgWidget = AspectRatio(
      aspectRatio: data.rasio,
      child: data.asset == null
          ? _placeholder(context)
          : ClipRRect(
              borderRadius: BorderRadius.circular(18),
              child: Image.asset(
                data.asset!,
                fit: BoxFit.cover,
                errorBuilder: (c, _, __) => _placeholder(c),
              ),
            ),
    );

    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (ctx) => Dialog(
            backgroundColor: Colors.black87,
            insetPadding: EdgeInsets.zero,
            child: Stack(
              children: [
                Center(
                  child: InteractiveViewer(
                    minScale: 0.5,
                    maxScale: 4.0,
                    child: data.asset == null
                        ? Container(
                            padding: const EdgeInsets.all(24),
                            color: Colors.white,
                            child: Text(data.deskripsi,
                                style: const TextStyle(
                                    color: Colors.black, fontSize: 18)),
                          )
                        : Image.asset(data.asset!),
                  ),
                ),
                Positioned(
                  top: 40,
                  right: 20,
                  child: IconButton(
                    icon: const Icon(Icons.close, color: Colors.white, size: 30),
                    onPressed: () => Navigator.of(ctx).pop(),
                  ),
                ),
                Positioned(
                  bottom: 30,
                  left: 20,
                  right: 20,
                  child: Text(
                    data.deskripsi,
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.white, fontSize: 14),
                  ),
                ),
              ],
            ),
          ),
        );
      },
      child: imgWidget,
    );
  }
}

class _KutipanView extends StatelessWidget {
  final Kutipan data;
  final Color warna;
  const _KutipanView(this.data, this.warna);

  @override
  Widget build(BuildContext context) {
    final aksen = _aksen(context, warna);
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 14),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: _tint(warna, .07),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.format_quote_rounded, size: 30, color: aksen),
          Text(data.isi,
              style: _gayaTeks(context).copyWith(
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.w600,
                  fontSize: 16.5)),
          if (data.sumber != null) ...[
            const SizedBox(height: 8),
            Text(data.sumber!,
                style: TextStyle(
                    fontSize: 12.5, fontWeight: FontWeight.w700, color: aksen)),
          ],
        ],
      ),
    );
  }
}

// ── Kartu balik ──────────────────────────────────────────────────────────────

class _KartuBalikView extends StatelessWidget {
  final KartuBalik data;
  final Color warna;
  const _KartuBalikView(this.data, this.warna);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Row(children: [
            Icon(Icons.touch_app_rounded,
                size: 18, color: _aksen(context, warna)),
            const SizedBox(width: 6),
            Expanded(
              child: Text(data.petunjuk ?? 'Ketuk kartu untuk membaliknya',
                  style: Theme.of(context).textTheme.bodySmall),
            ),
          ]),
        ),
        for (var i = 0; i < data.kartu.length; i++)
          Padding(
            padding: EdgeInsets.only(bottom: i == data.kartu.length - 1 ? 0 : 10),
            child: _FlipCard(item: data.kartu[i], warna: warna),
          ),
      ],
    );
  }
}

class _FlipCard extends StatefulWidget {
  final ItemKartu item;
  final Color warna;
  const _FlipCard({required this.item, required this.warna});

  @override
  State<_FlipCard> createState() => _FlipCardState();
}

class _FlipCardState extends State<_FlipCard>
    with SingleTickerProviderStateMixin {
  late final AnimationController _c = AnimationController(
      vsync: this, duration: const Duration(milliseconds: 450));

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  void _balik() {
    HapticFeedback.selectionClick();
    _c.isCompleted || _c.velocity > 0 ? _c.reverse() : _c.forward();
  }

  Widget _isiDepan(Color teks) => Padding(
        padding: const EdgeInsets.all(16),
        child: Row(children: [
          Expanded(
            child: Text(widget.item.depan,
                style: TextStyle(
                    color: teks,
                    fontWeight: FontWeight.w800,
                    fontSize: 16,
                    height: 1.3)),
          ),
          Icon(Icons.flip_rounded, color: teks.withAlpha(200)),
        ]),
      );

  Widget _isiBelakang(Color teks) => Padding(
        padding: const EdgeInsets.all(16),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text.rich(TextSpan(
              children: _spans(
                  widget.item.belakang,
                  TextStyle(color: teks, fontSize: 14.5, height: 1.5),
                  teks))),
        ),
      );

  Widget _muka(double sudut, bool tampak, Widget isi, BoxDecoration dekor) {
    return Positioned.fill(
      child: Opacity(
        opacity: tampak ? 1 : 0,
        child: Transform(
          alignment: Alignment.center,
          transform: Matrix4.identity()
            ..setEntry(3, 2, 0.0012)
            ..rotateY(sudut),
          child: Container(decoration: dekor, child: isi),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final w = widget.warna;
    final warnaTeksBelakang = Theme.of(context).textTheme.bodyMedium?.color ??
        (_gelap(context) ? Colors.white : Colors.black87);

    return GestureDetector(
      onTap: _balik,
      child: AnimatedBuilder(
        animation: _c,
        builder: (_, __) {
          final sudut = Curves.easeInOut.transform(_c.value) * math.pi;
          final depan = sudut < math.pi / 2;
          return Stack(
            children: [
              // pengukur tinggi (tak terlihat): mengikuti sisi yang paling tinggi
              IgnorePointer(
                child: Opacity(
                  opacity: 0,
                  child: Stack(children: [
                    _isiDepan(Colors.white),
                    _isiBelakang(warnaTeksBelakang),
                  ]),
                ),
              ),
              _muka(
                sudut,
                depan,
                _isiDepan(Colors.white),
                BoxDecoration(
                  borderRadius: BorderRadius.circular(18),
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [w, _lebihGelap(w, .3)],
                  ),
                ),
              ),
              _muka(
                sudut + math.pi,
                !depan,
                _isiBelakang(warnaTeksBelakang),
                BoxDecoration(
                  borderRadius: BorderRadius.circular(18),
                  color: _tint(w, _gelap(context) ? .2 : .1),
                  border: Border.all(color: _tint(w, .6), width: 1.4),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

// ── Tab konten ───────────────────────────────────────────────────────────────

class _TabView extends StatefulWidget {
  final TabKonten data;
  final Color warna;
  const _TabView(this.data, this.warna);

  @override
  State<_TabView> createState() => _TabViewState();
}

class _TabViewState extends State<_TabView> {
  int _i = 0;

  @override
  Widget build(BuildContext context) {
    final w = widget.warna;
    final aksen = _aksen(context, w);
    final tab = widget.data.tab;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              for (var i = 0; i < tab.length; i++)
                Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: GestureDetector(
                    onTap: () {
                      HapticFeedback.selectionClick();
                      setState(() => _i = i);
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 220),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 14, vertical: 10),
                      decoration: BoxDecoration(
                        color: _i == i ? w : Colors.transparent,
                        borderRadius: BorderRadius.circular(24),
                        border: Border.all(color: _i == i ? w : _tint(w, .5)),
                      ),
                      child: Row(children: [
                        Icon(tab[i].ikon,
                            size: 18, color: _i == i ? Colors.white : aksen),
                        const SizedBox(width: 6),
                        Text(tab[i].label,
                            style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 13.5,
                                color: _i == i ? Colors.white : aksen)),
                      ]),
                    ),
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        AnimatedSize(
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeOutCubic,
          alignment: Alignment.topCenter,
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 220),
            child: Container(
              key: ValueKey(_i),
              padding: const EdgeInsets.fromLTRB(14, 14, 14, 0),
              decoration: BoxDecoration(
                color: _tint(w, _gelap(context) ? .12 : .06),
                borderRadius: BorderRadius.circular(18),
              ),
              child: BlokList(tab[_i].isi, w),
            ),
          ),
        ),
      ],
    );
  }
}

// ── Tabel pasal ──────────────────────────────────────────────────────────────

class _PasalView extends StatelessWidget {
  final TabelPasal data;
  final Color warna;
  const _PasalView(this.data, this.warna);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (var i = 0; i < data.baris.length; i++)
          _PasalTile(item: data.baris[i], warna: warna, awalBuka: i == 0),
      ],
    );
  }
}

class _PasalTile extends StatefulWidget {
  final ItemPasal item;
  final Color warna;
  final bool awalBuka;
  const _PasalTile(
      {required this.item, required this.warna, required this.awalBuka});

  @override
  State<_PasalTile> createState() => _PasalTileState();
}

class _PasalTileState extends State<_PasalTile> {
  late bool _buka = widget.awalBuka;

  Widget _kolom(BuildContext c, IconData ikon, String label, String isi,
      Color warna) {
    final a = _aksen(c, warna);
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: _tint(warna, _gelap(c) ? .16 : .09),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(children: [
            Icon(ikon, size: 18, color: a),
            const SizedBox(width: 6),
            Text(label,
                style: TextStyle(
                    fontWeight: FontWeight.w800, fontSize: 13.5, color: a)),
          ]),
          const SizedBox(height: 6),
          Text(isi, style: _gayaTeks(c).copyWith(fontSize: 14.5)),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final w = widget.warna;
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        border: Border.all(color: _tint(w, _buka ? .6 : .3)),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          InkWell(
            borderRadius: BorderRadius.circular(16),
            onTap: () => setState(() => _buka = !_buka),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
              child: Row(children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                      color: w, borderRadius: BorderRadius.circular(10)),
                  child: Text(widget.item.pasal,
                      style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w800,
                          fontSize: 13)),
                ),
                const Spacer(),
                AnimatedRotation(
                  turns: _buka ? .5 : 0,
                  duration: const Duration(milliseconds: 220),
                  child: Icon(Icons.keyboard_arrow_down_rounded,
                      color: _aksen(context, w)),
                ),
              ]),
            ),
          ),
          AnimatedSize(
            duration: const Duration(milliseconds: 240),
            alignment: Alignment.topCenter,
            child: _buka
                ? Padding(
                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                    child: Column(children: [
                      _kolom(context, Icons.verified_user_rounded, 'Hak',
                          widget.item.hak, const Color(0xFF2E7D32)),
                      const SizedBox(height: 8),
                      _kolom(context, Icons.assignment_turned_in_rounded,
                          'Kewajiban', widget.item.kewajiban,
                          const Color(0xFFEF6C00)),
                    ]),
                  )
                : const SizedBox(width: double.infinity),
          ),
        ],
      ),
    );
  }
}

// ── Kuis mini ────────────────────────────────────────────────────────────────

class _KuisView extends StatefulWidget {
  final KuisMini data;
  final Color warna;
  const _KuisView(this.data, this.warna);

  @override
  State<_KuisView> createState() => _KuisViewState();
}

class _KuisViewState extends State<_KuisView> {
  int? _pilih;

  @override
  Widget build(BuildContext context) {
    final d = widget.data;
    final w = widget.warna;
    final aksen = _aksen(context, w);
    final selesai = _pilih != null;
    final benar = _pilih == d.benar;
    const hijau = Color(0xFF2E7D32);
    const merah = Color(0xFFC62828);

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: _tint(w, .5), width: 1.4),
        color: _tint(w, .05),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(children: [
            Icon(Icons.bolt_rounded, color: aksen),
            const SizedBox(width: 6),
            Text('Cek pemahaman',
                style: TextStyle(fontWeight: FontWeight.w800, color: aksen)),
          ]),
          const SizedBox(height: 8),
          Text(d.tanya,
              style: _gayaTeks(context)
                  .copyWith(fontWeight: FontWeight.w700, height: 1.45)),
          const SizedBox(height: 10),
          for (var i = 0; i < d.opsi.length; i++)
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: _opsi(context, i, hijau, merah, selesai),
            ),
          AnimatedSize(
            duration: const Duration(milliseconds: 250),
            alignment: Alignment.topCenter,
            child: !selesai
                ? const SizedBox(width: double.infinity)
                : Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: _tint(benar ? hijau : merah, .1),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(benar ? 'Tepat sekali!' : 'Belum tepat.',
                            style: TextStyle(
                                fontWeight: FontWeight.w800,
                                color: _aksen(context, benar ? hijau : merah))),
                        const SizedBox(height: 4),
                        Text(d.penjelasan,
                            style: _gayaTeks(context).copyWith(fontSize: 14.5)),
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton.icon(
                            onPressed: () => setState(() => _pilih = null),
                            icon: const Icon(Icons.refresh_rounded, size: 18),
                            label: const Text('Coba lagi'),
                          ),
                        ),
                      ],
                    ),
                  ),
          ),
        ],
      ),
    );
  }

  Widget _opsi(BuildContext context, int i, Color hijau, Color merah,
      bool selesai) {
    final d = widget.data;
    final dipilih = _pilih == i;
    final adalahBenar = i == d.benar;
    Color? warna;
    IconData? ikon;
    if (selesai) {
      if (adalahBenar) {
        warna = hijau;
        ikon = Icons.check_circle_rounded;
      } else if (dipilih) {
        warna = merah;
        ikon = Icons.cancel_rounded;
      }
    }
    final w = warna ?? widget.warna;
    return Material(
      color: warna != null ? _tint(warna, .14) : Theme.of(context).cardColor,
      borderRadius: BorderRadius.circular(14),
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: selesai
            ? null
            : () {
                HapticFeedback.selectionClick();
                setState(() => _pilih = i);
              },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 11),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
                color: warna ?? _tint(w, .35), width: warna != null ? 1.6 : 1),
          ),
          child: Row(children: [
            Container(
              width: 26,
              height: 26,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  shape: BoxShape.circle, color: _tint(w, .15)),
              child: ikon != null
                  ? Icon(ikon, size: 20, color: warna)
                  : Text(String.fromCharCode(65 + i),
                      style: TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: 12.5,
                          color: _aksen(context, w))),
            ),
            const SizedBox(width: 10),
            Expanded(
                child: Text(d.opsi[i],
                    style: _gayaTeks(context)
                        .copyWith(fontSize: 14.5, height: 1.4))),
          ]),
        ),
      ),
    );
  }
}

// ── Ceklis refleksi ──────────────────────────────────────────────────────────

class _CeklisView extends StatefulWidget {
  final Ceklis data;
  final Color warna;
  const _CeklisView(this.data, this.warna);

  @override
  State<_CeklisView> createState() => _CeklisViewState();
}

class _CeklisViewState extends State<_CeklisView> {
  late final List<bool> _centang =
      List<bool>.filled(widget.data.item.length, false);

  @override
  Widget build(BuildContext context) {
    final d = widget.data;
    final w = widget.warna;
    final aksen = _aksen(context, w);
    final j = _centang.where((e) => e).length;
    final tuntas = j == d.item.length;

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: _tint(w, .5), width: 1.4),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(children: [
            Icon(Icons.checklist_rounded, color: aksen),
            const SizedBox(width: 8),
            Expanded(
              child: Text(d.judul,
                  style: TextStyle(
                      fontWeight: FontWeight.w800, fontSize: 15, color: aksen)),
            ),
          ]),
          const SizedBox(height: 6),
          for (var i = 0; i < d.item.length; i++)
            InkWell(
              borderRadius: BorderRadius.circular(12),
              onTap: () {
                HapticFeedback.selectionClick();
                setState(() => _centang[i] = !_centang[i]);
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 7),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 180),
                      width: 24,
                      height: 24,
                      margin: const EdgeInsets.only(top: 1),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: _centang[i] ? w : Colors.transparent,
                        border: Border.all(color: w, width: 1.8),
                      ),
                      child: _centang[i]
                          ? const Icon(Icons.check_rounded,
                              size: 17, color: Colors.white)
                          : null,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(d.item[i],
                          style: _gayaTeks(context).copyWith(
                              fontSize: 14.5,
                              decoration: _centang[i]
                                  ? TextDecoration.lineThrough
                                  : null,
                              decorationColor: aksen)),
                    ),
                  ],
                ),
              ),
            ),
          const SizedBox(height: 8),
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: LinearProgressIndicator(
              value: j / d.item.length,
              minHeight: 7,
              color: tuntas ? const Color(0xFF2E7D32) : w,
              backgroundColor: _tint(w, .15),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            tuntas
                ? d.pesanSelesai
                : j == 0
                    ? 'Ketuk yang sudah pernah kamu lakukan.'
                    : '$j dari ${d.item.length} sudah kamu lakukan.',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                fontWeight: FontWeight.w700,
                color: tuntas ? const Color(0xFF2E7D32) : null),
          ),
        ],
      ),
    );
  }
}

// ── Rumah pilar ──────────────────────────────────────────────────────────────

class _AtapPainter extends CustomPainter {
  final Color warna;
  final bool aktif;
  _AtapPainter(this.warna, this.aktif);

  @override
  void paint(Canvas canvas, Size s) {
    final p = Path()
      ..moveTo(0, s.height)
      ..lineTo(s.width / 2, 0)
      ..lineTo(s.width, s.height)
      ..close();
    canvas.drawPath(
        p,
        Paint()
          ..color = aktif ? warna : _tint(warna, .22)
          ..style = PaintingStyle.fill);
    canvas.drawPath(
        p,
        Paint()
          ..color = warna
          ..style = PaintingStyle.stroke
          ..strokeWidth = 2.5
          ..strokeJoin = StrokeJoin.round);
  }

  @override
  bool shouldRepaint(covariant _AtapPainter o) =>
      o.warna != warna || o.aktif != aktif;
}

class _RumahView extends StatefulWidget {
  final RumahPilar data;
  final Color warna;
  const _RumahView(this.data, this.warna);

  @override
  State<_RumahView> createState() => _RumahViewState();
}

class _RumahViewState extends State<_RumahView> {
  int? _pilih; // 0 atap, 1 kiri, 2 kanan, 3 pondasi

  List<ItemTab> get _semua => [
        widget.data.atap,
        widget.data.tiangKiri,
        widget.data.tiangKanan,
        widget.data.pondasi,
      ];

  void _ketuk(int i) {
    HapticFeedback.selectionClick();
    setState(() => _pilih = _pilih == i ? null : i);
  }

  Widget _bagian(int i, {double? tinggi}) {
    final t = _semua[i];
    final w = widget.warna;
    final aktif = _pilih == i;
    return GestureDetector(
      onTap: () => _ketuk(i),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 220),
        height: tinggi,
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 10),
        decoration: BoxDecoration(
          color: aktif ? w : _tint(w, _gelap(context) ? .22 : .12),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: w, width: 1.6),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(t.ikon, color: aktif ? Colors.white : _aksen(context, w)),
            const SizedBox(height: 4),
            Text(t.label,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 13,
                    height: 1.2,
                    fontWeight: FontWeight.w800,
                    color: aktif ? Colors.white : _aksen(context, w))),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final w = widget.warna;
    final aksen = _aksen(context, w);
    final tema = Theme.of(context);
    final atap = widget.data.atap;

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: _tint(w, .4), width: 1.4),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(children: [
            Icon(Icons.touch_app_rounded, size: 18, color: aksen),
            const SizedBox(width: 6),
            Expanded(
              child: Text('Rumah kebangsaan: ketuk tiap bagiannya',
                  style: tema.textTheme.bodySmall
                      ?.copyWith(fontWeight: FontWeight.w700)),
            ),
          ]),
          const SizedBox(height: 12),
          // atap
          GestureDetector(
            onTap: () => _ketuk(0),
            child: SizedBox(
              height: 84,
              child: CustomPaint(
                painter: _AtapPainter(w, _pilih == 0),
                child: Align(
                  alignment: const Alignment(0, .55),
                  child: Text(atap.label,
                      style: TextStyle(
                          fontWeight: FontWeight.w900,
                          fontSize: 17,
                          color: _pilih == 0 ? Colors.white : aksen)),
                ),
              ),
            ),
          ),
          const SizedBox(height: 6),
          // dua tiang
          Row(children: [
            Expanded(child: _bagian(1, tinggi: 86)),
            const SizedBox(width: 8),
            Expanded(child: _bagian(2, tinggi: 86)),
          ]),
          const SizedBox(height: 6),
          // pondasi
          _bagian(3, tinggi: 60),
          const SizedBox(height: 12),
          AnimatedSize(
            duration: const Duration(milliseconds: 250),
            curve: Curves.easeOutCubic,
            alignment: Alignment.topCenter,
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 220),
              child: _pilih == null
                  ? const SizedBox(key: ValueKey('kosong'), width: double.infinity)
                  : Container(
                      key: ValueKey(_pilih),
                      padding: const EdgeInsets.fromLTRB(14, 14, 14, 0),
                      decoration: BoxDecoration(
                        color: _tint(w, _gelap(context) ? .16 : .08),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(_semua[_pilih!].label,
                              style: TextStyle(
                                  fontWeight: FontWeight.w900,
                                  fontSize: 16,
                                  color: aksen)),
                          const SizedBox(height: 6),
                          BlokList(_semua[_pilih!].isi, w),
                        ],
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
