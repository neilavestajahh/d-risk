import 'package:flutter/material.dart';

class CaraPencegahanScreen extends StatelessWidget {
  const CaraPencegahanScreen({super.key});

  static const Color kBlue = Color(0xFF2E9AFF);
  static const Color kBlueSoft = Color(0xFFEAF5FF);

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
          'Cara Pencegahan',
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
            const Text(
              'Upaya Cegah Diabetes dari Mulai',
              style: TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              'Langkah kecil hari ini, sehat di masa depan!',
              style: TextStyle(
                fontSize: 13,
                color: Colors.grey.shade600,
              ),
            ),
            const SizedBox(height: 16),

            Center(
              child: SizedBox(
                width: 240,
                height: 180,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      width: 170,
                      height: 170,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: kBlueSoft,
                      ),
                    ),
                    Icon(
                      Icons.emoji_people,
                      size: 110,
                      color: Colors.blueGrey.shade200,
                    ),
                    const Positioned(
                      top: 0,
                      left: 10,
                      child: _MiniIconBubble(
                        icon: Icons.eco,
                        color: Colors.green,
                      ),
                    ),
                    const Positioned(
                      top: 0,
                      right: 10,
                      child: _MiniIconBubble(
                        icon: Icons.smoke_free,
                        color: Colors.red,
                      ),
                    ),
                    const Positioned(
                      bottom: 10,
                      left: 20,
                      child: _MiniIconBubble(
                        icon: Icons.local_drink,
                        color: kBlue,
                      ),
                    ),
                    const Positioned(
                      bottom: 10,
                      right: 20,
                      child: _MiniIconBubble(
                        icon: Icons.place,
                        color: kBlue,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            const PencegahanTile(
              icon: Icons.restaurant_menu,
              iconColor: Color(0xFF8E24AA),
              judul: 'Konsumsi Makanan Sehat',
              deskripsi:
                  'Perbanyak sayur, buah, biji-bijian, dan kurangi '
                  'gula, garam, serta lemak jenuh.',
            ),
            const SizedBox(height: 12),
            const PencegahanTile(
              icon: Icons.directions_run,
              iconColor: Color(0xFF1E88E5),
              judul: 'Tingkatkan aktivitas fisik',
              deskripsi:
                  'Olahraga rutin minimal 30 menit per hari, 5 kali '
                  'seminggu.',
            ),
            const SizedBox(height: 12),
            const PencegahanTile(
              icon: Icons.self_improvement,
              iconColor: Color(0xFF43A047),
              judul: 'Hindari Stres',
              deskripsi:
                  'Kelola stres dengan baik melalui relaksasi, hobi, '
                  'atau meditasi.',
            ),
            const SizedBox(height: 12),
            const PencegahanTile(
              icon: Icons.directions_walk,
              iconColor: Color(0xFFFB8C00),
              judul: 'Banyak Bergerak',
              deskripsi:
                  'Kurangi waktu duduk terlalu lama dan biasakan '
                  'bergerak setiap hari.',
            ),
            const SizedBox(height: 12),
            const PencegahanTile(
              icon: Icons.no_drinks,
              iconColor: Color(0xFFE53935),
              judul: 'Baca Alkohol & Hindari Rokok',
              deskripsi:
                  'Rokok dan alkohol dapat meningkatkan risiko '
                  'diabetes dan komplikasi.',
            ),
          ],
        ),
      ),
    );
  }
}

class _MiniIconBubble extends StatelessWidget {
  final IconData icon;
  final Color color;

  const _MiniIconBubble({required this.icon, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 34,
      height: 34,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      alignment: Alignment.center,
      child: Icon(icon, color: color, size: 18),
    );
  }
}

class PencegahanTile extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String judul;
  final String deskripsi;

  const PencegahanTile({
    super.key,
    required this.icon,
    required this.iconColor,
    required this.judul,
    required this.deskripsi,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFFF7F9FC),
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
              color: iconColor,
            ),
            alignment: Alignment.center,
            child: Icon(icon, color: Colors.white, size: 20),
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
                    fontSize: 13.5,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  deskripsi,
                  style: TextStyle(
                    fontSize: 12,
                    height: 1.4,
                    color: Colors.grey.shade600,
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