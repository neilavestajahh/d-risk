import 'package:flutter/material.dart';

import 'jadwal_booking_screen.dart';

// Letakkan di: lib/detail_layanan_screen.dart
// (langsung di lib/, BUKAN di lib/screens/)

const Color _dlPrimaryBlue = Color(0xFF1E6FE0);
const Color _dlTeal = Color(0xFF17A2B8);
const Color _dlNavyDark = Color(0xFF1B2A4A);
const Color _dlTextGrey = Color(0xFF7A8B9E);
const Color _dlCardBorderColor = Color(0xFFE2E8F0);
const Color _dlCheckGreen = Color(0xFF22C55E);
const Color _dlLightBg = Color(0xFFF1F5F9);
const Color _dlStarYellow = Color(0xFFFFB020);

/// Satu dokter/petugas yang tersedia untuk layanan ini (dipakai di tab
/// "Jadwal Dokter").
class LayananDoctorOption {
  final String name;
  final String specialty;
  final double rating;
  final int reviewCount;
  final String imageSeed;

  const LayananDoctorOption({
    required this.name,
    required this.specialty,
    required this.imageSeed,
    this.rating = 4.8,
    this.reviewCount = 120,
  });
}

/// Halaman "Detail Layanan" — generik untuk semua jenis layanan konsultasi
/// (mis. Konsultasi Dokter Umum, Konsultasi Spesialis, dll). Berisi 2 tab:
/// "Deskripsi" (fasilitas & info layanan) dan "Jadwal Dokter" (daftar dokter
/// yang tersedia untuk layanan ini).
///
/// [onPilihDokter] dipanggil saat kartu dokter di tab "Jadwal Dokter" ditap.
/// Sambungkan ke JadwalBookingScreen kamu di sana, misalnya:
///
/// ```dart
/// onPilihDokter: (doctor) {
///   Navigator.push(context, MaterialPageRoute(
///     builder: (_) => JadwalBookingScreen(
///       name: doctor.name,
///       specialty: doctor.specialty,
///       rating: doctor.rating,
///       reviewCount: doctor.reviewCount,
///       imageSeed: doctor.imageSeed,
///     ),
///   ));
/// },
/// ```
class DetailLayananScreen extends StatefulWidget {
  final IconData icon;
  final Color iconBg;
  final String title;
  final String subtitle;
  final List<String> fasilitas;
  final String waktuLayanan; // contoh: '30 - 60 menit'
  final int biaya; // dalam Rupiah, contoh: 100000
  final String tersediaDi; // contoh: 'Semua cabang'
  final List<LayananDoctorOption> daftarDokter;
  final void Function(LayananDoctorOption doctor)? onPilihDokter;

  const DetailLayananScreen({
    super.key,
    required this.icon,
    required this.iconBg,
    required this.title,
    required this.subtitle,
    required this.fasilitas,
    required this.waktuLayanan,
    required this.biaya,
    required this.tersediaDi,
    this.daftarDokter = const [],
    this.onPilihDokter,
  });

  @override
  State<DetailLayananScreen> createState() => _DetailLayananScreenState();
}

class _DetailLayananScreenState extends State<DetailLayananScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  String get _formattedBiaya {
    final s = widget.biaya.toString();
    final buffer = StringBuffer();
    for (int i = 0; i < s.length; i++) {
      final posFromEnd = s.length - i;
      buffer.write(s[i]);
      if (posFromEnd > 1 && posFromEnd % 3 == 1) buffer.write('.');
    }
    return 'Rp $buffer';
  }

  void _handleBookingSekarang() {
    // Arahkan user ke tab "Jadwal Dokter" untuk memilih dokter.
    _tabController.animateTo(1);
  }

  void _handlePilihDokter(LayananDoctorOption doctor) {
    if (widget.onPilihDokter != null) {
      widget.onPilihDokter!(doctor);
      return;
    }
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => JadwalBookingScreen(
          name: doctor.name,
          specialty: doctor.specialty,
          rating: doctor.rating,
          reviewCount: doctor.reviewCount,
          imageSeed: doctor.imageSeed,
          biaya: widget.biaya,
        ),
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
          icon: const Icon(Icons.arrow_back, color: _dlNavyDark, size: 22),
          onPressed: () => Navigator.maybePop(context),
        ),
        title: const Text(
          'Detail Layanan',
          style: TextStyle(
            color: _dlNavyDark,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SafeArea(
        top: false,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 0),
              child: _buildHeaderCard(),
            ),
            const SizedBox(height: 8),
            TabBar(
              controller: _tabController,
              labelColor: _dlPrimaryBlue,
              unselectedLabelColor: _dlTextGrey,
              indicatorColor: _dlPrimaryBlue,
              labelStyle: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
              tabs: const [
                Tab(text: 'Deskripsi'),
                Tab(text: 'Jadwal Dokter'),
              ],
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  _buildDeskripsiTab(),
                  _buildJadwalDokterTab(),
                ],
              ),
            ),
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
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _dlCardBorderColor),
      ),
      child: Row(
        children: [
          Container(
            width: 46,
            height: 46,
            decoration: BoxDecoration(
              color: widget.iconBg,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(widget.icon, color: Colors.white, size: 22),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.title,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: _dlNavyDark,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  widget.subtitle,
                  style: const TextStyle(fontSize: 11.5, color: _dlTextGrey, height: 1.3),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // -------------------------------------------------------------------------
  // TAB DESKRIPSI
  // -------------------------------------------------------------------------

  Widget _buildDeskripsiTab() {
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Fasilitas',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: _dlNavyDark,
                  ),
                ),
                const SizedBox(height: 12),
                ...widget.fasilitas.map(
                  (text) => Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(Icons.check_circle_rounded,
                            color: _dlCheckGreen, size: 20),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            text,
                            style: const TextStyle(
                              fontSize: 13,
                              color: _dlNavyDark,
                              height: 1.3,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                const Text(
                  'Informasi Layanan',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: _dlNavyDark,
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: _buildInfoItem(
                        icon: Icons.access_time_rounded,
                        label: 'Waktu Layanan',
                        value: widget.waktuLayanan,
                      ),
                    ),
                    Expanded(
                      child: _buildInfoItem(
                        icon: Icons.sell_outlined,
                        label: 'Biaya',
                        value: _formattedBiaya,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 14),
                _buildInfoItem(
                  icon: Icons.location_on_outlined,
                  label: 'Tersedia di',
                  value: widget.tersediaDi,
                ),
              ],
            ),
          ),
        ),
        _buildBookingButton(),
      ],
    );
  }

  Widget _buildInfoItem({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 16, color: _dlPrimaryBlue),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(fontSize: 11.5, color: _dlTextGrey),
              ),
              const SizedBox(height: 2),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 12.5,
                  fontWeight: FontWeight.w700,
                  color: _dlNavyDark,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildBookingButton() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 16),
      child: SizedBox(
        width: double.infinity,
        height: 52,
        child: ElevatedButton(
          onPressed: _handleBookingSekarang,
          style: ElevatedButton.styleFrom(
            backgroundColor: _dlTeal,
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
            ],
          ),
        ),
      ),
    );
  }

  // -------------------------------------------------------------------------
  // TAB JADWAL DOKTER
  // -------------------------------------------------------------------------

  Widget _buildJadwalDokterTab() {
    if (widget.daftarDokter.isEmpty) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(24),
          child: Text(
            'Belum ada dokter tersedia untuk layanan ini.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 13, color: _dlTextGrey),
          ),
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 16),
      itemCount: widget.daftarDokter.length,
      itemBuilder: (context, index) {
        final doctor = widget.daftarDokter[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: _buildDoctorCard(doctor),
        );
      },
    );
  }

  Widget _buildDoctorCard(LayananDoctorOption doctor) {
    return InkWell(
      onTap: () => _handlePilihDokter(doctor),
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: _dlCardBorderColor),
        ),
        child: Row(
          children: [
            ClipOval(
              child: Image.network(
                'https://api.dicebear.com/7.x/avataaars/png?seed=${Uri.encodeComponent(doctor.name)}',
                width: 48,
                height: 48,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  width: 48,
                  height: 48,
                  color: _dlLightBg,
                  child: const Icon(Icons.person, color: _dlTextGrey),
                ),
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    doctor.name,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: _dlNavyDark,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    doctor.specialty,
                    style: const TextStyle(fontSize: 12, color: _dlTextGrey),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(Icons.star_rounded, color: _dlStarYellow, size: 15),
                      const SizedBox(width: 4),
                      Text(
                        '${doctor.rating} (${doctor.reviewCount} ulasan)',
                        style: const TextStyle(fontSize: 11, color: _dlTextGrey),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const Icon(Icons.chevron_right_rounded, color: _dlPrimaryBlue),
          ],
        ),
      ),
    );
  }
}