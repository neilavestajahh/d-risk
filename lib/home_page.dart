import 'package:flutter/material.dart';
import 'article_list_screen.dart';
import 'notification_screen.dart';
import 'health_book_page.dart';
import 'kunjungan_dokter_screen.dart';
import 'screening_screen.dart';
import 'home_care_screen.dart';
import 'profil_screen.dart'; // berisi ProfilScreen dan RiwayatScreen
import 'konsultasi_dokter_screen.dart';
import 'olahraga_screen.dart';

/// Halaman Beranda (Home) untuk aplikasi D-risk (diabetes risk screening)
class HomePage extends StatefulWidget {
  final String userName;

  const HomePage({super.key, this.userName = 'Sania'});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  // Palet Warna
  static const Color primaryBlue = Color(0xFF1E6FE0);
  static const Color navyDark = Color(0xFF1B2A4A);
  static const Color textGrey = Color(0xFF7A8B9E);
  static const Color accentGreen = Color(0xFF22A45D);
  static const Color lightGreenBg = Color(0xFFE7F7EF);
  static const Color accentOrange = Color(0xFFFF8A3D);
  static const Color lightOrangeBg = Color(0xFFFFF1E6);
  static const Color accentPurple = Color(0xFF8B5CF6);
  static const Color lightPurpleBg = Color(0xFFF2ECFF);
  static const Color lightBlueBg = Color(0xFFE8F1FE);
  static const Color fieldFillColor = Color(0xFFF1F5F9);
  static const Color cardBorderColor = Color(0xFFE2E8F0);
  static const Color bannerBg = Color(0xFFDCEBFF);

  static const List<String> _newsImageUrls = [
    'https://images.unsplash.com/photo-1576091160399-112ba8d25d1d?w=200&q=80',
    'https://images.unsplash.com/photo-1490645935967-10de6ba17061?w=200&q=80',
    'https://images.unsplash.com/photo-1571019613454-1cb2f99b2d8b?w=200&q=80',
  ];

  List<Article> get _homeNewsItems => articles.take(3).toList();

  String get _firstName {
    final trimmed = widget.userName.trim();
    if (trimmed.isEmpty) return trimmed;
    return trimmed.split(RegExp(r'\s+')).first;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: _buildBottomNav(),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFFCFE0FB),
              Color(0xFFBFE8F2),
              Color(0xFFD6F2DE),
              Color(0xFFFBE6D6),
              Color(0xFFF8FAFC),
            ],
            stops: [0.0, 0.22, 0.45, 0.65, 0.9],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildHeader(),
                const SizedBox(height: 18),
                _buildSearchBar(),
                const SizedBox(height: 18),
                _buildDiabetesBanner(),
                const SizedBox(height: 22),
                _buildQuickAccessGrid(),
                const SizedBox(height: 22),
                _buildRecommendationSection(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Header sapaan + notifikasi + avatar
  Widget _buildHeader() {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    'Hi, $_firstName',
                    style: const TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.w800,
                      color: navyDark,
                    ),
                  ),
                  const SizedBox(width: 6),
                  const Text('👋', style: TextStyle(fontSize: 18)),
                ],
              ),
              const SizedBox(height: 3),
              const Text(
                'Jaga kesehatan, wujudkan hidup yang lebih baik',
                style: TextStyle(
                  fontSize: 12.5,
                  color: textGrey,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
        _buildIconButton(Icons.notifications_none_rounded, () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (_) => const NotificationScreen()),
          );
        }),
        const SizedBox(width: 10),
        _buildAvatar(),
      ],
    );
  }

  Widget _buildIconButton(IconData icon, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          border: Border.all(color: cardBorderColor),
        ),
        child: Icon(icon, size: 20, color: navyDark),
      ),
    );
  }

  Widget _buildAvatar() {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (_) => const ProfilScreen()),
        );
      },
      borderRadius: BorderRadius.circular(20),
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: primaryBlue, width: 1.6),
        ),
        child: ClipOval(
          child: Image.network(
            'https://i.pravatar.cc/80?img=47',
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) => Container(
              color: fieldFillColor,
              child: const Icon(Icons.person, color: textGrey),
            ),
          ),
        ),
      ),
    );
  }

  /// Search bar
  Widget _buildSearchBar() {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (_) => const ArticleListScreen()),
        );
      },
      child: Container(
        height: 46,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: cardBorderColor),
        ),
        child: const Row(
          children: [
            SizedBox(width: 14),
            Icon(Icons.search_rounded, size: 20, color: textGrey),
            SizedBox(width: 10),
            Expanded(
              child: Text(
                'Cari artikel, dokter, atau layanan...',
                style: TextStyle(fontSize: 13, color: textGrey),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Banner "Kenali Risiko Diabetes Sejak Dini"
  Widget _buildDiabetesBanner() {
    return Container(
      padding: const EdgeInsets.fromLTRB(18, 16, 12, 16),
      decoration: BoxDecoration(
        color: bannerBg,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Text(
                    'Cek Risiko Diabetes',
                    style: TextStyle(
                      fontSize: 10.5,
                      color: primaryBlue,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Kenali Risiko\nDiabetes Sejak Dini',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                    color: navyDark,
                    height: 1.25,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Cek tingkat risiko diabetesmu dengan mudah dan cepat, hanya dalam hitungan menit.',
                  style: TextStyle(
                    fontSize: 11,
                    color: textGrey,
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 14),
                InkWell(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (_) => const ScreeningKesehatanPage()),
                    );
                  },
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      color: accentGreen,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Mulai Cek Sekarang',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(width: 6),
                        Icon(
                          Icons.arrow_forward_rounded,
                          size: 15,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          _buildGlucoseIllustration(),
        ],
      ),
    );
  }

  Widget _buildGlucoseIllustration() {
    return SizedBox(
      width: 92,
      height: 118,
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.bottomCenter,
        children: [
          Positioned(
            bottom: 0,
            child: Container(
              width: 74,
              height: 96,
              decoration: BoxDecoration(
                color: primaryBlue,
                borderRadius: BorderRadius.circular(18),
              ),
              child: const Icon(
                Icons.back_hand_rounded,
                color: Colors.white,
                size: 40,
              ),
            ),
          ),
          Positioned(
            top: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
                boxShadow: [
                  BoxShadow(
                    color: navyDark.withValues(alpha: 0.12),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.water_drop_rounded,
                      color: Colors.redAccent, size: 14),
                  const SizedBox(height: 2),
                  const Text(
                    '98',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w800,
                      color: navyDark,
                    ),
                  ),
                  const Text(
                    'mg/dL',
                    style: TextStyle(fontSize: 7.5, color: textGrey),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Grid akses cepat: Homecare, Healthbook, Olahraga, Screening
  Widget _buildQuickAccessGrid() {
    final items = [
      _QuickAccessItem(
        icon: Icons.home_repair_service_rounded,
        label: 'Homecare',
        subtitle: 'Kunjungan dokter ke rumah',
        iconColor: accentGreen,
        iconBg: lightGreenBg,
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (_) => const HomeCareScreen()),
          );
        },
      ),
      _QuickAccessItem(
        icon: Icons.menu_book_rounded,
        label: 'Healthbook',
        subtitle: 'Simpan riwayat kesehatan',
        iconColor: accentPurple,
        iconBg: lightPurpleBg,
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (_) => const HealthBookPage()),
          );
        },
      ),
      _QuickAccessItem(
        icon: Icons.fitness_center_rounded,
        label: 'Olahraga',
        subtitle: 'Latihan fisik rutin',
        iconColor: accentOrange,
        iconBg: lightOrangeBg,
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (_) => OlahragaScreen()),
          );
        },
      ),
      _QuickAccessItem(
        icon: Icons.monitor_heart_rounded,
        label: 'Screening',
        subtitle: 'Deteksi dini penyakit',
        iconColor: primaryBlue,
        iconBg: lightBlueBg,
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (_) => const ScreeningKesehatanPage()),
          );
        },
      ),
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: items.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
        childAspectRatio: 1.25,
      ),
      itemBuilder: (context, index) => _buildQuickAccessCard(items[index]),
    );
  }

  Widget _buildQuickAccessCard(_QuickAccessItem item) {
    return InkWell(
      onTap: item.onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: cardBorderColor),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 34,
              height: 34,
              decoration: BoxDecoration(
                color: item.iconBg,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(item.icon, color: item.iconColor, size: 18),
            ),
            const SizedBox(height: 6),
            Text(
              item.label,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w700,
                color: navyDark,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              item.subtitle,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 10, color: textGrey),
            ),
          ],
        ),
      ),
    );
  }

  /// Section "Rekomendasi untuk Anda"
  Widget _buildRecommendationSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Rekomendasi untuk Anda',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: navyDark,
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const ArticleListScreen()),
                );
              },
              style: TextButton.styleFrom(
                padding: EdgeInsets.zero,
                minimumSize: Size.zero,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              child: const Text(
                'Lihat Semua',
                style: TextStyle(
                  fontSize: 12.5,
                  color: primaryBlue,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: _homeNewsItems.length,
          separatorBuilder: (context, index) => const SizedBox(height: 12),
          itemBuilder: (context, index) => _buildRecommendationCard(
            _homeNewsItems[index],
            index < _newsImageUrls.length ? _newsImageUrls[index] : null,
          ),
        ),
      ],
    );
  }

  Color _tagColor(String tag) {
    if (tag.toLowerCase().contains('olahraga')) return accentGreen;
    if (tag.toLowerCase().contains('kesehatan')) return accentOrange;
    return primaryBlue;
  }

  Color _tagBgColor(String tag) {
    if (tag.toLowerCase().contains('olahraga')) return lightGreenBg;
    if (tag.toLowerCase().contains('kesehatan')) return lightOrangeBg;
    return lightBlueBg;
  }

  Widget _buildRecommendationCard(Article item, String? imageUrl) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (_) => ArticleDetailScreen(article: item)),
        );
      },
      borderRadius: BorderRadius.circular(14),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: cardBorderColor),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: imageUrl != null
                  ? Image.network(
                      imageUrl,
                      width: 72,
                      height: 72,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Container(
                        width: 72,
                        height: 72,
                        color: fieldFillColor,
                        child:
                            const Icon(Icons.image_outlined, color: textGrey),
                      ),
                    )
                  : Container(
                      width: 72,
                      height: 72,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: item.thumbGradient,
                        ),
                      ),
                    ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(
                      color: _tagBgColor(item.tag),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      item.tag,
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                        color: _tagColor(item.tag),
                      ),
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    item.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: navyDark,
                      height: 1.3,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      const Icon(
                        Icons.calendar_today_outlined,
                        size: 11,
                        color: textGrey,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        item.date,
                        style: const TextStyle(fontSize: 10.5, color: textGrey),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        '• ${item.readTime}',
                        style: const TextStyle(fontSize: 10.5, color: textGrey),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Bottom Navigation Bar: Beranda, Konsultasi, Riwayat, Profil
  Widget _buildBottomNav() {
    final items = [
      _NavItem(icon: Icons.home_rounded, label: 'Beranda'),
      _NavItem(icon: Icons.chat_bubble_outline_rounded, label: 'Konsultasi'),
      _NavItem(icon: Icons.history_rounded, label: 'Riwayat'),
      _NavItem(icon: Icons.person_outline_rounded, label: 'Profil'),
    ];

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: navyDark.withValues(alpha: 0.06),
            blurRadius: 12,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(items.length, (index) {
              final isSelected = index == _selectedIndex;
              return InkWell(
                onTap: () {
                  // Beranda: tetap di halaman ini
                  if (index == 0) {
                    setState(() => _selectedIndex = 0);
                    return;
                  }

                  // Semua tab sekarang punya halaman tujuan
                  final Widget page;
                  if (index == 1) {
                    page = KonsultasiDokterScreen();
                  } else if (index == 2) {
                    page = RiwayatScreen(); // dari profil_screen.dart
                  } else {
                    page = const ProfilScreen();
                  }

                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => page),
                  );
                },
                borderRadius: BorderRadius.circular(12),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        items[index].icon,
                        size: 22,
                        color: isSelected ? primaryBlue : textGrey,
                      ),
                      const SizedBox(height: 3),
                      Text(
                        items[index].label,
                        style: TextStyle(
                          fontSize: 10.5,
                          fontWeight:
                              isSelected ? FontWeight.w700 : FontWeight.w500,
                          color: isSelected ? primaryBlue : textGrey,
                        ),
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

class _QuickAccessItem {
  final IconData icon;
  final String label;
  final String subtitle;
  final Color iconColor;
  final Color iconBg;
  final VoidCallback onTap;

  const _QuickAccessItem({
    required this.icon,
    required this.label,
    required this.subtitle,
    required this.iconColor,
    required this.iconBg,
    required this.onTap,
  });
}

class _NavItem {
  final IconData icon;
  final String label;

  const _NavItem({required this.icon, required this.label});
}