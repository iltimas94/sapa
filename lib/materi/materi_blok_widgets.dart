// =============================================================================
// materi_blok_widgets.dart
// Semua widget yang merender blok konten (linimasa, kartu balik, tab, kuis, dll.)
// Tanpa package tambahan. Aman untuk HP (layout responsif, area sentuh besar).
// =============================================================================
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'materi_model.dart';

// ─────────────────────────────────────────────────────────────────────────────
// UTILITAS WARNA
// ─────────────────────────────────────────────────────────────────────────────
Color alfa(Color c, double o) =>
    c.withAlpha((o.clamp(0.0, 1.0) * 255).round());

Color gelapkan(Color c, [double d = 0.12]) {
  final h = HSLColor.fromColor(c);
  return h.withLightness((h.lightness - d).clamp(0.0, 1.0)).toColor();
}

Color terangkan(Color c, [double d = 0.12]) {
  final h = HSLColor.fromColor(c);
  return h.withLightness((h.lightness + d).clamp(0.0, 1.0)).toColor();
}

// ─────────────────────────────────────────────────────────────────────────────
// SCOPE: warna materi, skala huruf, kata yang disorot
// ─────────────────────────────────────────────────────────────────────────────
class MateriScope extends InheritedWidget {
  final Color warna;
  final double skala;
  final List<String> kataCari;

  const MateriScope({
    super.key,
    required this.warna,
    required this.skala,
    required this.kataCari,
    required super.child,
  });

  static MateriScope of(BuildContext context) {
    final s = context.dependOnInheritedWidgetOfExactType<MateriScope>();
    assert(s != null, 'MateriScope tidak ditemukan di atas widget ini');
    return s!;
  }

  @override
  bool updateShouldNotify(MateriScope old) =>
      warna != old.warna || skala != old.skala || kataCari != old.kataCari;
}

// ─────────────────────────────────────────────────────────────────────────────
// TEKS KAYA: **tebal** + sorot hasil pencarian
// ─────────────────────────────────────────────────────────────────────────────
const Color _warnaSorot = Color(0xFFFFE082);

List<InlineSpan> bangunSpan(
    String teks, TextStyle dasar, List<String> cari) {
  final out = <InlineSpan>[];
  final bagian = teks.split('**');
  for (var i = 0; i < bagian.length; i++) {
    final seg = bagian[i];
    if (seg.isEmpty) continue;
    final gaya = i.isOdd ? dasar.copyWith(fontWeight: FontWeight.w700) : dasar;
    out.addAll(_sorot(seg, gaya, cari));
  }
  return out;
}

List<InlineSpan> _sorot(String s, TextStyle gaya, List<String> cari) {
  if (cari.isEmpty) return [TextSpan(text: s, style: gaya)];
  final low = s.toLowerCase();
  if (low.length != s.length) return [TextSpan(text: s, style: gaya)];
  final out = <InlineSpan>[];
  var pos = 0;
  while (pos < s.length) {
    var dekat = -1;
    var panjang = 0;
    for (final k in cari) {
      if (k.isEmpty) continue;
      final i = low.indexOf(k, pos);
      if (i >= 0 && (dekat < 0 || i < dekat)) {
        dekat = i;
        panjang = k.length;
      }
    }
    if (dekat < 0) {
      out.add(TextSpan(text: s.substring(pos), style: gaya));
      break;
    }
    if (dekat > pos) {
      out.add(TextSpan(text: s.substring(pos, dekat), style: gaya));
    }
    out.add(TextSpan(
      text: s.substring(dekat, dekat + panjang),
      style: gaya.copyWith(
          backgroundColor: _warnaSorot, color: const Color(0xDD000000)),
    ));
    pos = dekat + panjang;
  }
  return out;
}

class TeksKaya extends StatelessWidget {
  final String teks;
  final double ukuran;
  final FontWeight? berat;
  final FontStyle? miring;
  final Color? warna;
  final double tinggi;
  final TextAlign? rata;

  const TeksKaya(
    this.teks, {
    super.key,
    this.ukuran = 15.5,
    this.berat,
    this.miring,
    this.warna,
    this.tinggi = 1.6,
    this.rata,
  });

  @override
  Widget build(BuildContext context) {
    final sc = MateriScope.of(context);
    final cs = Theme.of(context).colorScheme;
    final dasar = TextStyle(
      fontSize: ukuran * sc.skala,
      height: tinggi,
      fontWeight: berat,
      fontStyle: miring,
      color: warna ?? cs.onSurface.withAlpha(235),
    );
    return Text.rich(
      TextSpan(children: bangunSpan(teks, dasar, sc.kataCari)),
      textAlign: rata,
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// ANIMASI MUNCUL SAAT TERLIHAT (saat di-scroll)
// ─────────────────────────────────────────────────────────────────────────────
class SaatTerlihat extends StatefulWidget {
  final Widget Function(BuildContext context, bool terlihat) builder;
  const SaatTerlihat({super.key, required this.builder});

  @override
  State<SaatTerlihat> createState() => _SaatTerlihatState();
}

class _SaatTerlihatState extends State<SaatTerlihat> {
  bool _terlihat = false;
  ScrollPosition? _pos;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final p = Scrollable.maybeOf(context)?.position;
    if (!identical(p, _pos)) {
      _pos?.removeListener(_cek);
      _pos = p;
      _pos?.addListener(_cek);
    }
    if (p == null) {
      _terlihat = true; // tidak ada scroll → tampilkan langsung
    } else {
      WidgetsBinding.instance.addPostFrameCallback((_) => _cek());
    }
  }

  void _cek() {
    if (_terlihat || !mounted) return;
    final ro = context.findRenderObject();
    if (ro is! RenderBox || !ro.attached || !ro.hasSize) return;
    final atas = ro.localToGlobal(Offset.zero).dy;
    final tinggiLayar = MediaQuery.of(context).size.height;
    if (atas < tinggiLayar * 0.94) {
      _terlihat = true;
      _pos?.removeListener(_cek);
      setState(() {});
    }
  }

  @override
  void dispose() {
    _pos?.removeListener(_cek);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => widget.builder(context, _terlihat);
}

class Muncul extends StatelessWidget {
  final Widget child;
  const Muncul({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return SaatTerlihat(
      builder: (context, terlihat) => AnimatedOpacity(
        opacity: terlihat ? 1 : 0,
        duration: const Duration(milliseconds: 450),
        curve: Curves.easeOut,
        child: AnimatedSlide(
          offset: terlihat ? Offset.zero : const Offset(0, 0.04),
          duration: const Duration(milliseconds: 450),
          curve: Curves.easeOutCubic,
          child: child,
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// DAFTAR BLOK (dipakai halaman & tab)
// ─────────────────────────────────────────────────────────────────────────────
bool _penuhLebar(Blok b) => b is KartuGeser || b is TabelData;

class DaftarBlok extends StatelessWidget {
  final List<Blok> blok;
  final bool muncul;
  final double padH;

  const DaftarBlok({
    super.key,
    required this.blok,
    this.muncul = false,
    this.padH = 0,
  });

  @override
  Widget build(BuildContext context) {
    final anak = <Widget>[];
    for (final b in blok) {
      Widget w = bangunBlok(b);
      if (muncul && b is! Paragraf) w = Muncul(child: w);
      anak.add(Padding(
        padding: EdgeInsets.fromLTRB(
            _penuhLebar(b) ? 0 : padH, 0, _penuhLebar(b) ? 0 : padH, 16),
        child: w,
      ));
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: anak,
    );
  }
}

Widget bangunBlok(Blok b) {
  if (b is Paragraf) return TeksKaya(b.teks);
  if (b is SubJudul) return _SubJudulW(b);
  if (b is Gambar) return _GambarW(b);
  if (b is Kutipan) return _KutipanW(b);
  if (b is Callout) return _CalloutW(b);
  if (b is Daftar) return _DaftarW(b);
  if (b is Linimasa) return _LinimasaW(b);
  if (b is KartuGeser) return _KartuGeserW(b);
  if (b is Akordeon) return _AkordeonW(b);
  if (b is TabInfo) return _TabInfoW(b);
  if (b is KartuBalik) return _KartuBalikW(b);
  if (b is Perbandingan) return _PerbandinganW(b);
  if (b is GridIkon) return _GridIkonW(b);
  if (b is AngkaKunci) return _AngkaKunciW(b);
  if (b is KuisKilat) return _KuisKilatW(b);
  if (b is Ringkasan) return _RingkasanW(b);
  if (b is TabelData) return _TabelDataW(b);
  if (b is ZonaLaut) return const _ZonaLautW();
  return const SizedBox.shrink();
}

// ─────────────────────────────────────────────────────────────────────────────
// SUB JUDUL
// ─────────────────────────────────────────────────────────────────────────────
class _SubJudulW extends StatelessWidget {
  final SubJudul b;
  const _SubJudulW(this.b);

  @override
  Widget build(BuildContext context) {
    final sc = MateriScope.of(context);
    final cs = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 5,
            height: 24,
            decoration: BoxDecoration(
              color: sc.warna,
              borderRadius: BorderRadius.circular(3),
            ),
          ),
          const SizedBox(width: 10),
          if (b.ikon != null) ...[
            Icon(b.ikon, size: 20 * sc.skala, color: sc.warna),
            const SizedBox(width: 6),
          ],
          Expanded(
            child: Text.rich(
              TextSpan(
                  children: bangunSpan(
                b.teks,
                TextStyle(
                  fontSize: 17.5 * sc.skala,
                  fontWeight: FontWeight.w800,
                  height: 1.3,
                  color: cs.onSurface,
                ),
                sc.kataCari,
              )),
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// GAMBAR (kotak placeholder / Image.asset)
// ─────────────────────────────────────────────────────────────────────────────
class _GarisPutusPainter extends CustomPainter {
  final Color warna;
  final double radius;
  _GarisPutusPainter(this.warna, this.radius);

  @override
  void paint(Canvas canvas, Size size) {
    final p = Paint()
      ..color = warna
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.6;
    final path = Path()
      ..addRRect(RRect.fromRectAndRadius(
          Offset.zero & size, Radius.circular(radius)));
    for (final m in path.computeMetrics()) {
      var d = 0.0;
      while (d < m.length) {
        canvas.drawPath(m.extractPath(d, math.min(d + 8, m.length)), p);
        d += 14;
      }
    }
  }

  @override
  bool shouldRepaint(covariant _GarisPutusPainter old) =>
      old.warna != warna || old.radius != radius;
}

class _GambarW extends StatelessWidget {
  final Gambar g;
  const _GambarW(this.g);

  Widget _placeholder(BuildContext context, Color warna) {
    final cs = Theme.of(context).colorScheme;
    return CustomPaint(
      painter: _GarisPutusPainter(alfa(warna, .55), 16),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [alfa(warna, .14), alfa(warna, .05)],
          ),
        ),
        padding: const EdgeInsets.all(12),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.add_photo_alternate_outlined,
                  size: 36, color: alfa(warna, .85)),
              const SizedBox(height: 6),
              Text(
                'TEMPAT GAMBAR',
                style: TextStyle(
                    fontSize: 10.5,
                    letterSpacing: 1.4,
                    fontWeight: FontWeight.w800,
                    color: alfa(warna, .9)),
              ),
              if (g.aset != null) ...[
                const SizedBox(height: 2),
                Text(g.aset!,
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontSize: 10, color: cs.onSurface.withAlpha(140))),
              ],
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final sc = MateriScope.of(context);
    final cs = Theme.of(context).colorScheme;
    final Widget isi = g.aset == null
        ? _placeholder(context, sc.warna)
        : ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Image.asset(
              g.aset!,
              fit: BoxFit.cover,
              width: double.infinity,
              errorBuilder: (c, e, s) => _placeholder(c, sc.warna),
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
                    child: g.aset == null
                        ? Container(
                            padding: const EdgeInsets.all(24),
                            color: Colors.white,
                            child: Text(g.label,
                                style: const TextStyle(
                                    color: Colors.black, fontSize: 18)),
                          )
                        : Image.asset(g.aset!),
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
                    g.label,
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.white, fontSize: 14),
                  ),
                ),
              ],
            ),
          ),
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          AspectRatio(aspectRatio: g.rasio, child: isi),
          const SizedBox(height: 6),
          Text(
            g.label,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12.5 * sc.skala,
              fontStyle: FontStyle.italic,
              height: 1.35,
              color: cs.onSurface.withAlpha(150),
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// KUTIPAN
// ─────────────────────────────────────────────────────────────────────────────
class _KutipanW extends StatelessWidget {
  final Kutipan b;
  const _KutipanW(this.b);

  @override
  Widget build(BuildContext context) {
    final sc = MateriScope.of(context);
    final cs = Theme.of(context).colorScheme;
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: Container(
        color: alfa(sc.warna, .08),
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(width: 5, color: sc.warna),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(14, 12, 14, 14),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(Icons.format_quote,
                          size: 30, color: alfa(sc.warna, .75)),
                      TeksKaya('“${b.teks}”',
                          ukuran: 16.5,
                          miring: FontStyle.italic,
                          berat: FontWeight.w600),
                      if (b.sumber != null) ...[
                        const SizedBox(height: 8),
                        Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            '— ${b.sumber}',
                            textAlign: TextAlign.right,
                            style: TextStyle(
                              fontSize: 12.5 * sc.skala,
                              fontWeight: FontWeight.w700,
                              color: cs.onSurface.withAlpha(165),
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// CALLOUT
// ─────────────────────────────────────────────────────────────────────────────
const Map<JenisCallout, Color> _warnaCallout = {
  JenisCallout.info: Color(0xFF1E88E5),
  JenisCallout.penting: Color(0xFFE53935),
  JenisCallout.fakta: Color(0xFF8E24AA),
  JenisCallout.tips: Color(0xFF2E9E5B),
  JenisCallout.peringatan: Color(0xFFF57C00),
};
const Map<JenisCallout, IconData> _ikonCallout = {
  JenisCallout.info: Icons.info_outline,
  JenisCallout.penting: Icons.push_pin,
  JenisCallout.fakta: Icons.auto_awesome,
  JenisCallout.tips: Icons.tips_and_updates,
  JenisCallout.peringatan: Icons.warning_amber_rounded,
};

class _CalloutW extends StatelessWidget {
  final Callout b;
  const _CalloutW(this.b);

  @override
  Widget build(BuildContext context) {
    final w = _warnaCallout[b.jenis]!;
    final sc = MateriScope.of(context);
    return Container(
      decoration: BoxDecoration(
        color: alfa(w, .10),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: alfa(w, .35)),
      ),
      padding: const EdgeInsets.all(14),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 34,
            height: 34,
            decoration: BoxDecoration(color: alfa(w, .18), shape: BoxShape.circle),
            child: Icon(_ikonCallout[b.jenis], size: 19, color: w),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text.rich(TextSpan(
                    children: bangunSpan(
                  b.judul,
                  TextStyle(
                      fontSize: 15 * sc.skala,
                      fontWeight: FontWeight.w800,
                      height: 1.3,
                      color: w),
                  sc.kataCari,
                ))),
                const SizedBox(height: 4),
                TeksKaya(b.isi, ukuran: 14.5, tinggi: 1.5),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// DAFTAR
// ─────────────────────────────────────────────────────────────────────────────
class _DaftarW extends StatelessWidget {
  final Daftar b;
  const _DaftarW(this.b);

  @override
  Widget build(BuildContext context) {
    final sc = MateriScope.of(context);
    return Column(
      children: [
        for (var i = 0; i < b.item.length; i++)
          Padding(
            padding: const EdgeInsets.only(bottom: 9),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 2),
                  child: b.bernomor
                      ? Container(
                          width: 24 * sc.skala.clamp(1.0, 1.2).toDouble(),
                          height: 24 * sc.skala.clamp(1.0, 1.2).toDouble(),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: alfa(sc.warna, .16),
                              shape: BoxShape.circle),
                          child: Text('${i + 1}',
                              style: TextStyle(
                                  fontSize: 12.5,
                                  fontWeight: FontWeight.w800,
                                  color: sc.warna)),
                        )
                      : Container(
                          margin: const EdgeInsets.only(left: 6, right: 4, top: 7),
                          width: 9,
                          height: 9,
                          decoration: BoxDecoration(
                              color: sc.warna, shape: BoxShape.circle),
                        ),
                ),
                const SizedBox(width: 10),
                Expanded(child: TeksKaya(b.item[i], ukuran: 15, tinggi: 1.5)),
              ],
            ),
          ),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// LINIMASA
// ─────────────────────────────────────────────────────────────────────────────
class _LinimasaW extends StatefulWidget {
  final Linimasa b;
  const _LinimasaW(this.b);

  @override
  State<_LinimasaW> createState() => _LinimasaWState();
}

class _LinimasaWState extends State<_LinimasaW> {
  final Set<int> _buka = <int>{};

  bool get _semua => _buka.length == widget.b.langkah.length;

  @override
  Widget build(BuildContext context) {
    final sc = MateriScope.of(context);
    final cs = Theme.of(context).colorScheme;
    final n = widget.b.langkah.length;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            Icon(Icons.touch_app, size: 16, color: cs.onSurface.withAlpha(140)),
            const SizedBox(width: 6),
            Expanded(
              child: Text('Ketuk tiap peristiwa untuk membuka detail',
                  style: TextStyle(
                      fontSize: 12.5, color: cs.onSurface.withAlpha(150))),
            ),
            TextButton(
              style: TextButton.styleFrom(
                  visualDensity: VisualDensity.compact,
                  foregroundColor: sc.warna),
              onPressed: () => setState(() {
                if (_semua) {
                  _buka.clear();
                } else {
                  _buka.addAll(List<int>.generate(n, (i) => i));
                }
              }),
              child: Text(_semua ? 'Tutup semua' : 'Buka semua'),
            ),
          ],
        ),
        const SizedBox(height: 4),
        for (var i = 0; i < n; i++) _langkah(context, i, n, sc, cs),
      ],
    );
  }

  Widget _langkah(
      BuildContext context, int i, int n, MateriScope sc, ColorScheme cs) {
    final l = widget.b.langkah[i];
    final terbuka = _buka.contains(i);
    final pertama = i == 0;
    final terakhir = i == n - 1;
    final garis = alfa(sc.warna, .30);
    return Stack(
      children: [
        if (!(pertama && terakhir))
          Positioned(
            left: 17,
            top: pertama ? 22 : 0,
            bottom: terakhir ? null : 0,
            height: terakhir ? 22 : null,
            width: 2.5,
            child: DecoratedBox(
              decoration: BoxDecoration(
                  color: garis, borderRadius: BorderRadius.circular(2)),
            ),
          ),
        Positioned(
          left: 0,
          top: 4,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 250),
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: terbuka ? sc.warna : cs.surface,
              border: Border.all(color: sc.warna, width: 2.2),
            ),
            child: Icon(l.ikon,
                size: 17, color: terbuka ? Colors.white : sc.warna),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 48, bottom: 12),
          child: Material(
            color: terbuka ? alfa(sc.warna, .09) : alfa(cs.onSurface, .045),
            borderRadius: BorderRadius.circular(14),
            child: InkWell(
              borderRadius: BorderRadius.circular(14),
              onTap: () => setState(() {
                if (!_buka.add(i)) _buka.remove(i);
              }),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(12, 10, 8, 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            alignment: Alignment.centerLeft,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 3),
                              decoration: BoxDecoration(
                                color: alfa(sc.warna, .16),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(l.waktu,
                                  style: TextStyle(
                                      fontSize: 11.5 * sc.skala,
                                      fontWeight: FontWeight.w800,
                                      color: sc.warna)),
                            ),
                          ),
                        ),
                        AnimatedRotation(
                          turns: terbuka ? .5 : 0,
                          duration: const Duration(milliseconds: 250),
                          child: Icon(Icons.expand_more,
                              color: cs.onSurface.withAlpha(150)),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Padding(
                      padding: const EdgeInsets.only(right: 6),
                      child: TeksKaya(l.judul,
                          ukuran: 15.5, berat: FontWeight.w700, tinggi: 1.35),
                    ),
                    AnimatedSize(
                      duration: const Duration(milliseconds: 260),
                      curve: Curves.easeOutCubic,
                      alignment: Alignment.topCenter,
                      child: terbuka
                          ? Padding(
                              padding: const EdgeInsets.only(top: 6, right: 6),
                              child: TeksKaya(l.isi, ukuran: 14.5, tinggi: 1.55),
                            )
                          : const SizedBox(width: double.infinity),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// KARTU GESER (carousel)
// ─────────────────────────────────────────────────────────────────────────────
class _KartuGeserW extends StatelessWidget {
  final KartuGeser b;
  const _KartuGeserW(this.b);

  @override
  Widget build(BuildContext context) {
    final sc = MateriScope.of(context);
    final cs = Theme.of(context).colorScheme;
    final lebar = math.min(310.0, MediaQuery.of(context).size.width * 0.8);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (b.kartu.length > 1)
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 8),
            child: Row(
              children: [
                Icon(Icons.swipe, size: 16, color: cs.onSurface.withAlpha(140)),
                const SizedBox(width: 6),
                Text('Geser ke samping untuk melihat semuanya',
                    style: TextStyle(
                        fontSize: 12.5, color: cs.onSurface.withAlpha(150))),
              ],
            ),
          ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                for (var i = 0; i < b.kartu.length; i++) ...[
                  if (i > 0) const SizedBox(width: 12),
                  SizedBox(
                      width: lebar, child: _kartu(context, b.kartu[i], sc, cs)),
                ],
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _kartu(
      BuildContext context, KartuInfo k, MateriScope sc, ColorScheme cs) {
    return Container(
      decoration: BoxDecoration(
        color: cs.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: alfa(sc.warna, .30)),
        boxShadow: [
          BoxShadow(
              color: alfa(Colors.black, .06),
              blurRadius: 10,
              offset: const Offset(0, 4)),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: const EdgeInsets.fromLTRB(14, 12, 14, 12),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [sc.warna, gelapkan(sc.warna, .10)]),
            ),
            child: Row(
              children: [
                Container(
                  width: 36,
                  height: 36,
                  decoration: const BoxDecoration(
                      color: Color(0x33FFFFFF), shape: BoxShape.circle),
                  child: Icon(k.ikon, color: Colors.white, size: 20),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(k.label,
                      style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w800,
                          fontSize: 13)),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TeksKaya(k.judul,
                    ukuran: 17, berat: FontWeight.w800, tinggi: 1.3),
                const SizedBox(height: 6),
                TeksKaya(k.isi, ukuran: 14, tinggi: 1.5),
                for (final p in k.poin)
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 3),
                          child: Icon(Icons.check_circle,
                              size: 15, color: sc.warna),
                        ),
                        const SizedBox(width: 7),
                        Expanded(
                            child: TeksKaya(p, ukuran: 13.5, tinggi: 1.45)),
                      ],
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

// ─────────────────────────────────────────────────────────────────────────────
// AKORDEON
// ─────────────────────────────────────────────────────────────────────────────
class _AkordeonW extends StatefulWidget {
  final Akordeon b;
  const _AkordeonW(this.b);

  @override
  State<_AkordeonW> createState() => _AkordeonWState();
}

class _AkordeonWState extends State<_AkordeonW> {
  late final Set<int> _buka = widget.b.bukaPertama ? <int>{0} : <int>{};

  @override
  Widget build(BuildContext context) {
    final sc = MateriScope.of(context);
    final cs = Theme.of(context).colorScheme;
    return Column(
      children: [
        for (var i = 0; i < widget.b.item.length; i++)
          Padding(
            padding: EdgeInsets.only(bottom: i == widget.b.item.length - 1 ? 0 : 10),
            child: _item(context, i, sc, cs),
          ),
      ],
    );
  }

  Widget _item(BuildContext context, int i, MateriScope sc, ColorScheme cs) {
    final it = widget.b.item[i];
    final terbuka = _buka.contains(i);
    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      decoration: BoxDecoration(
        color: terbuka ? alfa(sc.warna, .07) : cs.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
            color: terbuka ? alfa(sc.warna, .45) : alfa(cs.onSurface, .14)),
      ),
      child: Material(
        type: MaterialType.transparency,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () => setState(() {
            if (!_buka.add(i)) _buka.remove(i);
          }),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(12, 12, 10, 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 32,
                      height: 32,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: alfa(sc.warna, .15), shape: BoxShape.circle),
                      child: it.ikon != null
                          ? Icon(it.ikon, size: 17, color: sc.warna)
                          : Text('${i + 1}',
                              style: TextStyle(
                                  fontWeight: FontWeight.w800,
                                  fontSize: 13,
                                  color: sc.warna)),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: TeksKaya(it.judul,
                          ukuran: 15, berat: FontWeight.w700, tinggi: 1.3),
                    ),
                    AnimatedRotation(
                      turns: terbuka ? .5 : 0,
                      duration: const Duration(milliseconds: 250),
                      child: Icon(Icons.expand_more,
                          color: cs.onSurface.withAlpha(150)),
                    ),
                  ],
                ),
                AnimatedSize(
                  duration: const Duration(milliseconds: 260),
                  curve: Curves.easeOutCubic,
                  alignment: Alignment.topCenter,
                  child: terbuka
                      ? Padding(
                          padding: const EdgeInsets.fromLTRB(42, 8, 6, 0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (it.isi.isNotEmpty)
                                TeksKaya(it.isi, ukuran: 14.5, tinggi: 1.55),
                              for (final p in it.poin)
                                Padding(
                                  padding: const EdgeInsets.only(top: 6),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(top: 8),
                                        child: Container(
                                          width: 6,
                                          height: 6,
                                          decoration: BoxDecoration(
                                              color: sc.warna,
                                              shape: BoxShape.circle),
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      Expanded(
                                          child: TeksKaya(p,
                                              ukuran: 14.5, tinggi: 1.5)),
                                    ],
                                  ),
                                ),
                            ],
                          ),
                        )
                      : const SizedBox(width: double.infinity),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// TAB
// ─────────────────────────────────────────────────────────────────────────────
class _TabInfoW extends StatefulWidget {
  final TabInfo b;
  const _TabInfoW(this.b);

  @override
  State<_TabInfoW> createState() => _TabInfoWState();
}

class _TabInfoWState extends State<_TabInfoW> {
  int _i = 0;

  @override
  Widget build(BuildContext context) {
    final sc = MateriScope.of(context);
    final cs = Theme.of(context).colorScheme;
    final tab = widget.b.tab[_i];
    final warna = tab.warna ?? sc.warna;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(),
          child: Row(
            children: [
              for (var i = 0; i < widget.b.tab.length; i++)
                Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: _chip(i, sc, cs),
                ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        AnimatedSize(
          duration: const Duration(milliseconds: 280),
          curve: Curves.easeOutCubic,
          alignment: Alignment.topCenter,
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 260),
            layoutBuilder: (cur, prev) => Stack(
              alignment: Alignment.topCenter,
              children: [...prev, if (cur != null) cur],
            ),
            transitionBuilder: (child, anim) =>
                FadeTransition(opacity: anim, child: child),
            child: Container(
              key: ValueKey<int>(_i),
              width: double.infinity,
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: alfa(warna, .06),
                borderRadius: BorderRadius.circular(18),
                border: Border.all(color: alfa(warna, .28)),
              ),
              child: MateriScope(
                warna: warna,
                skala: sc.skala,
                kataCari: sc.kataCari,
                child: DaftarBlok(blok: tab.isi),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _chip(int i, MateriScope sc, ColorScheme cs) {
    final t = widget.b.tab[i];
    final warna = t.warna ?? sc.warna;
    final aktif = i == _i;
    return Material(
      color: aktif ? warna : alfa(warna, .10),
      borderRadius: BorderRadius.circular(30),
      child: InkWell(
        borderRadius: BorderRadius.circular(30),
        onTap: () {
          HapticFeedback.selectionClick();
          setState(() => _i = i);
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(t.ikon, size: 17, color: aktif ? Colors.white : warna),
              const SizedBox(width: 6),
              Text(t.label,
                  style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 13.5,
                      color: aktif ? Colors.white : warna)),
            ],
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// KARTU BALIK
// ─────────────────────────────────────────────────────────────────────────────
class _KartuBalikW extends StatelessWidget {
  final KartuBalik b;
  const _KartuBalikW(this.b);

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.flip, size: 16, color: cs.onSurface.withAlpha(140)),
            const SizedBox(width: 6),
            Text(b.petunjuk,
                style: TextStyle(
                    fontSize: 12.5, color: cs.onSurface.withAlpha(150))),
          ],
        ),
        const SizedBox(height: 10),
        LayoutBuilder(builder: (context, c) {
          final setengah = (c.maxWidth - 12) / 2;
          final n = b.kartu.length;
          return Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              for (var i = 0; i < n; i++)
                SizedBox(
                  width: (n.isOdd && i == n - 1) ? c.maxWidth : setengah,
                  child: _KartuBalikItem(item: b.kartu[i]),
                ),
            ],
          );
        }),
      ],
    );
  }
}

class _KartuBalikItem extends StatefulWidget {
  final ItemKartuBalik item;
  const _KartuBalikItem({required this.item});

  @override
  State<_KartuBalikItem> createState() => _KartuBalikItemState();
}

class _KartuBalikItemState extends State<_KartuBalikItem>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctl = AnimationController(
      vsync: this, duration: const Duration(milliseconds: 480));
  late final Animation<double> _anim =
      CurvedAnimation(parent: _ctl, curve: Curves.easeInOutCubic);
  bool _balik = false;

  @override
  void dispose() {
    _ctl.dispose();
    super.dispose();
  }

  void _toggle() {
    HapticFeedback.selectionClick();
    _balik = !_balik;
    if (_balik) {
      _ctl.forward();
    } else {
      _ctl.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    final sc = MateriScope.of(context);
    final cs = Theme.of(context).colorScheme;
    return GestureDetector(
      onTap: _toggle,
      child: AnimatedBuilder(
        animation: _anim,
        builder: (context, _) {
          final sudut = _anim.value * math.pi;
          final tampakBelakang = sudut > math.pi / 2;
          return Transform(
            alignment: Alignment.center,
            transform: Matrix4.identity()
              ..setEntry(3, 2, 0.0012)
              ..rotateY(sudut),
            child: SizedBox(
              height: 172,
              child: tampakBelakang
                  ? Transform(
                      alignment: Alignment.center,
                      transform: Matrix4.identity()..rotateY(math.pi),
                      child: _belakang(sc, cs),
                    )
                  : _depan(sc),
            ),
          );
        },
      ),
    );
  }

  Widget _depan(MateriScope sc) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [sc.warna, gelapkan(sc.warna, .14)],
        ),
        boxShadow: [
          BoxShadow(
              color: alfa(sc.warna, .30),
              blurRadius: 10,
              offset: const Offset(0, 5)),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(widget.item.ikon, color: const Color(0xCCFFFFFF), size: 30),
          const SizedBox(height: 8),
          Flexible(
            child: Text(
              widget.item.depan,
              textAlign: TextAlign.center,
              maxLines: 4,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w800,
                  fontSize: 15.5 * sc.skala.clamp(0.9, 1.15).toDouble(),
                  height: 1.25),
            ),
          ),
          const SizedBox(height: 8),
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.touch_app, size: 13, color: Color(0xB3FFFFFF)),
              SizedBox(width: 4),
              Text('ketuk',
                  style: TextStyle(color: Color(0xB3FFFFFF), fontSize: 11)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _belakang(MateriScope sc, ColorScheme cs) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: cs.surface,
        border: Border.all(color: sc.warna, width: 2),
      ),
      child: Center(
        child: SingleChildScrollView(
          child: Text(
            widget.item.belakang,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 13.5 * sc.skala.clamp(0.9, 1.15).toDouble(),
                height: 1.45,
                color: cs.onSurface.withAlpha(235)),
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// PERBANDINGAN
// ─────────────────────────────────────────────────────────────────────────────
class _PerbandinganW extends StatelessWidget {
  final Perbandingan b;
  const _PerbandinganW(this.b);

  @override
  Widget build(BuildContext context) {
    final sc = MateriScope.of(context);
    final cs = Theme.of(context).colorScheme;
    final kiri = b.warnaKiri ?? sc.warna;
    final kanan = b.warnaKanan ?? gelapkan(const Color(0xFF455A64), 0.02);
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: alfa(cs.onSurface, .16)),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          Row(
            children: [
              Expanded(child: _kepala(b.judulKiri, kiri, sc)),
              Expanded(child: _kepala(b.judulKanan, kanan, sc)),
            ],
          ),
          for (var i = 0; i < b.baris.length; i++)
            Container(
              color: i.isOdd ? alfa(cs.onSurface, .035) : null,
              padding: const EdgeInsets.fromLTRB(10, 8, 10, 10),
              child: Column(
                children: [
                  if (b.baris[i].label.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 6),
                      child: Text(
                        b.baris[i].label.toUpperCase(),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 10.5 * sc.skala.clamp(0.9, 1.1).toDouble(),
                          letterSpacing: 1.1,
                          fontWeight: FontWeight.w800,
                          color: cs.onSurface.withAlpha(140),
                        ),
                      ),
                    ),
                  IntrinsicHeight(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Expanded(
                            child: _sel(b.baris[i].kiri, kiri)),
                        const SizedBox(width: 8),
                        Expanded(
                            child: _sel(b.baris[i].kanan, kanan)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _kepala(String t, Color w, MateriScope sc) {
    return Container(
      color: w,
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
      alignment: Alignment.center,
      child: Text(t,
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w800,
              fontSize: 14 * sc.skala.clamp(0.9, 1.15).toDouble(),
              height: 1.25)),
    );
  }

  Widget _sel(String t, Color w) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: alfa(w, .09),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: alfa(w, .25)),
      ),
      child: TeksKaya(t, ukuran: 13.5, tinggi: 1.45),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// GRID IKON
// ─────────────────────────────────────────────────────────────────────────────
class _GridIkonW extends StatelessWidget {
  final GridIkon b;
  const _GridIkonW(this.b);

  @override
  Widget build(BuildContext context) {
    final sc = MateriScope.of(context);
    final cs = Theme.of(context).colorScheme;
    if (b.kolom <= 1) {
      return Column(
        children: [
          for (var i = 0; i < b.item.length; i++)
            Padding(
              padding: EdgeInsets.only(bottom: i == b.item.length - 1 ? 0 : 10),
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: alfa(sc.warna, .07),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: alfa(sc.warna, .25)),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 42,
                      height: 42,
                      decoration: BoxDecoration(
                          color: alfa(sc.warna, .16), shape: BoxShape.circle),
                      child: Icon(b.item[i].ikon, color: sc.warna, size: 22),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TeksKaya(b.item[i].judul,
                              ukuran: 15.5, berat: FontWeight.w800, tinggi: 1.3),
                          if (b.item[i].isi.isNotEmpty) ...[
                            const SizedBox(height: 3),
                            TeksKaya(b.item[i].isi, ukuran: 14, tinggi: 1.5),
                          ],
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ],
      );
    }
    return LayoutBuilder(builder: (context, c) {
      const jarak = 10.0;
      final lebar = (c.maxWidth - jarak * (b.kolom - 1)) / b.kolom;
      return Wrap(
        spacing: jarak,
        runSpacing: jarak,
        children: [
          for (final it in b.item)
            SizedBox(
              width: lebar,
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: alfa(sc.warna, .07),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: alfa(sc.warna, .25)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 38,
                      height: 38,
                      decoration: BoxDecoration(
                          color: alfa(sc.warna, .16), shape: BoxShape.circle),
                      child: Icon(it.ikon, color: sc.warna, size: 20),
                    ),
                    const SizedBox(height: 8),
                    TeksKaya(it.judul,
                        ukuran: 14.5, berat: FontWeight.w800, tinggi: 1.3),
                    if (it.isi.isNotEmpty) ...[
                      const SizedBox(height: 3),
                      TeksKaya(it.isi,
                          ukuran: 13, tinggi: 1.45, warna: cs.onSurface.withAlpha(205)),
                    ],
                  ],
                ),
              ),
            ),
        ],
      );
    });
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// ANGKA KUNCI (hitung naik)
// ─────────────────────────────────────────────────────────────────────────────
String _formatAngka(int n, bool pisah) {
  if (!pisah) return '$n';
  final s = n.toString();
  final out = StringBuffer();
  for (var i = 0; i < s.length; i++) {
    if (i > 0 && (s.length - i) % 3 == 0) out.write('.');
    out.write(s[i]);
  }
  return out.toString();
}

class _AngkaKunciW extends StatelessWidget {
  final AngkaKunci b;
  const _AngkaKunciW(this.b);

  @override
  Widget build(BuildContext context) {
    final sc = MateriScope.of(context);
    final cs = Theme.of(context).colorScheme;
    return SaatTerlihat(
      builder: (context, terlihat) => Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          for (var i = 0; i < b.item.length; i++) ...[
            if (i > 0) const SizedBox(width: 10),
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 14),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [alfa(sc.warna, .16), alfa(sc.warna, .06)],
                  ),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: alfa(sc.warna, .28)),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TweenAnimationBuilder<double>(
                      tween: Tween<double>(
                          begin: 0,
                          end: terlihat ? b.item[i].nilai.toDouble() : 0),
                      duration: const Duration(milliseconds: 1300),
                      curve: Curves.easeOutCubic,
                      builder: (context, v, _) => SizedBox(
                        height: 36,
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(
                            '${_formatAngka(v.round(), b.item[i].pisah)}${b.item[i].akhiran}',
                            style: TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.w900,
                                color: sc.warna),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      b.item[i].label,
                      textAlign: TextAlign.center,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontSize: 12 * sc.skala.clamp(0.9, 1.1).toDouble(),
                          height: 1.3,
                          color: cs.onSurface.withAlpha(200)),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// KUIS KILAT
// ─────────────────────────────────────────────────────────────────────────────
class _KuisKilatW extends StatefulWidget {
  final KuisKilat b;
  const _KuisKilatW(this.b);

  @override
  State<_KuisKilatW> createState() => _KuisKilatWState();
}

class _KuisKilatWState extends State<_KuisKilatW> {
  int _i = 0;
  int? _pilih;
  int _skor = 0;
  bool _selesai = false;
  late List<bool?> _hasil = List<bool?>.filled(widget.b.soal.length, null);

  void _jawab(int p) {
    if (_pilih != null) return;
    final benar = p == widget.b.soal[_i].benar;
    HapticFeedback.lightImpact();
    setState(() {
      _pilih = p;
      _hasil[_i] = benar;
      if (benar) _skor++;
    });
  }

  void _lanjut() {
    setState(() {
      if (_i + 1 >= widget.b.soal.length) {
        _selesai = true;
      } else {
        _i++;
        _pilih = null;
      }
    });
  }

  void _ulang() {
    setState(() {
      _i = 0;
      _pilih = null;
      _skor = 0;
      _selesai = false;
      _hasil = List<bool?>.filled(widget.b.soal.length, null);
    });
  }

  @override
  Widget build(BuildContext context) {
    final sc = MateriScope.of(context);
    final cs = Theme.of(context).colorScheme;
    return Container(
      decoration: BoxDecoration(
        color: cs.surface,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: alfa(sc.warna, .4), width: 1.6),
        boxShadow: [
          BoxShadow(
              color: alfa(sc.warna, .14),
              blurRadius: 14,
              offset: const Offset(0, 6)),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [sc.warna, gelapkan(sc.warna, .10)]),
            ),
            child: Row(
              children: [
                const Icon(Icons.bolt, color: Colors.amberAccent, size: 22),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(widget.b.judul,
                      style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w800,
                          fontSize: 15.5)),
                ),
                if (!_selesai)
                  Text('${_i + 1}/${widget.b.soal.length}',
                      style: const TextStyle(
                          color: Color(0xE6FFFFFF), fontWeight: FontWeight.w700)),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: AnimatedSize(
              duration: const Duration(milliseconds: 260),
              curve: Curves.easeOutCubic,
              alignment: Alignment.topCenter,
              child: _selesai ? _hasilAkhir(sc, cs) : _soal(sc, cs),
            ),
          ),
        ],
      ),
    );
  }

  Widget _titik(MateriScope sc, ColorScheme cs) {
    return Row(
      children: [
        for (var i = 0; i < _hasil.length; i++)
          Expanded(
            child: Container(
              height: 5,
              margin: EdgeInsets.only(right: i == _hasil.length - 1 ? 0 : 4),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(3),
                color: _hasil[i] == null
                    ? (i == _i && !_selesai
                        ? alfa(sc.warna, .55)
                        : alfa(cs.onSurface, .14))
                    : (_hasil[i]!
                        ? const Color(0xFF2E9E5B)
                        : const Color(0xFFE53935)),
              ),
            ),
          ),
      ],
    );
  }

  Widget _soal(MateriScope sc, ColorScheme cs) {
    final s = widget.b.soal[_i];
    const huruf = ['A', 'B', 'C', 'D', 'E', 'F'];
    final terjawab = _pilih != null;
    return Column(
      key: ValueKey<int>(_i),
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _titik(sc, cs),
        const SizedBox(height: 14),
        TeksKaya(s.tanya, ukuran: 16, berat: FontWeight.w700, tinggi: 1.4),
        const SizedBox(height: 12),
        for (var p = 0; p < s.pilihan.length; p++) ...[
          _opsi(p, huruf[p], s, terjawab, sc, cs),
          const SizedBox(height: 8),
        ],
        if (terjawab) ...[
          const SizedBox(height: 4),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: alfa(
                  _pilih == s.benar
                      ? const Color(0xFF2E9E5B)
                      : const Color(0xFFE53935),
                  .10),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  _pilih == s.benar ? Icons.check_circle : Icons.cancel,
                  color: _pilih == s.benar
                      ? const Color(0xFF2E9E5B)
                      : const Color(0xFFE53935),
                  size: 22,
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _pilih == s.benar ? 'Benar!' : 'Belum tepat',
                        style: TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: 15,
                          color: _pilih == s.benar
                              ? const Color(0xFF2E9E5B)
                              : const Color(0xFFE53935),
                        ),
                      ),
                      const SizedBox(height: 2),
                      TeksKaya(s.jelas, ukuran: 14, tinggi: 1.45),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Align(
            alignment: Alignment.centerRight,
            child: ElevatedButton.icon(
              onPressed: _lanjut,
              style: ElevatedButton.styleFrom(
                backgroundColor: sc.warna,
                foregroundColor: Colors.white,
                padding:
                    const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14)),
              ),
              icon: Icon(
                  _i + 1 >= widget.b.soal.length
                      ? Icons.emoji_events
                      : Icons.arrow_forward,
                  size: 18),
              label: Text(_i + 1 >= widget.b.soal.length
                  ? 'Lihat Hasil'
                  : 'Soal Berikutnya'),
            ),
          ),
        ],
      ],
    );
  }

  Widget _opsi(int p, String huruf, SoalKilat s, bool terjawab, MateriScope sc,
      ColorScheme cs) {
    Color warna = sc.warna;
    var isi = alfa(cs.onSurface, .04);
    var tepi = alfa(cs.onSurface, .16);
    Widget lencana = Text(huruf,
        style: TextStyle(
            fontWeight: FontWeight.w800, fontSize: 13, color: sc.warna));
    if (terjawab) {
      if (p == s.benar) {
        warna = const Color(0xFF2E9E5B);
        isi = alfa(warna, .13);
        tepi = warna;
        lencana = const Icon(Icons.check, size: 16, color: Colors.white);
      } else if (p == _pilih) {
        warna = const Color(0xFFE53935);
        isi = alfa(warna, .12);
        tepi = warna;
        lencana = const Icon(Icons.close, size: 16, color: Colors.white);
      } else {
        isi = alfa(cs.onSurface, .03);
        tepi = alfa(cs.onSurface, .10);
      }
    }
    final menyala = terjawab && (p == s.benar || p == _pilih);
    return Opacity(
      opacity: terjawab && !menyala ? .55 : 1,
      child: Material(
        color: isi,
        borderRadius: BorderRadius.circular(14),
        child: InkWell(
          borderRadius: BorderRadius.circular(14),
          onTap: terjawab ? null : () => _jawab(p),
          child: Container(
            padding: const EdgeInsets.fromLTRB(10, 10, 12, 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: tepi, width: menyala ? 1.8 : 1.2),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 28,
                  height: 28,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: menyala ? warna : alfa(sc.warna, .14),
                  ),
                  child: lencana,
                ),
                const SizedBox(width: 10),
                Expanded(
                    child: TeksKaya(s.pilihan[p], ukuran: 14.5, tinggi: 1.4)),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _hasilAkhir(MateriScope sc, ColorScheme cs) {
    final total = widget.b.soal.length;
    final persen = total == 0 ? 0 : (_skor * 100 / total).round();
    final String pesan;
    final IconData ikon;
    if (persen == 100) {
      pesan = 'Sempurna! Kamu menguasai bagian ini.';
      ikon = Icons.emoji_events;
    } else if (persen >= 70) {
      pesan = 'Bagus sekali! Sedikit lagi sempurna.';
      ikon = Icons.thumb_up;
    } else if (persen >= 50) {
      pesan = 'Lumayan! Baca ulang bagian yang masih keliru, lalu coba lagi.';
      ikon = Icons.auto_stories;
    } else {
      pesan = 'Jangan menyerah. Baca ulang materinya pelan-pelan, lalu coba lagi.';
      ikon = Icons.menu_book;
    }
    return Column(
      key: const ValueKey<String>('hasil'),
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _titik(sc, cs),
        const SizedBox(height: 18),
        Center(
          child: Container(
            width: 76,
            height: 76,
            decoration: BoxDecoration(
                color: alfa(sc.warna, .14), shape: BoxShape.circle),
            child: Icon(ikon, size: 40, color: sc.warna),
          ),
        ),
        const SizedBox(height: 12),
        Text('$_skor dari $total benar',
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 22, fontWeight: FontWeight.w900, color: sc.warna)),
        const SizedBox(height: 6),
        Text(pesan,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 14.5, height: 1.4, color: cs.onSurface.withAlpha(210))),
        const SizedBox(height: 14),
        Center(
          child: OutlinedButton.icon(
            onPressed: _ulang,
            style: OutlinedButton.styleFrom(
              foregroundColor: sc.warna,
              side: BorderSide(color: sc.warna, width: 1.5),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14)),
            ),
            icon: const Icon(Icons.replay, size: 18),
            label: const Text('Ulangi'),
          ),
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// RINGKASAN
// ─────────────────────────────────────────────────────────────────────────────
class _RingkasanW extends StatelessWidget {
  final Ringkasan b;
  const _RingkasanW(this.b);

  @override
  Widget build(BuildContext context) {
    final sc = MateriScope.of(context);
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(22),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [sc.warna, gelapkan(sc.warna, .16)],
        ),
        boxShadow: [
          BoxShadow(
              color: alfa(sc.warna, .30),
              blurRadius: 14,
              offset: const Offset(0, 6)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.auto_awesome, color: Colors.amberAccent, size: 22),
              const SizedBox(width: 8),
              Text(b.judul,
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w900,
                      fontSize: 17 * sc.skala.clamp(0.9, 1.15).toDouble())),
            ],
          ),
          const SizedBox(height: 10),
          for (final p in b.poin)
            Padding(
              padding: const EdgeInsets.only(bottom: 9),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 3),
                    child: Icon(Icons.check_circle,
                        size: 16, color: Color(0xFFFFE082)),
                  ),
                  const SizedBox(width: 9),
                  Expanded(
                      child: TeksKaya(p,
                          ukuran: 14.5, tinggi: 1.45, warna: Colors.white)),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// TABEL DATA
// ─────────────────────────────────────────────────────────────────────────────
class _TabelDataW extends StatelessWidget {
  final TabelData b;
  const _TabelDataW(this.b);

  @override
  Widget build(BuildContext context) {
    final sc = MateriScope.of(context);
    final cs = Theme.of(context).colorScheme;
    final n = b.kolom.length;
    final lebarKolom = <int, TableColumnWidth>{
      0: const FixedColumnWidth(104),
      for (var i = 1; i < n; i++) i: const FixedColumnWidth(158),
    };
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 8),
          child: Row(
            children: [
              Icon(Icons.swipe, size: 16, color: cs.onSurface.withAlpha(140)),
              const SizedBox(width: 6),
              Text('Geser tabel ke samping',
                  style: TextStyle(
                      fontSize: 12.5, color: cs.onSurface.withAlpha(150))),
            ],
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(14),
            child: Table(
              columnWidths: lebarKolom,
              defaultVerticalAlignment: TableCellVerticalAlignment.top,
              border: TableBorder.all(color: alfa(cs.onSurface, .15)),
              children: [
                TableRow(
                  decoration: BoxDecoration(color: sc.warna),
                  children: [
                    for (final k in b.kolom)
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Text(k,
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w800,
                                fontSize: 13.5)),
                      ),
                  ],
                ),
                for (var r = 0; r < b.baris.length; r++)
                  TableRow(
                    decoration: BoxDecoration(
                        color: r.isOdd ? alfa(sc.warna, .06) : cs.surface),
                    children: [
                      for (var c = 0; c < n; c++)
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: TeksKaya(
                            c < b.baris[r].length ? b.baris[r][c] : '',
                            ukuran: 13,
                            tinggi: 1.4,
                            berat: c == 0 ? FontWeight.w800 : null,
                          ),
                        ),
                    ],
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// ZONA LAUT (diagram interaktif)
// ─────────────────────────────────────────────────────────────────────────────
class _ZonaLautW extends StatefulWidget {
  const _ZonaLautW();

  @override
  State<_ZonaLautW> createState() => _ZonaLautWState();
}

class _ZonaData {
  final String nama;
  final String ukuran;
  final String isi;
  final Color warna;
  final IconData ikon;
  const _ZonaData(this.nama, this.ukuran, this.isi, this.warna, this.ikon);
}

const List<_ZonaData> _zona = [
  _ZonaData(
      'Daratan',
      'Garis pangkal',
      'Wilayah darat Indonesia: lebih dari 17.000 pulau. Dari garis pangkal kepulauan Indonesia inilah lebar laut diukur.',
      Color(0xFF8D6E4A),
      Icons.terrain),
  _ZonaData(
      'Laut Teritorial',
      '12 mil laut',
      'Jalur laut selebar 12 mil laut yang diukur dari garis pangkal kepulauan Indonesia. Di zona ini Indonesia memiliki kedaulatan penuh, termasuk atas ruang udara di atasnya dan dasar laut di bawahnya.',
      Color(0xFF29B6F6),
      Icons.sailing),
  _ZonaData(
      'Zona Ekonomi Eksklusif (ZEE)',
      '200 mil laut',
      'Jalur laut selebar 200 mil laut ke arah laut terbuka. Kapal asing boleh lewat, tetapi hanya Indonesia yang berhak memanfaatkan sumber daya alamnya (seperti menangkap ikan atau menambang minyak).',
      Color(0xFF1E88E5),
      Icons.set_meal),
  _ZonaData(
      'Perairan Internasional',
      'di luar ZEE',
      'Wilayah laut di luar zona-zona milik Indonesia, yang berbatasan dengan perairan internasional.',
      Color(0xFF283593),
      Icons.public),
  _ZonaData(
      'Landas Kontinen',
      'dasar laut',
      'Dasar laut dan tanah di bawahnya yang merupakan kelanjutan alamiah dari wilayah daratan, hingga kedalaman tertentu. Indonesia memiliki hak eksklusif untuk mengeksplorasi bahan tambang di dasar laut ini.',
      Color(0xFFB07A3A),
      Icons.layers),
];

class _ZonaLautWState extends State<_ZonaLautW> {
  int _sel = 1;

  Widget _segmen(int i, int flex, {String? label}) {
    final z = _zona[i];
    final aktif = _sel == i;
    return Expanded(
      flex: flex,
      child: GestureDetector(
        onTap: () {
          HapticFeedback.selectionClick();
          setState(() => _sel = i);
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 220),
          height: 84,
          decoration: BoxDecoration(
            color: aktif ? z.warna : alfa(z.warna, .55),
            border: aktif
                ? Border.all(color: Colors.white, width: 2.4)
                : null,
          ),
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(horizontal: 2),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(z.ikon, color: Colors.white, size: 20),
              const SizedBox(height: 3),
              Text(label ?? z.ukuran,
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 10.5,
                      fontWeight: FontWeight.w800,
                      height: 1.15)),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final sc = MateriScope.of(context);
    final cs = Theme.of(context).colorScheme;
    final z = _zona[_sel];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            Icon(Icons.touch_app, size: 16, color: cs.onSurface.withAlpha(140)),
            const SizedBox(width: 6),
            Expanded(
              child: Text('Ketuk tiap zona untuk melihat penjelasannya',
                  style: TextStyle(
                      fontSize: 12.5, color: cs.onSurface.withAlpha(150))),
            ),
          ],
        ),
        const SizedBox(height: 10),
        ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Column(
            children: [
              Row(
                children: [
                  _segmen(0, 2, label: 'Darat'),
                  _segmen(1, 3),
                  _segmen(2, 5),
                  _segmen(3, 3, label: 'Laut lepas'),
                ],
              ),
              const SizedBox(height: 3),
              Row(
                children: [
                  const Expanded(flex: 2, child: SizedBox(height: 40)),
                  _segmen4(),
                  const Expanded(flex: 3, child: SizedBox(height: 40)),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 6),
        Text('Gambar disederhanakan, tidak sesuai skala.',
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 11.5,
                fontStyle: FontStyle.italic,
                color: cs.onSurface.withAlpha(140))),
        const SizedBox(height: 10),
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 250),
          child: Container(
            key: ValueKey<int>(_sel),
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: alfa(z.warna, .10),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: alfa(z.warna, .5)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(z.ikon, color: z.warna, size: 22),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(z.nama,
                          style: TextStyle(
                              fontWeight: FontWeight.w800,
                              fontSize: 16 * sc.skala.clamp(0.9, 1.15).toDouble(),
                              color: z.warna)),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 9, vertical: 3),
                      decoration: BoxDecoration(
                          color: alfa(z.warna, .18),
                          borderRadius: BorderRadius.circular(20)),
                      child: Text(z.ukuran,
                          style: TextStyle(
                              fontSize: 11.5,
                              fontWeight: FontWeight.w800,
                              color: z.warna)),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                TeksKaya(z.isi, ukuran: 14.5, tinggi: 1.5),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _segmen4() {
    final z = _zona[4];
    final aktif = _sel == 4;
    return Expanded(
      flex: 8,
      child: GestureDetector(
        onTap: () {
          HapticFeedback.selectionClick();
          setState(() => _sel = 4);
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 220),
          height: 40,
          decoration: BoxDecoration(
            color: aktif ? z.warna : alfa(z.warna, .55),
            border: aktif ? Border.all(color: Colors.white, width: 2.4) : null,
          ),
          alignment: Alignment.center,
          child: const Text('Landas kontinen (dasar laut)',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 11,
                  fontWeight: FontWeight.w800)),
        ),
      ),
    );
  }
}
