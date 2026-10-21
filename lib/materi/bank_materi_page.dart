// =============================================================================
// bank_materi_page.dart
// Halaman "Bank Materi" (kolom cari + daftar materi) dan halaman baca materi.
//
// PEMAKAIAN:
//   Navigator.push(context, MaterialPageRoute(
//     builder: (_) => BankMateriPage(
//       judul: 'Materi Kelas VII',
//       daftar: materiKelas7,
//       onBukaKuis: () { /* buka menu kuis kelas 7 */ },   // opsional
//     ),
//   ));
// =============================================================================
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'materi_blok_widgets.dart';
import 'materi_model.dart';

const Color _merahSapa = Color(0xFFB71C1C);

// ─────────────────────────────────────────────────────────────────────────────
// BANK MATERI
// ─────────────────────────────────────────────────────────────────────────────
class BankMateriPage extends StatefulWidget {
  final String judul;
  final List<Materi> daftar;
  final Color warnaTema;
  final VoidCallback? onBukaKuis;

  const BankMateriPage({
    super.key,
    required this.judul,
    required this.daftar,
    this.warnaTema = _merahSapa,
    this.onBukaKuis,
  });

  @override
  State<BankMateriPage> createState() => _BankMateriPageState();
}

class _BankMateriPageState extends State<BankMateriPage> {
  final TextEditingController _ctl = TextEditingController();
  String _q = '';
  int? _filter;

  @override
  void initState() {
    super.initState();
    ProgresMateri.instance.addListener(_segarkan);
  }

  void _segarkan() {
    if (mounted) setState(() {});
  }

  @override
  void dispose() {
    ProgresMateri.instance.removeListener(_segarkan);
    _ctl.dispose();
    super.dispose();
  }

  void _setQuery(String v) {
    setState(() {
      _q = v;
      if (pecahKataCari(v).isEmpty) _filter = null;
    });
  }

  void _buka(int indeks, {int bab = 0, List<String> kata = const []}) {
    FocusScope.of(context).unfocus();
    Navigator.of(context).push(MaterialPageRoute<void>(
      builder: (_) => DetailMateriPage(
        daftar: widget.daftar,
        indeks: indeks,
        babAwal: bab,
        kataCari: kata,
        onBukaKuis: widget.onBukaKuis,
      ),
    ));
  }

  int get _totalBab => widget.daftar.fold<int>(0, (s, m) => s + m.bab.length);
  int get _totalMenit => widget.daftar.fold<int>(0, (s, m) => s + m.menitBaca);

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final kata = pecahKataCari(_q);
    final mencari = kata.isNotEmpty;
    final hasil =
        mencari ? cariMateri(widget.daftar, _q, hanyaMateri: _filter) : const <HasilCari>[];
    final warna = widget.warnaTema;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: CustomScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            pinned: true,
            expandedHeight: 256,
            backgroundColor: warna,
            foregroundColor: Colors.white,
            systemOverlayStyle: SystemUiOverlayStyle.light,
            title: Text(widget.judul,
                style: const TextStyle(fontWeight: FontWeight.w800)),
            flexibleSpace: FlexibleSpaceBar(
              collapseMode: CollapseMode.parallax,
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [warna, gelapkan(warna, .16)],
                  ),
                ),
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 84),
                alignment: Alignment.bottomLeft,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Bank Materi',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 28,
                            fontWeight: FontWeight.w900)),
                    const SizedBox(height: 4),
                    Text(
                      'Cari topik apa pun, lalu langsung baca bagian yang kamu perlukan.',
                      style: TextStyle(
                          color: alfa(Colors.white, .88), fontSize: 13.5, height: 1.35),
                    ),
                    const SizedBox(height: 10),
                    Wrap(
                      spacing: 8,
                      runSpacing: 6,
                      children: [
                        _pil(Icons.menu_book, '${widget.daftar.length} materi'),
                        _pil(Icons.layers, '$_totalBab bagian'),
                        _pil(Icons.timer_outlined, '±$_totalMenit menit'),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(70),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 14),
                child: Material(
                  elevation: 3,
                  borderRadius: BorderRadius.circular(16),
                  color: cs.surface,
                  child: TextField(
                    controller: _ctl,
                    onChanged: _setQuery,
                    textInputAction: TextInputAction.search,
                    style: TextStyle(color: cs.onSurface, fontSize: 15.5),
                    decoration: InputDecoration(
                      hintText: 'Cari: bullying, BPUPK, norma hukum…',
                      hintStyle: TextStyle(color: cs.onSurface.withAlpha(120)),
                      prefixIcon: Icon(Icons.search, color: warna),
                      suffixIcon: _q.isEmpty
                          ? null
                          : IconButton(
                              icon: const Icon(Icons.close),
                              onPressed: () {
                                _ctl.clear();
                                _setQuery('');
                              },
                            ),
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(vertical: 15),
                    ),
                  ),
                ),
              ),
            ),
          ),
          if (!mencari) ..._tampilanAwal(cs),
          if (mencari) ..._tampilanHasil(cs, hasil, kata),
          const SliverToBoxAdapter(child: SizedBox(height: 40)),
        ],
      ),
    );
  }

  Widget _pil(IconData i, String t) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
            color: alfa(Colors.white, .18),
            borderRadius: BorderRadius.circular(20)),
        child: Row(mainAxisSize: MainAxisSize.min, children: [
          Icon(i, size: 14, color: Colors.white),
          const SizedBox(width: 5),
          Text(t,
              style: const TextStyle(
                  color: Colors.white, fontSize: 12, fontWeight: FontWeight.w700)),
        ]),
      );

  // ── tampilan tanpa pencarian ──────────────────────────────────────────────
  List<Widget> _tampilanAwal(ColorScheme cs) {
    final populer = <MapEntry<String, int>>[];
    for (var i = 0; i < widget.daftar.length; i++) {
      for (final k in widget.daftar[i].kataKunci.take(2)) {
        populer.add(MapEntry(k, i));
      }
    }
    return [
      SliverToBoxAdapter(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 18, 16, 6),
          child: Row(children: [
            Icon(Icons.local_fire_department, size: 18, color: widget.warnaTema),
            const SizedBox(width: 6),
            Text('Topik populer',
                style: TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 15,
                    color: cs.onSurface)),
          ]),
        ),
      ),
      SliverToBoxAdapter(
        child: SizedBox(
          height: 44,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            physics: const BouncingScrollPhysics(),
            itemCount: populer.length,
            separatorBuilder: (_, __) => const SizedBox(width: 8),
            itemBuilder: (context, i) {
              final w = widget.daftar[populer[i].value].warna;
              return ActionChip(
                backgroundColor: alfa(w, .10),
                side: BorderSide(color: alfa(w, .35)),
                label: Text(populer[i].key,
                    style: TextStyle(color: w, fontWeight: FontWeight.w700)),
                onPressed: () {
                  _ctl.text = populer[i].key;
                  _ctl.selection =
                      TextSelection.collapsed(offset: _ctl.text.length);
                  _setQuery(populer[i].key);
                },
              );
            },
          ),
        ),
      ),
      SliverToBoxAdapter(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 20, 16, 8),
          child: Text('Semua Materi',
              style: TextStyle(
                  fontWeight: FontWeight.w800, fontSize: 15, color: cs.onSurface)),
        ),
      ),
      SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, i) => _Masuk(
            indeks: i,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 14),
              child: _KartuMateri(
                materi: widget.daftar[i],
                selesai: ProgresMateri.instance.apakahSelesai(widget.daftar[i].id),
                onTap: () => _buka(i),
              ),
            ),
          ),
          childCount: widget.daftar.length,
        ),
      ),
    ];
  }

  // ── tampilan hasil pencarian ──────────────────────────────────────────────
  List<Widget> _tampilanHasil(
      ColorScheme cs, List<HasilCari> hasil, List<String> kata) {
    return [
      SliverToBoxAdapter(
        child: SizedBox(
          height: 56,
          child: ListView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
            physics: const BouncingScrollPhysics(),
            children: [
              _chipFilter('Semua', null, widget.warnaTema),
              for (var i = 0; i < widget.daftar.length; i++)
                _chipFilter('Materi ${widget.daftar[i].nomor}', i,
                    widget.daftar[i].warna),
            ],
          ),
        ),
      ),
      SliverToBoxAdapter(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 6, 16, 10),
          child: Text(
            hasil.isEmpty
                ? 'Tidak ada hasil'
                : '${hasil.length} bagian ditemukan untuk “${_q.trim()}”',
            style: TextStyle(
                fontSize: 13, color: cs.onSurface.withAlpha(160)),
          ),
        ),
      ),
      if (hasil.isEmpty)
        SliverToBoxAdapter(child: _kosong(cs))
      else
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, i) {
              final h = hasil[i];
              return Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 10),
                child: _KartuHasil(
                  hasil: h,
                  kata: kata,
                  onTap: () => _buka(h.indeksMateri, bab: h.indeksBab, kata: kata),
                ),
              );
            },
            childCount: hasil.length,
          ),
        ),
    ];
  }

  Widget _chipFilter(String t, int? nilai, Color w) {
    final aktif = _filter == nilai;
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: ChoiceChip(
        label: Text(t),
        selected: aktif,
        showCheckmark: false,
        selectedColor: w,
        backgroundColor: alfa(w, .10),
        side: BorderSide(color: alfa(w, .4)),
        labelStyle: TextStyle(
            color: aktif ? Colors.white : w, fontWeight: FontWeight.w700),
        onSelected: (_) => setState(() => _filter = nilai),
      ),
    );
  }

  Widget _kosong(ColorScheme cs) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(32, 30, 32, 10),
      child: Column(
        children: [
          Icon(Icons.search_off, size: 64, color: cs.onSurface.withAlpha(90)),
          const SizedBox(height: 10),
          Text('Belum ketemu',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                  color: cs.onSurface)),
          const SizedBox(height: 6),
          Text(
            'Coba kata yang lebih singkat atau ejaan lain, mis. “norma”, “toleransi”, atau “BPUPK”.',
            textAlign: TextAlign.center,
            style: TextStyle(
                height: 1.45, color: cs.onSurface.withAlpha(170), fontSize: 14),
          ),
          const SizedBox(height: 12),
          OutlinedButton.icon(
            onPressed: () {
              _ctl.clear();
              _setQuery('');
            },
            icon: const Icon(Icons.refresh),
            label: const Text('Hapus pencarian'),
          ),
        ],
      ),
    );
  }
}

/// Animasi masuk (fade + naik) berurutan untuk kartu.
class _Masuk extends StatelessWidget {
  final int indeks;
  final Widget child;
  const _Masuk({required this.indeks, required this.child});

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween<double>(begin: 0, end: 1),
      duration: Duration(milliseconds: 380 + indeks * 90),
      curve: Curves.easeOutCubic,
      builder: (context, v, c) => Opacity(
        opacity: v,
        child: Transform.translate(offset: Offset(0, (1 - v) * 24), child: c),
      ),
      child: child,
    );
  }
}

class _KartuMateri extends StatelessWidget {
  final Materi materi;
  final bool selesai;
  final VoidCallback onTap;
  const _KartuMateri(
      {required this.materi, required this.selesai, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final w = materi.warna;
    return Material(
      type: MaterialType.transparency,
      child: Ink(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(22),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [w, gelapkan(w, .14)],
          ),
          boxShadow: [
            BoxShadow(
                color: alfa(w, .32), blurRadius: 14, offset: const Offset(0, 7)),
          ],
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(22),
          onTap: onTap,
          child: Stack(
            children: [
              Positioned(
                right: -8,
                bottom: -22,
                child: Text(
                  '${materi.nomor}',
                  style: TextStyle(
                      fontSize: 120,
                      height: 1,
                      fontWeight: FontWeight.w900,
                      color: alfa(Colors.white, .10)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 46,
                          height: 46,
                          decoration: BoxDecoration(
                              color: alfa(Colors.white, .20),
                              shape: BoxShape.circle),
                          child: Icon(materi.ikon, color: Colors.white, size: 25),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text('Materi ${materi.nomor}',
                              style: TextStyle(
                                  color: alfa(Colors.white, .85),
                                  fontWeight: FontWeight.w800,
                                  letterSpacing: 1.4,
                                  fontSize: 12)),
                        ),
                        if (selesai)
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 9, vertical: 4),
                            decoration: BoxDecoration(
                                color: const Color(0xFF2E9E5B),
                                borderRadius: BorderRadius.circular(20)),
                            child: const Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.check, size: 13, color: Colors.white),
                                SizedBox(width: 3),
                                Text('Selesai',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 11.5,
                                        fontWeight: FontWeight.w800)),
                              ],
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Text(materi.judul,
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 19,
                            height: 1.25,
                            fontWeight: FontWeight.w900)),
                    const SizedBox(height: 6),
                    Text(materi.deskripsi,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            color: alfa(Colors.white, .90),
                            fontSize: 13.5,
                            height: 1.4)),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        _info(Icons.layers, '${materi.bab.length} bagian'),
                        const SizedBox(width: 14),
                        _info(Icons.timer_outlined, '±${materi.menitBaca} menit'),
                        const Spacer(),
                        const Icon(Icons.arrow_circle_right,
                            color: Colors.white, size: 28),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _info(IconData i, String t) => Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(i, size: 15, color: alfa(Colors.white, .9)),
          const SizedBox(width: 4),
          Text(t,
              style: TextStyle(
                  color: alfa(Colors.white, .9),
                  fontSize: 12.5,
                  fontWeight: FontWeight.w700)),
        ],
      );
}

class _KartuHasil extends StatelessWidget {
  final HasilCari hasil;
  final List<String> kata;
  final VoidCallback onTap;
  const _KartuHasil(
      {required this.hasil, required this.kata, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final w = hasil.materi.warna;
    TextSpan sorot(String t, TextStyle s) =>
        TextSpan(children: bangunSpan(t, s, kata));
    return Material(
      color: cs.surface,
      borderRadius: BorderRadius.circular(18),
      elevation: 1.5,
      shadowColor: alfa(Colors.black, .25),
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: alfa(w, .28)),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 42,
                height: 42,
                decoration:
                    BoxDecoration(color: alfa(w, .15), shape: BoxShape.circle),
                child: Icon(hasil.bab.ikon, color: w, size: 22),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'MATERI ${hasil.materi.nomor} · ${hasil.materi.judul}',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontSize: 11,
                          letterSpacing: .6,
                          fontWeight: FontWeight.w800,
                          color: w),
                    ),
                    const SizedBox(height: 3),
                    Text.rich(sorot(
                        hasil.bab.judul,
                        TextStyle(
                            fontSize: 15.5,
                            height: 1.3,
                            fontWeight: FontWeight.w800,
                            color: cs.onSurface))),
                    const SizedBox(height: 5),
                    Text.rich(
                      sorot(
                          hasil.cuplikan,
                          TextStyle(
                              fontSize: 13,
                              height: 1.4,
                              color: cs.onSurface.withAlpha(185))),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              Icon(Icons.chevron_right, color: cs.onSurface.withAlpha(120)),
            ],
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// HALAMAN BACA MATERI
// ─────────────────────────────────────────────────────────────────────────────
class DetailMateriPage extends StatefulWidget {
  final List<Materi> daftar;
  final int indeks;
  final int babAwal;
  final List<String> kataCari;
  final VoidCallback? onBukaKuis;

  const DetailMateriPage({
    super.key,
    required this.daftar,
    required this.indeks,
    this.babAwal = 0,
    this.kataCari = const [],
    this.onBukaKuis,
  });

  @override
  State<DetailMateriPage> createState() => _DetailMateriPageState();
}

class _DetailMateriPageState extends State<DetailMateriPage> {
  final ScrollController _ctl = ScrollController();
  final ValueNotifier<double> _progres = ValueNotifier<double>(0);
  final ValueNotifier<int> _aktif = ValueNotifier<int>(0);
  late final List<GlobalKey> _kunci =
      List<GlobalKey>.generate(_materi.bab.length, (_) => GlobalKey());
  late List<String> _kata = List<String>.of(widget.kataCari);
  double _skala = 1.0;

  Materi get _materi => widget.daftar[widget.indeks];

  @override
  void initState() {
    super.initState();
    _ctl.addListener(_saatGulir);
    if (widget.babAwal > 0) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Future<void>.delayed(const Duration(milliseconds: 350), () {
          if (mounted) _lompat(widget.babAwal);
        });
      });
    }
  }

  @override
  void dispose() {
    _ctl.removeListener(_saatGulir);
    _ctl.dispose();
    _progres.dispose();
    _aktif.dispose();
    super.dispose();
  }

  void _saatGulir() {
    if (!_ctl.hasClients) return;
    final max = _ctl.position.maxScrollExtent;
    _progres.value = max <= 0 ? 0 : (_ctl.offset / max).clamp(0.0, 1.0);
    final batas = MediaQuery.of(context).padding.top + kToolbarHeight + 140;
    var aktif = 0;
    for (var i = 0; i < _kunci.length; i++) {
      final ro = _kunci[i].currentContext?.findRenderObject();
      if (ro is RenderBox && ro.attached && ro.hasSize) {
        if (ro.localToGlobal(Offset.zero).dy <= batas) aktif = i;
      }
    }
    if (_aktif.value != aktif) _aktif.value = aktif;
  }

  void _lompat(int i) {
    final ctx = _kunci[i].currentContext;
    if (ctx == null || !_ctl.hasClients) return;
    final vp = _ctl.position.viewportDimension;
    final atas = MediaQuery.of(context).padding.top + kToolbarHeight + 10;
    Scrollable.ensureVisible(
      ctx,
      duration: const Duration(milliseconds: 650),
      curve: Curves.easeInOutCubic,
      alignment: vp <= 0 ? 0 : atas / vp,
    );
  }

  void _bukaDaftarIsi() {
    HapticFeedback.selectionClick();
    final m = _materi;
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (ctx) => DraggableScrollableSheet(
        expand: false,
        initialChildSize: .7,
        minChildSize: .4,
        maxChildSize: .92,
        builder: (ctx, sc) => ListView(
          controller: sc,
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
          children: [
            Text('Daftar Isi',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w900,
                    color: m.warna)),
            const SizedBox(height: 10),
            for (var i = 0; i < m.bab.length; i++)
              ValueListenableBuilder<int>(
                valueListenable: _aktif,
                builder: (context, aktif, _) => ListTile(
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14)),
                  tileColor: aktif == i ? alfa(m.warna, .10) : null,
                  leading: CircleAvatar(
                    radius: 17,
                    backgroundColor: aktif == i ? m.warna : alfa(m.warna, .14),
                    child: Text('${i + 1}',
                        style: TextStyle(
                            fontWeight: FontWeight.w800,
                            fontSize: 13,
                            color: aktif == i ? Colors.white : m.warna)),
                  ),
                  title: Text(m.bab[i].judul,
                      style: const TextStyle(
                          fontWeight: FontWeight.w700, height: 1.25)),
                  trailing: aktif == i
                      ? Icon(Icons.chrome_reader_mode, color: m.warna, size: 20)
                      : null,
                  onTap: () {
                    Navigator.of(ctx).pop();
                    Future<void>.delayed(
                        const Duration(milliseconds: 250), () {
                      if (mounted) _lompat(i);
                    });
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }

  void _bukaUkuranHuruf() {
    final m = _materi;
    showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setSheet) => Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 28),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Ukuran Huruf',
                  style: TextStyle(
                      fontSize: 20, fontWeight: FontWeight.w900, color: m.warna)),
              const SizedBox(height: 6),
              Row(
                children: [
                  const Text('A', style: TextStyle(fontSize: 14)),
                  Expanded(
                    child: Slider(
                      value: _skala,
                      min: 0.85,
                      max: 1.4,
                      divisions: 11,
                      activeColor: m.warna,
                      label: '${(_skala * 100).round()}%',
                      onChanged: (v) {
                        setState(() => _skala = v);
                        setSheet(() {});
                      },
                    ),
                  ),
                  const Text('A',
                      style: TextStyle(fontSize: 26, fontWeight: FontWeight.w700)),
                ],
              ),
              Text(
                'Contoh: Pancasila adalah dasar negara dan pandangan hidup bangsa Indonesia.',
                style: TextStyle(fontSize: 15.5 * _skala, height: 1.5),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final m = _materi;
    final cs = Theme.of(context).colorScheme;
    final adaBerikut = widget.indeks + 1 < widget.daftar.length;

    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _bukaDaftarIsi,
        backgroundColor: m.warna,
        foregroundColor: Colors.white,
        icon: const Icon(Icons.list_alt),
        label: const Text('Daftar Isi',
            style: TextStyle(fontWeight: FontWeight.w800)),
      ),
      body: CustomScrollView(
        controller: _ctl,
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            pinned: true,
            expandedHeight: 270,
            backgroundColor: m.warna,
            foregroundColor: Colors.white,
            systemOverlayStyle: SystemUiOverlayStyle.light,
            title: Text('Materi ${m.nomor}',
                style: const TextStyle(fontWeight: FontWeight.w800)),
            actions: [
              IconButton(
                tooltip: 'Ukuran huruf',
                icon: const Icon(Icons.text_fields),
                onPressed: _bukaUkuranHuruf,
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              collapseMode: CollapseMode.parallax,
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [m.warna, gelapkan(m.warna, .18)],
                  ),
                ),
                child: Stack(
                  children: [
                    Positioned(
                      right: -24,
                      top: 40,
                      child: Icon(m.ikon,
                          size: 190, color: alfa(Colors.white, .10)),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 0, 20, 26),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(m.judul,
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 25,
                                  height: 1.2,
                                  fontWeight: FontWeight.w900)),
                          const SizedBox(height: 10),
                          Wrap(spacing: 8, runSpacing: 6, children: [
                            _pilHeader(Icons.layers, '${m.bab.length} bagian'),
                            _pilHeader(
                                Icons.timer_outlined, '±${m.menitBaca} menit baca'),
                          ]),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(4),
              child: ValueListenableBuilder<double>(
                valueListenable: _progres,
                builder: (context, v, _) => LinearProgressIndicator(
                  value: v,
                  minHeight: 4,
                  backgroundColor: alfa(Colors.white, .22),
                  valueColor: const AlwaysStoppedAnimation<Color>(Colors.amberAccent),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: MateriScope(
              warna: m.warna,
              skala: _skala,
              kataCari: _kata,
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 720),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      if (_kata.isNotEmpty) _bannerSorot(cs, m),
                      for (var i = 0; i < m.bab.length; i++)
                        _bagian(i, m, cs),
                      _penutup(m, cs, adaBerikut),
                      const SizedBox(height: 90),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _pilHeader(IconData i, String t) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
            color: alfa(Colors.white, .20),
            borderRadius: BorderRadius.circular(20)),
        child: Row(mainAxisSize: MainAxisSize.min, children: [
          Icon(i, size: 14, color: Colors.white),
          const SizedBox(width: 5),
          Text(t,
              style: const TextStyle(
                  color: Colors.white, fontSize: 12, fontWeight: FontWeight.w700)),
        ]),
      );

  Widget _bannerSorot(ColorScheme cs, Materi m) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 14, 20, 0),
      child: Container(
        padding: const EdgeInsets.fromLTRB(12, 6, 4, 6),
        decoration: BoxDecoration(
          color: const Color(0xFFFFF3C4),
          borderRadius: BorderRadius.circular(14),
        ),
        child: Row(
          children: [
            const Icon(Icons.highlight, size: 18, color: Color(0xFF8D6E00)),
            const SizedBox(width: 8),
            Expanded(
              child: Text('Menyorot: ${_kata.join(', ')}',
                  style: const TextStyle(
                      color: Color(0xFF5D4A00),
                      fontWeight: FontWeight.w700,
                      fontSize: 13)),
            ),
            TextButton(
              onPressed: () => setState(() => _kata = <String>[]),
              child: const Text('Hapus'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _bagian(int i, Materi m, ColorScheme cs) {
    final b = m.bab[i];
    return Padding(
      key: _kunci[i],
      padding: const EdgeInsets.only(top: 26),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Muncul(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 14),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 44,
                    height: 44,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                          colors: [m.warna, gelapkan(m.warna, .15)]),
                      boxShadow: [
                        BoxShadow(
                            color: alfa(m.warna, .35),
                            blurRadius: 8,
                            offset: const Offset(0, 3)),
                      ],
                    ),
                    child: Text('${i + 1}',
                        style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w900,
                            fontSize: 18)),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text.rich(
                      TextSpan(
                        children: bangunSpan(
                          b.judul,
                          TextStyle(
                              fontSize: 19.5 * _skala,
                              height: 1.25,
                              fontWeight: FontWeight.w900,
                              color: cs.onSurface),
                          _kata,
                        ),
                      ),
                    ),
                  ),
                  Icon(b.ikon, color: alfa(m.warna, .8), size: 26),
                ],
              ),
            ),
          ),
          DaftarBlok(blok: b.isi, muncul: true, padH: 20),
          if (i < m.bab.length - 1)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Divider(color: alfa(cs.onSurface, .12), height: 1),
            ),
        ],
      ),
    );
  }

  Widget _penutup(Materi m, ColorScheme cs, bool adaBerikut) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 28, 20, 0),
      child: AnimatedBuilder(
        animation: ProgresMateri.instance,
        builder: (context, _) {
          final selesai = ProgresMateri.instance.apakahSelesai(m.id);
          return Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: alfa(m.warna, .08),
              borderRadius: BorderRadius.circular(22),
              border: Border.all(color: alfa(m.warna, .35)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Icon(selesai ? Icons.verified : Icons.celebration,
                    size: 44, color: m.warna),
                const SizedBox(height: 8),
                Text(
                  selesai ? 'Materi ini sudah selesai' : 'Kamu sudah sampai di akhir!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 18, fontWeight: FontWeight.w900, color: m.warna),
                ),
                const SizedBox(height: 14),
                ElevatedButton.icon(
                  onPressed: () {
                    HapticFeedback.mediumImpact();
                    ProgresMateri.instance.atur(m.id, !selesai);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: selesai ? cs.surface : m.warna,
                    foregroundColor: selesai ? m.warna : Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                        side: BorderSide(color: m.warna)),
                  ),
                  icon: Icon(selesai ? Icons.undo : Icons.check_circle),
                  label: Text(selesai ? 'Batalkan tanda selesai' : 'Tandai Selesai'),
                ),
                if (widget.onBukaKuis != null) ...[
                  const SizedBox(height: 10),
                  OutlinedButton.icon(
                    onPressed: widget.onBukaKuis,
                    style: OutlinedButton.styleFrom(
                      foregroundColor: m.warna,
                      side: BorderSide(color: m.warna, width: 1.5),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14)),
                    ),
                    icon: const Icon(Icons.quiz),
                    label: const Text('Uji dengan Kuis'),
                  ),
                ],
                if (adaBerikut) ...[
                  const SizedBox(height: 10),
                  TextButton.icon(
                    onPressed: () {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute<void>(
                          builder: (_) => DetailMateriPage(
                            daftar: widget.daftar,
                            indeks: widget.indeks + 1,
                            onBukaKuis: widget.onBukaKuis,
                          ),
                        ),
                      );
                    },
                    style: TextButton.styleFrom(foregroundColor: m.warna),
                    icon: const Icon(Icons.arrow_forward),
                    label: Text(
                      'Lanjut: ${widget.daftar[widget.indeks + 1].judul}',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ],
            ),
          );
        },
      ),
    );
  }
}
