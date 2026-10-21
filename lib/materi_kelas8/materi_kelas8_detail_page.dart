import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'materi_kelas8_model.dart';
import 'materi_kelas8_widgets.dart';

/// Halaman baca satu materi: header, bar progres baca, daftar isi,
/// pengatur ukuran teks, dan seluruh blok interaktif.
class DetailMateriKelas8Page extends StatefulWidget {
  final MateriKelas8 materi;

  /// Jika diisi, halaman langsung menggulir ke bagian ini (dipakai hasil pencarian).
  final int? bagianAwal;

  /// Materi berikutnya (opsional) untuk tombol "Lanjut" di akhir halaman.
  final MateriKelas8? berikutnya;

  const DetailMateriKelas8Page({
    super.key,
    required this.materi,
    this.bagianAwal,
    this.berikutnya,
  });

  @override
  State<DetailMateriKelas8Page> createState() => _DetailMateriKelas8PageState();
}

class _DetailMateriKelas8PageState extends State<DetailMateriKelas8Page> {
  static const double _tinggiHeader = 240;

  final ScrollController _scroll = ScrollController();
  final ValueNotifier<double> _progres = ValueNotifier<double>(0);
  final ValueNotifier<bool> _runtuh = ValueNotifier<bool>(false);
  late final List<GlobalKey> _kunci;
  double _skala = 1.0;

  MateriKelas8 get _m => widget.materi;

  @override
  void initState() {
    super.initState();
    _kunci = List<GlobalKey>.generate(_m.bagian.length, (_) => GlobalKey());
    _scroll.addListener(_onScroll);
    if (widget.bagianAwal != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) _keBagian(widget.bagianAwal!, animasi: false);
      });
    }
  }

  @override
  void dispose() {
    _scroll.removeListener(_onScroll);
    _scroll.dispose();
    _progres.dispose();
    _runtuh.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (!_scroll.hasClients) return;
    final max = _scroll.position.maxScrollExtent;
    _progres.value =
        max <= 0 ? 0.0 : (_scroll.offset / max).clamp(0.0, 1.0).toDouble();
    final atas = MediaQuery.of(context).padding.top;
    _runtuh.value = _scroll.offset > _tinggiHeader - kToolbarHeight - atas - 8;
  }

  void _keBagian(int i, {bool animasi = true}) {
    if (i < 0 || i >= _kunci.length) return;
    final ctx = _kunci[i].currentContext;
    if (ctx == null) return;
    final mq = MediaQuery.of(context);
    final atas = mq.padding.top + kToolbarHeight + 8;
    Scrollable.ensureVisible(
      ctx,
      alignment: atas / mq.size.height,
      duration: animasi ? const Duration(milliseconds: 450) : Duration.zero,
      curve: Curves.easeInOutCubic,
    );
  }

  void _tampilDaftarIsi() {
    showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      isScrollControlled: true,
      builder: (ctx) => SafeArea(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxHeight: MediaQuery.of(ctx).size.height * 0.75),
          child: ListView(
            shrinkWrap: true,
            padding: const EdgeInsets.fromLTRB(8, 0, 8, 16),
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
                child: Text(
                  'Daftar isi',
                  style: Theme.of(ctx)
                      .textTheme
                      .titleLarge!
                      .copyWith(fontWeight: FontWeight.w800),
                ),
              ),
              for (var i = 0; i < _m.bagian.length; i++)
                ListTile(
                  leading: Text(_m.bagian[i].emoji, style: const TextStyle(fontSize: 24)),
                  title: Text(_m.bagian[i].judul,
                      style: const TextStyle(fontWeight: FontWeight.w600)),
                  subtitle: Text('Bagian ${i + 1}'),
                  trailing: const Icon(Icons.chevron_right_rounded),
                  onTap: () {
                    Navigator.of(ctx).pop();
                    Future<void>.delayed(const Duration(milliseconds: 280), () {
                      if (mounted) _keBagian(i);
                    });
                  },
                ),
            ],
          ),
        ),
      ),
    );
  }

  void _pilihUkuranTeks() {
    showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setSheet) => SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Ukuran teks',
                  style: Theme.of(ctx)
                      .textTheme
                      .titleLarge!
                      .copyWith(fontWeight: FontWeight.w800),
                ),
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  child: SegmentedButton<double>(
                    showSelectedIcon: false,
                    segments: const [
                      ButtonSegment<double>(value: 0.9, label: Text('Kecil')),
                      ButtonSegment<double>(value: 1.0, label: Text('Normal')),
                      ButtonSegment<double>(value: 1.15, label: Text('Besar')),
                      ButtonSegment<double>(value: 1.3, label: Text('Jumbo')),
                    ],
                    selected: {_skala},
                    onSelectionChanged: (s) {
                      setState(() => _skala = s.first);
                      setSheet(() {});
                    },
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  'Teks akan menyesuaikan, jadi nyaman dibaca di layar HP.',
                  style: Theme.of(ctx).textTheme.bodySmall,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    final skalaSistem = mq.textScaler.scale(1.0);
    final dataTeks = mq.copyWith(textScaler: TextScaler.linear(skalaSistem * _skala));

    return Scaffold(
      body: CustomScrollView(
        controller: _scroll,
        slivers: [
          SliverAppBar(
            pinned: true,
            expandedHeight: _tinggiHeader,
            backgroundColor: _m.warna,
            foregroundColor: Colors.white,
            surfaceTintColor: Colors.transparent,
            systemOverlayStyle: SystemUiOverlayStyle.light,
            title: ValueListenableBuilder<bool>(
              valueListenable: _runtuh,
              builder: (_, runtuh, __) => AnimatedOpacity(
                opacity: runtuh ? 1 : 0,
                duration: const Duration(milliseconds: 200),
                child: Text(
                  'Materi ${_m.nomor}: ${_m.judul}',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                ),
              ),
            ),
            actions: [
              IconButton(
                tooltip: 'Ukuran teks',
                icon: const Icon(Icons.format_size_rounded),
                onPressed: _pilihUkuranTeks,
              ),
              IconButton(
                tooltip: 'Daftar isi',
                icon: const Icon(Icons.format_list_bulleted_rounded),
                onPressed: _tampilDaftarIsi,
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(background: _Header(materi: _m)),
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(4),
              child: ValueListenableBuilder<double>(
                valueListenable: _progres,
                builder: (_, v, __) => LinearProgressIndicator(
                  value: v,
                  minHeight: 4,
                  backgroundColor: Colors.white24,
                  valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: MediaQuery(
              data: dataTeks,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 4, 16, 32),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    for (var i = 0; i < _m.bagian.length; i++) _bagian(context, i),
                    const SizedBox(height: 36),
                    _Penutup(materi: _m, berikutnya: widget.berikutnya),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _bagian(BuildContext context, int i) {
    final b = _m.bagian[i];
    final tt = Theme.of(context).textTheme;
    final aksen = aksenTeks(context, _m.warna);
    return Padding(
      key: _kunci[i],
      padding: const EdgeInsets.only(top: 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 46,
                height: 46,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: tint(_m.warna, 0.14),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Text(b.emoji, style: const TextStyle(fontSize: 24)),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Bagian ${i + 1} dari ${_m.bagian.length}',
                      style: tt.labelMedium!
                          .copyWith(fontWeight: FontWeight.w700, color: aksen),
                    ),
                    Text(
                      b.judul,
                      style: tt.titleLarge!
                          .copyWith(fontWeight: FontWeight.w800, height: 1.2),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          for (final blok in b.blok)
            Padding(
              padding: const EdgeInsets.only(bottom: 14),
              child: BlokView(blok: blok, warna: _m.warna),
            ),
        ],
      ),
    );
  }
}

/// Header berwarna dengan emoji besar (atau gambar sampul jika diisi).
class _Header extends StatelessWidget {
  final MateriKelas8 materi;
  const _Header({required this.materi});

  @override
  Widget build(BuildContext context) {
    final atas = MediaQuery.of(context).padding.top;
    final tt = Theme.of(context).textTheme;
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [gelapkan(materi.warna, 0.7), materi.warna],
        ),
      ),
      child: Stack(
        fit: StackFit.expand,
        children: [
          if (materi.sampul != null)
            Image.asset(
              materi.sampul!,
              fit: BoxFit.cover,
              color: Colors.black45,
              colorBlendMode: BlendMode.darken,
              errorBuilder: (_, __, ___) => const SizedBox.shrink(),
            ),
          Positioned(
            right: -8,
            bottom: 18,
            child: Opacity(
              opacity: 0.22,
              child: Text(materi.emoji, style: const TextStyle(fontSize: 130)),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(20, atas + 56, 20, 28),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.white24,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    'Materi ${materi.nomor}  •  Kelas VIII',
                    style: tt.labelMedium!
                        .copyWith(color: Colors.white, fontWeight: FontWeight.w700),
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  materi.judul,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: tt.headlineSmall!.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w900,
                    height: 1.15,
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    const Icon(Icons.schedule_rounded, size: 16, color: Colors.white70),
                    const SizedBox(width: 4),
                    Text('${materi.menitBaca} menit',
                        style: tt.bodySmall!.copyWith(color: Colors.white70)),
                    const SizedBox(width: 14),
                    const Icon(Icons.extension_rounded, size: 16, color: Colors.white70),
                    const SizedBox(width: 4),
                    Text('${materi.jumlahInteraktif} aktivitas',
                        style: tt.bodySmall!.copyWith(color: Colors.white70)),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Kartu penutup di akhir materi.
class _Penutup extends StatelessWidget {
  final MateriKelas8 materi;
  final MateriKelas8? berikutnya;
  const _Penutup({required this.materi, this.berikutnya});

  @override
  Widget build(BuildContext context) {
    final tt = Theme.of(context).textTheme;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [gelapkan(materi.warna, 0.7), materi.warna],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        children: [
          const Text('🎉', style: TextStyle(fontSize: 48)),
          const SizedBox(height: 8),
          Text(
            'Materi ${materi.nomor} selesai!',
            style: tt.titleLarge!
                .copyWith(color: Colors.white, fontWeight: FontWeight.w900),
          ),
          const SizedBox(height: 6),
          Text(
            'Kamu sudah sampai di akhir bab ini. Ulangi kuisnya kalau mau skor yang lebih tinggi.',
            textAlign: TextAlign.center,
            style: tt.bodyMedium!.copyWith(color: Colors.white70),
          ),
          const SizedBox(height: 16),
          if (berikutnya != null)
            SizedBox(
              width: double.infinity,
              child: FilledButton.icon(
                style: FilledButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: gelapkan(materi.warna, 0.8),
                ),
                onPressed: () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute<void>(
                      builder: (_) => DetailMateriKelas8Page(materi: berikutnya!),
                    ),
                  );
                },
                icon: const Icon(Icons.arrow_forward_rounded),
                label: Text('Lanjut: Materi ${berikutnya!.nomor}'),
              ),
            ),
          SizedBox(
            width: double.infinity,
            child: TextButton(
              style: TextButton.styleFrom(foregroundColor: Colors.white),
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Kembali ke bank materi'),
            ),
          ),
        ],
      ),
    );
  }
}
