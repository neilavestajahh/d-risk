import 'package:flutter/material.dart';
import 'pertanyaan_ya_tidak.dart';
import 'hasil_screening_page.dart';

// ============================================================
// FILE: screening_kesehatan_mandiri_screen_3.dart
// Letakkan di: lib/screening_kesehatan_mandiri_screen_3.dart
//
// Halaman TERAKHIR dari screening_kesehatan_mandiri_screen_2.dart
// Pertanyaan nomor 16-18 (halaman terakhir dari total 18).
// ============================================================

class ScreeningKesehatanMandiriScreen3 extends StatefulWidget {
  const ScreeningKesehatanMandiriScreen3({super.key});

  @override
  State<ScreeningKesehatanMandiriScreen3> createState() =>
      _ScreeningKesehatanMandiriScreen3State();
}

class _ScreeningKesehatanMandiriScreen3State
    extends State<ScreeningKesehatanMandiriScreen3> {
  static const Color kBlue = Color(0xFF2E9AFF);
  static const Color kBlueDark = Color(0xFF1E6FD9);

  static const int totalPertanyaan = 18;

  final List<_PertanyaanData> _pertanyaan = [
    _PertanyaanData(
      nomor: 16,
      teks: 'Apakah Anda sering mengalami kekakuan pada otot atau '
          'anggota tubuh?',
    ),
    _PertanyaanData(
      nomor: 17,
      teks: 'Apakah Anda mengalami kerontokan rambut yang tidak biasa '
          'atau lebih banyak dari biasanya?',
    ),
    _PertanyaanData(
      nomor: 18,
      teks: 'Apakah Anda pernah diberitahu oleh tenaga kesehatan bahwa '
          'Anda mengalami obesitas atau kelebihan berat badan?',
    ),
  ];

  final Map<int, bool?> _jawaban = {};

  @override
  void initState() {
    super.initState();
    for (var p in _pertanyaan) {
      _jawaban[p.nomor] = null;
    }
  }

  bool get _semuaTerjawab =>
      _pertanyaan.every((p) => _jawaban[p.nomor] != null);

  @override
  Widget build(BuildContext context) {
    final progress = _pertanyaan.last.nomor / totalPertanyaan;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new,
              color: Colors.black87, size: 18),
          onPressed: () => Navigator.maybePop(context),
        ),
        title: const Text(
          'Screening Kesehatan Mandiri',
          style: TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.bookmark_border, color: kBlue),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: LinearProgressIndicator(
                value: progress,
                minHeight: 6,
                backgroundColor: const Color(0xFFEAF5FF),
                valueColor: const AlwaysStoppedAnimation<Color>(kBlue),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  for (final p in _pertanyaan) ...[
                    PertanyaanYaTidak(
                      nomor: p.nomor,
                      totalPertanyaan: totalPertanyaan,
                      teks: p.teks,
                      jawaban: _jawaban[p.nomor],
                      onJawab: (val) {
                        setState(() => _jawaban[p.nomor] = val);
                      },
                    ),
                    const SizedBox(height: 20),
                  ],
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 12),
            child: Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      // Kembali ke halaman awal screening (bukan cuma
                      // pop satu halaman), sesuai perilaku "Batalkan"
                      // pada halaman pertama.
                      Navigator.of(context)
                          .popUntil((route) => route.isFirst);
                    },
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: kBlue),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text(
                      'Batalkan',
                      style: TextStyle(
                        color: kBlue,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  flex: 2,
                  child: ElevatedButton(
                    onPressed: _semuaTerjawab
                        ? () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const HasilScreeningPage(),
                              ),
                            );
                          }
                        : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: kBlueDark,
                      disabledBackgroundColor: Colors.grey.shade300,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Lihat Hasil',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(width: 6),
                        Icon(Icons.arrow_forward,
                            color: Colors.white, size: 16),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: kBlue,
        unselectedItemColor: Colors.grey,
        currentIndex: 3,
        showUnselectedLabels: true,
        selectedFontSize: 11,
        unselectedFontSize: 11,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: 'Beranda',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_border),
            label: 'Book Health',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat_bubble_outline),
            label: 'Konsultasi',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.biotech_outlined),
            label: 'Screening',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home_repair_service_outlined),
            label: 'Home Care',
          ),
        ],
      ),
    );
  }
}

// ============================================================
// MODEL: Data sederhana untuk tiap pertanyaan
// (private per-file, aman walau ada class sama nama di file lain)
// ============================================================
class _PertanyaanData {
  final int nomor;
  final String teks;

  _PertanyaanData({required this.nomor, required this.teks});
}