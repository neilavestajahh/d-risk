import 'package:flutter/material.dart';
import 'article_list_screen.dart'; // sesuaikan path sesuai struktur project-mu
import 'notification_screen.dart'; // sesuaikan path sesuai struktur project-mu
import 'health_book_page.dart'; // halaman Health Book - Daftar Bab Diabetes
import 'kunjungan_dokter_screen.dart'; // halaman Kunjungan Dokter (dipakai di Home Care)
import 'konsultasi_dokter_screen.dart'; // halaman Konsultasi Dokter (list dokter)
import 'screening_screen.dart'; // berisi class ScreeningKesehatanPage (halaman intro)
import 'home_care_screen.dart'; // halaman Home Care
import 'profil_screen.dart'; // halaman Profil (dibuka lewat avatar)

/// Halaman Beranda (Home) untuk aplikasi D-risk (diabetes risk screening)
class HomePage extends StatefulWidget {
  final String userName;

  const HomePage({super.key, this.userName = 'Sania'});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedNavIndex = 0;

  // Palet Warna
  static const Color primaryBlue = Color(0xFF1E6FE0);
  static const Color navyDark = Color(0xFF1B2A4A);
  static const Color textGrey = Color(0xFF7A8B9E);
  static const Color accentGreen = Color(0xFF22A45D);
  static const Color lightGreenBg = Color(0xFFE7F7EF);
  static const Color fieldFillColor = Color(0xFFF1F5F9);
  static const Color cardBorderColor = Color(0xFFE2E8F0);

  // Menggunakan model Article (dari article_list_screen.dart) supaya data
  // yang tampil di Home, di List, dan di Detail selalu konsisten.
  // Untuk gambar asli (network image) dipetakan lewat _newsImageUrls,
  // karena model Article aslinya pakai thumbGradient, bukan URL gambar.
  static const List<String> _newsImageUrls = [
    'https://images.unsplash.com/photo-1576091160399-112ba8d25d1d?w=200&q=80',
    'https://images.unsplash.com/photo-1631815589968-fdb09a223b1e?w=200&q=80',
    'https://images.unsplash.com/photo-1490645935967-10de6ba17061?w=200&q=80',
  ];

  List<Article> get _homeNewsItems => articles.take(3).toList();

  /// Ambil kata pertama dari nama supaya sapaan di dashboard singkat,
  /// walau nama lengkapnya terdiri dari beberapa kata.
  /// Contoh: "Neila Vesta" -> "Neila"
  String get _firstName {
    final trimmed = widget.userName.trim();
    if (trimmed.isEmpty) return trimmed;
    return trimmed.split(RegExp(r'\s+')).first;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: SafeArea(
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
              _buildScreeningBanner(),
              const SizedBox(height: 22),
              _buildRiskSection(),
              const SizedBox(height: 22),
              _buildNewsSection(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: _buildBottomNav(),
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
                    'Halo, $_firstName',
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
                'Bagaimana kondisi kesehatanmu hari ini?',
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
        // Avatar diklik -> buka halaman Profil (menu akun)
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
                'Cari artikel, dokter, penyakit, atau tips...',
                style: TextStyle(fontSize: 13, color: textGrey),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Banner "Early Screening, Better Living"
  Widget _buildScreeningBanner() {
    return Container(
      decoration: BoxDecoration(
        color: navyDark,
        borderRadius: BorderRadius.circular(20),
      ),
      clipBehavior: Clip.antiAlias,
      child: Stack(
        children: [
          Positioned(
            right: 0,
            top: 0,
            bottom: 0,
            width: 130,
            child: Image.network(
              'https://images.unsplash.com/photo-1584982751601-97dcc096659c?w=300&q=80',
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Container(
                color: primaryBlue.withValues(alpha: 0.3),
              ),
            ),
          ),
          Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [
                    navyDark,
                    navyDark.withValues(alpha: 0.85),
                    navyDark.withValues(alpha: 0.0),
                  ],
                  stops: const [0.0, 0.55, 1.0],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(18, 16, 18, 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Text(
                    'Pemeriksaan Rutin',
                    style: TextStyle(
                      fontSize: 10.5,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                const SizedBox(
                  width: 190,
                  child: Text(
                    'Early Screening,\nBetter Living',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                      height: 1.2,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                const SizedBox(
                  width: 175,
                  child: Text(
                    'Deteksi dini diabetes sekarang, hidup lebih sehat dan berkualitas.',
                    style: TextStyle(
                      fontSize: 11,
                      color: Color(0xFFCBD5E1),
                      height: 1.4,
                    ),
                  ),
                ),
                const SizedBox(height: 14),
                InkWell(
                  onTap: () {
                    // Arahkan ke halaman Screening Kesehatan Mandiri
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
                          'Mulai Pengecekan',
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
        ],
      ),
    );
  }

  /// Section "Risiko Diabetes Anda"
  Widget _buildRiskSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Risiko Diabetes Anda',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: navyDark,
          ),
        ),
        const SizedBox(height: 2),
        const Text(
          'Berdasarkan hasil screening terakhir',
          style: TextStyle(fontSize: 12, color: textGrey),
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: cardBorderColor),
          ),
          child: Row(
            children: [
              Container(
                width: 46,
                height: 46,
                decoration: const BoxDecoration(
                  color: lightGreenBg,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.favorite_rounded,
                  color: accentGreen,
                  size: 22,
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Text(
                          'Hasil Anda menunjukkan risiko ',
                          style: TextStyle(fontSize: 12.5, color: navyDark),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: lightGreenBg,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: const Text(
                            'Rendah',
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w700,
                              color: accentGreen,
                            ),
                          ),
                        ),
                        const SizedBox(width: 6),
                        const Expanded(
                          child: Text(
                            'diabetes rendah.',
                            style: TextStyle(
                              fontSize: 12.5,
                              color: navyDark,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'Tetap jaga pola hidup sehat!',
                      style: TextStyle(
                        fontSize: 11.5,
                        color: textGrey,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  /// Section "Berita"
  Widget _buildNewsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Berita',
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
          itemBuilder: (context, index) => _buildNewsCard(
            _homeNewsItems[index],
            index < _newsImageUrls.length ? _newsImageUrls[index] : null,
          ),
        ),
      ],
    );
  }

  Widget _buildNewsCard(Article item, String? imageUrl) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (_) => ArticleDetailScreen(article: item)),
        );
      },
      borderRadius: BorderRadius.circular(14),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: imageUrl != null
                ? Image.network(
                    imageUrl,
                    width: 78,
                    height: 78,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(
                      width: 78,
                      height: 78,
                      color: fieldFillColor,
                      child: const Icon(Icons.image_outlined, color: textGrey),
                    ),
                  )
                : Container(
                    width: 78,
                    height: 78,
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
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: lightGreenBg,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    item.tag,
                    style: const TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                      color: accentGreen,
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
    );
  }

  /// Bottom navigation bar dengan 5 menu
  Widget _buildBottomNav() {
    final items = [
      _NavItem(Icons.home_rounded, 'Beranda'),
      _NavItem(Icons.calendar_month_rounded, 'Book Health'),
      _NavItem(Icons.chat_bubble_rounded, 'Konsultasi'),
      _NavItem(Icons.monitor_heart_rounded, 'Screening'),
      _NavItem(Icons.home_repair_service_rounded, 'Home Care'),
    ];

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: navyDark.withValues(alpha: 0.06),
            blurRadius: 16,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: List.generate(items.length, (index) {
            final isCenter = index == 2;
            final isSelected = _selectedNavIndex == index;

            if (isCenter) {
              return GestureDetector(
                onTap: () {
                  setState(() => _selectedNavIndex = index);
                  // Index 2 = menu "Konsultasi" -> buka halaman KonsultasiDokterScreen (list dokter)
                  Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (_) => const KonsultasiDokterScreen()),
                  );
                },
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 46,
                      height: 46,
                      decoration: const BoxDecoration(
                        color: primaryBlue,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        items[index].icon,
                        color: Colors.white,
                        size: 22,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      items[index].label,
                      style: const TextStyle(
                        fontSize: 9.5,
                        color: primaryBlue,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              );
            }

            return InkWell(
              onTap: () {
                setState(() => _selectedNavIndex = index);
                // Index 1 = menu "Book Health" -> buka halaman HealthBookPage
                if (index == 1) {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => const HealthBookPage()),
                  );
                }
                // Index 3 = menu "Screening" -> buka halaman ScreeningKesehatanPage
                if (index == 3) {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (_) => const ScreeningKesehatanPage()),
                  );
                }
                // Index 4 = menu "Home Care" -> buka halaman HomeCareScreen
                if (index == 4) {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => const HomeCareScreen()),
                  );
                }
              },
              borderRadius: BorderRadius.circular(10),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 6),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      items[index].icon,
                      size: 22,
                      color: isSelected ? primaryBlue : textGrey,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      items[index].label,
                      style: TextStyle(
                        fontSize: 9.5,
                        color: isSelected ? primaryBlue : textGrey,
                        fontWeight:
                            isSelected ? FontWeight.w600 : FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}

class _NavItem {
  final IconData icon;
  final String label;

  const _NavItem(this.icon, this.label);
}