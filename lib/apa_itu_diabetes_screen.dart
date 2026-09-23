import 'package:flutter/material.dart';

class ApaItuDiabetesScreen extends StatelessWidget {
  const ApaItuDiabetesScreen({super.key});

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
          'Apa itu diabetes',
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
            Center(
              child: SizedBox(
                width: 220,
                height: 220,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      width: 220,
                      height: 220,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: kBlueSoft,
                      ),
                    ),
                    Container(
                      width: 160,
                      height: 160,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                        border: Border.all(color: kBlue, width: 2),
                      ),
                      alignment: Alignment.center,
                      child: const Text(
                        'DIABETES',
                        style: TextStyle(
                          color: kBlue,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'Diabetes adalah penyakit kronis ketika kadar gula darah '
              '(glukosa) di dalam tubuh menjadi terlalu tinggi. Karena '
              'pankreas tidak menghasilkan cukup insulin atau insulin '
              'tidak dapat menggunakannya secara efektif.',
              style: TextStyle(
                fontSize: 14,
                height: 1.6,
                color: Colors.grey.shade800,
              ),
            ),
            const SizedBox(height: 14),
            Text(
              'Penyebab utama diabetes bervariasi, bergantung pada '
              'jenisnya, tetapi secara umum sering terjadi karena '
              'gangguan pada produksi atau penggunaan hormon insulin '
              'oleh tubuh.',
              style: TextStyle(
                fontSize: 14,
                height: 1.6,
                color: Colors.grey.shade800,
              ),
            ),
            const SizedBox(height: 20),
            const TipsSingkatBox(),
          ],
        ),
      ),
    );
  }
}

class TipsSingkatBox extends StatelessWidget {
  const TipsSingkatBox({super.key});

  static const List<String> tips = [
    'Batasi gula : Kurangi minuman manis',
    'Turunkan berat badan agar ideal',
    'Tidur cukup : Minimal 7-8 jam',
    'Cukupi air putih : 8 gelas sehari',
    'Hindari makanan tinggi lemak',
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: ApaItuDiabetesScreen.kBlueSoft,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: const [
              Icon(Icons.info,
                  color: ApaItuDiabetesScreen.kBlue, size: 18),
              SizedBox(width: 8),
              Text(
                'Tips Singkat:',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ...tips.map(
            (t) => Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(Icons.check_circle,
                      color: ApaItuDiabetesScreen.kBlue, size: 16),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      t,
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
          ),
        ],
      ),
    );
  }
}