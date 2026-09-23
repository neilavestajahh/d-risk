import 'package:flutter/material.dart';

import 'jadwal_booking_screen.dart';

// Letakkan di: lib/perawat_screen.dart
// (langsung di lib/, BUKAN di lib/screens/)

const Color _pwPrimaryBlue = Color(0xFF1E6FE0);
const Color _pwNavyDark = Color(0xFF1B2A4A);
const Color _pwTextGrey = Color(0xFF7A8B9E);
const Color _pwCardBorderColor = Color(0xFFE2E8F0);
const Color _pwStarYellow = Color(0xFFFFB020);

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

/// Halaman Perawat / Nakes (dibuka dari menu Home Care)
class PerawatScreen extends StatefulWidget {
  const PerawatScreen({super.key});

  @override
  State<PerawatScreen> createState() => _PerawatScreenState();
}

class _PerawatScreenState extends State<PerawatScreen> {
  final TextEditingController _searchController = TextEditingController();

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
    _NurseItem(
      name: 'Ns. Zaky Putra',
      role: 'Perawat Vaksinasi',
      rating: 4.9,
      reviewCount: 101,
      imageSeed: '24',
    ),
    _NurseItem(
      name: 'Ns. Lisa R',
      role: 'Perawat Homecare',
      rating: 4.8,
      reviewCount: 78,
      imageSeed: '25',
    ),
    _NurseItem(
      name: 'Ns. Diana L',
      role: 'Perawat Home Care',
      rating: 4.6,
      reviewCount: 55,
      imageSeed: '26',
    ),
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F8FA),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        surfaceTintColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: _pwNavyDark, size: 22),
          onPressed: () => Navigator.maybePop(context),
        ),
        title: const Text(
          'Perawat / Nakes',
          style: TextStyle(
            color: _pwNavyDark,
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
              padding: const EdgeInsets.fromLTRB(20, 4, 20, 8),
              child: Text(
                'Tim kesehatan yang siap membantu Anda.',
                style: TextStyle(fontSize: 12.5, color: _pwTextGrey),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 14),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: _pwCardBorderColor),
                      ),
                      child: TextField(
                        controller: _searchController,
                        onChanged: (_) => setState(() {}),
                        decoration: InputDecoration(
                          icon: Icon(Icons.search, color: _pwTextGrey, size: 20),
                          hintText: 'Cari nama perawat...',
                          hintStyle: TextStyle(fontSize: 13, color: _pwTextGrey),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: _pwCardBorderColor),
                    ),
                    child: Icon(Icons.tune, color: _pwPrimaryBlue, size: 20),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 16),
                itemCount: _filteredNurses.length,
                itemBuilder: (context, index) {
                  final nurse = _filteredNurses[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: _buildNurseCard(context, nurse),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<_NurseItem> get _filteredNurses {
    final query = _searchController.text.trim().toLowerCase();
    if (query.isEmpty) return _nurses;
    return _nurses
        .where((n) => n.name.toLowerCase().contains(query))
        .toList();
  }

  Widget _buildNurseCard(BuildContext context, _NurseItem nurse) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _pwCardBorderColor),
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
                child: Icon(Icons.person, color: _pwTextGrey),
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
                    color: _pwNavyDark,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  nurse.role,
                  style: TextStyle(fontSize: 12, color: _pwTextGrey),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(Icons.star_rounded, color: _pwStarYellow, size: 16),
                    const SizedBox(width: 4),
                    Text(
                      '${nurse.rating} (${nurse.reviewCount} ulasan)',
                      style: TextStyle(fontSize: 11.5, color: _pwTextGrey),
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
              backgroundColor: _pwPrimaryBlue,
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