import 'package:flutter/material.dart';

import 'kunjungan_dokter_screen.dart';

// Letakkan di: lib/layanan_kunjungan_dokter_screen.dart
// (langsung di lib/, BUKAN di lib/screens/)

const Color _lkdPrimaryBlue = Color(0xFF1E6FE0);
const Color _lkdNavyDark = Color(0xFF1B2A4A);
const Color _lkdTextGrey = Color(0xFF7A8B9E);
const Color _lkdBgGrey = Color(0xFFF3F5F8);

/// Halaman "Kunjungan Dokter" (entry point) — menjelaskan layanan
/// kunjungan dokter ke rumah, dengan tombol "Booking Sekarang" yang
/// membuka daftar dokter/perawat (KunjunganDokterScreen) untuk dipilih,
/// sama seperti alur di Perawatan Luka.
class LayananKunjunganDokterScreen extends StatelessWidget {
  const LayananKunjunganDokterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _lkdBgGrey,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        surfaceTintColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: _lkdNavyDark, size: 22),
          onPressed: () => Navigator.maybePop(context),
        ),
        title: const Text(
          'Kunjungan Dokter',
          style: TextStyle(
            color: _lkdNavyDark,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SafeArea(
        top: false,
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Layanan kunjungan dokter ke rumah',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  color: _lkdNavyDark,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Dokter akan datang langsung ke lokasi Anda untuk pemeriksaan.',
                style: TextStyle(
                  fontSize: 13,
                  color: _lkdTextGrey,
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 20),
              _buildJadwalkanCard(context),
            ],
          ),
        ),
      ),
    );
  }

  // -------------------------------------------------------------------------
  // KARTU "JADWALKAN KUNJUNGAN" + TOMBOL BOOKING SEKARANG
  // -------------------------------------------------------------------------

  Widget _buildJadwalkanCard(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Jadwalkan Kunjungan',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: _lkdNavyDark,
            ),
          ),
          const SizedBox(height: 14),
          SizedBox(
            width: double.infinity,
            height: 52,
            child: ElevatedButton(
              onPressed: () {
                // Navigasi ke daftar dokter/perawat, sama seperti
                // alur "Booking Sekarang" di Perawatan Luka.
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const KunjunganDokterScreen(),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: _lkdPrimaryBlue,
                foregroundColor: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(26),
                ),
              ),
              child: const Text(
                'Booking Sekarang',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ],
      ),
    );
  }
}