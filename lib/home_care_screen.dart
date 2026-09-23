import 'package:flutter/material.dart';
import 'home_page.dart';
import 'health_book_page.dart';
import 'konsultasi_dokter_screen.dart';
import 'screening_screen.dart';
import 'perawatan_luka_screen.dart';
import 'vitamin_booster_screen.dart';
import 'kunjungan_dokter_screen.dart';

// Letakkan di: lib/home_care_screen.dart
// (langsung di lib/, BUKAN di lib/screens/)

const Color _primaryBlue = Color(0xFF1E6FE0);
const Color _navyDark = Color(0xFF1B2A4A);
const Color _textGrey = Color(0xFF7A8B9E);
const Color _cardBorderColor = Color(0xFFE2E8F0);
const Color _fieldFillColor = Color(0xFFF1F5F9);

class _HomeCareOption {
  final IconData icon;
  final Color iconBg;
  final String title;
  final String subtitle;
  final WidgetBuilder? builder;

  const _HomeCareOption({
    required this.icon,
    required this.iconBg,
    required this.title,
    required this.subtitle,
    this.builder,
  });
}

/// Halaman menu pilihan layanan Home Care (dibuka dari bottom nav "Home Care")
class HomeCareScreen extends StatefulWidget {
  const HomeCareScreen({super.key});

  @override
  State<HomeCareScreen> createState() => _HomeCareScreenState();
}

class _HomeCareScreenState extends State<HomeCareScreen> {
  static final List<_HomeCareOption> _options = [
    _HomeCareOption(
      icon: Icons.healing,
      iconBg: _primaryBlue,
      title: 'Perawatan Luka',
      subtitle: 'Perawatan luka diabetes oleh tenaga kesehatan profesional',
      builder: (_) => const PerawatanLukaScreen(),
    ),
    _HomeCareOption(
      icon: Icons.person_outline_rounded,
      iconBg: const Color(0xFF22A45D),
      title: 'Kunjungan Dokter',
      subtitle: 'Konsultasi dan pemeriksaan di rumah',
      builder: (_) => const KunjunganDokterScreen(),
    ),
    _HomeCareOption(
      icon: Icons.medication_liquid,
      iconBg: const Color(0xFF9B51E0),
      title: 'Vitamin Booster',
      subtitle: 'Nutrisi tambahan untuk menjaga daya tahan tubuh',
      builder: (_) => const VitaminBoosterScreen(),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildHeader(context),
              const SizedBox(height: 16),
              _buildSearchBar(),
              const SizedBox(height: 20),
              const Text(
                'Pilih Layanan',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: _navyDark,
                ),
              ),
              const SizedBox(height: 10),
              ..._options.map(
                (opt) => Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: _buildOptionCard(context, opt),
                ),
              ),
              const SizedBox(height: 8),
              _buildInfoBanner(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: _buildBottomNav(context),
    );
  }

  // -------------------------------------------------------------------------
  // HEADER
  // -------------------------------------------------------------------------

  Widget _buildHeader(BuildContext context) {
    return Row(
      children: [
        InkWell(
          onTap: () => Navigator.maybePop(context),
          borderRadius: BorderRadius.circular(20),
          child: const Padding(
            padding: EdgeInsets.all(4),
            child: Icon(Icons.arrow_back, color: _navyDark, size: 22),
          ),
        ),
        const SizedBox(width: 8),
        const Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Home Care',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: _navyDark,
                ),
              ),
              SizedBox(height: 2),
              Text(
                'Perawatan Kesehatan di Rumah',
                style: TextStyle(fontSize: 12, color: _textGrey),
              ),
            ],
          ),
        ),
        Container(
          width: 38,
          height: 38,
          decoration: const BoxDecoration(
            color: Color(0xFFE2F0FD),
            shape: BoxShape.circle,
          ),
          child: const Icon(Icons.home_rounded, color: _primaryBlue, size: 18),
        ),
      ],
    );
  }

  // -------------------------------------------------------------------------
  // SEARCH BAR
  // -------------------------------------------------------------------------

  Widget _buildSearchBar() {
    return Container(
      height: 46,
      decoration: BoxDecoration(
        color: _fieldFillColor,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: _cardBorderColor),
      ),
      child: const Row(
        children: [
          SizedBox(width: 14),
          Icon(Icons.search_rounded, size: 20, color: _textGrey),
          SizedBox(width: 10),
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Cari layanan home care...',
                hintStyle: TextStyle(fontSize: 13, color: _textGrey),
              ),
              style: TextStyle(fontSize: 13, color: _navyDark),
            ),
          ),
          SizedBox(width: 14),
        ],
      ),
    );
  }

  // -------------------------------------------------------------------------
  // KARTU LAYANAN
  // -------------------------------------------------------------------------

  Widget _buildOptionCard(BuildContext context, _HomeCareOption opt) {
    return InkWell(
      onTap: () {
        if (opt.builder == null) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Fitur ini segera hadir'),
              behavior: SnackBarBehavior.floating,
            ),
          );
          return;
        }
        Navigator.of(context).push(MaterialPageRoute(builder: opt.builder!));
      },
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: _cardBorderColor),
          boxShadow: [
            BoxShadow(
              color: _navyDark.withOpacity(0.04),
              blurRadius: 10,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 46,
              height: 46,
              decoration: BoxDecoration(
                color: opt.iconBg,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Icon(opt.icon, color: Colors.white, size: 22),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    opt.title,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: _navyDark,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    opt.subtitle,
                    style: const TextStyle(fontSize: 11.5, color: _textGrey, height: 1.3),
                  ),
                ],
              ),
            ),
            const Icon(Icons.chevron_right_rounded, color: _textGrey),
          ],
        ),
      ),
    );
  }

  // -------------------------------------------------------------------------
  // BANNER INFO BAWAH
  // -------------------------------------------------------------------------

  Widget _buildInfoBanner() {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: const Color(0xFFE2F0FD),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        children: [
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Lebih mudah\njaga kesehatan\ndi rumah',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: _navyDark,
                    height: 1.3,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Layanan home care, untuk kualitas hidup yang lebih baik.',
                  style: TextStyle(fontSize: 11, color: _textGrey, height: 1.4),
                ),
              ],
            ),
          ),
          Stack(
            alignment: Alignment.center,
            children: [
              Icon(Icons.home_rounded, size: 56, color: _primaryBlue.withOpacity(0.25)),
              const Icon(Icons.favorite_rounded, color: Color(0xFF22A45D), size: 22),
            ],
          ),
        ],
      ),
    );
  }

  // -------------------------------------------------------------------------
  // BOTTOM NAVIGATION BAR (konsisten dengan HomePage)
  // -------------------------------------------------------------------------

  Widget _buildBottomNav(BuildContext context) {
    final items = [
      {'icon': Icons.home_rounded, 'label': 'Beranda'},
      {'icon': Icons.calendar_month_rounded, 'label': 'Book Health'},
      {'icon': Icons.chat_bubble_rounded, 'label': 'Konsultasi'},
      {'icon': Icons.monitor_heart_rounded, 'label': 'Screening'},
      {'icon': Icons.home_repair_service_rounded, 'label': 'Home Care'},
    ];

    void goTo(Widget page) {
      Navigator.of(context).push(MaterialPageRoute(builder: (_) => page));
    }

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: _navyDark.withOpacity(0.06),
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
            final isSelected = index == 4; // Home Care aktif di halaman ini
            final isCenter = index == 2;

            if (isCenter) {
              return GestureDetector(
                onTap: () => goTo(const KonsultasiDokterScreen()),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 46,
                      height: 46,
                      decoration: const BoxDecoration(
                        color: _primaryBlue,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        items[index]['icon'] as IconData,
                        color: Colors.white,
                        size: 22,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      items[index]['label'] as String,
                      style: const TextStyle(
                        fontSize: 9.5,
                        color: _primaryBlue,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              );
            }

            return InkWell(
              onTap: () {
                if (index == 0) {
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (_) => const HomePage()),
                    (route) => false,
                  );
                } else if (index == 1) {
                  goTo(const HealthBookPage());
                } else if (index == 3) {
                  goTo(const ScreeningKesehatanPage());
                }
                // index 4 (Home Care) -> sudah di halaman ini, tidak perlu aksi
              },
              borderRadius: BorderRadius.circular(10),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 6),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      items[index]['icon'] as IconData,
                      size: 22,
                      color: isSelected ? _primaryBlue : _textGrey,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      items[index]['label'] as String,
                      style: TextStyle(
                        fontSize: 9.5,
                        color: isSelected ? _primaryBlue : _textGrey,
                        fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
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