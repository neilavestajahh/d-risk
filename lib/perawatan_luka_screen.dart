import 'package:flutter/material.dart';

import 'pilih_petugas_luka_screen.dart';

// Letakkan di: lib/perawatan_luka_screen.dart
// (langsung di lib/, BUKAN di lib/screens/)

const Color _plTeal = Color(0xFF17A2B8);
const Color _plNavyDark = Color(0xFF1B2A4A);
const Color _plTextGrey = Color(0xFF7A8B9E);
const Color _plLightBlueBg = Color(0xFFE6F4F7);
const Color _plInfoBg = Color(0xFFEAF6F9);
const Color _plCheckGreen = Color(0xFF22C55E);

class _LayananItem {
  final String text;
  const _LayananItem(this.text);
}

class _ManfaatItem {
  final IconData icon;
  final Color color;
  final String text;
  const _ManfaatItem(this.icon, this.color, this.text);
}

/// Halaman detail "Perawatan Luka" — menjelaskan layanan & manfaat,
/// dengan tombol "Booking Sekarang" di bawah untuk lanjut memilih
/// dokter/perawat.
class PerawatanLukaScreen extends StatelessWidget {
  const PerawatanLukaScreen({super.key});

  static const List<_LayananItem> _layanan = [
    _LayananItem('Pembersihan luka oleh tenaga kesehatan terlatih'),
    _LayananItem('Penggantian balutan (dressing)'),
    _LayananItem('Monitoring perkembangan luka'),
    _LayananItem('Edukasi perawatan luka di rumah'),
  ];

  static const List<_ManfaatItem> _manfaat = [
    _ManfaatItem(Icons.shield_outlined, _plTeal, 'Mencegah infeksi'),
    _ManfaatItem(Icons.autorenew_rounded, _plTeal, 'Mempercepat proses penyembuhan'),
    _ManfaatItem(Icons.water_drop_outlined, _plTeal, 'Mengurangi risiko amputasi'),
    _ManfaatItem(Icons.person_outline_rounded, _plTeal, 'Meningkatkan kualitas hidup'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        surfaceTintColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: _plNavyDark, size: 22),
          onPressed: () => Navigator.maybePop(context),
        ),
        title: const Text(
          'Perawatan Luka',
          style: TextStyle(
            color: _plNavyDark,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SafeArea(
        top: false,
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(20, 8, 20, 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildHeaderCard(),
                    const SizedBox(height: 14),
                    _buildInfoBanner(),
                    const SizedBox(height: 22),
                    const Text(
                      'Layanan yang Tersedia',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: _plNavyDark,
                      ),
                    ),
                    const SizedBox(height: 12),
                    ..._layanan.map(_buildLayananRow),
                    const SizedBox(height: 22),
                    const Text(
                      'Manfaat',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: _plNavyDark,
                      ),
                    ),
                    const SizedBox(height: 12),
                    ..._manfaat.map(_buildManfaatRow),
                  ],
                ),
              ),
            ),
            _buildBookingButton(context),
          ],
        ),
      ),
    );
  }

  // -------------------------------------------------------------------------
  // KARTU HEADER
  // -------------------------------------------------------------------------

  Widget _buildHeaderCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: _plLightBlueBg,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Perawatan Luka\nDiabetes',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: _plNavyDark,
                        height: 1.25,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Perawatan luka yang aman,\nprofesional, dan terstandar.',
                      style: TextStyle(
                        fontSize: 12.5,
                        color: _plTextGrey,
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              Icon(
                Icons.back_hand_outlined,
                size: 56,
                color: _plTeal.withOpacity(0.55),
              ),
            ],
          ),
          Positioned(
            top: -4,
            right: 40,
            child: Container(
              width: 26,
              height: 26,
              decoration: const BoxDecoration(
                color: _plTeal,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.add, color: Colors.white, size: 16),
            ),
          ),
        ],
      ),
    );
  }

  // -------------------------------------------------------------------------
  // BANNER INFO
  // -------------------------------------------------------------------------

  Widget _buildInfoBanner() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: _plInfoBg,
        borderRadius: BorderRadius.circular(14),
      ),
      child: const Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.info_outline_rounded, color: _plTeal, size: 18),
          SizedBox(width: 10),
          Expanded(
            child: Text(
              'Luka diabetes perlu ditangani dengan tepat untuk mencegah infeksi dan komplikasi yang lebih serius.',
              style: TextStyle(fontSize: 12.5, color: _plNavyDark, height: 1.4),
            ),
          ),
        ],
      ),
    );
  }

  // -------------------------------------------------------------------------
  // LAYANAN YANG TERSEDIA
  // -------------------------------------------------------------------------

  Widget _buildLayananRow(_LayananItem item) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.check_circle_rounded, color: _plCheckGreen, size: 20),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              item.text,
              style: const TextStyle(fontSize: 13, color: _plNavyDark, height: 1.3),
            ),
          ),
        ],
      ),
    );
  }

  // -------------------------------------------------------------------------
  // MANFAAT
  // -------------------------------------------------------------------------

  Widget _buildManfaatRow(_ManfaatItem item) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(item.icon, color: item.color, size: 20),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              item.text,
              style: const TextStyle(fontSize: 13, color: _plNavyDark, height: 1.3),
            ),
          ),
        ],
      ),
    );
  }

  // -------------------------------------------------------------------------
  // TOMBOL BOOKING SEKARANG
  // -------------------------------------------------------------------------

  Widget _buildBookingButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 16),
      child: SizedBox(
        width: double.infinity,
        height: 52,
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const PilihPetugasLukaScreen(),
              ),
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: _plTeal,
            foregroundColor: Colors.white,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(26),
            ),
          ),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.calendar_today_rounded, size: 16),
              SizedBox(width: 8),
              Text(
                'Booking Sekarang',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
              ),
              SizedBox(width: 8),
              Icon(Icons.arrow_forward, size: 16),
            ],
          ),
        ),
      ),
    );
  }
}