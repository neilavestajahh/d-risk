import 'package:flutter/material.dart';

import 'jadwal_booking_screen.dart';

// Letakkan di: lib/kunjungan_dokter_screen.dart
// (langsung di lib/, BUKAN di lib/screens/)

const Color _kjPrimaryBlue = Color(0xFF1E6FE0);
const Color _kjNavyDark = Color(0xFF1B2A4A);
const Color _kjTextGrey = Color(0xFF7A8B9E);
const Color _kjCardBorderColor = Color(0xFFE2E8F0);
const Color _kjStarYellow = Color(0xFFFFB020);

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

class _NurseItem {
  final String name;
  final String role;
  final double rating;
  final int reviewCount;
  final String imageSeed;

  const _NurseItem({
    required this.name,
    required this.role,
    required this.rating,
    required this.reviewCount,
    required this.imageSeed,
  });
}

/// Halaman Kunjungan Dokter — berisi tab pilihan Dokter & Perawat.
/// Tombol "Booking" di tiap kartu membuka JadwalBookingScreen dengan
/// data dokter/perawat yang dipilih.
class KunjunganDokterScreen extends StatefulWidget {
  const KunjunganDokterScreen({super.key});

  @override
  State<KunjunganDokterScreen> createState() => _KunjunganDokterScreenState();
}

class _KunjunganDokterScreenState extends State<KunjunganDokterScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  static const List<_DoctorItem> _doctors = [
    _DoctorItem(
      name: 'dr. Amelia Putri, Sp.PD',
      specialty: 'Spesialis Penyakit Dalam',
      imageSeed: '11',
    ),
    _DoctorItem(
      name: 'dr. Rangga Saputra',
      specialty: 'Dokter Umum',
      imageSeed: '12',
    ),
    _DoctorItem(
      name: 'dr. Sinta Dewi, Sp.PD',
      specialty: 'Spesialis Penyakit Dalam',
      imageSeed: '13',
    ),
  ];

  static const List<_NurseItem> _nurses = [
    _NurseItem(
      name: 'Ns. Rina Safitri',
      role: 'Perawat Vaksinasi',
      rating: 4.8,
      reviewCount: 78,
      imageSeed: '21',
    ),
    _NurseItem(
      name: 'Ns. Yeni Astuti',
      role: 'Perawat Home Care',
      rating: 4.7,
      reviewCount: 62,
      imageSeed: '22',
    ),
    _NurseItem(
      name: 'Ns. Rizki Fahmi',
      role: 'Perawat Home Care',
      rating: 4.6,
      reviewCount: 55,
      imageSeed: '23',
    ),
  ];

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        surfaceTintColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: _kjNavyDark, size: 22),
          onPressed: () => Navigator.maybePop(context),
        ),
        title: const Text(
          'Kunjungan Dokter',
          style: TextStyle(
            color: _kjNavyDark,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        bottom: TabBar(
          controller: _tabController,
          labelColor: _kjPrimaryBlue,
          unselectedLabelColor: _kjTextGrey,
          indicatorColor: _kjPrimaryBlue,
          labelStyle: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
          tabs: const [
            Tab(text: 'Dokter'),
            Tab(text: 'Perawat'),
          ],
        ),
      ),
      body: SafeArea(
        top: false,
        child: TabBarView(
          controller: _tabController,
          children: [
            _buildDoctorList(context),
            _buildNurseList(context),
          ],
        ),
      ),
    );
  }

  // -------------------------------------------------------------------------
  // TAB DOKTER
  // -------------------------------------------------------------------------

  Widget _buildDoctorList(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 16),
      itemCount: _doctors.length,
      itemBuilder: (context, index) {
        final doctor = _doctors[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: _buildDoctorCard(context, doctor),
        );
      },
    );
  }

  Widget _buildDoctorCard(BuildContext context, _DoctorItem doctor) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _kjCardBorderColor),
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
                child: const Icon(Icons.person, color: _kjTextGrey),
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
                    color: _kjNavyDark,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  doctor.specialty,
                  style: const TextStyle(fontSize: 12, color: _kjTextGrey),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(Icons.star_rounded, color: _kjStarYellow, size: 16),
                    const SizedBox(width: 4),
                    Text(
                      '${doctor.rating} (${doctor.reviewCount} ulasan)',
                      style: const TextStyle(fontSize: 11.5, color: _kjTextGrey),
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
                    name: doctor.name,
                    specialty: doctor.specialty,
                    rating: doctor.rating,
                    reviewCount: doctor.reviewCount,
                    imageSeed: doctor.imageSeed,
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
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
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

  // -------------------------------------------------------------------------
  // TAB PERAWAT
  // -------------------------------------------------------------------------

  Widget _buildNurseList(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 16),
      itemCount: _nurses.length,
      itemBuilder: (context, index) {
        final nurse = _nurses[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: _buildNurseCard(context, nurse),
        );
      },
    );
  }

  Widget _buildNurseCard(BuildContext context, _NurseItem nurse) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _kjCardBorderColor),
      ),
      child: Row(
        children: [
          ClipOval(
            child: Image.network(
              'https://api.dicebear.com/7.x/avataaars/png?seed=${Uri.encodeComponent(nurse.name)}',
              width: 48,
              height: 48,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Container(
                width: 48,
                height: 48,
                color: const Color(0xFFF1F5F9),
                child: const Icon(Icons.person, color: _kjTextGrey),
              ),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  nurse.name,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: _kjNavyDark,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  nurse.role,
                  style: const TextStyle(fontSize: 12, color: _kjTextGrey),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(Icons.star_rounded, color: _kjStarYellow, size: 16),
                    const SizedBox(width: 4),
                    Text(
                      '${nurse.rating} (${nurse.reviewCount} ulasan)',
                      style: const TextStyle(fontSize: 11.5, color: _kjTextGrey),
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
                    name: nurse.name,
                    specialty: nurse.role,
                    rating: nurse.rating,
                    reviewCount: nurse.reviewCount,
                    imageSeed: nurse.imageSeed,
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
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
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