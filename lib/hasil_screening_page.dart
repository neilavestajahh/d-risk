import 'package:flutter/material.dart';

// ============================================================
// FILE: hasil_screening_page.dart
// Letakkan di: lib/hasil_screening_page.dart
//
// Halaman hasil setelah semua pertanyaan screening (1-18) selesai
// dijawab. Dipanggil dari tombol "Lihat Hasil" pada
// screening_kesehatan_mandiri_screen_3.dart.
//
// CATATAN: main()/MyApp bawaan dari file asli SUDAH DIHAPUS di sini
// karena project kamu sudah punya lib/main.dart sendiri. Kalau file
// ini dijalankan sendirian (bukan lewat main.dart project), halaman
// ini tidak akan tampil apa-apa -- itu wajar, karena memang dibuat
// untuk dipanggil lewat Navigator dari halaman lain.
// ============================================================

// ---------------------------------------------------------------------------
// WARNA UTAMA HALAMAN INI (private ke file ini, aman dari bentrok nama)
// ---------------------------------------------------------------------------

const Color _kTeal = Color(0xFF17A2B8);
const Color _kGreen = Color(0xFF27AE60);

// ---------------------------------------------------------------------------
// MODEL DATA
// ---------------------------------------------------------------------------

class _RecommendationItem {
  final String text;
  const _RecommendationItem(this.text);
}

// ---------------------------------------------------------------------------
// HALAMAN UTAMA
// ---------------------------------------------------------------------------

class HasilScreeningPage extends StatefulWidget {
  const HasilScreeningPage({super.key});

  @override
  State<HasilScreeningPage> createState() => _HasilScreeningPageState();
}

class _HasilScreeningPageState extends State<HasilScreeningPage> {
  int _bottomNavIndex = 3; // "Screening" aktif

  final List<_RecommendationItem> _recommendations = const [
    _RecommendationItem('Pertahankan pola makan sehat'),
    _RecommendationItem('Rutin beraktivitas fisik'),
    _RecommendationItem('Lakukan pemeriksaan kesehatan secara berkala'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppBar(context),
      body: SafeArea(
        top: false,
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildResultCard(),
              const SizedBox(height: 16),
              _buildRecommendationCard(),
              const SizedBox(height: 20),
              _buildUlangiButton(context),
              const SizedBox(height: 12),
              _buildKembaliButton(context),
            ],
          ),
        ),
      ),
      bottomNavigationBar: _buildBottomNavBar(),
    );
  }

  // -------------------------------------------------------------------------
  // APP BAR
  // -------------------------------------------------------------------------

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      surfaceTintColor: Colors.white,
      centerTitle: true,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: _kTeal, size: 22),
        onPressed: () => Navigator.maybePop(context),
      ),
      title: const Text(
        'Hasil Screening',
        style: TextStyle(
          color: Colors.black87,
          fontSize: 17,
          fontWeight: FontWeight.w600,
        ),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.insert_drive_file_outlined,
              color: _kTeal, size: 20),
          onPressed: () {
            // TODO: aksi unduh / bagikan hasil screening
          },
        ),
      ],
    );
  }

  // -------------------------------------------------------------------------
  // KARTU HASIL (RISIKO RENDAH)
  // -------------------------------------------------------------------------

  Widget _buildResultCard() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 28),
      decoration: BoxDecoration(
        color: const Color(0xFFE9F7EF),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Container(
            width: 64,
            height: 64,
            decoration: const BoxDecoration(
              color: _kGreen,
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.check, color: Colors.white, size: 32),
          ),
          const SizedBox(height: 14),
          const Text(
            'Risiko Rendah',
            style: TextStyle(
              fontSize: 19,
              fontWeight: FontWeight.bold,
              color: _kGreen,
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            'Berdasarkan jawaban yang Anda berikan, risiko Anda untuk terkena '
            'diabetes tergolong rendah. Tetap jaga pola hidup sehat agar risiko '
            'tetap terkendali.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 13, color: Colors.black54, height: 1.5),
          ),
        ],
      ),
    );
  }

  // -------------------------------------------------------------------------
  // KARTU REKOMENDASI
  // -------------------------------------------------------------------------

  Widget _buildRecommendationCard() {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: const [
              Icon(Icons.description_outlined, color: _kTeal, size: 20),
              SizedBox(width: 8),
              Text(
                'Rekomendasi',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: _kTeal,
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          ..._recommendations.map(
            (r) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: _buildRecommendationRow(r.text),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecommendationRow(String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 20,
          height: 20,
          margin: const EdgeInsets.only(top: 1),
          decoration: const BoxDecoration(
            color: _kTeal,
            shape: BoxShape.circle,
          ),
          child: const Icon(Icons.check, color: Colors.white, size: 13),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            text,
            style:
                const TextStyle(fontSize: 13, color: Colors.black87, height: 1.4),
          ),
        ),
      ],
    );
  }

  // -------------------------------------------------------------------------
  // TOMBOL AKSI
  // -------------------------------------------------------------------------

  Widget _buildUlangiButton(BuildContext context) {
    return SizedBox(
      height: 52,
      child: ElevatedButton(
        onPressed: () {
          // Ulangi dari awal: hapus semua halaman screening di stack,
          // kembali ke halaman pertama (route paling awal).
          Navigator.of(context).popUntil((route) => route.isFirst);
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: _kTeal,
          foregroundColor: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(26),
          ),
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.refresh, size: 18),
            SizedBox(width: 8),
            Text(
              'Ulangi Screening',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildKembaliButton(BuildContext context) {
    return SizedBox(
      height: 52,
      child: OutlinedButton(
        onPressed: () {
          // Kembali ke beranda: hapus semua halaman di atas beranda.
          Navigator.of(context).popUntil((route) => route.isFirst);
        },
        style: OutlinedButton.styleFrom(
          foregroundColor: _kTeal,
          side: const BorderSide(color: _kTeal, width: 1.4),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(26),
          ),
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.home_outlined, size: 18),
            SizedBox(width: 8),
            Text(
              'Kembali ke Beranda',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }

  // -------------------------------------------------------------------------
  // BOTTOM NAVIGATION BAR
  // -------------------------------------------------------------------------

  Widget _buildBottomNavBar() {
    final items = [
      {'icon': Icons.home_rounded, 'label': 'Beranda'},
      {'icon': Icons.menu_book_rounded, 'label': 'Book Health'},
      {'icon': Icons.chat_bubble_outline_rounded, 'label': 'Konsultasi'},
      {'icon': Icons.science_outlined, 'label': 'Screening'},
      {'icon': Icons.home_repair_service_outlined, 'label': 'Home Care'},
    ];

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Colors.grey.shade200)),
      ),
      child: SafeArea(
        top: false,
        child: SizedBox(
          height: 64,
          child: Row(
            children: List.generate(items.length, (index) {
              final selected = index == _bottomNavIndex;
              final color = selected ? _kTeal : Colors.grey;
              return Expanded(
                child: InkWell(
                  onTap: () => setState(() => _bottomNavIndex = index),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(items[index]['icon'] as IconData,
                          color: color, size: 22),
                      const SizedBox(height: 4),
                      Text(
                        items[index]['label'] as String,
                        style: TextStyle(fontSize: 10, color: color),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}