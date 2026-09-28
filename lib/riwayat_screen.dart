import 'package:flutter/material.dart';

/// Model sederhana untuk satu item riwayat.
class RiwayatItem {
  final String jenis; // contoh: Konsultasi, Perawatan Luka
  final String tanggal;
  final String petugas;
  final IconData icon;
  final bool selesai;

  const RiwayatItem({
    required this.jenis,
    required this.tanggal,
    required this.petugas,
    required this.icon,
    this.selesai = true,
  });
}

/// Data contoh. Ganti dengan data asli dari API / database milikmu.
const List<RiwayatItem> daftarRiwayat = [
  RiwayatItem(
    jenis: 'Konsultasi',
    tanggal: 'Sat, 18 Mei 2022',
    petugas: 'dr. Yolanda Silapi, M.A.R.S — Online',
    icon: Icons.chat_bubble_outline_rounded,
  ),
  RiwayatItem(
    jenis: 'Perawatan Luka',
    tanggal: 'Wed, 20 Jun 2022',
    petugas: 'Venika Tyas, S.Kep., Ns',
    icon: Icons.healing_rounded,
  ),
];

/// Halaman Riwayat. Dipakai dari Beranda (bottom nav) DAN dari Profil.
/// Di Profil cukup: Navigator.push(context, MaterialPageRoute(builder: (_) => const RiwayatScreen()));
class RiwayatScreen extends StatelessWidget {
  const RiwayatScreen({super.key});

  static const Color primaryBlue = Color(0xFF1E6FE0);
  static const Color navyDark = Color(0xFF1B2A4A);
  static const Color textGrey = Color(0xFF7A8B9E);
  static const Color accentGreen = Color(0xFF22A45D);
  static const Color cardBorderColor = Color(0xFFE2E8F0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        backgroundColor: const Color(0xFFBFE8F2),
        elevation: 0,
        centerTitle: true,
        iconTheme: const IconThemeData(color: navyDark),
        title: const Text(
          'Riwayat',
          style: TextStyle(
            color: navyDark,
            fontWeight: FontWeight.w700,
            fontSize: 16,
          ),
        ),
      ),
      body: daftarRiwayat.isEmpty
          ? const Center(
              child: Text(
                'Belum ada riwayat',
                style: TextStyle(color: textGrey),
              ),
            )
          : ListView.separated(
              padding: const EdgeInsets.all(20),
              itemCount: daftarRiwayat.length,
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final item = daftarRiwayat[index];
                return InkWell(
                  borderRadius: BorderRadius.circular(16),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => RiwayatDetailScreen(item: item),
                      ),
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: cardBorderColor),
                    ),
                    child: Row(
                      children: [
                        Icon(item.icon, color: navyDark, size: 22),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item.jenis,
                                style: const TextStyle(
                                  fontSize: 13.5,
                                  fontWeight: FontWeight.w700,
                                  color: navyDark,
                                ),
                              ),
                              const SizedBox(height: 3),
                              Text(
                                item.tanggal,
                                style: const TextStyle(
                                    fontSize: 11, color: textGrey),
                              ),
                              Text(
                                item.petugas,
                                style: const TextStyle(
                                    fontSize: 11, color: textGrey),
                              ),
                            ],
                          ),
                        ),
                        if (item.selesai)
                          const Icon(Icons.check_circle_rounded,
                              color: accentGreen, size: 20),
                        const SizedBox(width: 4),
                        const Icon(Icons.chevron_right_rounded,
                            color: textGrey),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}

/// Halaman detail satu riwayat (dibuka saat item diklik).
class RiwayatDetailScreen extends StatelessWidget {
  final RiwayatItem item;

  const RiwayatDetailScreen({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        backgroundColor: const Color(0xFFBFE8F2),
        elevation: 0,
        centerTitle: true,
        iconTheme: const IconThemeData(color: RiwayatScreen.navyDark),
        title: Text(
          'Detail ${item.jenis}',
          style: const TextStyle(
            color: RiwayatScreen.navyDark,
            fontWeight: FontWeight.w700,
            fontSize: 16,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: RiwayatScreen.cardBorderColor),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              _row('Layanan', item.jenis),
              _row('Tanggal', item.tanggal),
              _row('Petugas', item.petugas),
              _row('Status', item.selesai ? 'Selesai' : 'Berlangsung'),
            ],
          ),
        ),
      ),
    );
  }

  Widget _row(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 90,
            child: Text(label,
                style: const TextStyle(
                    fontSize: 12, color: RiwayatScreen.textGrey)),
          ),
          Expanded(
            child: Text(value,
                style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: RiwayatScreen.navyDark)),
          ),
        ],
      ),
    );
  }
}