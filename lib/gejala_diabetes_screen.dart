import 'package:flutter/material.dart';

// ---------------------------------------------------------------------------
// COLORS
// ---------------------------------------------------------------------------
class AppColors {
  static const blue = Color(0xFF2F6BFF);
  static const blueLight = Color(0xFFEAF0FF);
  static const ink = Color(0xFF101828);
  static const sub = Color(0xFF667085);
  static const line = Color(0xFFEEF0F4);
  static const bg = Color(0xFFF7F8FA);
  static const red = Color(0xFFE85D5D);
  static const redLight = Color(0xFFFDECEC);
}

// ---------------------------------------------------------------------------
// MODEL + DATA
// ---------------------------------------------------------------------------
class SymptomItem {
  final int number;
  final IconData icon;
  final Color iconColor;
  final Color iconBg;
  final String title;
  final String description;

  const SymptomItem({
    required this.number,
    required this.icon,
    required this.iconColor,
    required this.iconBg,
    required this.title,
    required this.description,
  });
}

final List<SymptomItem> symptoms = [
  SymptomItem(
    number: 1,
    icon: Icons.water_drop_rounded,
    iconColor: AppColors.blue,
    iconBg: AppColors.blueLight,
    title: "Sering Haus",
    description: "Merasa haus yang tidak wajar dan terus-menerus.",
  ),
  SymptomItem(
    number: 2,
    icon: Icons.wc_rounded,
    iconColor: AppColors.blue,
    iconBg: AppColors.blueLight,
    title: "Sering buang air kecil",
    description: "Frekuensi buang air kecil meningkat, terutama di malam hari.",
  ),
  SymptomItem(
    number: 3,
    icon: Icons.battery_1_bar_rounded,
    iconColor: AppColors.red,
    iconBg: AppColors.redLight,
    title: "Mudah Lelah",
    description: "Tubuh terasa lemas dan kurang bertenaga.",
  ),
  SymptomItem(
    number: 4,
    icon: Icons.remove_red_eye_rounded,
    iconColor: AppColors.blue,
    iconBg: AppColors.blueLight,
    title: "Penglihatan kabur",
    description: "Penglihatan mulai tidak jelas atau sering berubah.",
  ),
];

// ---------------------------------------------------------------------------
// SCREEN: GEJALA DIABETES
// ---------------------------------------------------------------------------
class GejalaDiabetesScreen extends StatelessWidget {
  const GejalaDiabetesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 8, 8, 6),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back_ios_new, size: 18, color: AppColors.ink),
                      onPressed: () => Navigator.of(context).maybePop(),
                    ),
                  ),
                  const Text(
                    "Gejala Diabetes",
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: AppColors.ink),
                  ),
                ],
              ),
            ),

            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(20, 4, 20, 12),
                children: [
                  const Text(
                    "Perhatikan beberapa tanda yang mungkin muncul pada tubuh, antara lain:",
                    style: TextStyle(fontSize: 13, color: AppColors.sub, height: 1.5),
                  ),
                  const SizedBox(height: 16),

                  ...symptoms.map(
                    (s) => Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: SymptomCard(item: s),
                    ),
                  ),

                  const SizedBox(height: 4),
                  const InfoBanner(
                    text:
                        "Mengenali beberapa gejala bukan berarti kamu sudah diabetes, namun ini adalah tanda untuk memeriksakan lebih lanjut.",
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// WIDGET: KARTU GEJALA
// ---------------------------------------------------------------------------
class SymptomCard extends StatelessWidget {
  final SymptomItem item;

  const SymptomCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.line),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Nomor urut
          Container(
            width: 22,
            height: 22,
            alignment: Alignment.center,
            decoration: const BoxDecoration(color: AppColors.bg, shape: BoxShape.circle),
            child: Text(
              "${item.number}",
              style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: AppColors.sub),
            ),
          ),
          const SizedBox(width: 12),
          // Ikon
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(color: item.iconBg, borderRadius: BorderRadius.circular(12)),
            child: Icon(item.icon, color: item.iconColor, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.title,
                  style: const TextStyle(fontSize: 14.5, fontWeight: FontWeight.bold, color: AppColors.ink),
                ),
                const SizedBox(height: 3),
                Text(
                  item.description,
                  style: const TextStyle(fontSize: 12.5, color: AppColors.sub, height: 1.4),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// WIDGET: BANNER INFORMASI
// ---------------------------------------------------------------------------
class InfoBanner extends StatelessWidget {
  final String text;

  const InfoBanner({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.blueLight,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.info_rounded, color: AppColors.blue, size: 18),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(fontSize: 12.5, color: AppColors.ink, height: 1.5),
            ),
          ),
        ],
      ),
    );
  }
}