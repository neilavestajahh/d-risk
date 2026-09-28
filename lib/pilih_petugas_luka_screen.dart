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
const Color _ppChipBg = Color(0xFFEFF4FF);

/// Link foto gratis dari Pexels (dimuat dari internet).
String _px(String id) =>
    'https://images.pexels.com/photos/$id/pexels-photo-$id.jpeg?auto=compress&cs=tinysrgb&w=400&h=400&fit=crop';

enum _PetugasType { dokter, perawat }

class _PetugasItem {
  final String name;
  final String specialty;
  final String imageSeed;
  final String photoUrl;
  final double rating;
  final int reviewCount;

  const _PetugasItem({
    required this.name,
    required this.specialty,
    required this.imageSeed,
    required this.photoUrl,
    required this.rating,
    required this.reviewCount,
  });
}

/// Halaman "Pilih Dokter/Perawat" khusus layanan Perawatan Luka.
/// Langkah 1: pilih dulu "Dokter" atau "Perawat".
/// Langkah 2: tampil daftar sesuai pilihan, lalu lanjut ke JadwalBookingScreen.
class PilihPetugasLukaScreen extends StatefulWidget {
  const PilihPetugasLukaScreen({super.key});

  @override
  State<PilihPetugasLukaScreen> createState() => _PilihPetugasLukaScreenState();
}

class _PilihPetugasLukaScreenState extends State<PilihPetugasLukaScreen> {
  /// null = masih di langkah 1 (belum memilih).
  _PetugasType? _pilihan;

  static final List<_PetugasItem> _dokter = [
    _PetugasItem(
      name: 'dr. Amelia Putri',
      specialty: 'Dokter Umum',
      imageSeed: '11',
      photoUrl: _px('5998477'),
      rating: 4.9,
      reviewCount: 128,
    ),
    _PetugasItem(
      name: 'dr. Dewa Saputra',
      specialty: 'Dokter Umum',
      imageSeed: '12',
      photoUrl: _px('19438560'),
      rating: 4.7,
      reviewCount: 81,
    ),
    _PetugasItem(
      name: 'dr. Yolanda M.A.R.S',
      specialty: 'Dokter Umum',
      imageSeed: '13',
      photoUrl: _px('19218034'),
      rating: 4.8,
      reviewCount: 92,
    ),
    _PetugasItem(
      name: 'dr. Sania Pramita',
      specialty: 'Dokter Umum',
      imageSeed: '14',
      photoUrl: _px('4227075'),
      rating: 4.8,
      reviewCount: 76,
    ),
    _PetugasItem(
      name: 'dr. Neila Azzahra',
      specialty: 'Dokter Umum',
      imageSeed: '15',
      photoUrl: _px('8376309'),
      rating: 4.8,
      reviewCount: 69,
    ),
    _PetugasItem(
      name: 'dr. Sinta Dewi, Sp.PD',
      specialty: 'Spesialis Penyakit Dalam',
      imageSeed: '16',
      photoUrl: _px('6749773'),
      rating: 4.8,
      reviewCount: 110,
    ),
    _PetugasItem(
      name: 'dr. Rangga Saputra, Sp.PD',
      specialty: 'Spesialis Penyakit Dalam',
      imageSeed: '17',
      photoUrl: _px('6129574'),
      rating: 4.8,
      reviewCount: 96,
    ),
    _PetugasItem(
      name: 'dr. Bagas Pratama, Sp.PD-KEMD',
      specialty: 'Spesialis Endokrin & Diabetes',
      imageSeed: '18',
      photoUrl: _px('7108250'),
      rating: 4.9,
      reviewCount: 142,
    ),
    _PetugasItem(
      name: 'dr. Maya Kusuma, Sp.B',
      specialty: 'Spesialis Bedah',
      imageSeed: '19',
      photoUrl: _px('9893870'),
      rating: 4.8,
      reviewCount: 88,
    ),
    _PetugasItem(
      name: 'dr. Fajar Nugroho, Sp.B',
      specialty: 'Spesialis Bedah',
      imageSeed: '20',
      photoUrl: _px('8460090'),
      rating: 4.8,
      reviewCount: 73,
    ),
  ];

  static final List<_PetugasItem> _perawat = [
    _PetugasItem(
      name: 'Ns. Rina Wulandari, S.Kep',
      specialty: 'Perawat Home Care',
      imageSeed: '31',
      photoUrl: _px('30674582'),
      rating: 4.8,
      reviewCount: 78,
    ),
    _PetugasItem(
      name: 'Ns. Yeni Astuti, S.Kep',
      specialty: 'Perawat Home Care',
      imageSeed: '32',
      photoUrl: _px('18828738'),
      rating: 4.7,
      reviewCount: 62,
    ),
    _PetugasItem(
      name: 'Ns. Dewi Anggraini, S.Kep',
      specialty: 'Perawat Luka Diabetes',
      imageSeed: '33',
      photoUrl: _px('9893870'),
      rating: 4.9,
      reviewCount: 91,
    ),
    _PetugasItem(
      name: 'Ns. Ayu Lestari, S.Kep',
      specialty: 'Edukator Diabetes',
      imageSeed: '34',
      photoUrl: _px('6749773'),
      rating: 4.8,
      reviewCount: 70,
    ),
    _PetugasItem(
      name: 'Ns. Rina Safitri, S.Kep',
      specialty: 'Perawat Vaksinasi',
      imageSeed: '35',
      photoUrl: _px('8376309'),
      rating: 4.8,
      reviewCount: 64,
    ),
    _PetugasItem(
      name: 'Ns. Siti Nurhaliza, S.Kep',
      specialty: 'Perawat Lansia',
      imageSeed: '36',
      photoUrl: _px('4227075'),
      rating: 4.7,
      reviewCount: 58,
    ),
    _PetugasItem(
      name: 'Ns. Budi Hartono, S.Kep',
      specialty: 'Perawat Home Care',
      imageSeed: '37',
      photoUrl: _px('6129574'),
      rating: 4.7,
      reviewCount: 60,
    ),
    _PetugasItem(
      name: 'Ns. Rizki Fahmi, S.Kep',
      specialty: 'Perawat Home Care',
      imageSeed: '38',
      photoUrl: _px('19438560'),
      rating: 4.6,
      reviewCount: 55,
    ),
    _PetugasItem(
      name: 'Ns. Hendra Wijaya, S.Kep',
      specialty: 'Perawat Luka Diabetes',
      imageSeed: '39',
      photoUrl: _px('7108250'),
      rating: 4.7,
      reviewCount: 66,
    ),
    _PetugasItem(
      name: 'Ns. Fitri Handayani, S.Kep',
      specialty: 'Perawat Luka',
      imageSeed: '40',
      photoUrl: _px('5998477'),
      rating: 4.8,
      reviewCount: 72,
    ),
  ];

  /// Tombol back: kalau sudah memilih, kembali ke langkah 1;
  /// kalau belum, keluar halaman.
  bool _handleBack() {
    if (_pilihan != null) {
      setState(() => _pilihan = null);
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    final judul = _pilihan == null
        ? 'Pilih Dokter / Perawat'
        : (_pilihan == _PetugasType.dokter ? 'Pilih Dokter' : 'Pilih Perawat');

    return WillPopScope(
      onWillPop: () async => _handleBack(),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          surfaceTintColor: Colors.white,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: _ppNavyDark, size: 22),
            onPressed: () {
              if (_handleBack()) Navigator.maybePop(context);
            },
          ),
          title: Text(
            judul,
            style: const TextStyle(
              color: _ppNavyDark,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: SafeArea(
          top: false,
          child: _pilihan == null
              ? _buildPilihanAwal()
              : _buildDaftar(
                  _pilihan == _PetugasType.dokter ? _dokter : _perawat,
                  _pilihan!,
                ),
        ),
      ),
    );
  }

  // -------------------------------------------------------------------------
  // LANGKAH 1: PILIH DOKTER ATAU PERAWAT
  // -------------------------------------------------------------------------

  Widget _buildInfoBox() {
    return Container(
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
    );
  }

  Widget _buildPilihanAwal() {
    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 16),
      children: [
        _buildInfoBox(),
        const SizedBox(height: 20),
        const Text(
          'Siapa yang ingin menangani lukamu?',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: _ppNavyDark,
          ),
        ),
        const SizedBox(height: 14),
        _buildJenisCard(
          icon: Icons.medical_services_rounded,
          color: _ppPrimaryBlue,
          title: 'Dokter',
          subtitle:
              'Pemeriksaan luka dan penanganan medis oleh dokter umum atau spesialis.',
          jumlah: '${_dokter.length} dokter tersedia',
          onTap: () => setState(() => _pilihan = _PetugasType.dokter),
        ),
        const SizedBox(height: 14),
        _buildJenisCard(
          icon: Icons.health_and_safety_rounded,
          color: _ppTeal,
          title: 'Perawat',
          subtitle:
              'Pembersihan luka, ganti balutan, dan pemantauan luka rutin di rumah.',
          jumlah: '${_perawat.length} perawat tersedia',
          onTap: () => setState(() => _pilihan = _PetugasType.perawat),
        ),
      ],
    );
  }

  Widget _buildJenisCard({
    required IconData icon,
    required Color color,
    required String title,
    required String subtitle,
    required String jumlah,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(18),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: _ppCardBorderColor),
          boxShadow: [
            BoxShadow(
              color: _ppNavyDark.withOpacity(0.04),
              blurRadius: 10,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Icon(icon, color: Colors.white, size: 28),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: _ppNavyDark,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      fontSize: 12,
                      color: _ppTextGrey,
                      height: 1.35,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: _ppChipBg,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      jumlah,
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: color,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Icon(Icons.chevron_right_rounded, color: _ppTextGrey),
          ],
        ),
      ),
    );
  }

  // -------------------------------------------------------------------------
  // LANGKAH 2: DAFTAR SESUAI PILIHAN
  // -------------------------------------------------------------------------

  Widget _buildDaftar(List<_PetugasItem> items, _PetugasType type) {
    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 16),
      itemCount: items.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: _buildPetugasCard(context, items[index], type),
        );
      },
    );
  }

  Widget _buildFoto(_PetugasItem petugas) {
    const double size = 52;
    return ClipOval(
      child: Image.network(
        petugas.photoUrl,
        width: size,
        height: size,
        fit: BoxFit.cover,
        alignment: Alignment.topCenter,
        errorBuilder: (context, error, stackTrace) => Container(
          width: size,
          height: size,
          color: _ppChipBg,
          child: const Icon(Icons.person, color: _ppPrimaryBlue, size: 28),
        ),
      ),
    );
  }

  Widget _buildPetugasCard(
      BuildContext context, _PetugasItem petugas, _PetugasType type) {
    final isDokter = type == _PetugasType.dokter;

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
            _buildFoto(petugas),
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
                        padding: const EdgeInsets.symmetric(
                            horizontal: 7, vertical: 2),
                        decoration: BoxDecoration(
                          color: (isDokter ? _ppPrimaryBlue : _ppTeal)
                              .withOpacity(0.1),
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
                      const Icon(Icons.star_rounded,
                          color: Color(0xFFFFB020), size: 15),
                      const SizedBox(width: 4),
                      Text(
                        '${petugas.rating} (${petugas.reviewCount} ulasan)',
                        style:
                            const TextStyle(fontSize: 11, color: _ppTextGrey),
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