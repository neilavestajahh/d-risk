import 'package:flutter/material.dart';

// Letakkan di: lib/konfirmasi_booking_screen.dart
// (langsung di lib/, BUKAN di lib/screens/)

const Color _kbPrimaryBlue = Color(0xFF1E6FE0);
const Color _kbTeal = Color(0xFF17A2B8);
const Color _kbNavyDark = Color(0xFF1B2A4A);
const Color _kbTextGrey = Color(0xFF7A8B9E);
const Color _kbCardBorderColor = Color(0xFFE2E8F0);
const Color _kbInfoBg = Color(0xFFEAF6F9);
const Color _kbStarYellow = Color(0xFFFFB020);

/// Halaman "Konfirmasi Booking" — ringkasan akhir sebelum booking
/// benar-benar diproses. Dipanggil setelah user mengisi Data Pasien
/// (mis. dari DataPasienScreen).
class KonfirmasiBookingScreen extends StatelessWidget {
  // Detail dokter / petugas
  final String doctorName;
  final String doctorSpecialty;
  final double doctorRating;
  final int doctorReviewCount;
  final String imageSeed;

  // Jadwal
  final String tanggal; // contoh: 'Rabu, 12 Agustus 2025'
  final String jamMulai; // contoh: '09:00'
  final String jamSelesai; // contoh: '09:30'

  // Data pasien
  final String pasienNama;
  final String pasienNoRM;
  final String keluhan;

  // Biaya
  final int totalBiaya; // dalam Rupiah, contoh: 150000

  final VoidCallback? onConfirm;

  const KonfirmasiBookingScreen({
    super.key,
    required this.doctorName,
    required this.doctorSpecialty,
    required this.doctorRating,
    required this.doctorReviewCount,
    required this.imageSeed,
    required this.tanggal,
    required this.jamMulai,
    required this.jamSelesai,
    required this.pasienNama,
    required this.pasienNoRM,
    required this.keluhan,
    required this.totalBiaya,
    this.onConfirm,
  });

  String get _jamRange => '$jamMulai - $jamSelesai WIB';

  String get _formattedBiaya {
    final s = totalBiaya.toString();
    final buffer = StringBuffer();
    for (int i = 0; i < s.length; i++) {
      final posFromEnd = s.length - i;
      buffer.write(s[i]);
      if (posFromEnd > 1 && posFromEnd % 3 == 1) {
        buffer.write('.');
      }
    }
    return 'Rp $buffer';
  }

  void _handleKonfirmasi(BuildContext context) {
    if (onConfirm != null) {
      onConfirm!();
      return;
    }
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text('Booking Berhasil'),
        content: const Text(
          'Booking Anda telah dikonfirmasi. Silakan tunggu petugas sesuai jadwal yang dipilih.',
          style: TextStyle(fontSize: 13.5, height: 1.4),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // tutup dialog
              Navigator.of(context)
                  .popUntil((route) => route.isFirst); // kembali ke awal
            },
            child: const Text('Selesai'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        surfaceTintColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: _kbNavyDark, size: 22),
          onPressed: () => Navigator.maybePop(context),
        ),
        title: const Text(
          'Konfirmasi Booking',
          style: TextStyle(
            color: _kbNavyDark,
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
                    _buildSectionTitle('Detail Dokter'),
                    const SizedBox(height: 10),
                    _buildDoctorCard(),
                    const SizedBox(height: 20),
                    _buildSectionTitle('Jadwal'),
                    const SizedBox(height: 10),
                    _buildJadwalRow(
                      icon: Icons.calendar_today_rounded,
                      text: tanggal,
                    ),
                    const SizedBox(height: 8),
                    _buildJadwalRow(
                      icon: Icons.access_time_rounded,
                      text: _jamRange,
                    ),
                    const SizedBox(height: 20),
                    _buildSectionTitle('Data Pasien'),
                    const SizedBox(height: 10),
                    _buildPasienRow(),
                    const SizedBox(height: 14),
                    _buildKeluhanBlock(),
                    const SizedBox(height: 16),
                    _buildInfoBanner(),
                  ],
                ),
              ),
            ),
            _buildBottomBar(context),
          ],
        ),
      ),
    );
  }

  // -------------------------------------------------------------------------
  // HELPERS
  // -------------------------------------------------------------------------

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w700,
        color: _kbNavyDark,
      ),
    );
  }

  Widget _buildDoctorCard() {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _kbCardBorderColor),
      ),
      child: Row(
        children: [
          ClipOval(
            child: Image.network(
              'https://api.dicebear.com/7.x/avataaars/png?seed=${Uri.encodeComponent(imageSeed)}',
              width: 48,
              height: 48,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Container(
                width: 48,
                height: 48,
                color: const Color(0xFFF1F5F9),
                child: const Icon(Icons.person, color: _kbTextGrey),
              ),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  doctorName,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: _kbNavyDark,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  doctorSpecialty,
                  style: const TextStyle(fontSize: 12, color: _kbTextGrey),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(Icons.star_rounded, color: _kbStarYellow, size: 15),
                    const SizedBox(width: 4),
                    Text(
                      '$doctorRating ($doctorReviewCount ulasan)',
                      style: const TextStyle(fontSize: 11, color: _kbTextGrey),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildJadwalRow({required IconData icon, required String text}) {
    return Row(
      children: [
        Icon(icon, size: 17, color: _kbPrimaryBlue),
        const SizedBox(width: 10),
        Text(
          text,
          style: const TextStyle(
            fontSize: 13,
            color: _kbNavyDark,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildPasienRow() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Icon(Icons.person_outline_rounded, size: 17, color: _kbPrimaryBlue),
        const SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              pasienNama,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: _kbNavyDark,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              'No. RM: $pasienNoRM',
              style: const TextStyle(fontSize: 11.5, color: _kbTextGrey),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildKeluhanBlock() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Icon(Icons.chat_bubble_outline_rounded,
            size: 17, color: _kbPrimaryBlue),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Keluhan',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: _kbNavyDark,
                ),
              ),
              const SizedBox(height: 3),
              Text(
                keluhan.isEmpty ? '-' : keluhan,
                style: const TextStyle(
                  fontSize: 12.5,
                  color: _kbTextGrey,
                  height: 1.4,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildInfoBanner() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: _kbInfoBg,
        borderRadius: BorderRadius.circular(14),
      ),
      child: const Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.info_outline_rounded, color: _kbTeal, size: 18),
          SizedBox(width: 10),
          Expanded(
            child: Text(
              'Pastikan data sudah benar sebelum melanjutkan ke proses booking.',
              style: TextStyle(fontSize: 12, color: _kbNavyDark, height: 1.4),
            ),
          ),
        ],
      ),
    );
  }

  // -------------------------------------------------------------------------
  // BOTTOM BAR: TOTAL BIAYA + TOMBOL
  // -------------------------------------------------------------------------

  Widget _buildBottomBar(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 14, 20, 16),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: _kbCardBorderColor)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Total Biaya',
                style: TextStyle(fontSize: 12.5, color: _kbTextGrey),
              ),
              Text(
                _formattedBiaya,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: _kbNavyDark,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 52,
            child: ElevatedButton(
              onPressed: () => _handleKonfirmasi(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: _kbTeal,
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
                    'Konfirmasi Booking',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}