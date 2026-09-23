import 'package:flutter/material.dart';

import 'pilih_jadwal_vitamin_screen.dart';

// Letakkan di: lib/vitamin_booster_screen.dart
// (langsung di lib/, BUKAN di lib/screens/)

// ---------------------------------------------------------------------------
// WARNA UTAMA HALAMAN INI
// ---------------------------------------------------------------------------

const Color kTeal = Color(0xFF17A2B8);
const Color kBlue = Color(0xFF2F80ED);
const Color kGreen = Color(0xFF27AE60);

// ---------------------------------------------------------------------------
// MODEL DATA
// ---------------------------------------------------------------------------

class VitaminType {
  final String letter;
  final Color color;
  final Color bgColor;
  final String title;
  final String subtitle;

  const VitaminType({
    required this.letter,
    required this.color,
    required this.bgColor,
    required this.title,
    required this.subtitle,
  });
}

// ---------------------------------------------------------------------------
// HALAMAN DETAIL: VITAMIN BOOSTER
// ---------------------------------------------------------------------------

class VitaminBoosterScreen extends StatefulWidget {
  const VitaminBoosterScreen({super.key});

  @override
  State<VitaminBoosterScreen> createState() => _VitaminBoosterScreenState();
}

class _VitaminBoosterScreenState extends State<VitaminBoosterScreen> {
  final List<String> _manfaat = const [
    'Meningkatkan daya tahan tubuh',
    'Menjaga metabolisme energi',
    'Membantu proses penyembuhan',
    'Mengurangi risiko komplikasi diabetes',
  ];

  final List<VitaminType> _jenisVitamin = const [
    VitaminType(
      letter: 'C',
      color: Color(0xFFF2994A),
      bgColor: Color(0xFFFDF0E4),
      title: 'Vitamin C',
      subtitle: 'Meningkatkan imunitas tubuh',
    ),
    VitaminType(
      letter: 'D',
      color: Color(0xFF2F80ED),
      bgColor: Color(0xFFE8F1FD),
      title: 'Vitamin D',
      subtitle: 'Menjaga kesehatan tulang & sel',
    ),
    VitaminType(
      letter: 'M',
      color: Color(0xFF9B51E0),
      bgColor: Color(0xFFF1E9FB),
      title: 'Multivitamin',
      subtitle: 'Lengkapi nutrisi harian',
    ),
  ];

  // Jenis vitamin yang sedang dipilih user (null = belum pilih spesifik).
  String? _selectedVitamin;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppBar(),
      body: SafeArea(
        top: false,
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeaderBanner(),
              const SizedBox(height: 14),
              _buildInfoNotice(),
              const SizedBox(height: 20),
              _buildSectionTitle('Manfaat'),
              const SizedBox(height: 10),
              ..._manfaat.map(
                (text) => Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: _buildCheckRow(text),
                ),
              ),
              const SizedBox(height: 12),
              _buildSectionTitle('Jenis Vitamin Booster'),
              const SizedBox(height: 10),
              ..._jenisVitamin.map(
                (v) => Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: _buildVitaminCard(v),
                ),
              ),
              const SizedBox(height: 12),
              _buildBookingButton(),
            ],
          ),
        ),
      ),
    );
  }

  // -------------------------------------------------------------------------
  // APP BAR
  // -------------------------------------------------------------------------

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      surfaceTintColor: Colors.white,
      titleSpacing: 0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.black87, size: 22),
        onPressed: () => Navigator.maybePop(context),
      ),
      title: const Text(
        'Vitamin Booster',
        style: TextStyle(
          color: Colors.black87,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  // -------------------------------------------------------------------------
  // BANNER HEADER
  // -------------------------------------------------------------------------

  Widget _buildHeaderBanner() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFFDDEBFB), Color(0xFFE8F1FD)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                'Vitamin Booster',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: 8),
              SizedBox(
                width: 190,
                child: Text(
                  'Nutrisi tambahan untuk menjaga daya tahan tubuh.',
                  style: TextStyle(fontSize: 12, color: Colors.black54, height: 1.4),
                ),
              ),
            ],
          ),
          Positioned(
            right: 4,
            top: 0,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Icon(Icons.medication_liquid, size: 56, color: kBlue.withOpacity(0.85)),
                Positioned(
                  right: -4,
                  bottom: -2,
                  child: Container(
                    width: 22,
                    height: 22,
                    decoration: BoxDecoration(
                      color: const Color(0xFFF2994A),
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 2),
                    ),
                    child: const Icon(Icons.add, color: Colors.white, size: 13),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // -------------------------------------------------------------------------
  // NOTIFIKASI INFO
  // -------------------------------------------------------------------------

  Widget _buildInfoNotice() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: const Color(0xFFE8F1FD),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Icon(Icons.shield_outlined, color: kBlue, size: 18),
          SizedBox(width: 10),
          Expanded(
            child: Text(
              'Vitamin dan nutrisi penting membantu menjaga metabolisme tubuh dan mendukung imunitas, terutama bagi penderita diabetes.',
              style: TextStyle(fontSize: 12.5, color: Colors.black87, height: 1.4),
            ),
          ),
        ],
      ),
    );
  }

  // -------------------------------------------------------------------------
  // JUDUL SEKSI
  // -------------------------------------------------------------------------

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.bold,
        color: Colors.black87,
      ),
    );
  }

  // -------------------------------------------------------------------------
  // BARIS MANFAAT (CENTANG HIJAU)
  // -------------------------------------------------------------------------

  Widget _buildCheckRow(String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 20,
          height: 20,
          margin: const EdgeInsets.only(top: 1),
          decoration: const BoxDecoration(
            color: kGreen,
            shape: BoxShape.circle,
          ),
          child: const Icon(Icons.check, color: Colors.white, size: 13),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(fontSize: 13, color: Colors.black87, height: 1.4),
          ),
        ),
      ],
    );
  }

  // -------------------------------------------------------------------------
  // KARTU JENIS VITAMIN
  // -------------------------------------------------------------------------

  Widget _buildVitaminCard(VitaminType vitamin) {
    final isSelected = _selectedVitamin == vitamin.title;

    return InkWell(
      borderRadius: BorderRadius.circular(14),
      onTap: () {
        setState(() {
          // Tap lagi pada yang sama untuk batal pilih.
          _selectedVitamin = isSelected ? null : vitamin.title;
        });
      },
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: isSelected ? kTeal : Colors.grey.shade200,
            width: isSelected ? 1.4 : 1,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.03),
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: vitamin.bgColor,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  vitamin.letter,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: vitamin.color,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    vitamin.title,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    vitamin.subtitle,
                    style: const TextStyle(fontSize: 12, color: Colors.black45),
                  ),
                ],
              ),
            ),
            Icon(
              isSelected ? Icons.check_circle_rounded : Icons.chevron_right,
              color: isSelected ? kTeal : Colors.grey,
              size: 20,
            ),
          ],
        ),
      ),
    );
  }

  // -------------------------------------------------------------------------
  // TOMBOL BOOKING
  // -------------------------------------------------------------------------

  Widget _buildBookingButton() {
    return SizedBox(
      width: double.infinity,
      height: 52,
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => PilihJadwalVitaminScreen(
                selectedVitamin: _selectedVitamin,
              ),
            ),
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: kTeal,
          foregroundColor: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(26),
          ),
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.calendar_today, size: 16),
            SizedBox(width: 8),
            Text(
              'Booking Sekarang',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
            ),
            SizedBox(width: 8),
            Icon(Icons.arrow_forward, size: 16),
          ],
        ),
      ),
    );
  }
}