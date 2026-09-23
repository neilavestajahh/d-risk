import 'package:flutter/material.dart';

// ============================================================
// FILE: olahraga_screen.dart
// Letakkan di: lib/screens/olahraga_screen.dart
// ============================================================

class OlahragaScreen extends StatelessWidget {
  const OlahragaScreen({super.key});

  static const Color kBlue = Color(0xFF2E9AFF);
  static const Color kBlueDark = Color(0xFF1E6FD9);
  static const Color kCardBg = Color(0xFFF7F9FC);
  static const Color kYellowSoft = Color(0xFFFFF8E1);
  static const Color kGreenSoft = Color(0xFFE8F5E9);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: false,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new,
              color: Colors.black87, size: 18),
          onPressed: () => Navigator.maybePop(context),
        ),
        title: const Text(
          'Olahraga',
          style: TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.bold,
            fontSize: 17,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Aktivitas fisik untuk diabetesi',
              style: TextStyle(fontSize: 12.5, color: Colors.grey.shade600),
            ),
            const SizedBox(height: 12),

            // ---------------- BADGE "Panduan Medis" ----------------
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                color: kBlueSoftDecor,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Icon(Icons.verified, size: 13, color: kBlue),
                  SizedBox(width: 5),
                  Text(
                    'Panduan Medis',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: kBlue,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),

            // ---------------- HERO CARD GRADIENT ----------------
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18),
                gradient: const LinearGradient(
                  colors: [kBlue, kBlueDark],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Aktif Bergerak,\nDarah Terkendali',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                height: 1.3,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Latihan sensitif teratur meningkatkan '
                              'sensitivitas insulin dan menjaga '
                              'kadar gula tetap stabil.',
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.9),
                                fontSize: 12,
                                height: 1.4,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 10),
                      Container(
                        width: 56,
                        height: 56,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white.withOpacity(0.2),
                        ),
                        alignment: Alignment.center,
                        child: const Icon(Icons.directions_run,
                            color: Colors.white, size: 28),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: _StatBox(
                          icon: Icons.timer_outlined,
                          value: '150 Menit/Mgg',
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: _StatBox(
                          icon: Icons.calendar_today_outlined,
                          value: '5x/Minggu',
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // ---------------- WARNING BOX KUNING ----------------
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: kYellowSoft,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: const Color(0xFFFFE0A3)),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(Icons.warning_amber_rounded,
                      color: Color(0xFFF9A825), size: 20),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Aturan Wajib Sebelum Mulai',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Tunda olahraga jika gula darah < 100 mg/dL '
                          '(risiko hipoglikemia) atau > 250 mg/dL '
                          '(risiko ketosis), dan tunda dahulu.',
                          style: TextStyle(
                            fontSize: 11.5,
                            height: 1.4,
                            color: Colors.grey.shade700,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // ---------------- HEADER "Rekomendasi Latihan Fisik" ----------------
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Rekomendasi Latihan Fisik',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    color: Colors.black87,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(
                    color: kGreenSoft,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Text(
                    '5 Olahraga Aman',
                    style: TextStyle(
                      fontSize: 10.5,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF2E7D32),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),

            // ---------------- LIST LATIHAN ----------------
            const LatihanTile(
              icon: Icons.directions_walk,
              iconColor: Color(0xFF43A047),
              judul: 'Jalan Kaki Cepat (Brisk Walk)',
              deskripsi: '30 menit/hari • aman untuk semua kondisi',
              badgeText: 'Rekomendasi Utama',
              badgeColor: Color(0xFF43A047),
            ),
            const SizedBox(height: 10),
            const LatihanTile(
              icon: Icons.self_improvement,
              iconColor: Color(0xFF1E88E5),
              judul: 'Senam Diabetes & Aerobik Ringan',
              deskripsi: '20 menit/hari • sirkulasi pembuluh darah baik',
              badgeText: 'Terbukti Efektif',
              badgeColor: Color(0xFF1E88E5),
            ),
            const SizedBox(height: 10),
            const LatihanTile(
              icon: Icons.pedal_bike,
              iconColor: Color(0xFFFB8C00),
              judul: 'Bersepeda Statis / Santai',
              deskripsi: '20 menit/hari • ringan sendi minim tekanan',
              badgeText: 'Rendah Benturan',
              badgeColor: Color(0xFFFB8C00),
            ),
            const SizedBox(height: 10),
            const LatihanTile(
              icon: Icons.pool,
              iconColor: Color(0xFF00ACC1),
              judul: 'Berenang Ringan',
              deskripsi: 'Latihan seluruh tubuh, rendah risiko',
              badgeText: 'Rendah Risiko',
              badgeColor: Color(0xFF00ACC1),
            ),
            const SizedBox(height: 10),
            const LatihanTile(
              icon: Icons.fitness_center,
              iconColor: Color(0xFF8E24AA),
              judul: 'Latihan Kekuatan Otot',
              deskripsi:
                  'Resistance band 2-3x/mgg, massa otot tetap terjaga',
              badgeText: 'Massa Otot & Bakar',
              badgeColor: Color(0xFF8E24AA),
            ),
            const SizedBox(height: 20),

            // ---------------- CHECKLIST PERLENGKAPAN WAJIB ----------------
            Row(
              children: const [
                Icon(Icons.checklist_rtl, size: 18, color: kBlue),
                SizedBox(width: 6),
                Text(
                  'Checklist Perlengkapan Wajib',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            const ChecklistItem(
              text: 'Bawa sumber glukosa cepat (3 butir permen / jus '
                  'buah) untuk antisipasi hipoglikemia tiba-tiba.',
            ),
            const SizedBox(height: 8),
            const ChecklistItem(
              text: 'Gunakan kaos kaki katun dan sepatu nyaman yang '
                  'melindungi kaki penuh.',
            ),
            const SizedBox(height: 8),
            const ChecklistItem(
              text: 'Cukupi hidrasi 250 ml air sebelum dan sesudah 20 '
                  'menit setelah berolahraga.',
            ),
          ],
        ),
      ),

      // ---------------- BOTTOM NAVIGATION ----------------
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: kBlue,
        unselectedItemColor: Colors.grey,
        currentIndex: 1,
        showUnselectedLabels: true,
        selectedFontSize: 11,
        unselectedFontSize: 11,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: 'Beranda',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_border),
            label: 'Book Health',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat_bubble_outline),
            label: 'Konsultasi',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.biotech_outlined),
            label: 'Screening',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home_repair_service_outlined),
            label: 'Home Care',
          ),
        ],
      ),
    );
  }
}

const Color kBlueSoftDecor = Color(0xFFEAF5FF);

// ============================================================
// WIDGET: Kotak statistik kecil di hero card (menit/minggu, dst)
// ============================================================
class _StatBox extends StatelessWidget {
  final IconData icon;
  final String value;

  const _StatBox({required this.icon, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.15),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: Colors.white, size: 16),
          const SizedBox(width: 6),
          Flexible(
            child: Text(
              value,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: 12,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================
// WIDGET: Tile rekomendasi latihan fisik (reusable)
// ============================================================
class LatihanTile extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String judul;
  final String deskripsi;
  final String badgeText;
  final Color badgeColor;

  const LatihanTile({
    super.key,
    required this.icon,
    required this.iconColor,
    required this.judul,
    required this.deskripsi,
    required this.badgeText,
    required this.badgeColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: OlahragaScreen.kCardBg,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: iconColor.withOpacity(0.12),
            ),
            alignment: Alignment.center,
            child: Icon(icon, color: iconColor, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  judul,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  deskripsi,
                  style: TextStyle(
                    fontSize: 11.5,
                    color: Colors.grey.shade600,
                  ),
                ),
                const SizedBox(height: 6),
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(
                    color: badgeColor.withOpacity(0.12),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    badgeText,
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                      color: badgeColor,
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
}

// ============================================================
// WIDGET: Item checklist perlengkapan
// ============================================================
class ChecklistItem extends StatelessWidget {
  final String text;

  const ChecklistItem({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Icon(Icons.check_circle,
            color: OlahragaScreen.kBlue, size: 16),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 12.5,
              height: 1.4,
              color: Colors.grey.shade700,
            ),
          ),
        ),
      ],
    );
  }
}