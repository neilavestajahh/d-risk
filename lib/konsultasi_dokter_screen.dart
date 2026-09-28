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
const Color _kdChipBg = Color(0xFFEFF4FF);

class _DoctorItem {
  final String name;
  final String specialty;

  /// Link foto dokter (dimuat dari internet)
  final String photoUrl;
  final double rating;
  final int reviewCount;

  const _DoctorItem({
    required this.name,
    required this.specialty,
    required this.photoUrl,
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
      photoUrl: 'https://images.pexels.com/photos/5998477/pexels-photo-5998477.jpeg?auto=compress&cs=tinysrgb&w=400&h=400&fit=crop',
      rating: 4.9,
      reviewCount: 128,
    ),
    _DoctorItem(
      name: 'dr. Dewa Saputra',
      specialty: 'Dokter Umum',
      photoUrl: 'https://images.pexels.com/photos/19438560/pexels-photo-19438560.jpeg?auto=compress&cs=tinysrgb&w=400&h=400&fit=crop',
      rating: 4.7,
      reviewCount: 81,
    ),
    _DoctorItem(
      name: 'dr. Yolanda M.A.R.S',
      specialty: 'Dokter Umum',
      photoUrl: 'https://images.pexels.com/photos/19218034/pexels-photo-19218034.jpeg?auto=compress&cs=tinysrgb&w=400&h=400&fit=crop',
      rating: 4.8,
      reviewCount: 92,
    ),
    _DoctorItem(
      name: 'dr. Sania Pramita',
      specialty: 'Dokter Umum',
      photoUrl: 'https://images.pexels.com/photos/4227075/pexels-photo-4227075.jpeg?auto=compress&cs=tinysrgb&w=400&h=400&fit=crop',
      rating: 4.8,
      reviewCount: 76,
    ),
    _DoctorItem(
      name: 'dr. Neila Azzahra',
      specialty: 'Dokter Umum',
      photoUrl: 'https://images.pexels.com/photos/8376309/pexels-photo-8376309.jpeg?auto=compress&cs=tinysrgb&w=400&h=400&fit=crop',
      rating: 4.8,
      reviewCount: 69,
    ),
    _DoctorItem(
      name: 'dr. Sinta Dewi, Sp.PD',
      specialty: 'Spesialis Penyakit Dalam',
      photoUrl: 'https://images.pexels.com/photos/6749773/pexels-photo-6749773.jpeg?auto=compress&cs=tinysrgb&w=400&h=400&fit=crop',
      rating: 4.8,
      reviewCount: 110,
    ),
    _DoctorItem(
      name: 'dr. Rangga Saputra, Sp.PD',
      specialty: 'Spesialis Penyakit Dalam',
      photoUrl: 'https://images.pexels.com/photos/6129574/pexels-photo-6129574.jpeg?auto=compress&cs=tinysrgb&w=400&h=400&fit=crop',
      rating: 4.8,
      reviewCount: 96,
    ),
    _DoctorItem(
      name: 'dr. Bagas Pratama, Sp.PD-KEMD',
      specialty: 'Spesialis Endokrin & Diabetes',
      photoUrl: 'https://images.pexels.com/photos/7108250/pexels-photo-7108250.jpeg?auto=compress&cs=tinysrgb&w=400&h=400&fit=crop',
      rating: 4.9,
      reviewCount: 142,
    ),
    _DoctorItem(
      name: 'dr. Maya Kusuma, Sp.B',
      specialty: 'Spesialis Bedah',
      photoUrl: 'https://images.pexels.com/photos/9893870/pexels-photo-9893870.jpeg?auto=compress&cs=tinysrgb&w=400&h=400&fit=crop',
      rating: 4.8,
      reviewCount: 88,
    ),
    _DoctorItem(
      name: 'dr. Fajar Nugroho, Sp.B',
      specialty: 'Spesialis Bedah',
      photoUrl: 'https://images.pexels.com/photos/8460090/pexels-photo-8460090.jpeg?auto=compress&cs=tinysrgb&w=400&h=400&fit=crop',
      rating: 4.8,
      reviewCount: 73,
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
                  Icon(Icons.chat_bubble_outline_rounded,
                      color: _kdAccentGreen, size: 18),
                  SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      'Konsultasikan keluhan kesehatanmu langsung dengan dokter terpercaya.',
                      style: TextStyle(
                          fontSize: 12.5, color: _kdNavyDark, height: 1.4),
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

  /// Foto dokter dari internet. Kalau gagal dimuat,
  /// tampil ikon orang sebagai cadangan (tidak bikin aplikasi crash).
  Widget _buildDoctorPhoto(_DoctorItem doctor) {
    const double size = 56;
    return ClipOval(
      child: Image.network(
        doctor.photoUrl,
        width: size,
        height: size,
        fit: BoxFit.cover,
        alignment: Alignment.topCenter, // supaya wajah tidak terpotong
        errorBuilder: (context, error, stackTrace) => Container(
          width: size,
          height: size,
          color: _kdChipBg,
          child: const Icon(Icons.person, color: _kdPrimaryBlue, size: 30),
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
              photoUrl: doctor.photoUrl,
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
            _buildDoctorPhoto(doctor),
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