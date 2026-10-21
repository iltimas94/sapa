import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'materi_kelas8_model.dart';

/// ---------------------------------------------------------------------------
///  HELPER WARNA
/// ---------------------------------------------------------------------------
Color tint(Color c, double opacity) => c.withAlpha((opacity * 255).round());

Color gelapkan(Color c, [double faktor = 0.72]) {
  final hsl = HSLColor.fromColor(c);
  return hsl.withLightness((hsl.lightness * faktor).clamp(0.0, 1.0)).toColor();
}

/// Warna aksen untuk TEKS: dicerahkan otomatis saat mode gelap.
Color aksenTeks(BuildContext context, Color warna) {
  final gelap = Theme.of(context).brightness == Brightness.dark;
  return gelap ? Color.lerp(warna, Colors.white, 0.55)! : warna;
}

const Color _hijau = Color(0xFF2E7D32);
const Color _merah = Color(0xFFC62828);

/// ---------------------------------------------------------------------------
///  TEKS KAYA: mendukung **tebal**
/// ---------------------------------------------------------------------------
class TeksKaya extends StatelessWidget {
  final String teks;
  final TextStyle? gaya;
  final TextAlign? rata;
  const TeksKaya(this.teks, {super.key, this.gaya, this.rata});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final dasar = gaya ??
        Theme.of(context)
            .textTheme
            .bodyLarge!
            .copyWith(height: 1.6, color: cs.onSurface);
    final tebal = dasar.copyWith(fontWeight: FontWeight.w700);
    final bagian = teks.split('**');
    return Text.rich(
      TextSpan(children: [
        for (var i = 0; i < bagian.length; i++)
          if (bagian[i].isNotEmpty)
            TextSpan(text: bagian[i], style: i.isOdd ? tebal : dasar),
      ]),
      textAlign: rata,
    );
  }
}

/// Daftar poin dengan ikon centang.
class _DaftarPoin extends StatelessWidget {
  final List<String> items;
  final Color warna;
  const _DaftarPoin({required this.items, required this.warna});

  @override
  Widget build(BuildContext context) {
    final aksen = aksenTeks(context, warna);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (final it in items)
          Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 3),
                  child: Icon(Icons.check_circle_rounded, size: 18, color: aksen),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: TeksKaya(
                    it,
                    gaya: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          height: 1.5,
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}

/// ---------------------------------------------------------------------------
///  PENGATUR BLOK -> WIDGET
/// ---------------------------------------------------------------------------
class BlokView extends StatelessWidget {
  final Blok blok;
  final Color warna;
  const BlokView({super.key, required this.blok, required this.warna});

  @override
  Widget build(BuildContext context) {
    final b = blok;
    if (b is Paragraf) return TeksKaya(b.teks);
    if (b is SubJudul) {
      return Text(
        b.teks,
        style: Theme.of(context)
            .textTheme
            .titleMedium!
            .copyWith(fontWeight: FontWeight.w800),
      );
    }
    if (b is Gambar) return _GambarView(b: b, warna: warna);
    if (b is Kotak) return _KotakView(k: b, warna: warna);
    if (b is Poin) return _DaftarPoin(items: b.items, warna: warna);
    if (b is Akordeon) return _AkordeonView(b: b, warna: warna);
    if (b is TabPerbandingan) return _TabView(b: b, warna: warna);
    if (b is Linimasa) return _LinimasaView(b: b, warna: warna);
    if (b is Piramida) return _PiramidaView(b: b, warna: warna);
    if (b is KartuBalik) return _KartuBalikView(b: b, warna: warna);
    if (b is Statistik) return _StatistikView(b: b, warna: warna);
    if (b is Ceklis) return _CeklisView(b: b, warna: warna);
    if (b is Urutkan) return _UrutkanView(b: b, warna: warna);
    if (b is Latihan) {
      return _Engine(
        judul: b.judul,
        emoji: '✅',
        warna: warna,
        ringkas: false,
        soal: [
          for (final s in b.soal)
            _Q(s.pertanyaan, s.opsi, s.benar, s.penjelasan),
        ],
      );
    }
    if (b is Klasifikasi) {
      return _Engine(
        judul: b.judul,
        emoji: '🧩',
        petunjuk: b.petunjuk,
        warna: warna,
        ringkas: true,
        soal: [
          for (final it in b.items) _Q(it.teks, b.labels, it.jawaban, it.alasan),
        ],
      );
    }
    return const SizedBox.shrink();
  }
}

/// ---------------------------------------------------------------------------
///  GAMBAR (placeholder atau aset)
/// ---------------------------------------------------------------------------
class _GambarView extends StatelessWidget {
  final Gambar b;
  final Color warna;
  const _GambarView({required this.b, required this.warna});

  Widget _placeholder(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      color: tint(warna, 0.10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.image_outlined, size: 40, color: tint(warna, 0.7)),
          const SizedBox(height: 8),
          Text(
            'TEMPAT GAMBAR',
            style: Theme.of(context).textTheme.labelSmall!.copyWith(
                  letterSpacing: 1.2,
                  fontWeight: FontWeight.w800,
                  color: tint(cs.onSurface, 0.55),
                ),
          ),
          const SizedBox(height: 4),
          Text(
            b.deskripsi,
            textAlign: TextAlign.center,
            maxLines: 4,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context)
                .textTheme
                .bodyMedium!
                .copyWith(color: tint(cs.onSurface, 0.75)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final Widget imgWidget = AspectRatio(
      aspectRatio: b.rasio,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(18),
        child: b.aset != null
            ? Image.asset(
                b.aset!,
                fit: BoxFit.cover,
                width: double.infinity,
                errorBuilder: (_, __, ___) => _placeholder(context),
              )
            : _placeholder(context),
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
                    child: b.aset == null
                        ? Container(
                            padding: const EdgeInsets.all(24),
                            color: Colors.white,
                            child: Text(b.deskripsi,
                                style: const TextStyle(
                                    color: Colors.black, fontSize: 18)),
                          )
                        : Image.asset(b.aset!),
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
                    [
                      if (b.aset != null) b.deskripsi,
                      if (b.sumber != null) 'Sumber: ${b.sumber}',
                    ].join('. '),
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          imgWidget,
          if (b.aset != null || b.sumber != null) ...[
            const SizedBox(height: 6),
            Text(
              [
                if (b.aset != null) b.deskripsi,
                if (b.sumber != null) 'Sumber: ${b.sumber}',
              ].join('. '),
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    fontStyle: FontStyle.italic,
                    color: tint(cs.onSurface, 0.65),
                  ),
            ),
          ],
        ],
      ),
    );
  }
}

/// ---------------------------------------------------------------------------
///  KOTAK INFO
/// ---------------------------------------------------------------------------
Color _warnaJenis(JenisKotak j, Color aksen) {
  switch (j) {
    case JenisKotak.info:
      return const Color(0xFF0277BD);
    case JenisKotak.penting:
      return const Color(0xFFE65100);
    case JenisKotak.tips:
      return const Color(0xFF2E7D32);
    case JenisKotak.contoh:
      return const Color(0xFF6A1B9A);
    case JenisKotak.refleksi:
      return const Color(0xFF00838F);
    case JenisKotak.ringkasan:
      return aksen;
  }
}

IconData _ikonJenis(JenisKotak j) {
  switch (j) {
    case JenisKotak.info:
      return Icons.info_outline_rounded;
    case JenisKotak.penting:
      return Icons.priority_high_rounded;
    case JenisKotak.tips:
      return Icons.lightbulb_outline_rounded;
    case JenisKotak.contoh:
      return Icons.push_pin_outlined;
    case JenisKotak.refleksi:
      return Icons.forum_outlined;
    case JenisKotak.ringkasan:
      return Icons.flag_outlined;
  }
}

class _KotakView extends StatelessWidget {
  final Kotak k;
  final Color warna;
  const _KotakView({required this.k, required this.warna});

  @override
  Widget build(BuildContext context) {
    final c = _warnaJenis(k.jenis, warna);
    final cText = aksenTeks(context, c);
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: Container(
        color: tint(c, 0.10),
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(width: 5, color: c),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(14),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(_ikonJenis(k.jenis), size: 20, color: cText),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              k.judul,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall!
                                  .copyWith(
                                      fontWeight: FontWeight.w800, color: cText),
                            ),
                          ),
                        ],
                      ),
                      if (k.isi.isNotEmpty) ...[
                        const SizedBox(height: 8),
                        TeksKaya(k.isi),
                      ],
                      if (k.poin.isNotEmpty) ...[
                        const SizedBox(height: 10),
                        _DaftarPoin(items: k.poin, warna: c),
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

/// ---------------------------------------------------------------------------
///  AKORDEON
/// ---------------------------------------------------------------------------
class _AkordeonView extends StatelessWidget {
  final Akordeon b;
  final Color warna;
  const _AkordeonView({required this.b, required this.warna});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (final it in b.items)
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: _ItemAkordeonView(item: it, warna: warna),
          ),
      ],
    );
  }
}

class _ItemAkordeonView extends StatefulWidget {
  final ItemAkordeon item;
  final Color warna;
  const _ItemAkordeonView({required this.item, required this.warna});

  @override
  State<_ItemAkordeonView> createState() => _ItemAkordeonViewState();
}

class _ItemAkordeonViewState extends State<_ItemAkordeonView> {
  bool _buka = false;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final w = widget.warna;
    return Material(
      color: _buka ? tint(w, 0.08) : tint(cs.onSurface, 0.04),
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: _buka ? tint(w, 0.5) : tint(cs.onSurface, 0.12)),
      ),
      child: InkWell(
        onTap: () => setState(() => _buka = !_buka),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(widget.item.emoji, style: const TextStyle(fontSize: 26)),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      widget.item.judul,
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium!
                          .copyWith(fontWeight: FontWeight.w700, height: 1.25),
                    ),
                  ),
                  AnimatedRotation(
                    turns: _buka ? 0.5 : 0,
                    duration: const Duration(milliseconds: 250),
                    child: Icon(Icons.keyboard_arrow_down_rounded,
                        color: aksenTeks(context, w)),
                  ),
                ],
              ),
              AnimatedSize(
                duration: const Duration(milliseconds: 250),
                curve: Curves.easeInOut,
                alignment: Alignment.topCenter,
                child: _buka
                    ? Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: TeksKaya(widget.item.isi),
                      )
                    : const SizedBox(width: double.infinity, height: 0),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// ---------------------------------------------------------------------------
///  TAB PERBANDINGAN
/// ---------------------------------------------------------------------------
class _TabView extends StatefulWidget {
  final TabPerbandingan b;
  final Color warna;
  const _TabView({required this.b, required this.warna});

  @override
  State<_TabView> createState() => _TabViewState();
}

class _TabViewState extends State<_TabView> {
  int _i = 0;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final w = widget.warna;
    final t = widget.b.tab[_i];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              for (var i = 0; i < widget.b.tab.length; i++)
                Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: ChoiceChip(
                    showCheckmark: false,
                    selected: _i == i,
                    selectedColor: w,
                    label: Text('${widget.b.tab[i].emoji} ${widget.b.tab[i].label}'),
                    labelStyle: TextStyle(
                      fontWeight: FontWeight.w700,
                      color: _i == i ? Colors.white : cs.onSurface,
                    ),
                    onSelected: (_) => setState(() => _i = i),
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 250),
          child: Container(
            key: ValueKey<int>(_i),
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: tint(w, 0.08),
              borderRadius: BorderRadius.circular(18),
              border: Border.all(color: tint(w, 0.28)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(t.emoji, style: const TextStyle(fontSize: 28)),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        t.judul,
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(fontWeight: FontWeight.w800, height: 1.25),
                      ),
                    ),
                  ],
                ),
                if (t.isi.isNotEmpty) ...[
                  const SizedBox(height: 10),
                  TeksKaya(t.isi),
                ],
                if (t.poin.isNotEmpty) ...[
                  const SizedBox(height: 12),
                  _DaftarPoin(items: t.poin, warna: w),
                ],
              ],
            ),
          ),
        ),
      ],
    );
  }
}

/// ---------------------------------------------------------------------------
///  LINIMASA
/// ---------------------------------------------------------------------------
class _LinimasaView extends StatelessWidget {
  final Linimasa b;
  final Color warna;
  const _LinimasaView({required this.b, required this.warna});

  @override
  Widget build(BuildContext context) {
    final aksen = aksenTeks(context, warna);
    final tt = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (b.judul != null) ...[
          Text(b.judul!,
              style: tt.titleMedium!.copyWith(fontWeight: FontWeight.w800)),
          const SizedBox(height: 12),
        ],
        for (var i = 0; i < b.items.length; i++)
          IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(
                  width: 28,
                  child: Column(
                    children: [
                      Container(
                        width: 16,
                        height: 16,
                        margin: const EdgeInsets.only(top: 3),
                        decoration: BoxDecoration(
                          color: warna,
                          shape: BoxShape.circle,
                          border: Border.all(color: tint(warna, 0.3), width: 4),
                        ),
                      ),
                      if (i != b.items.length - 1)
                        Expanded(
                          child: Container(width: 2, color: tint(warna, 0.3)),
                        ),
                    ],
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(
                        bottom: i == b.items.length - 1 ? 0 : 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          b.items[i].waktu,
                          style: tt.labelLarge!
                              .copyWith(fontWeight: FontWeight.w800, color: aksen),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          b.items[i].judul,
                          style: tt.titleMedium!
                              .copyWith(fontWeight: FontWeight.w700, height: 1.25),
                        ),
                        const SizedBox(height: 4),
                        TeksKaya(
                          b.items[i].isi,
                          gaya: tt.bodyMedium!.copyWith(
                            height: 1.55,
                            fontSize: 15,
                            color: Theme.of(context).colorScheme.onSurface,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}

/// ---------------------------------------------------------------------------
///  PIRAMIDA INTERAKTIF
/// ---------------------------------------------------------------------------
class _PiramidaView extends StatefulWidget {
  final Piramida b;
  final Color warna;
  const _PiramidaView({required this.b, required this.warna});

  @override
  State<_PiramidaView> createState() => _PiramidaViewState();
}

class _PiramidaViewState extends State<_PiramidaView> {
  int? _pilih;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;
    final n = widget.b.level.length;
    final gelap = HSLColor.fromColor(widget.warna).withLightness(0.26).toColor();
    final terang = HSLColor.fromColor(widget.warna).withLightness(0.74).toColor();
    final kecil = tt.labelSmall!.copyWith(color: tint(cs.onSurface, 0.6));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(child: Text('▲ Kedudukan tertinggi', style: kecil)),
        const SizedBox(height: 8),
        for (var i = 0; i < n; i++)
          Padding(
            padding: const EdgeInsets.only(bottom: 6),
            child: Center(
              child: FractionallySizedBox(
                widthFactor: n == 1 ? 1.0 : 0.5 + 0.5 * i / (n - 1),
                child: Builder(builder: (context) {
                  final warnaLapis = Color.lerp(gelap, terang, n == 1 ? 0 : i / (n - 1))!;
                  final teks = warnaLapis.computeLuminance() > 0.5
                      ? Colors.black87
                      : Colors.white;
                  final aktif = _pilih == i;
                  return Material(
                    color: warnaLapis,
                    borderRadius: BorderRadius.circular(12),
                    clipBehavior: Clip.antiAlias,
                    child: InkWell(
                      onTap: () => setState(() => _pilih = aktif ? null : i),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 12, horizontal: 8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: aktif ? cs.onSurface : Colors.transparent,
                            width: 2,
                          ),
                        ),
                        child: Center(
                          child: Text(
                            '${i + 1}. ${widget.b.level[i].singkat}',
                            textAlign: TextAlign.center,
                            style: tt.titleSmall!.copyWith(
                                color: teks, fontWeight: FontWeight.w800),
                          ),
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ),
          ),
        const SizedBox(height: 2),
        Center(child: Text('▼ Kedudukan terendah', style: kecil)),
        const SizedBox(height: 12),
        AnimatedSize(
          duration: const Duration(milliseconds: 250),
          alignment: Alignment.topCenter,
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 250),
            child: _pilih == null
                ? Container(
                    key: const ValueKey<String>('petunjuk'),
                    width: double.infinity,
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: tint(cs.onSurface, 0.05),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Row(
                      children: [
                        const Text('👆', style: TextStyle(fontSize: 20)),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text('Ketuk salah satu lapisan untuk melihat rinciannya.',
                              style: tt.bodyMedium),
                        ),
                      ],
                    ),
                  )
                : _detail(context, widget.b.level[_pilih!]),
          ),
        ),
      ],
    );
  }

  Widget _detail(BuildContext context, LevelPiramida l) {
    final tt = Theme.of(context).textTheme;
    return Container(
      key: ValueKey<String>(l.singkat),
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: tint(widget.warna, 0.09),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: tint(widget.warna, 0.35)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(l.judul,
              style: tt.titleMedium!.copyWith(fontWeight: FontWeight.w800, height: 1.25)),
          if (l.pembuat.isNotEmpty) ...[
            const SizedBox(height: 8),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.person_outline_rounded,
                    size: 18, color: aksenTeks(context, widget.warna)),
                const SizedBox(width: 6),
                Expanded(
                  child: TeksKaya('Dibuat oleh: **${l.pembuat}**',
                      gaya: tt.bodyMedium!.copyWith(
                          height: 1.4,
                          color: Theme.of(context).colorScheme.onSurface)),
                ),
              ],
            ),
          ],
          const SizedBox(height: 8),
          TeksKaya(l.isi),
        ],
      ),
    );
  }
}

/// ---------------------------------------------------------------------------
///  KARTU BALIK
/// ---------------------------------------------------------------------------
class _KartuBalikView extends StatelessWidget {
  final KartuBalik b;
  final Color warna;
  const _KartuBalikView({required this.b, required this.warna});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (final it in b.items)
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: _KartuBalikItemView(item: it, warna: warna),
          ),
      ],
    );
  }
}

class _KartuBalikItemView extends StatefulWidget {
  final KartuBalikItem item;
  final Color warna;
  const _KartuBalikItemView({required this.item, required this.warna});

  @override
  State<_KartuBalikItemView> createState() => _KartuBalikItemViewState();
}

class _KartuBalikItemViewState extends State<_KartuBalikItemView> {
  bool _balik = false;

  Widget _depan(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;
    return Container(
      key: const ValueKey<String>('depan'),
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: tint(widget.warna, 0.10),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: tint(widget.warna, 0.35)),
      ),
      child: Row(
        children: [
          Text(widget.item.emoji, style: const TextStyle(fontSize: 36)),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.item.depan,
                    style: tt.titleMedium!
                        .copyWith(fontWeight: FontWeight.w800, height: 1.25)),
                const SizedBox(height: 4),
                Text('Ketuk untuk membalik kartu',
                    style: tt.bodySmall!.copyWith(color: tint(cs.onSurface, 0.6))),
              ],
            ),
          ),
          Icon(Icons.flip_rounded, color: aksenTeks(context, widget.warna)),
        ],
      ),
    );
  }

  Widget _belakang(BuildContext context) {
    final tt = Theme.of(context).textTheme;
    final putih = tt.bodyLarge!.copyWith(height: 1.55, color: Colors.white);
    return Container(
      key: const ValueKey<String>('belakang'),
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: widget.warna,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(widget.item.emoji, style: const TextStyle(fontSize: 22)),
              const SizedBox(width: 8),
              Expanded(
                child: Text(widget.item.depan,
                    style: tt.titleSmall!
                        .copyWith(color: Colors.white, fontWeight: FontWeight.w800)),
              ),
              const Icon(Icons.flip_rounded, color: Colors.white70, size: 20),
            ],
          ),
          const SizedBox(height: 10),
          TeksKaya(widget.item.belakang, gaya: putih),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => setState(() => _balik = !_balik),
      child: AnimatedSize(
        duration: const Duration(milliseconds: 250),
        alignment: Alignment.topCenter,
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 350),
          transitionBuilder: (child, animation) {
            final rotasi = Tween<double>(begin: math.pi / 2, end: 0).animate(animation);
            return AnimatedBuilder(
              animation: rotasi,
              child: child,
              builder: (context, child) => Transform(
                transform: Matrix4.rotationX(rotasi.value),
                alignment: Alignment.center,
                child: child,
              ),
            );
          },
          child: _balik ? _belakang(context) : _depan(context),
        ),
      ),
    );
  }
}

/// ---------------------------------------------------------------------------
///  STATISTIK
/// ---------------------------------------------------------------------------
class _StatistikView extends StatelessWidget {
  final Statistik b;
  final Color warna;
  const _StatistikView({required this.b, required this.warna});

  @override
  Widget build(BuildContext context) {
    final tt = Theme.of(context).textTheme;
    return LayoutBuilder(builder: (context, c) {
      final setengah = (c.maxWidth - 10) / 2;
      final n = b.items.length;
      return Wrap(
        spacing: 10,
        runSpacing: 10,
        children: [
          for (var i = 0; i < n; i++)
            SizedBox(
              width: (n.isOdd && i == n - 1) ? c.maxWidth : setengah,
              child: Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: tint(warna, 0.10),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: tint(warna, 0.3)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(b.items[i].emoji, style: const TextStyle(fontSize: 24)),
                    const SizedBox(height: 6),
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      alignment: Alignment.centerLeft,
                      child: Text(
                        b.items[i].angka,
                        style: tt.headlineSmall!.copyWith(
                            fontWeight: FontWeight.w900,
                            color: aksenTeks(context, warna)),
                      ),
                    ),
                    Text(b.items[i].label, style: tt.bodyMedium),
                  ],
                ),
              ),
            ),
        ],
      );
    });
  }
}

/// ---------------------------------------------------------------------------
///  CEKLIS KOMITMEN
/// ---------------------------------------------------------------------------
class _CeklisView extends StatefulWidget {
  final Ceklis b;
  final Color warna;
  const _CeklisView({required this.b, required this.warna});

  @override
  State<_CeklisView> createState() => _CeklisViewState();
}

class _CeklisViewState extends State<_CeklisView> {
  final Set<int> _centang = {};

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;
    final w = widget.warna;
    final n = widget.b.items.length;
    final semua = _centang.length == n;
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: tint(cs.onSurface, 0.04),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: tint(cs.onSurface, 0.12)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Text('📝', style: TextStyle(fontSize: 22)),
              const SizedBox(width: 8),
              Expanded(
                child: Text(widget.b.judul,
                    style: tt.titleMedium!.copyWith(fontWeight: FontWeight.w800)),
              ),
              Text('${_centang.length}/$n',
                  style: tt.labelLarge!.copyWith(
                      fontWeight: FontWeight.w800, color: aksenTeks(context, w))),
            ],
          ),
          const SizedBox(height: 8),
          for (var i = 0; i < n; i++)
            InkWell(
              borderRadius: BorderRadius.circular(12),
              onTap: () => setState(() {
                if (!_centang.remove(i)) _centang.add(i);
              }),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      _centang.contains(i)
                          ? Icons.check_box_rounded
                          : Icons.check_box_outline_blank_rounded,
                      color: _centang.contains(i) ? w : tint(cs.onSurface, 0.5),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: TeksKaya(
                        widget.b.items[i],
                        gaya: tt.bodyLarge!.copyWith(
                          height: 1.45,
                          color: cs.onSurface,
                          decoration: _centang.contains(i)
                              ? TextDecoration.lineThrough
                              : null,
                          decorationColor: tint(cs.onSurface, 0.5),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          AnimatedSize(
            duration: const Duration(milliseconds: 250),
            alignment: Alignment.topCenter,
            child: semua
                ? Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Text('🎉 Mantap! Semua komitmen sudah kamu centang.',
                        style: tt.bodyMedium!.copyWith(
                            fontWeight: FontWeight.w700,
                            color: aksenTeks(context, w))),
                  )
                : const SizedBox(width: double.infinity, height: 0),
          ),
        ],
      ),
    );
  }
}

/// ---------------------------------------------------------------------------
///  GAME URUTKAN
/// ---------------------------------------------------------------------------
class _UrutkanView extends StatefulWidget {
  final Urutkan b;
  final Color warna;
  const _UrutkanView({required this.b, required this.warna});

  @override
  State<_UrutkanView> createState() => _UrutkanViewState();
}

class _UrutkanViewState extends State<_UrutkanView> {
  late List<String> _daftar;
  bool _dicek = false;

  @override
  void initState() {
    super.initState();
    _acak();
  }

  bool _semuaBenar() {
    for (var i = 0; i < _daftar.length; i++) {
      if (_daftar[i] != widget.b.urutanBenar[i]) return false;
    }
    return true;
  }

  void _acak() {
    final l = List<String>.of(widget.b.urutanBenar)..shuffle(math.Random(11));
    _daftar = l;
    if (_semuaBenar()) _daftar = l.reversed.toList();
    _dicek = false;
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;
    final w = widget.warna;
    final benar = _dicek && _semuaBenar();

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: tint(w, 0.06),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: tint(w, 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Text('🔀', style: TextStyle(fontSize: 22)),
              const SizedBox(width: 8),
              Expanded(
                child: Text(widget.b.judul,
                    style: tt.titleMedium!.copyWith(fontWeight: FontWeight.w800)),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(widget.b.petunjuk, style: tt.bodyMedium),
          const SizedBox(height: 12),
          ReorderableListView(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            buildDefaultDragHandles: false,
            onReorder: (lama, baru) {
              setState(() {
                if (baru > lama) baru -= 1;
                final item = _daftar.removeAt(lama);
                _daftar.insert(baru, item);
                _dicek = false;
              });
            },
            children: [
              for (var i = 0; i < _daftar.length; i++)
                _itemUrut(context, i),
            ],
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              FilledButton(
                style: FilledButton.styleFrom(backgroundColor: w),
                onPressed: () => setState(() => _dicek = true),
                child: const Text('Periksa urutan'),
              ),
              const SizedBox(width: 8),
              TextButton(
                onPressed: () => setState(_acak),
                child: const Text('Acak ulang'),
              ),
            ],
          ),
          AnimatedSize(
            duration: const Duration(milliseconds: 250),
            alignment: Alignment.topCenter,
            child: !_dicek
                ? const SizedBox(width: double.infinity, height: 0)
                : Container(
                    width: double.infinity,
                    margin: const EdgeInsets.only(top: 12),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: tint(benar ? _hijau : _merah, 0.10),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: TeksKaya(
                      benar
                          ? '✅ **Tepat sekali!** ${widget.b.penjelasan}'
                          : '❌ **Belum tepat.** Perhatikan kotak berwarna merah, lalu geser dan coba lagi.',
                      gaya: tt.bodyMedium!.copyWith(height: 1.5, color: cs.onSurface),
                    ),
                  ),
          ),
        ],
      ),
    );
  }

  Widget _itemUrut(BuildContext context, int i) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;
    final teks = _daftar[i];
    final posisiBenar = widget.b.urutanBenar[i] == teks;
    Color garis = tint(cs.onSurface, 0.15);
    if (_dicek) garis = posisiBenar ? _hijau : _merah;
    return Container(
      key: ValueKey<String>(teks),
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.fromLTRB(12, 6, 4, 6),
      decoration: BoxDecoration(
        color: cs.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: garis, width: _dicek ? 2 : 1),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 13,
            backgroundColor: tint(widget.warna, 0.18),
            child: Text('${i + 1}',
                style: tt.labelMedium!.copyWith(
                    fontWeight: FontWeight.w800,
                    color: aksenTeks(context, widget.warna))),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 6),
              child: Text(teks, style: tt.bodyLarge!.copyWith(height: 1.35)),
            ),
          ),
          ReorderableDragStartListener(
            index: i,
            child: const Padding(
              padding: EdgeInsets.all(10),
              child: Icon(Icons.drag_indicator_rounded),
            ),
          ),
        ],
      ),
    );
  }
}

/// ---------------------------------------------------------------------------
///  MESIN KUIS (dipakai Latihan dan Klasifikasi)
/// ---------------------------------------------------------------------------
class _Q {
  final String teks;
  final List<String> opsi;
  final int benar;
  final String penjelasan;
  const _Q(this.teks, this.opsi, this.benar, this.penjelasan);
}

class _Engine extends StatefulWidget {
  final String judul;
  final String emoji;
  final String? petunjuk;
  final List<_Q> soal;
  final Color warna;
  final bool ringkas; // true: opsi berupa chip (untuk klasifikasi)
  const _Engine({
    required this.judul,
    required this.emoji,
    required this.soal,
    required this.warna,
    required this.ringkas,
    this.petunjuk,
  });

  @override
  State<_Engine> createState() => _EngineState();
}

class _EngineState extends State<_Engine> {
  int _i = 0;
  int? _pilih;
  int _skor = 0;
  bool _selesai = false;

  void _jawab(int p) {
    if (_pilih != null) return;
    setState(() {
      _pilih = p;
      if (p == widget.soal[_i].benar) _skor++;
    });
  }

  void _lanjut() {
    setState(() {
      if (_i + 1 >= widget.soal.length) {
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
    });
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final w = widget.warna;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: tint(w, 0.06),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: tint(w, 0.3)),
      ),
      child: AnimatedSize(
        duration: const Duration(milliseconds: 250),
        alignment: Alignment.topCenter,
        child: _selesai ? _hasil(context, cs) : _pertanyaan(context, cs),
      ),
    );
  }

  Widget _pertanyaan(BuildContext context, ColorScheme cs) {
    final tt = Theme.of(context).textTheme;
    final w = widget.warna;
    final q = widget.soal[_i];
    final n = widget.soal.length;
    final dijawab = _pilih != null;
    final benar = dijawab && _pilih == q.benar;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(widget.emoji, style: const TextStyle(fontSize: 22)),
            const SizedBox(width: 8),
            Expanded(
              child: Text(widget.judul,
                  style: tt.titleMedium!.copyWith(fontWeight: FontWeight.w800)),
            ),
            Text('${_i + 1}/$n',
                style: tt.labelLarge!.copyWith(
                    fontWeight: FontWeight.w800, color: aksenTeks(context, w))),
          ],
        ),
        const SizedBox(height: 10),
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: LinearProgressIndicator(
            value: (_i + (dijawab ? 1 : 0)) / n,
            minHeight: 6,
            color: w,
            backgroundColor: tint(w, 0.15),
          ),
        ),
        if (widget.petunjuk != null) ...[
          const SizedBox(height: 12),
          Text(widget.petunjuk!, style: tt.bodyMedium),
        ],
        const SizedBox(height: 14),
        if (widget.ringkas)
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 22, horizontal: 16),
            decoration: BoxDecoration(
              color: cs.surface,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: tint(cs.onSurface, 0.12)),
            ),
            child: Text(
              q.teks,
              textAlign: TextAlign.center,
              style: tt.titleLarge!
                  .copyWith(fontWeight: FontWeight.w800, height: 1.3),
            ),
          )
        else
          Text(q.teks,
              style: tt.titleMedium!
                  .copyWith(fontWeight: FontWeight.w700, height: 1.4)),
        const SizedBox(height: 14),
        if (widget.ringkas)
          Wrap(
            spacing: 8,
            runSpacing: 8,
            alignment: WrapAlignment.center,
            children: [for (var i = 0; i < q.opsi.length; i++) _chip(context, q, i)],
          )
        else
          Column(
            children: [for (var i = 0; i < q.opsi.length; i++) _tile(context, q, i)],
          ),
        if (dijawab) ...[
          const SizedBox(height: 12),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: tint(benar ? _hijau : _merah, 0.10),
              borderRadius: BorderRadius.circular(12),
            ),
            child: TeksKaya(
              benar
                  ? '✅ **Tepat!** ${q.penjelasan}'
                  : '❌ **Belum tepat.** Jawaban yang benar: **${q.opsi[q.benar]}**. ${q.penjelasan}',
              gaya: tt.bodyMedium!.copyWith(height: 1.5, color: cs.onSurface),
            ),
          ),
          const SizedBox(height: 12),
          Align(
            alignment: Alignment.centerRight,
            child: FilledButton(
              style: FilledButton.styleFrom(backgroundColor: w),
              onPressed: _lanjut,
              child: Text(_i + 1 >= n ? 'Lihat hasil' : 'Lanjut'),
            ),
          ),
        ],
      ],
    );
  }

  /// Warna dan ikon status sebuah opsi setelah dijawab.
  ({Color? warna, IconData? ikon, bool redup}) _status(_Q q, int i) {
    if (_pilih == null) return (warna: null, ikon: null, redup: false);
    if (i == q.benar) {
      return (warna: _hijau, ikon: Icons.check_circle_rounded, redup: false);
    }
    if (i == _pilih) {
      return (warna: _merah, ikon: Icons.cancel_rounded, redup: false);
    }
    return (warna: null, ikon: null, redup: true);
  }

  Widget _tile(BuildContext context, _Q q, int i) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;
    final s = _status(q, i);
    final garis = s.warna ?? tint(cs.onSurface, 0.15);
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Opacity(
        opacity: s.redup ? 0.55 : 1,
        child: Material(
          color: s.warna != null ? tint(s.warna!, 0.10) : cs.surface,
          clipBehavior: Clip.antiAlias,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
            side: BorderSide(color: garis, width: s.warna != null ? 2 : 1),
          ),
          child: InkWell(
            onTap: _pilih == null ? () => _jawab(i) : null,
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 13,
                    backgroundColor: tint(widget.warna, 0.18),
                    child: Text(String.fromCharCode(65 + i),
                        style: tt.labelMedium!.copyWith(
                            fontWeight: FontWeight.w800,
                            color: aksenTeks(context, widget.warna))),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(q.opsi[i], style: tt.bodyLarge!.copyWith(height: 1.35)),
                  ),
                  if (s.ikon != null) ...[
                    const SizedBox(width: 8),
                    Icon(s.ikon, color: s.warna),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _chip(BuildContext context, _Q q, int i) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;
    final s = _status(q, i);
    final garis = s.warna ?? tint(widget.warna, 0.5);
    return Opacity(
      opacity: s.redup ? 0.55 : 1,
      child: Material(
        color: s.warna != null ? tint(s.warna!, 0.12) : cs.surface,
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
          side: BorderSide(color: garis, width: 2),
        ),
        child: InkWell(
          onTap: _pilih == null ? () => _jawab(i) : null,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(q.opsi[i],
                    style: tt.titleSmall!.copyWith(fontWeight: FontWeight.w700)),
                if (s.ikon != null) ...[
                  const SizedBox(width: 6),
                  Icon(s.ikon, size: 18, color: s.warna),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _hasil(BuildContext context, ColorScheme cs) {
    final tt = Theme.of(context).textTheme;
    final n = widget.soal.length;
    final persen = _skor / n;
    final emoji = persen == 1 ? '🏆' : (persen >= 0.6 ? '🎉' : '💪');
    final pesan = persen == 1
        ? 'Sempurna! Kamu menguasai bagian ini.'
        : (persen >= 0.6
            ? 'Bagus sekali! Sedikit lagi sempurna.'
            : 'Jangan menyerah. Baca ulang materinya, lalu coba lagi.');
    return Column(
      children: [
        const SizedBox(height: 4),
        Text(emoji, style: const TextStyle(fontSize: 56)),
        const SizedBox(height: 8),
        Text('Skor kamu: $_skor dari $n',
            style: tt.titleLarge!.copyWith(fontWeight: FontWeight.w900)),
        const SizedBox(height: 6),
        Text(pesan, textAlign: TextAlign.center, style: tt.bodyLarge),
        const SizedBox(height: 14),
        OutlinedButton.icon(
          onPressed: _ulang,
          icon: const Icon(Icons.replay_rounded),
          label: const Text('Ulangi'),
        ),
      ],
    );
  }
}
