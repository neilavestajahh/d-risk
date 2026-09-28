import 'package:flutter/material.dart';

import 'jadwal_booking_screen.dart';

// Letakkan di: lib/kunjungan_dokter_screen.dart
// (langsung di lib/, BUKAN di lib/screens/)

const Color _kjPrimaryBlue = Color(0xFF1E6FE0);
const Color _kjNavyDark = Color(0xFF1B2A4A);
const Color _kjTextGrey = Color(0xFF7A8B9E);
const Color _kjCardBorderColor = Color(0xFFE2E8F0);
const Color _kjStarYellow = Color(0xFFFFB020);
const Color _kjGreen = Color(0xFF22A45D);
const Color _kjChipBg = Color(0xFFEFF4FF);

/// Link foto gratis dari Pexels (dimuat dari internet).
String _px(String id) =>
    'https://images.pexels.com/photos/$id/pexels-photo-$id.jpeg?auto=compress&cs=tinysrgb&w=400&h=400&fit=crop';

/// Satu data tenaga kesehatan (dipakai untuk dokter DAN perawat).
class _NakesItem {
  final String name;
  final String role;
  final double rating;
  final int reviewCount;
  final String imageSeed;
  final String photoUrl;

  const _NakesItem({
    required this.name,
    required this.role,
    required this.rating,
    required this.reviewCount,
    required this.imageSeed,
    required this.photoUrl,
  });
}

/// Pilihan awal: mau dokter atau perawat.
enum _Jenis { dokter, perawat }

/// Halaman Kunjungan Dokter.
/// Langkah 1: pilih dulu "Dokter" atau "Perawat".
/// Langkah 2: tampil daftar sesuai pilihan. Tombol "Booking" membuka
/// JadwalBookingScreen dengan data yang dipilih.
class KunjunganDokterScreen extends StatefulWidget {
  const KunjunganDokterScreen({super.key});

  @override
  State<KunjunganDokterScreen> createState() => _KunjunganDokterScreenState();
}

class _KunjunganDokterScreenState extends State<KunjunganDokterScreen> {
  /// null = masih di langkah 1 (belum memilih).
  _Jenis? _pilihan;

  static final List<_NakesItem> _doctors = [
    _NakesItem(
      name: 'dr. Amelia Putri',
      role: 'Dokter Umum',
      rating: 4.9,
      reviewCount: 128,
      imageSeed: '11',
      photoUrl: _px('5998477'),
    ),
    _NakesItem(
      name: 'dr. Dewa Saputra',
      role: 'Dokter Umum',
      rating: 4.7,
      reviewCount: 81,
      imageSeed: '12',
      photoUrl: _px('19438560'),
    ),
    _NakesItem(
      name: 'dr. Yolanda M.A.R.S',
      role: 'Dokter Umum',
      rating: 4.8,
      reviewCount: 92,
      imageSeed: '13',
      photoUrl: _px('19218034'),
    ),
    _NakesItem(
      name: 'dr. Sania Pramita',
      role: 'Dokter Umum',
      rating: 4.8,
      reviewCount: 76,
      imageSeed: '14',
      photoUrl: _px('4227075'),
    ),
    _NakesItem(
      name: 'dr. Neila Azzahra',
      role: 'Dokter Umum',
      rating: 4.8,
      reviewCount: 69,
      imageSeed: '15',
      photoUrl: _px('8376309'),
    ),
    _NakesItem(
      name: 'dr. Sinta Dewi, Sp.PD',
      role: 'Spesialis Penyakit Dalam',
      rating: 4.8,
      reviewCount: 110,
      imageSeed: '16',
      photoUrl: _px('6749773'),
    ),
    _NakesItem(
      name: 'dr. Rangga Saputra, Sp.PD',
      role: 'Spesialis Penyakit Dalam',
      rating: 4.8,
      reviewCount: 96,
      imageSeed: '17',
      photoUrl: _px('6129574'),
    ),
    _NakesItem(
      name: 'dr. Bagas Pratama, Sp.PD-KEMD',
      role: 'Spesialis Endokrin & Diabetes',
      rating: 4.9,
      reviewCount: 142,
      imageSeed: '18',
      photoUrl: _px('7108250'),
    ),
    _NakesItem(
      name: 'dr. Maya Kusuma, Sp.B',
      role: 'Spesialis Bedah',
      rating: 4.8,
      reviewCount: 88,
      imageSeed: '19',
      photoUrl: _px('9893870'),
    ),
    _NakesItem(
      name: 'dr. Fajar Nugroho, Sp.B',
      role: 'Spesialis Bedah',
      rating: 4.8,
      reviewCount: 73,
      imageSeed: '20',
      photoUrl: _px('8460090'),
    ),
  ];

  static final List<_NakesItem> _nurses = [
    _NakesItem(
      name: 'Ns. Rina Wulandari, S.Kep',
      role: 'Perawat Home Care',
      rating: 4.8,
      reviewCount: 78,
      imageSeed: '31',
      photoUrl: _px('30674582'),
    ),
    _NakesItem(
      name: 'Ns. Yeni Astuti, S.Kep',
      role: 'Perawat Home Care',
      rating: 4.7,
      reviewCount: 62,
      imageSeed: '32',
      photoUrl: _px('18828738'),
    ),
    _NakesItem(
      name: 'Ns. Dewi Anggraini, S.Kep',
      role: 'Perawat Luka Diabetes',
      rating: 4.9,
      reviewCount: 91,
      imageSeed: '33',
      photoUrl: _px('9893870'),
    ),
    _NakesItem(
      name: 'Ns. Ayu Lestari, S.Kep',
      role: 'Edukator Diabetes',
      rating: 4.8,
      reviewCount: 70,
      imageSeed: '34',
      photoUrl: _px('6749773'),
    ),
    _NakesItem(
      name: 'Ns. Rina Safitri, S.Kep',
      role: 'Perawat Vaksinasi',
      rating: 4.8,
      reviewCount: 64,
      imageSeed: '35',
      photoUrl: _px('8376309'),
    ),
    _NakesItem(
      name: 'Ns. Siti Nurhaliza, S.Kep',
      role: 'Perawat Lansia',
      rating: 4.7,
      reviewCount: 58,
      imageSeed: '36',
      photoUrl: _px('4227075'),
    ),
    _NakesItem(
      name: 'Ns. Budi Hartono, S.Kep',
      role: 'Perawat Home Care',
      rating: 4.7,
      reviewCount: 60,
      imageSeed: '37',
      photoUrl: _px('6129574'),
    ),
    _NakesItem(
      name: 'Ns. Rizki Fahmi, S.Kep',
      role: 'Perawat Home Care',
      rating: 4.6,
      reviewCount: 55,
      imageSeed: '38',
      photoUrl: _px('19438560'),
    ),
    _NakesItem(
      name: 'Ns. Hendra Wijaya, S.Kep',
      role: 'Perawat Luka Diabetes',
      rating: 4.7,
      reviewCount: 66,
      imageSeed: '39',
      photoUrl: _px('7108250'),
    ),
    _NakesItem(
      name: 'Ns. Fitri Handayani, S.Kep',
      role: 'Perawat Luka',
      rating: 4.8,
      reviewCount: 72,
      imageSeed: '40',
      photoUrl: _px('5998477'),
    ),
  ];

  /// Tombol back (di AppBar maupun tombol back HP):
  /// kalau sudah memilih, kembali ke langkah 1; kalau belum, keluar halaman.
  bool _handleBack() {
    if (_pilihan != null) {
      setState(() => _pilihan = null);
      return false; // jangan keluar halaman
    }
    return true; // keluar halaman
  }

  @override
  Widget build(BuildContext context) {
    final judul = _pilihan == null
        ? 'Kunjungan Dokter'
        : (_pilihan == _Jenis.dokter ? 'Pilih Dokter' : 'Pilih Perawat');

    return WillPopScope(
      onWillPop: () async => _handleBack(),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          surfaceTintColor: Colors.white,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: _kjNavyDark, size: 22),
            onPressed: () {
              if (_handleBack()) Navigator.maybePop(context);
            },
          ),
          title: Text(
            judul,
            style: const TextStyle(
              color: _kjNavyDark,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: SafeArea(
          top: false,
          child: _pilihan == null
              ? _buildPilihanAwal()
              : _buildDaftar(
                  _pilihan == _Jenis.dokter ? _doctors : _nurses,
                ),
        ),
      ),
    );
  }

  // -------------------------------------------------------------------------
  // LANGKAH 1: PILIH DOKTER ATAU PERAWAT
  // -------------------------------------------------------------------------

  Widget _buildPilihanAwal() {
    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 16),
      children: [
        const Text(
          'Siapa yang ingin berkunjung?',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: _kjNavyDark,
          ),
        ),
        const SizedBox(height: 4),
        const Text(
          'Pilih jenis tenaga kesehatan terlebih dahulu, lalu tentukan yang sesuai kebutuhanmu.',
          style: TextStyle(fontSize: 12.5, color: _kjTextGrey, height: 1.4),
        ),
        const SizedBox(height: 20),
        _buildJenisCard(
          icon: Icons.medical_services_rounded,
          color: _kjPrimaryBlue,
          title: 'Dokter',
          subtitle:
              'Pemeriksaan dan konsultasi di rumah oleh dokter umum atau spesialis.',
          jumlah: '${_doctors.length} dokter tersedia',
          onTap: () => setState(() => _pilihan = _Jenis.dokter),
        ),
        const SizedBox(height: 14),
        _buildJenisCard(
          icon: Icons.health_and_safety_rounded,
          color: _kjGreen,
          title: 'Perawat',
          subtitle:
              'Perawatan luka, vaksinasi, dan pendampingan kesehatan di rumah.',
          jumlah: '${_nurses.length} perawat tersedia',
          onTap: () => setState(() => _pilihan = _Jenis.perawat),
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
          border: Border.all(color: _kjCardBorderColor),
          boxShadow: [
            BoxShadow(
              color: _kjNavyDark.withOpacity(0.04),
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
                      color: _kjNavyDark,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      fontSize: 12,
                      color: _kjTextGrey,
                      height: 1.35,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: _kjChipBg,
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
            const Icon(Icons.chevron_right_rounded, color: _kjTextGrey),
          ],
        ),
      ),
    );
  }

  // -------------------------------------------------------------------------
  // LANGKAH 2: DAFTAR SESUAI PILIHAN
  // -------------------------------------------------------------------------

  Widget _buildDaftar(List<_NakesItem> items) {
    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 16),
      itemCount: items.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: _buildNakesCard(context, items[index]),
        );
      },
    );
  }

  Widget _buildFoto(_NakesItem item) {
    const double size = 52;
    return ClipOval(
      child: Image.network(
        item.photoUrl,
        width: size,
        height: size,
        fit: BoxFit.cover,
        alignment: Alignment.topCenter,
        errorBuilder: (context, error, stackTrace) => Container(
          width: size,
          height: size,
          color: _kjChipBg,
          child: const Icon(Icons.person, color: _kjPrimaryBlue, size: 28),
        ),
      ),
    );
  }

  Widget _buildNakesCard(BuildContext context, _NakesItem item) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _kjCardBorderColor),
      ),
      child: Row(
        children: [
          _buildFoto(item),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.name,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: _kjNavyDark,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  item.role,
                  style: const TextStyle(fontSize: 12, color: _kjTextGrey),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(Icons.star_rounded,
                        color: _kjStarYellow, size: 16),
                    const SizedBox(width: 4),
                    Text(
                      '${item.rating} (${item.reviewCount} ulasan)',
                      style:
                          const TextStyle(fontSize: 11.5, color: _kjTextGrey),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => JadwalBookingScreen(
                    name: item.name,
                    specialty: item.role,
                    rating: item.rating,
                    reviewCount: item.reviewCount,
                    imageSeed: item.imageSeed,
                  ),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: _kjPrimaryBlue,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              padding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            ),
            child: const Text(
              'Booking',
              style: TextStyle(fontSize: 12.5, fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }
}