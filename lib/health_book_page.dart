import 'package:flutter/material.dart';
import 'apa_itu_diabetes_screen.dart'; // halaman detail "Apa itu diabetes?"
import 'gejala_diabetes_screen.dart'; // halaman detail "Gejala diabetes?"
import 'faktor_risiko_screen.dart'; // halaman detail "Faktor Risiko diabetes?"
import 'cara_pencegahan_screen.dart'; // halaman detail "Cara pencegahan diabetes?"
import 'pola_makan_sehat_screen.dart'; // halaman detail "Pola makan sehat"
import 'kontrol_gula_darah_screen.dart'; // halaman detail "Kontrol Gula Darah"
import 'olahraga_screen.dart'; // halaman detail "Olahraga"

class ChapterItem {
  final IconData icon;
  final Color iconColor;
  final Color iconBgColor;
  final String title;
  final String subtitle;

  const ChapterItem({
    required this.icon,
    required this.iconColor,
    required this.iconBgColor,
    required this.title,
    required this.subtitle,
  });
}

class HealthBookPage extends StatefulWidget {
  const HealthBookPage({super.key});

  @override
  State<HealthBookPage> createState() => _HealthBookPageState();
}

class _HealthBookPageState extends State<HealthBookPage> {
  int _bottomNavIndex = 1;
  final TextEditingController _searchController = TextEditingController();

  final List<ChapterItem> _chapters = const [
    ChapterItem(
      icon: Icons.info_outline,
      iconColor: Color(0xFF2F80ED),
      iconBgColor: Color(0xFFE8F1FD),
      title: 'Apa itu diabetes?',
      subtitle: 'Pengertian, penyebab, dan jenis diabetes',
    ),
    ChapterItem(
      icon: Icons.error_outline,
      iconColor: Color(0xFFEB5757),
      iconBgColor: Color(0xFFFCEAEA),
      title: 'Gejala diabetes?',
      subtitle: 'Kenali tanda dan gejala diabetes',
    ),
    ChapterItem(
      icon: Icons.people_outline,
      iconColor: Color(0xFF27AE60),
      iconBgColor: Color(0xFFE7F6EC),
      title: 'Faktor Risiko diabetes?',
      subtitle: 'Siapa saja yang berisiko?',
    ),
    ChapterItem(
      icon: Icons.shield_outlined,
      iconColor: Color(0xFF9B51E0),
      iconBgColor: Color(0xFFF1E9FB),
      title: 'Cara pencegahan diabetes?',
      subtitle: 'Langkah sederhana mencegah diabetes',
    ),
    ChapterItem(
      icon: Icons.restaurant_menu,
      iconColor: Color(0xFFF2994A),
      iconBgColor: Color(0xFFFDF0E4),
      title: 'Pola makan sehat',
      subtitle: 'Menu sehat untuk penderita diabetes',
    ),
    ChapterItem(
      icon: Icons.directions_run,
      iconColor: Color(0xFF27AE60),
      iconBgColor: Color(0xFFE7F6EC),
      title: 'Olahraga',
      subtitle: 'Aktivitas fisik yang aman untuk diabetes',
    ),
    ChapterItem(
      icon: Icons.water_drop_outlined,
      iconColor: Color(0xFF2F80ED),
      iconBgColor: Color(0xFFE8F1FD),
      title: 'Kontrol Gula Darah',
      subtitle: 'Tips menjaga gula darah tetap stabil',
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
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: _buildAppBar(),
      body: SafeArea(
        top: false,
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildDiabetesBanner(),
              const SizedBox(height: 16),
              _buildSearchBar(),
              const SizedBox(height: 20),
              const Text(
                'Daftar Bab',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 12),
              ..._chapters.map(
                (c) => Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: _buildChapterCard(c),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: _buildBottomNavBar(),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: const Color(0xFFF5F7FA),
      elevation: 0,
      surfaceTintColor: const Color(0xFFF5F7FA),
      titleSpacing: 0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.black87, size: 22),
        onPressed: () => Navigator.maybePop(context),
      ),
      title: const Text(
        'Health Book',
        style: TextStyle(
          color: Colors.black87,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildDiabetesBanner() {
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (_) => const ApaItuDiabetesScreen()),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: const Color(0xFFDDEBFB),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.accessibility_new, color: Color(0xFF2F80ED)),
            ),
            const SizedBox(width: 14),
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'DIABETES',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                      letterSpacing: 0.5,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Ayo kenali gejala awal diabetes',
                    style: TextStyle(fontSize: 12, color: Colors.black54),
                  ),
                ],
              ),
            ),
            const Icon(Icons.chevron_right, color: Colors.black45),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: TextField(
        controller: _searchController,
        decoration: const InputDecoration(
          hintText: 'Cari topik kesehatan...',
          hintStyle: TextStyle(color: Colors.grey, fontSize: 14),
          prefixIcon: Icon(Icons.search, color: Colors.grey),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(vertical: 14),
        ),
      ),
    );
  }

  Widget _buildChapterCard(ChapterItem chapter) {
    return InkWell(
      borderRadius: BorderRadius.circular(14),
      onTap: () {
        // Setiap bab diarahkan ke halaman detailnya masing-masing.
        // Bab yang belum punya halaman detail akan diabaikan (tidak melakukan apa-apa).
        if (chapter.title == 'Apa itu diabetes?') {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (_) => const ApaItuDiabetesScreen()),
          );
        } else if (chapter.title == 'Gejala diabetes?') {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (_) => const GejalaDiabetesScreen()),
          );
        } else if (chapter.title == 'Faktor Risiko diabetes?') {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (_) => const FaktorRisikoScreen()),
          );
        } else if (chapter.title == 'Cara pencegahan diabetes?') {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (_) => const CaraPencegahanScreen()),
          );
        } else if (chapter.title == 'Pola makan sehat') {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (_) => const PolaMakanSehatScreen()),
          );
        } else if (chapter.title == 'Kontrol Gula Darah') {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (_) => const KontrolGulaDarahScreen()),
          );
        } else if (chapter.title == 'Olahraga') {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (_) => const OlahragaScreen()),
          );
        }
      },
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
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
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                color: chapter.iconBgColor,
                shape: BoxShape.circle,
              ),
              child: Icon(chapter.icon, color: chapter.iconColor, size: 20),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    chapter.title,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    chapter.subtitle,
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ],
              ),
            ),
            const Icon(Icons.chevron_right, color: Colors.grey, size: 20),
          ],
        ),
      ),
    );
  }

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
              final color = selected ? const Color(0xFF2F80ED) : Colors.grey;
              return Expanded(
                child: InkWell(
                  onTap: () => setState(() => _bottomNavIndex = index),
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