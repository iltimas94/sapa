// Test alur pemilihan jenjang/kelas (SD, SMP 7, SMP 8, SMP 9).
//
// Untuk menjalankan: `flutter test`

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:sapa/main.dart';
import 'package:sapa/models/student_level.dart';
import 'package:sapa/pages/level_selection_page.dart';

void main() {
  testWidgets('Halaman pilih jenjang menampilkan 4 pilihan kelas',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: LevelSelectionPage(onLevelSelected: (StudentLevel level) {}),
      ),
    );

    expect(find.text('SD Kelas 1 - 6'), findsOneWidget);
    expect(find.text('SMP Kelas 7'), findsOneWidget);

    // Kartu SMP kelas 8 dan 9 ada di bagian bawah sehingga perlu di-scroll.
    final Finder scrollable = find.byType(Scrollable).first;
    await tester.scrollUntilVisible(find.text('SMP Kelas 8'), 300.0,
        scrollable: scrollable);
    expect(find.text('SMP Kelas 8'), findsOneWidget);
    await tester.scrollUntilVisible(find.text('SMP Kelas 9'), 300.0,
        scrollable: scrollable);
    expect(find.text('SMP Kelas 9'), findsOneWidget);
  });

  testWidgets('Menekan salah satu jenjang memanggil callback yang sesuai',
      (WidgetTester tester) async {
    StudentLevel? selected;
    await tester.pumpWidget(
      MaterialApp(
        home: LevelSelectionPage(
          onLevelSelected: (StudentLevel level) => selected = level,
        ),
      ),
    );

    await tester.tap(find.text('SMP Kelas 7'));
    await tester.pump();

    expect(selected, StudentLevel.smp7);
  });

  testWidgets('Tanpa cache jenjang, aplikasi menampilkan halaman pilih jenjang',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
    await tester.pumpAndSettle();

    expect(find.text('SD Kelas 1 - 6'), findsOneWidget);
    expect(find.text('SMP Kelas 7'), findsOneWidget);
  });

  test('Id jenjang dapat diubah kembali menjadi StudentLevel (cache lokal)', () {
    expect(StudentLevel.fromId('sd'), StudentLevel.sd);
    expect(StudentLevel.fromId('smp-7'), StudentLevel.smp7);
    expect(StudentLevel.fromId('smp-8'), StudentLevel.smp8);
    expect(StudentLevel.fromId('smp-9'), StudentLevel.smp9);
    expect(StudentLevel.fromId(null), isNull);
    expect(StudentLevel.fromId('tidak-dikenal'), isNull);
  });
}
