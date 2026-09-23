import 'package:flutter/material.dart';
import 'home_page.dart';
import 'health_book_page.dart';
import 'kunjungan_dokter_screen.dart';
import 'screening_question_screen.dart';

// ---------------------------------------------------------------------------
// WARNA UTAMA HALAMAN INI
// ---------------------------------------------------------------------------

const Color kTeal = Color(0xFF17A2B8);

// ---------------------------------------------------------------------------
// HALAMAN AWAL / INTRO SCREENING
// ---------------------------------------------------------------------------

class ScreeningKesehatanPage extends StatefulWidget {
  const ScreeningKesehatanPage({super.key});

  @override
  State<ScreeningKesehatanPage> createState() => _ScreeningKesehatanPageState();
}

class _ScreeningKesehatanPageState extends State<ScreeningKesehatanPage> {
  int _bottomNavIndex = 3; // "Screening" aktif

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppBar(),
      body: SafeArea(
        top: false,
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(24, 20, 24, 20),
          child: Column(
            children: [
              _buildImageCard(
                'https://images.unsplash.com/photo-1683727186226-910f31a9da45?w=400&q=80',
                'Screening Dini',
              ),
              const SizedBox(height: 32),
              _buildMulaiButton(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: _buildBottomNavBar(),
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
      centerTitle: true,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: kTeal, size: 22),
        onPressed: () => Navigator.maybePop(context),
      ),
      title: const Text(
        'Screening Kesehatan Mandiri',
        style: TextStyle(
          color: kTeal,
          fontSize: 15,
          fontWeight: FontWeight.bold,
        ),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.insert_drive_file_outlined, color: kTeal, size: 20),
          onPressed: () {
            // TODO: aksi buka riwayat/dokumen screening
          },
        ),
      ],
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(3),
        child: Container(height: 3, color: kTeal),
      ),
    );
  }

  // -------------------------------------------------------------------------
  // KARTU GAMBAR (dengan label di bawahnya)
  // -------------------------------------------------------------------------

  Widget _buildImageCard(String imageUrl, String label) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: AspectRatio(
            aspectRatio: 1,
            child: Image.network(
              imageUrl,
              fit: BoxFit.cover,
              loadingBuilder: (context, child, progress) {
                if (progress == null) return child;
                return Container(
                  color: Colors.grey.shade200,
                  child: const Center(child: CircularProgressIndicator(color: kTeal)),
                );
              },
              errorBuilder: (context, error, stackTrace) => Container(
                color: Colors.grey.shade200,
                child: const Icon(Icons.image_not_supported, size: 40, color: Colors.grey),
              ),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: const TextStyle(
            fontSize: 13.5,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
      ],
    );
  }

  // -------------------------------------------------------------------------
  // TOMBOL MULAI PENGECEKAN -> masuk ke halaman form pertanyaan
  // -------------------------------------------------------------------------

  Widget _buildMulaiButton() {
    return SizedBox(
      width: double.infinity,
      height: 52,
      child: ElevatedButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (_) => const ScreeningQuestionScreen()),
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: kTeal,
          foregroundColor: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
        child: const Text(
          'Mulai Pengecekan',
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  // -------------------------------------------------------------------------
  // BOTTOM NAVIGATION BAR (navigasi beneran jalan, konsisten dengan Home)
  // -------------------------------------------------------------------------

  Widget _buildBottomNavBar() {
    final items = [
      {'icon': Icons.home_rounded, 'label': 'Beranda'},
      {'icon': Icons.menu_book_rounded, 'label': 'Book Health'},
      {'icon': Icons.chat_bubble_outline_rounded, 'label': 'Konsultasi'},
      {'icon': Icons.science_outlined, 'label': 'Screening'},
      {'icon': Icons.home_repair_service_outlined, 'label': 'Home Care'},
    ];

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Colors.grey.shade200)),
      ),
      child: SafeArea(
        top: false,
        child: SizedBox(
          height: 64,
          child: Row(
            children: List.generate(items.length, (index) {
              final selected = index == _bottomNavIndex;
              final color = selected ? kTeal : Colors.grey;
              return Expanded(
                child: InkWell(
                  onTap: () {
                    setState(() => _bottomNavIndex = index);

                    // Index 0 = Beranda -> kembali ke HomePage
                    if (index == 0) {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (_) => const HomePage()),
                      );
                    }
                    // Index 1 = Book Health
                    if (index == 1) {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) => const HealthBookPage()),
                      );
                    }
                    // Index 2 = Konsultasi
                    if (index == 2) {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) => const KunjunganDokterScreen()),
                      );
                    }
                    // Index 3 = Screening -> sudah di halaman ini, tidak perlu apa-apa
                    // Index 4 = Home Care -> TODO: sambungkan kalau halamannya sudah ada
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(items[index]['icon'] as IconData, color: color, size: 22),
                      const SizedBox(height: 4),
                      Text(
                        items[index]['label'] as String,
                        style: TextStyle(fontSize: 10, color: color),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}