import 'package:flutter/material.dart';

import 'jadwal_booking_screen.dart';

// Letakkan di: lib/pilih_petugas_luka_screen.dart
// (langsung di lib/, BUKAN di lib/screens/)

const Color _ppPrimaryBlue = Color(0xFF1E6FE0);
const Color _ppTeal = Color(0xFF17A2B8);
const Color _ppNavyDark = Color(0xFF1B2A4A);
const Color _ppTextGrey = Color(0xFF7A8B9E);
const Color _ppCardBorderColor = Color(0xFFE2E8F0);
const Color _ppLightGreenBg = Color(0xFFE7F7EF);
const Color _ppAccentGreen = Color(0xFF22A45D);

enum _PetugasType { dokter, perawat }

class _PetugasItem {
  final String name;
  final String specialty;
  final String imageSeed;
  final double rating;
  final int reviewCount;
  final _PetugasType type;

  const _PetugasItem({
    required this.name,
    required this.specialty,
    required this.imageSeed,
    required this.type,
    this.rating = 4.8,
    this.reviewCount = 120,
  });
}

/// Halaman "Pilih Dokter/Perawat" khusus untuk layanan Perawatan Luka.
/// Menampilkan gabungan Dokter dan Perawat yang bisa dipilih,
/// lalu lanjut ke JadwalBookingScreen.
class PilihPetugasLukaScreen extends StatelessWidget {
  const PilihPetugasLukaScreen({super.key});

  static const List<_PetugasItem> _petugasList = [
    _PetugasItem(
      name: 'dr. Amelia Putri, Sp.PD',
      specialty: 'Spesialis Penyakit Dalam',
      imageSeed: '11',
      type: _PetugasType.dokter,
    ),
    _PetugasItem(
      name: 'Ns. Rina Wulandari, S.Kep',
      specialty: 'Perawat Home Care',
      imageSeed: '21',
      type: _PetugasType.perawat,
    ),
    _PetugasItem(
      name: 'dr. Rangga Saputra',
      specialty: 'Dokter Umum',
      imageSeed: '12',
      type: _PetugasType.dokter,
    ),
    _PetugasItem(
      name: 'Ns. Budi Hartono, S.Kep',
      specialty: 'Perawat Home Care',
      imageSeed: '22',
      type: _PetugasType.perawat,
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
          icon: const Icon(Icons.arrow_back, color: _ppNavyDark, size: 22),
          onPressed: () => Navigator.maybePop(context),
        ),
        title: const Text(
          'Pilih Dokter / Perawat',
          style: TextStyle(
            color: _ppNavyDark,
            fontSize: 16,
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
                color: _ppLightGreenBg,
                borderRadius: BorderRadius.circular(14),
              ),
              child: const Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.info_outline_rounded, color: _ppAccentGreen, size: 18),
                  SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      'Pilih dokter atau perawat yang akan menangani perawatan luka Anda di rumah.',
                      style: TextStyle(fontSize: 12.5, color: _ppNavyDark, height: 1.4),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Tersedia',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w700,
                color: _ppNavyDark,
              ),
            ),
            const SizedBox(height: 10),
            ..._petugasList.map(
              (p) => Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: _buildPetugasCard(context, p),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPetugasCard(BuildContext context, _PetugasItem petugas) {
    final isDokter = petugas.type == _PetugasType.dokter;

    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => JadwalBookingScreen(
              name: petugas.name,
              specialty: petugas.specialty,
              rating: petugas.rating,
              reviewCount: petugas.reviewCount,
              imageSeed: petugas.imageSeed,
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
          border: Border.all(color: _ppCardBorderColor),
        ),
        child: Row(
          children: [
            ClipOval(
              child: Image.network(
                'https://api.dicebear.com/7.x/avataaars/png?seed=${Uri.encodeComponent(petugas.name)}',
                width: 48,
                height: 48,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  width: 48,
                  height: 48,
                  color: const Color(0xFFF1F5F9),
                  child: const Icon(Icons.person, color: _ppTextGrey),
                ),
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Flexible(
                        child: Text(
                          petugas.name,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: _ppNavyDark,
                          ),
                        ),
                      ),
                      const SizedBox(width: 6),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                        decoration: BoxDecoration(
                          color: (isDokter ? _ppPrimaryBlue : _ppTeal).withOpacity(0.1),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          isDokter ? 'Dokter' : 'Perawat',
                          style: TextStyle(
                            fontSize: 9.5,
                            fontWeight: FontWeight.w700,
                            color: isDokter ? _ppPrimaryBlue : _ppTeal,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 2),
                  Text(
                    petugas.specialty,
                    style: const TextStyle(fontSize: 12, color: _ppTextGrey),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(Icons.star_rounded, color: Color(0xFFFFB020), size: 15),
                      const SizedBox(width: 4),
                      Text(
                        '${petugas.rating} (${petugas.reviewCount} ulasan)',
                        style: const TextStyle(fontSize: 11, color: _ppTextGrey),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const Icon(Icons.chevron_right_rounded, color: _ppPrimaryBlue),
          ],
        ),
      ),
    );
  }
}