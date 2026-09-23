import 'package:flutter/material.dart';

class FaktorRisikoScreen extends StatelessWidget {
  const FaktorRisikoScreen({super.key});

  static const Color kBlue = Color(0xFF2E9AFF);
  static const Color kBlueSoft = Color(0xFFEAF5FF);
  static const Color kCardBg = Color(0xFFF7F9FC);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new,
              color: Colors.black87, size: 18),
          onPressed: () => Navigator.maybePop(context),
        ),
        title: const Text(
          'Faktor Risiko',
          style: TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.bold,
            fontSize: 17,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Beberapa faktor yang dapat meningkatkan risiko '
              'terjadinya diabetes:',
              style: TextStyle(
                fontSize: 14,
                height: 1.5,
                color: Colors.grey.shade700,
              ),
            ),
            const SizedBox(height: 16),

            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              mainAxisSpacing: 14,
              crossAxisSpacing: 14,
              childAspectRatio: 0.85,
              children: const [
                FaktorRisikoCard(
                  icon: Icons.groups_outlined,
                  judul: 'Riwayat Keluarga',
                  deskripsi:
                      'Memiliki keluarga dengan riwayat diabetes.',
                ),
                FaktorRisikoCard(
                  icon: Icons.monitor_weight_outlined,
                  judul: 'Berat badan berlebih',
                  deskripsi:
                      'Kelebihan berat badan dapat meningkatkan risiko.',
                ),
                FaktorRisikoCard(
                  icon: Icons.chair_outlined,
                  judul: 'Kurang aktivitas fisik',
                  deskripsi:
                      'Gaya hidup sedentary dapat meningkatkan risiko.',
                ),
                FaktorRisikoCard(
                  icon: Icons.fastfood_outlined,
                  judul: 'Pola makan tidak sehat',
                  deskripsi:
                      'Terlalu banyak makanan tinggi gula, lemak, '
                      'dan kalori.',
                ),
              ],
            ),
            const SizedBox(height: 16),

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: kBlueSoft,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(Icons.check_circle,
                      color: kBlue, size: 18),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      'Risiko dapat dikurangi dengan gaya hidup sehat '
                      'dan rutin pemeriksaan.',
                      style: TextStyle(
                        fontSize: 13,
                        height: 1.4,
                        color: Colors.grey.shade800,
                      ),
                    ),
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

class FaktorRisikoCard extends StatelessWidget {
  final IconData icon;
  final String judul;
  final String deskripsi;

  const FaktorRisikoCard({
    super.key,
    required this.icon,
    required this.judul,
    required this.deskripsi,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: FaktorRisikoScreen.kCardBg,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: FaktorRisikoScreen.kBlue,
            ),
            alignment: Alignment.center,
            child: Icon(icon, color: Colors.white, size: 20),
          ),
          const SizedBox(height: 10),
          Text(
            judul,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 13,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 6),
          Expanded(
            child: Text(
              deskripsi,
              style: TextStyle(
                fontSize: 11.5,
                height: 1.4,
                color: Colors.grey.shade600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}