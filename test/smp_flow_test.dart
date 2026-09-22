// Test alur jenjang SMP: halaman materi, placeholder kelas 8, dan tombol logout.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:sapa/data/materi_kelas7.dart';
import 'package:sapa/models/student_level.dart';
import 'package:sapa/pages/home_page.dart';
import 'package:sapa/pages/materi_smp_page.dart';
import 'package:sapa/theme/app_theme.dart';

void main() {
  testWidgets('Materi Kelas 7 menampilkan bab dan dapat dibuka',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: MateriSmpPage(level: StudentLevel.smp7),
      ),
    );

    // Materi kelas 7 terdiri atas 5 bab (MATERI 1 sampai MATERI 5).
    expect(materiKelas7.length, 5);
    expect(find.text('Materi 1'), findsOneWidget);
    expect(find.text('Sejarah Kelahiran Pancasila'), findsOneWidget);

    // Membuka bab pertama.
    await tester.tap(find.text('Sejarah Kelahiran Pancasila'));
    await tester.pumpAndSettle();

    expect(find.text('Pengantar'), findsOneWidget);
    expect(find.text('Latar Belakang Perumusan (Masa BPUPK)'), findsOneWidget);
  });

  testWidgets('Materi Kelas 8 menampilkan info segera hadir',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: MateriSmpPage(level: StudentLevel.smp8),
      ),
    );

    await tester.pump();
    expect(find.textContaining('segera hadir'), findsOneWidget);
  });

  testWidgets('Halaman utama SMP menampilkan menu, badge, dan tombol logout',
      (WidgetTester tester) async {
    bool logoutDipanggil = false;

    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.smpTheme(),
        home: HomePage(
          level: StudentLevel.smp7,
          onLogout: () async => logoutDipanggil = true,
        ),
      ),
    );
    await tester.pump();

    expect(find.text('PPKn Kelas 7'), findsOneWidget);
    expect(find.text('SMP 7'), findsOneWidget);
    expect(find.text('Materi'), findsOneWidget);
    expect(find.text('Kuis'), findsOneWidget);
    expect(find.text('Tanya AI'), findsOneWidget);
    expect(find.text('Lagu'), findsOneWidget);
    expect(find.byIcon(Icons.logout_rounded), findsOneWidget);

    // Menekan logout menampilkan konfirmasi lalu memanggil callback.
    await tester.tap(find.byIcon(Icons.logout_rounded));
    await tester.pump();
    expect(find.text('Ganti Jenjang Kelas'), findsOneWidget);

    await tester.tap(find.text('Logout'));
    await tester.pump();
    expect(logoutDipanggil, isTrue);
  });

  testWidgets('Jenjang SMP memakai tema biru (bukan tema kuning SD)',
      (WidgetTester tester) async {
    expect(AppTheme.forLevel(StudentLevel.smp7).appBarTheme.backgroundColor,
        AppTheme.smpAppBar);
    expect(AppTheme.forLevel(StudentLevel.sd).appBarTheme.backgroundColor,
        Colors.amber[700]);
  });
}
