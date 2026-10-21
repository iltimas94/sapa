import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'materi_kelas8_data.dart';
import 'materi_kelas8_detail_page.dart';
import 'materi_kelas8_model.dart';
import 'materi_kelas8_widgets.dart';

/// ---------------------------------------------------------------------------
///  BANK MATERI KELAS VIII
///  Panggil dari menu:
///    Navigator.push(context,
///      MaterialPageRoute(builder: (_) => const BankMateriKelas8Page()));
/// ---------------------------------------------------------------------------
class BankMateriKelas8Page extends StatefulWidget {
  const BankMateriKelas8Page({super.key});

  @override
  State<BankMateriKelas8Page> createState() => _BankMateriKelas8PageState();
}

class _Hasil {
  final MateriKelas8 materi;
  final int skor;
  final List<int> bagian; // indeks bagian yang cocok
  const _Hasil(this.materi, this.skor, this.bagian);
}

class _BankMateriKelas8PageState extends State<BankMateriKelas8Page> {
  static const List<String> _topikPopuler = [
    'dasar negara',
    'uud 1945',
    'hierarki',
    'djuanda',
    'hoaks',
    'subak',
  ];

  final TextEditingController _ctl = TextEditingController();
  String _q = '';

  @override
  void dispose() {
    _ctl.dispose();
    super.dispose();
  }

  List<String> get _kataCari => _q
      .toLowerCase()
      .split(RegExp(r'\s+'))
      .map((s) => s.trim())
      .where((s) => s.isNotEmpty)
      .toList();

  List<_Hasil> get _hasilCari {
    final kata = _kataCari;
    if (kata.isEmpty) return const [];
    final daftar = <_Hasil>[];

    for (final m in daftarMateriKelas8) {
      final cocokDiBagian = <int>[];
      var totalSkor = 0;

      for (var i = 0; i < m.bagian.length; i++) {
        final b = m.bagian[i];
        var bagianCocok = true;
        for (final k in kata) {
          if (!b.teksCari.contains(k)) {
            bagianCocok = false;
            break;
          }
        }
        if (bagianCocok) {
          cocokDiBagian.add(i);
          totalSkor += 10;
        }
      }

      var materiCocok = true;
      for (final k in kata) {
        if (!m.judulCari.contains(k) &&
            !m.ringkasCari.contains(k) &&
            !m.kunciCari.contains(k) &&
            cocokDiBagian.isEmpty) {
          materiCocok = false;
          break;
        }
      }

      if (materiCocok) {
        for (final k in kata) {
          if (m.judulCari.contains(k)) totalSkor += 20;
          if (m.kunciCari.contains(k)) totalSkor += 15;
          if (m.ringkasCari.contains(k)) totalSkor += 5;
        }
        daftar.add(_Hasil(m, totalSkor, cocokDiBagian));
      }
    }

    daftar.sort((a, b) => b.skor.compareTo(a.skor));
    return daftar;
  }

  void _bukaMateri(MateriKelas8 materi, [int? bagianAwal]) {
    final idx = daftarMateriKelas8.indexOf(materi);
    final berikutnya =
        (idx >= 0 && idx + 1 < daftarMateriKelas8.length) ? daftarMateriKelas8[idx + 1] : null;

    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => DetailMateriKelas8Page(
          materi: materi,
          bagianAwal: bagianAwal,
          berikutnya: berikutnya,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;
    final mencari = _q.trim().isNotEmpty;
    final hasil = _hasilCari;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Materi PPKn Kelas VIII'),
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SearchBar(
                    controller: _ctl,
                    hintText: 'Cari materi: "djuanda", "hoaks", "pasal"...',
                    leading: const Icon(Icons.search_rounded),
                    trailing: _q.isEmpty
                        ? null
                        : [
                            IconButton(
                              icon: const Icon(Icons.close_rounded),
                              onPressed: () {
                                _ctl.clear();
                                setState(() => _q = '');
                              },
                            ),
                          ],
                    onChanged: (v) => setState(() => _q = v),
                    elevation: const WidgetStatePropertyAll(1),
                  ),
                  const SizedBox(height: 12),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        Text('Populer: ', style: tt.bodySmall),
                        for (final t in _topikPopuler)
                          Padding(
                            padding: const EdgeInsets.only(right: 6),
                            child: ActionChip(
                              label: Text(t),
                              labelStyle: tt.labelMedium,
                              visualDensity: VisualDensity.compact,
                              onPressed: () {
                                _ctl.text = t;
                                setState(() => _q = t);
                              },
                            ),
                          ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  if (mencari)
                    Text(
                      'Ditemukan ${hasil.length} materi untuk "$_q"',
                      style: tt.labelLarge!.copyWith(
                        color: cs.primary,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                ],
              ),
            ),
          ),
          if (mencari)
            _SliverHasilPencarian(
              hasil: hasil,
              kataCari: _kataCari,
              onTap: _bukaMateri,
            )
          else
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, i) => _KartuMateri(
                    materi: daftarMateriKelas8[i],
                    onTap: () => _bukaMateri(daftarMateriKelas8[i]),
                  ),
                  childCount: daftarMateriKelas8.length,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

/// Tampilan daftar hasil pencarian.
class _SliverHasilPencarian extends StatelessWidget {
  final List<_Hasil> hasil;
  final List<String> kataCari;
  final void Function(MateriKelas8 m, [int? bagian]) onTap;

  const _SliverHasilPencarian({
    required this.hasil,
    required this.kataCari,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;

    if (hasil.isEmpty) {
      return SliverToBoxAdapter(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            children: [
              const Text('🔍', style: TextStyle(fontSize: 48)),
              const SizedBox(height: 12),
              Text('Materi tidak ditemukan',
                  style: tt.titleMedium!.copyWith(fontWeight: FontWeight.w800)),
              const SizedBox(height: 6),
              Text(
                'Coba gunakan kata kunci lain yang lebih singkat, misalnya "djuanda", "hoaks", atau "pasal".',
                textAlign: TextAlign.center,
                style: tt.bodyMedium!.copyWith(color: tint(cs.onSurface, 0.65)),
              ),
            ],
          ),
        ),
      );
    }

    return SliverPadding(
      padding: const EdgeInsets.fromLTRB(16, 4, 16, 24),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, i) {
            final h = hasil[i];
            final m = h.materi;
            return Card(
              margin: const EdgeInsets.only(bottom: 12),
              clipBehavior: Clip.antiAlias,
              child: InkWell(
                onTap: () => onTap(m, h.bagian.isNotEmpty ? h.bagian.first : null),
                child: Padding(
                  padding: const EdgeInsets.all(14),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 38,
                            height: 38,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: tint(m.warna, 0.14),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(m.emoji, style: const TextStyle(fontSize: 20)),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Materi ${m.nomor}',
                                  style: tt.labelMedium!.copyWith(
                                    fontWeight: FontWeight.w800,
                                    color: aksenTeks(context, m.warna),
                                  ),
                                ),
                                Text(
                                  m.judul,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: tt.titleSmall!.copyWith(
                                      fontWeight: FontWeight.w800, height: 1.2),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      if (h.bagian.isNotEmpty) ...[
                        const SizedBox(height: 10),
                        Text('Cocok di bagian:',
                            style: tt.labelSmall!
                                .copyWith(color: tint(cs.onSurface, 0.6))),
                        const SizedBox(height: 4),
                        for (final idxBagian in h.bagian.take(3))
                          _CuplikanBagian(
                            bagian: m.bagian[idxBagian],
                            kataCari: kataCari,
                            onTap: () => onTap(m, idxBagian),
                          ),
                      ],
                    ],
                  ),
                ),
              ),
            );
          },
          childCount: hasil.length,
        ),
      ),
    );
  }
}

/// Item bagian yang cocok dengan hasil pencarian (menampilkan cuplikan teks).
class _CuplikanBagian extends StatelessWidget {
  final Bagian bagian;
  final List<String> kataCari;
  final VoidCallback onTap;

  const _CuplikanBagian({
    required this.bagian,
    required this.kataCari,
    required this.onTap,
  });

  String get _cuplikan {
    final teks = bagian.teksAsli;
    final rendah = teks.toLowerCase();
    var idxAwal = -1;
    for (final k in kataCari) {
      final pos = rendah.indexOf(k);
      if (pos >= 0 && (idxAwal == -1 || pos < idxAwal)) {
        idxAwal = pos;
      }
    }
    if (idxAwal == -1) {
      return teks.length > 90 ? '${teks.substring(0, 90)}...' : teks;
    }
    final mulai = math.max(0, idxAwal - 20);
    final akhir = math.min(teks.length, idxAwal + 80);
    var hasil = teks.substring(mulai, akhir);
    if (mulai > 0) hasil = '...$hasil';
    if (akhir < teks.length) hasil = '$hasil...';
    return hasil;
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.only(top: 4),
      child: Material(
        color: tint(cs.onSurface, 0.05),
        borderRadius: BorderRadius.circular(8),
        child: InkWell(
          borderRadius: BorderRadius.circular(8),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            child: Row(
              children: [
                Text(bagian.emoji, style: const TextStyle(fontSize: 16)),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(bagian.judul,
                          style: tt.labelMedium!.copyWith(fontWeight: FontWeight.w700)),
                      Text(
                        _cuplikan,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: tt.bodySmall!.copyWith(color: tint(cs.onSurface, 0.7)),
                      ),
                    ],
                  ),
                ),
                const Icon(Icons.arrow_forward_ios_rounded, size: 12),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Kartu materi di halaman utama bank materi.
class _KartuMateri extends StatelessWidget {
  final MateriKelas8 materi;
  final VoidCallback onTap;

  const _KartuMateri({required this.materi, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;
    final m = materi;

    return Card(
      margin: const EdgeInsets.only(bottom: 14),
      clipBehavior: Clip.antiAlias,
      elevation: 2,
      child: InkWell(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            border: Border(
              left: BorderSide(color: m.warna, width: 6),
            ),
          ),
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 44,
                    height: 44,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: tint(m.warna, 0.14),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(m.emoji, style: const TextStyle(fontSize: 24)),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Materi ${m.nomor}',
                          style: tt.labelLarge!.copyWith(
                            fontWeight: FontWeight.w800,
                            color: aksenTeks(context, m.warna),
                          ),
                        ),
                        Text(
                          m.judul,
                          style: tt.titleMedium!.copyWith(
                            fontWeight: FontWeight.w800,
                            height: 1.2,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Text(
                m.ringkas,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: tt.bodyMedium!.copyWith(
                  height: 1.45,
                  color: tint(cs.onSurface, 0.75),
                ),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Icon(Icons.schedule_rounded,
                      size: 16, color: tint(cs.onSurface, 0.6)),
                  const SizedBox(width: 4),
                  Text('${m.menitBaca} menit',
                      style: tt.bodySmall!.copyWith(color: tint(cs.onSurface, 0.6))),
                  const SizedBox(width: 14),
                  Icon(Icons.extension_rounded,
                      size: 16, color: tint(cs.onSurface, 0.6)),
                  const SizedBox(width: 4),
                  Text('${m.jumlahInteraktif} aktivitas',
                      style: tt.bodySmall!.copyWith(color: tint(cs.onSurface, 0.6))),
                  const Spacer(),
                  Icon(Icons.arrow_forward_rounded, color: aksenTeks(context, m.warna)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
