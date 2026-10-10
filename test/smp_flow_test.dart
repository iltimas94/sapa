// Test alur jenjang SMP: materi kelas 7/8, placeholder kelas 9, tema per
// jenjang, dan tombol logout.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:sapa/data/materi_kelas7.dart';
import 'package:sapa/data/materi_kelas8.dart';
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

    await tester.tap(find.text('Sejarah Kelahiran Pancasila'));
    await tester.pumpAndSettle();

    expect(find.text('Pengantar'), findsOneWidget);
    expect(find.text('Latar Belakang Perumusan (Masa BPUPK)'), findsOneWidget);
  });

  testWidgets('Materi Kelas 8 menampilkan 5 bab dari dokumen Word',
      (WidgetTester tester) async {
    // Perbesar viewport layar uji supaya seluruh daftar bab muat di layar.
    tester.view.physicalSize = const Size(1080, 4000);
    tester.view.devicePixelRatio = 3.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(
      const MaterialApp(
        home: MateriSmpPage(level: StudentLevel.smp8),
      ),
    );

    // Materi kelas 8 dari dokumen Word: 5 bab. Nomor ganda di dokumen sumber
    // (dua "MATERI 4") sudah dikoreksi menjadi nomor urut 1-5.
    expect(materiKelas8.length, 5);
    expect(materiKelas8.first.title,
        'Kedudukan Pancasila Dalam Kehidupan Berbangsa Dan Bernegara');
    expect(materiKelas8.last.title, 'Wawasan Nusantara');

    expect(find.text('Materi 1'), findsOneWidget);
    expect(find.text('Materi 5'), findsOneWidget);
    expect(
        find.text('UUD Negara Republik Indonesia Tahun 1945'), findsOneWidget);
    expect(find.text('Wawasan Nusantara'), findsOneWidget);

    // Membuka bab terakhir.
    await tester.tap(find.text('Wawasan Nusantara'));
    await tester.pumpAndSettle();

    expect(find.text('Pengantar'), findsOneWidget);
  });

  testWidgets('Materi Kelas 9 (belum ada) menampilkan info segera hadir',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: MateriSmpPage(level: StudentLevel.smp9),
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
        theme: AppTheme.smp7Theme(),
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

  test('Tema tiap jenjang berbeda dan bergradasi dari SD ke SMP 9', () {
    final ThemeData sd = AppTheme.forLevel(StudentLevel.sd);
    final ThemeData smp7 = AppTheme.forLevel(StudentLevel.smp7);
    final ThemeData smp8 = AppTheme.forLevel(StudentLevel.smp8);
    final ThemeData smp9 = AppTheme.forLevel(StudentLevel.smp9);

    // SD tetap memakai tema kuning seperti sebelumnya.
    expect(sd.appBarTheme.backgroundColor, Colors.amber[700]);

    // Tiap jenjang SMP punya warna AppBar sendiri.
    expect(smp7.appBarTheme.backgroundColor, AppTheme.smp7AppBar);
    expect(smp8.appBarTheme.backgroundColor, AppTheme.smp8AppBar);
    expect(smp9.appBarTheme.backgroundColor, AppTheme.smp9AppBar);

    // Warna primer tiap jenjang harus berbeda satu sama lain.
    final Set<Color?> primer = <Color?>{
      sd.colorScheme.primary,
      smp7.colorScheme.primary,
      smp8.colorScheme.primary,
      smp9.colorScheme.primary,
    };
    expect(primer.length, 4);

    // Palet menu utama juga berbeda antar jenjang.
    final List<List<Color>> palet = <List<Color>>[
      AppTheme.menuPalette(StudentLevel.sd),
      AppTheme.menuPalette(StudentLevel.smp7),
      AppTheme.menuPalette(StudentLevel.smp8),
      AppTheme.menuPalette(StudentLevel.smp9),
    ];
    expect(palet[0], isNot(equals(palet[1])));
    expect(palet[1], isNot(equals(palet[2])));
    expect(palet[2], isNot(equals(palet[3])));

    // Latar halaman utama berbeda: SD gambar, SMP gradasi.
    expect(AppTheme.bodyDecoration(StudentLevel.sd).image, isNotNull);
    expect(AppTheme.bodyDecoration(StudentLevel.smp7).gradient,
        isNot(equals(AppTheme.bodyDecoration(StudentLevel.smp8).gradient)));
    expect(AppTheme.bodyDecoration(StudentLevel.smp8).gradient,
        isNot(equals(AppTheme.bodyDecoration(StudentLevel.smp9).gradient)));
  });

  test('Materi kelas 8 dianggap tersedia, kelas 9 belum', () {
    expect(StudentLevel.smp8.materiTersedia, isTrue);
    expect(StudentLevel.smp9.materiTersedia, isFalse);
    expect(StudentLevel.sd.materiTersedia, isTrue);
    expect(StudentLevel.smp7.materiTersedia, isTrue);
  });
}
