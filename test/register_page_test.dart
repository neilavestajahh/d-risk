import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:d_risk/register_page.dart';

void main() {
  testWidgets('RegisterPage renders all required components and validates fields', (WidgetTester tester) async {
    tester.view.physicalSize = const Size(1080, 2400);
    tester.view.devicePixelRatio = 2.5;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(
      const MaterialApp(
        home: RegisterPage(),
      ),
    );

    // Pastikan judul dan subteks muncul
    expect(find.text('Daftar'), findsNWidgets(2)); // Header title and button text
    expect(
      find.text('Buat akun untuk memulai\npemeriksaan risiko diabetes Anda'),
      findsOneWidget,
    );

    // Pastikan seluruh label field form ada
    expect(find.text('Nama Lengkap'), findsOneWidget);
    expect(find.text('Email atau Nomor Telepon'), findsOneWidget);
    expect(find.text('Tanggal Lahir'), findsOneWidget);
    expect(find.text('Jenis Kelamin'), findsOneWidget);
    expect(find.text('Password'), findsOneWidget);

    // Pastikan tautan footer ada
    expect(find.textContaining('Sudah punya akun?'), findsOneWidget);
    expect(find.textContaining('Masuk di sini'), findsOneWidget);

    // Coba tekan tombol Daftar dalam keadaan field kosong
    final registerButton = find.widgetWithText(ElevatedButton, 'Daftar');
    expect(registerButton, findsOneWidget);
    await tester.ensureVisible(registerButton);
    await tester.tap(registerButton);
    await tester.pump();

    // Validasi field wajib muncul
    expect(find.text('Nama lengkap wajib diisi'), findsOneWidget);
    expect(find.text('Email atau nomor telepon wajib diisi'), findsOneWidget);
    expect(find.text('Tanggal lahir wajib dipilih'), findsOneWidget);
    expect(find.text('Jenis kelamin wajib dipilih'), findsOneWidget);
    expect(find.text('Password wajib diisi'), findsOneWidget);
  });
}
