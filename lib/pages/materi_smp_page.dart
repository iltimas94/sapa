import 'package:flutter/material.dart';

import '../data/materi_kelas7.dart';
import '../data/materi_kelas8.dart';
import '../data/materi_kelas9.dart';
import '../models/materi_content.dart';
import '../models/student_level.dart';
import 'quiz_page.dart';

/// Halaman daftar materi PPKn untuk jenjang SMP (kelas 7, 8, dan 9).
class MateriSmpPage extends StatefulWidget {
  const MateriSmpPage({super.key, required this.level});

  /// Jenjang SMP yang sedang dibuka.
  final StudentLevel level;

  @override
  State<MateriSmpPage> createState() => _MateriSmpPageState();
}

class _MateriSmpPageState extends State<MateriSmpPage> {
  final TextEditingController _searchController = TextEditingController();
  String _query = '';

  /// Daftar materi sesuai jenjang yang dipilih.
  List<MateriSection> get _sections {
    switch (widget.level) {
      case StudentLevel.smp7:
        return materiKelas7;
      case StudentLevel.smp8:
        return materiKelas8;
      case StudentLevel.smp9:
        return materiKelas9;
      case StudentLevel.sd:
        return <MateriSection>[];
    }
  }

  /// Hasil filter pencarian materi.
  List<MateriSection> get _filteredSections {
    final String query = _query.trim().toLowerCase();
    if (query.isEmpty) {
      return _sections;
    }
    return _sections
        .where((MateriSection section) => section.matches(query))
        .toList();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final bool materiBelumAda = _sections.isEmpty;

    return Scaffold(
      appBar: AppBar(title: Text('Materi ${widget.level.fullLabel}')),
      body: materiBelumAda
          ? _buildBelumTersedia(context)
          : Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 4),
                  child: TextField(
                    controller: _searchController,
                    textInputAction: TextInputAction.search,
                    onChanged: (String value) =>
                        setState(() => _query = value),
                    decoration: InputDecoration(
                      hintText: 'Cari materi, contoh: norma',
                      prefixIcon: const Icon(Icons.search_rounded),
                      suffixIcon: _query.trim().isEmpty
                          ? null
                          : IconButton(
                              tooltip: 'Hapus pencarian',
                              icon: const Icon(Icons.close_rounded),
                              onPressed: () {
                                _searchController.clear();
                                setState(() => _query = '');
                              },
                            ),
                      filled: true,
                      fillColor: theme.colorScheme.surface,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: _filteredSections.isEmpty
                      ? _buildTidakDitemukan(context)
                      : ListView.builder(
                          padding: const EdgeInsets.fromLTRB(16, 10, 16, 24),
                          itemCount: _filteredSections.length,
                          itemBuilder: (BuildContext context, int index) {
                            return _buildSectionCard(
                                context, _filteredSections[index]);
                          },
                        ),
                ),
              ],
            ),
    );
  }

  Widget _buildSectionCard(BuildContext context, MateriSection section) {
    final ThemeData theme = Theme.of(context);
    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute<void>(
            builder: (BuildContext context) =>
                MateriDetailPage(section: section, level: widget.level),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              CircleAvatar(
                radius: 22,
                backgroundColor: theme.colorScheme.primary,
                child: Text(
                  '${section.number}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Materi ${section.number}',
                      style: theme.textTheme.labelMedium?.copyWith(
                        color: theme.colorScheme.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      section.title,
                      style: theme.textTheme.titleMedium
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      section.summary,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.bodySmall
                          ?.copyWith(color: Colors.grey[700], height: 1.4),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '${section.blocks.length} bagian materi',
                      style: theme.textTheme.labelSmall
                          ?.copyWith(color: Colors.grey[600]),
                    ),
                  ],
                ),
              ),
              Icon(Icons.chevron_right_rounded,
                  color: theme.colorScheme.primary),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBelumTersedia(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              'assets/images/maskot_semangat.png',
              height: 130,
              errorBuilder: (BuildContext context, Object error,
                      StackTrace? stackTrace) =>
                  Icon(
                Icons.auto_stories_rounded,
                size: 90,
                color: theme.colorScheme.primary,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Materi ${widget.level.fullLabel} segera hadir',
              textAlign: TextAlign.center,
              style: theme.textTheme.titleLarge
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              'Materi ${widget.level.kelasLabel} sedang disusun. Sementara itu kamu tetap bisa bermain Kuis, menonton Lagu Nasional, dan bertanya lewat Tanya AI.',
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyMedium
                  ?.copyWith(color: Colors.grey[700], height: 1.5),
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              icon: const Icon(Icons.quiz_rounded),
              label: const Text('Main Kuis Dulu'),
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute<void>(
                  builder: (BuildContext context) =>
                      QuizPage(level: widget.level),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTidakDitemukan(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(Icons.search_off_rounded, size: 72, color: Colors.grey[400]),
            const SizedBox(height: 16),
            Text(
              'Materi tidak ditemukan',
              style: theme.textTheme.titleMedium
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              'Coba gunakan kata kunci lain ya.',
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyMedium
                  ?.copyWith(color: Colors.grey[600]),
            ),
          ],
        ),
      ),
    );
  }
}

/// Halaman isi satu bab materi SMP.
class MateriDetailPage extends StatelessWidget {
  const MateriDetailPage({super.key, required this.section, this.level});

  /// Bab materi yang ditampilkan.
  final MateriSection section;

  /// Jenjang pemilik materi, dipakai saat membuka kuis.
  final StudentLevel? level;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(title: Text('Materi ${section.number}')),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
        children: <Widget>[
          Text(
            section.title,
            style: theme.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
              color: theme.colorScheme.primary,
            ),
          ),
          const SizedBox(height: 14),
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: theme.colorScheme.primaryContainer.withValues(alpha: 0.4),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Pengantar',
                  style: theme.textTheme.labelLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.primary,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  section.summary,
                  style: theme.textTheme.bodyMedium?.copyWith(height: 1.6),
                ),
              ],
            ),
          ),
          ...section.blocks
              .map((MateriBlock block) => _buildBlock(context, block)),
          const SizedBox(height: 26),
          ElevatedButton.icon(
            icon: const Icon(Icons.quiz_rounded),
            label: const Text('Uji Pemahaman dengan Kuis'),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute<void>(
                builder: (BuildContext context) => QuizPage(level: level),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBlock(BuildContext context, MateriBlock block) {
    final ThemeData theme = Theme.of(context);
    switch (block.type) {
      case MateriBlockType.heading:
        return Padding(
          padding: const EdgeInsets.only(top: 22, bottom: 8),
          child: Text(
            block.text,
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: theme.colorScheme.primary,
            ),
          ),
        );
      case MateriBlockType.paragraph:
        return Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Text(
            block.text,
            style: theme.textTheme.bodyMedium?.copyWith(height: 1.6),
          ),
        );
      case MateriBlockType.bullet:
        return Padding(
          padding: const EdgeInsets.only(bottom: 6, left: 4),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                '•',
                style: theme.textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: theme.colorScheme.primary,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  block.text,
                  style: theme.textTheme.bodyMedium?.copyWith(height: 1.55),
                ),
              ),
            ],
          ),
        );
      case MateriBlockType.numberedItem:
        return Padding(
          padding: const EdgeInsets.only(bottom: 8, left: 4),
          child: Text(
            block.text,
            style: theme.textTheme.bodyMedium?.copyWith(
              height: 1.55,
              fontWeight: FontWeight.w600,
            ),
          ),
        );
    }
  }
}
