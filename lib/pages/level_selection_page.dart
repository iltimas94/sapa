import 'package:flutter/material.dart';

import '../models/student_level.dart';

/// Halaman pertama aplikasi: memilih jenjang/kelas.
///
/// Halaman ini muncul saat pengguna baru pertama kali membuka aplikasi
/// atau setelah menekan tombol logout.
class LevelSelectionPage extends StatelessWidget {
  const LevelSelectionPage({
    super.key,
    required this.onLevelSelected,
    this.isSwitching = false,
  });

  /// Dipanggil saat pengguna memilih salah satu jenjang. Penyimpanan ke
  /// cache lokal dilakukan oleh pemanggil (lihat `LevelStorage`).
  final ValueChanged<StudentLevel> onLevelSelected;

  /// True bila halaman ini tampil karena tombol logout ditekan.
  final bool isSwitching;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    const List<StudentLevel> sdLevels = <StudentLevel>[StudentLevel.sd];
    const List<StudentLevel> smpLevels = <StudentLevel>[
      StudentLevel.smp7,
      StudentLevel.smp8,
      StudentLevel.smp9,
    ];

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: <Color>[Color(0xFFFFF8E1), Color(0xFFFFFFFF)],
          ),
        ),
        child: SafeArea(
          child: ListView(
            padding: const EdgeInsets.fromLTRB(20, 24, 20, 32),
            children: <Widget>[
              Center(
                child: Image.asset(
                  'assets/images/garuda_pancasila.png',
                  height: 110,
                  errorBuilder: (BuildContext context, Object error,
                          StackTrace? stackTrace) =>
                      Icon(
                    Icons.flag_circle_rounded,
                    size: 100,
                    color: Colors.grey[400],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Sahabat Pancasila',
                textAlign: TextAlign.center,
                style: theme.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: theme.colorScheme.primary,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                isSwitching
                    ? 'Pilih jenjang kelas yang baru'
                    : 'Pilih jenjang kelasmu dulu ya!',
                textAlign: TextAlign.center,
                style: theme.textTheme.titleMedium
                    ?.copyWith(fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 6),
              Text(
                'Pilihanmu tersimpan otomatis di perangkat ini, jadi tidak perlu memilih ulang setiap membuka aplikasi.',
                textAlign: TextAlign.center,
                style: theme.textTheme.bodySmall
                    ?.copyWith(color: Colors.grey[700], height: 1.4),
              ),
              const SizedBox(height: 24),
              _buildSectionTitle(context, 'SD - Sekolah Dasar'),
              ...sdLevels.map((StudentLevel level) =>
                  _buildLevelCard(context, level)),
              const SizedBox(height: 18),
              _buildSectionTitle(context, 'SMP - Sekolah Menengah Pertama'),
              ...smpLevels.map((StudentLevel level) =>
                  _buildLevelCard(context, level)),
              const SizedBox(height: 20),
              Text(
                'Kamu bisa menekan tombol logout di halaman utama untuk kembali ke halaman ini dan memilih jenjang lain.',
                textAlign: TextAlign.center,
                style: theme.textTheme.bodySmall
                    ?.copyWith(color: Colors.grey[600], height: 1.4),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(BuildContext context, String title) {
    final ThemeData theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Text(
        title,
        style: theme.textTheme.titleSmall?.copyWith(
          fontWeight: FontWeight.bold,
          color: theme.colorScheme.primary,
          letterSpacing: 0.3,
        ),
      ),
    );
  }

  Widget _buildLevelCard(BuildContext context, StudentLevel level) {
    final ThemeData theme = Theme.of(context);
    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () => onLevelSelected(level),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
          child: Row(
            children: <Widget>[
              Container(
                width: 52,
                height: 52,
                decoration: BoxDecoration(
                  color: level.color,
                  shape: BoxShape.circle,
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: level.color.withValues(alpha: 0.35),
                      blurRadius: 8,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Icon(level.icon, color: Colors.white, size: 28),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      level.fullLabel,
                      style: theme.textTheme.titleMedium
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      level.description,
                      style: theme.textTheme.bodySmall
                          ?.copyWith(color: Colors.grey[700], height: 1.3),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Icon(Icons.chevron_right_rounded,
                  color: theme.colorScheme.primary),
            ],
          ),
        ),
      ),
    );
  }
}
