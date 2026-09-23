import 'package:flutter/material.dart';

class PolaMakanSehatScreen extends StatelessWidget {
  const PolaMakanSehatScreen({super.key});

  static const Color kBlue = Color(0xFF2E9AFF);
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
          'Pola Makan Sehat',
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
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: kCardBg,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 56,
                        height: 56,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                        ),
                        padding: const EdgeInsets.all(6),
                        child: ClipOval(
                          child: CustomPaint(
                            painter: _PiringSehatPainter(),
                          ),
                        ),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Piring Sehat\nDiabetes Melitus',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                                height: 1.3,
                                color: Colors.black87,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              'Seimbangkan nutrisi untuk hidup lebih '
                              'sehat dan terkontrol.',
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
                  const SizedBox(height: 16),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      _KategoriMini(
                        icon: Icons.eco,
                        color: Colors.green,
                        label: 'Sayur & Buah',
                      ),
                      _KategoriMini(
                        icon: Icons.rice_bowl,
                        color: Colors.orange,
                        label: 'Karbohidrat\nKompleks',
                      ),
                      _KategoriMini(
                        icon: Icons.egg_alt,
                        color: kBlue,
                        label: 'Protein',
                      ),
                      _KategoriMini(
                        icon: Icons.local_drink,
                        color: kBlue,
                        label: 'Minum Air',
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 18),

            PolaMakanTile(
              porsi: '1/4',
              porsiColor: Colors.green,
              icon: Icons.eco,
              iconBg: const Color(0xFFE8F5E9),
              judul: 'Sayur dan Buah',
              deskripsi:
                  'Perbanyak sayur dan buah dengan berbagai warna.',
              onTap: () {},
            ),
            const SizedBox(height: 12),
            PolaMakanTile(
              porsi: '1/2',
              porsiColor: Colors.orange,
              icon: Icons.rice_bowl,
              iconBg: const Color(0xFFFFF8E1),
              judul: 'Karbohidrat',
              deskripsi:
                  'Pilih karbohidrat kompleks seperti nasi merah, '
                  'kentang, ubi, oatmeal.',
              onTap: () {},
            ),
            const SizedBox(height: 12),
            PolaMakanTile(
              porsi: '1/4',
              porsiColor: kBlue,
              icon: Icons.egg_alt,
              iconBg: const Color(0xFFFFF3E0),
              judul: 'Protein',
              deskripsi:
                  'Pilih protein tanpa lemak seperti ikan, ayam '
                  'tanpa kulit, tahu, dan tempe.',
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}

class _KategoriMini extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String label;

  const _KategoriMini({
    required this.icon,
    required this.color,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: color.withOpacity(0.12),
          ),
          alignment: Alignment.center,
          child: Icon(icon, color: color, size: 18),
        ),
        const SizedBox(height: 6),
        Text(
          label,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 10.5,
            color: Colors.grey.shade700,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}

class PolaMakanTile extends StatelessWidget {
  final String porsi;
  final Color porsiColor;
  final IconData icon;
  final Color iconBg;
  final String judul;
  final String deskripsi;
  final VoidCallback? onTap;

  const PolaMakanTile({
    super.key,
    required this.porsi,
    required this.porsiColor,
    required this.icon,
    required this.iconBg,
    required this.judul,
    required this.deskripsi,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: PolaMakanSehatScreen.kCardBg,
          borderRadius: BorderRadius.circular(14),
        ),
        child: Row(
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: iconBg,
                  ),
                  alignment: Alignment.center,
                  child: Icon(icon, color: porsiColor, size: 22),
                ),
                Positioned(
                  top: -6,
                  left: -6,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 5, vertical: 1),
                    decoration: BoxDecoration(
                      color: porsiColor.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      porsi,
                      style: TextStyle(
                        fontSize: 9,
                        fontWeight: FontWeight.bold,
                        color: porsiColor,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(width: 14),
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
                      fontSize: 11.5,
                      height: 1.4,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            Icon(Icons.chevron_right, color: Colors.grey.shade400),
          ],
        ),
      ),
    );
  }
}

class _PiringSehatPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;
    final rect = Rect.fromCircle(center: center, radius: radius);

    final paintGreen = Paint()..color = const Color(0xFF66BB6A);
    final paintOrange = Paint()..color = const Color(0xFFFFA726);
    final paintYellow = Paint()..color = const Color(0xFFFFD54F);

    canvas.drawArc(rect, -3.14159, 3.14159, true, paintGreen);
    canvas.drawArc(rect, 0, 1.5708, true, paintOrange);
    canvas.drawArc(rect, 1.5708, 1.5708, true, paintYellow);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}