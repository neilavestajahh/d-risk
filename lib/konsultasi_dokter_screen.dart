import 'package:flutter/material.dart';

import 'doctor_profile_screen.dart';

// Letakkan di: lib/konsultasi_dokter_screen.dart
// (langsung di lib/, BUKAN di lib/screens/)

const Color _kdPrimaryBlue = Color(0xFF1E6FE0);
const Color _kdNavyDark = Color(0xFF1B2A4A);
const Color _kdTextGrey = Color(0xFF7A8B9E);
const Color _kdCardBorderColor = Color(0xFFE2E8F0);
const Color _kdLightGreenBg = Color(0xFFE7F7EF);
const Color _kdAccentGreen = Color(0xFF22A45D);

class _DoctorItem {
  final String name;
  final String specialty;
  final String imageSeed;
  final double rating;
  final int reviewCount;

  const _DoctorItem({
    required this.name,
    required this.specialty,
    required this.imageSeed,
    this.rating = 4.8,
    this.reviewCount = 120,
  });
}

/// Halaman Konsultasi Dokter (dibuka dari tombol tengah bottom nav)
class KonsultasiDokterScreen extends StatelessWidget {
  const KonsultasiDokterScreen({super.key});

  static const List<_DoctorItem> _doctors = [
    _DoctorItem(
      name: 'dr. Amelia Putri',
      specialty: 'Dokter Umum',
      imageSeed: '11',
    ),
    _DoctorItem(
      name: 'dr. Dewa Saputra',
      specialty: 'Dokter Umum',
      imageSeed: '12',
    ),
    _DoctorItem(
      name: 'dr. Yolanda M.A.R.S',
      specialty: 'Dokter umum',
      imageSeed: '13',
    ),
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
          icon: const Icon(Icons.arrow_back, color: _kdNavyDark, size: 22),
          onPressed: () => Navigator.maybePop(context),
        ),
        title: const Text(
          'Konsultasi Dokter',
          style: TextStyle(
            color: _kdNavyDark,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SafeArea(
        top: false,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 16),
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
              decoration: BoxDecoration(
                color: _kdLightGreenBg,
                borderRadius: BorderRadius.circular(14),
              ),
              child: const Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.chat_bubble_outline_rounded, color: _kdAccentGreen, size: 18),
                  SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      'Konsultasikan keluhan kesehatanmu langsung dengan dokter terpercaya.',
                      style: TextStyle(fontSize: 12.5, color: _kdNavyDark, height: 1.4),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Pilih Dokter',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w700,
                color: _kdNavyDark,
              ),
            ),
            const SizedBox(height: 10),
            ..._doctors.map(
              (doc) => Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: _buildDoctorCard(context, doc),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDoctorCard(BuildContext context, _DoctorItem doctor) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => DoctorProfileScreen(
              name: doctor.name,
              specialty: doctor.specialty,
              rating: doctor.rating,
              reviewCount: doctor.reviewCount,
              imageSeed: doctor.imageSeed,
            ),
          ),
        );
      },
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: _kdCardBorderColor),
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
                  color: const Color(0xFFF1F5F9),
                  child: const Icon(Icons.person, color: _kdTextGrey),
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
                      color: _kdNavyDark,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    doctor.specialty,
                    style: const TextStyle(fontSize: 12, color: _kdTextGrey),
                  ),
                ],
              ),
            ),
            const Icon(Icons.chevron_right_rounded, color: _kdPrimaryBlue),
          ],
        ),
      ),
    );
  }
}