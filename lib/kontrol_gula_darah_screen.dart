import 'package:flutter/material.dart';

// ---------------------------------------------------------------------------
// MODEL DATA
// ---------------------------------------------------------------------------

class HabitItem {
  final int number;
  final String title;
  final String description;

  const HabitItem({
    required this.number,
    required this.title,
    required this.description,
  });
}

class TargetRow {
  final String title;
  final String subtitle;
  final String value;

  const TargetRow({
    required this.title,
    required this.subtitle,
    required this.value,
  });
}

// ---------------------------------------------------------------------------
// HALAMAN KONTROL GULA DARAH
// ---------------------------------------------------------------------------

class KontrolGulaDarahScreen extends StatefulWidget {
  const KontrolGulaDarahScreen({super.key});

  @override
  State<KontrolGulaDarahScreen> createState() => _KontrolGulaDarahScreenState();
}

class _KontrolGulaDarahScreenState extends State<KontrolGulaDarahScreen> {
  int _bottomNavIndex = 1; // "Book Health" aktif

  final List<HabitItem> _habits = const [
    HabitItem(
      number: 1,
      title: 'Minum air putih yang cukup',
      description:
          'Minimal 8 gelas sehari untuk membantu metabolisme dan menjaga kadar gula darah.',
    ),
    HabitItem(
      number: 2,
      title: 'Jaga waktu tidur',
      description: 'Tidur 7-8 jam per hari untuk menjaga keseimbangan hormon.',
    ),
    HabitItem(
      number: 3,
      title: 'Pantau kadar gula darah',
      description:
          'Lakukan pemeriksaan secara berkala sesuai anjuran tenaga kesehatan.',
    ),
    HabitItem(
      number: 4,
      title: 'Mengelola stres',
      description: 'Lakukan relaksasi, meditasi, atau aktivitas positif lainnya.',
    ),
    HabitItem(
      number: 5,
      title: 'Hindari makanan tinggi gula, lemak, dan kalori',
      description: 'Pilih makanan sehat dan seimbang.',
    ),
  ];

  final List<TargetRow> _targets = const [
    TargetRow(
      title: 'Gula Darah Puasa',
      subtitle: 'Sebelum makan pagi / puasa 8 jam',
      value: '<100 mg/dL',
    ),
    TargetRow(
      title: '2 Jam Setelah Makan',
      subtitle: 'Pasca konsumsi makanan utama',
      value: '<140 mg/dL',
    ),
  ];

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
              _buildIntroCard(),
              const SizedBox(height: 16),
              _buildHabitsCard(),
              const SizedBox(height: 16),
              _buildTargetCard(),
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
      backgroundColor: const Color(0xFFF5F7FA),
      elevation: 0,
      surfaceTintColor: const Color(0xFFF5F7FA),
      titleSpacing: 0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Color(0xFF2F80ED), size: 22),
        onPressed: () => Navigator.maybePop(context),
      ),
      title: const Text(
        'Kontrol Gula Darah',
        style: TextStyle(
          color: Colors.black87,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  // -------------------------------------------------------------------------
  // KARTU PENGANTAR (ILUSTRASI + JUDUL)
  // -------------------------------------------------------------------------

  Widget _buildIntroCard() {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFFDDEBFB),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 52,
            height: 52,
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                const Text(
                  '98',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2F80ED),
                  ),
                ),
                Positioned(
                  bottom: 2,
                  right: 2,
                  child: Container(
                    padding: const EdgeInsets.all(2),
                    decoration: const BoxDecoration(
                      color: Color(0xFFEB5757),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.favorite, color: Colors.white, size: 9),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 14),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Pantau gula darah secara teratur',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'Pemeriksaan rutin membantu mengetahui kondisi dan mencegah komplikasi.',
                  style: TextStyle(fontSize: 12, color: Colors.black54, height: 1.4),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // -------------------------------------------------------------------------
  // KARTU GAYA HIDUP DAN KEBIASAAN
  // -------------------------------------------------------------------------

  Widget _buildHabitsCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: const [
              Icon(Icons.shield_outlined, color: Color(0xFF2F80ED), size: 20),
              SizedBox(width: 8),
              Text(
                'Gaya Hidup dan Kebiasaan',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          ..._habits.map(
            (h) => Padding(
              padding: const EdgeInsets.only(bottom: 14),
              child: _buildHabitRow(h),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHabitRow(HabitItem habit) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 22,
          height: 22,
          decoration: const BoxDecoration(
            color: Color(0xFFE8F1FD),
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Text(
              '${habit.number}',
              style: const TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.bold,
                color: Color(0xFF2F80ED),
              ),
            ),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                habit.title,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 3),
              Text(
                habit.description,
                style: const TextStyle(fontSize: 12, color: Colors.black54, height: 1.4),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // -------------------------------------------------------------------------
  // KARTU TARGET KADAR GULA DARAH NORMAL
  // -------------------------------------------------------------------------

  Widget _buildTargetCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: const [
              Icon(Icons.bar_chart, color: Color(0xFF2F80ED), size: 20),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Target Kadar Gula Darah Normal',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 2),
          const Text(
            'Panduan rentang kadar gula darah sehat',
            style: TextStyle(fontSize: 12, color: Colors.black54),
          ),
          const SizedBox(height: 14),
          ..._targets.map(
            (t) => Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: _buildTargetRow(t),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTargetRow(TargetRow target) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: const Color(0xFFF5F7FA),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  target.title,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  target.subtitle,
                  style: const TextStyle(fontSize: 11, color: Colors.black45),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: const Color(0xFFE7F6EC),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              target.value,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: Color(0xFF27AE60),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // -------------------------------------------------------------------------
  // BOTTOM NAVIGATION BAR
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
              final color = selected ? const Color(0xFF2F80ED) : Colors.grey;
              return Expanded(
                child: InkWell(
                  onTap: () => setState(() => _bottomNavIndex = index),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (selected)
                        Container(
                          padding: const EdgeInsets.all(6),
                          decoration: const BoxDecoration(
                            color: Color(0xFF2F80ED),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(items[index]['icon'] as IconData,
                              color: Colors.white, size: 18),
                        )
                      else
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