import 'package:flutter/material.dart';

// Letakkan di: lib/profil_screen.dart
// (langsung di lib/, BUKAN di lib/screens/)

const Color _pfTeal = Color(0xFF8FD9D3);
const Color _pfPink = Color(0xFFF3D2DE);
const Color _pfNavyDark = Color(0xFF1B2A4A);
const Color _pfTextGrey = Color(0xFF7A8B9E);
const Color _pfCardBorder = Color(0xFFE2E8F0);
const Color _pfCheckGreen = Color(0xFF22C55E);

// Data profil contoh — nanti bisa diganti dengan data user asli (misalnya
// dari user_store.dart / API).
const String _userName = 'Sania Pramita Salim';
const String _userEmail = 'saniapramita@gmail.com';

BoxDecoration _pfBgGradient() {
  return const BoxDecoration(
    gradient: LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [_pfTeal, _pfPink],
    ),
  );
}

// ---------------------------------------------------------------------------
// APP BAR KECIL (back kiri, judul tengah, aksi kanan opsional)
// ---------------------------------------------------------------------------
Widget _pfTopBar(BuildContext context, String title, {VoidCallback? onAction, String actionLabel = 'Ubah'}) {
  return Padding(
    padding: const EdgeInsets.fromLTRB(8, 8, 16, 8),
    child: Row(
      children: [
        IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, size: 18, color: _pfNavyDark),
          onPressed: () => Navigator.maybePop(context),
        ),
        Expanded(
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: _pfNavyDark),
          ),
        ),
        if (onAction != null)
          TextButton(
            onPressed: onAction,
            child: Text(actionLabel, style: const TextStyle(color: _pfNavyDark, fontWeight: FontWeight.w600)),
          )
        else
          const SizedBox(width: 48),
      ],
    ),
  );
}

Widget _pfAvatar({double size = 72}) {
  return Container(
    width: size,
    height: size,
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      border: Border.all(color: Colors.white, width: 3),
    ),
    child: ClipOval(
      child: Image.network(
        'https://i.pravatar.cc/160?img=47',
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) => Container(
          color: Colors.white,
          child: Icon(Icons.person, color: _pfTextGrey, size: size * 0.5),
        ),
      ),
    ),
  );
}

Widget _pfNameHeader() {
  return Column(
    children: [
      _pfAvatar(),
      const SizedBox(height: 10),
      const Text(_userName, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: _pfNavyDark)),
      const SizedBox(height: 2),
      Text(_userEmail, style: const TextStyle(fontSize: 12.5, color: _pfNavyDark)),
    ],
  );
}

void _pfShowComingSoon(BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(content: Text('Fitur ubah belum tersedia')),
  );
}

// =============================================================================
// 1) HALAMAN PROFIL (menu utama akun)
// =============================================================================
class ProfilScreen extends StatelessWidget {
  const ProfilScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: _pfBgGradient(),
        child: SafeArea(
          child: Column(
            children: [
              _pfTopBar(context, 'Profil'),
              const SizedBox(height: 8),
              _pfNameHeader(),
              const SizedBox(height: 24),
              Expanded(
                child: Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
                  ),
                  padding: const EdgeInsets.fromLTRB(20, 24, 20, 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Akun', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: _pfTextGrey)),
                      const SizedBox(height: 10),
                      _ProfilMenuTile(
                        icon: Icons.person_outline_rounded,
                        label: 'Profil Saya',
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => const ProfilSayaScreen()),
                        ),
                      ),
                      _ProfilMenuTile(
                        icon: Icons.history_rounded,
                        label: 'Riwayat',
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => const RiwayatScreen()),
                        ),
                      ),
                      _ProfilMenuTile(
                        icon: Icons.diversity_3_rounded,
                        label: 'Riwayat Keluarga',
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => const RiwayatKeluargaScreen()),
                        ),
                      ),
                      _ProfilMenuTile(
                        icon: Icons.lock_outline_rounded,
                        label: 'Ubah Kata Sandi',
                        onTap: () => _pfShowComingSoon(context),
                      ),
                      const Spacer(),
                      SizedBox(
                        width: double.infinity,
                        height: 48,
                        child: OutlinedButton(
                          onPressed: () => _pfShowComingSoon(context),
                          style: OutlinedButton.styleFrom(
                            side: const BorderSide(color: _pfCardBorder),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                          ),
                          child: const Text('logout', style: TextStyle(color: _pfNavyDark, fontWeight: FontWeight.w600)),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ProfilMenuTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _ProfilMenuTile({required this.icon, required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Row(
          children: [
            Icon(icon, size: 20, color: _pfNavyDark),
            const SizedBox(width: 14),
            Expanded(child: Text(label, style: const TextStyle(fontSize: 14, color: _pfNavyDark))),
            const Icon(Icons.chevron_right_rounded, color: _pfTextGrey),
          ],
        ),
      ),
    );
  }
}

// =============================================================================
// 2) HALAMAN PROFIL SAYA (ringkasan + tombol Lihat Detail)
// =============================================================================
class ProfilSayaScreen extends StatelessWidget {
  const ProfilSayaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: _pfBgGradient(),
        child: SafeArea(
          child: Column(
            children: [
              _pfTopBar(context, 'Profil Saya', onAction: () => _pfShowComingSoon(context)),
              const SizedBox(height: 8),
              _pfNameHeader(),
              const SizedBox(height: 24),
              Expanded(
                child: Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
                  ),
                  padding: const EdgeInsets.fromLTRB(20, 24, 20, 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: const [
                          _StatBox(label: 'Tinggi Badan', value: '160 cm'),
                          SizedBox(width: 10),
                          _StatBox(label: 'Berat Badan', value: '52 kg'),
                          SizedBox(width: 10),
                          _StatBox(label: 'Gula Darah', value: '102 mg/dL'),
                        ],
                      ),
                      const SizedBox(height: 20),
                      InkWell(
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => const DetailProfilScreen()),
                        ),
                        child: Row(
                          children: const [
                            Text('Lihat Detail', style: TextStyle(color: _pfNavyDark, fontWeight: FontWeight.w600)),
                            SizedBox(width: 4),
                            Icon(Icons.chevron_right_rounded, color: _pfNavyDark, size: 18),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _StatBox extends StatelessWidget {
  final String label;
  final String value;

  const _StatBox({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
        decoration: BoxDecoration(
          color: const Color(0xFFF8FAFC),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: _pfCardBorder),
        ),
        child: Column(
          children: [
            Text(value, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: _pfNavyDark)),
            const SizedBox(height: 4),
            Text(label, textAlign: TextAlign.center, style: const TextStyle(fontSize: 10.5, color: _pfTextGrey)),
          ],
        ),
      ),
    );
  }
}

// =============================================================================
// 3) HALAMAN LIHAT DETAIL (data pribadi + alergi)
// =============================================================================
class DetailProfilScreen extends StatelessWidget {
  const DetailProfilScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: _pfBgGradient(),
        child: SafeArea(
          child: Column(
            children: [
              _pfTopBar(context, 'Lihat Detail'),
              const SizedBox(height: 8),
              _pfNameHeader(),
              const SizedBox(height: 24),
              Expanded(
                child: Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
                  ),
                  child: ListView(
                    padding: const EdgeInsets.fromLTRB(20, 24, 20, 20),
                    children: [
                      const _DetailRow(label: 'Tanggal Lahir', value: '12 Desember 2002'),
                      const _DetailRow(label: 'Jenis Kelamin', value: 'Perempuan'),
                      const _DetailRow(label: 'Tinggi Badan', value: '160 cm'),
                      const _DetailRow(label: 'Berat Badan', value: '52 kg'),
                      const _DetailRow(label: 'Tekanan Darah', value: '115/80 mmHg'),
                      const _DetailRow(label: 'Gula Darah Terakhir', value: '102 mg/dL'),
                      const _DetailRow(label: 'BMI', value: '20.31'),
                      const _DetailRow(label: 'Kota/Kabupaten', value: 'Kabupaten Jember'),
                      const _DetailRow(label: 'Nomor KTP', value: '3350507121020002'),
                      const _DetailRow(label: 'Alamat Sesuai KTP', value: 'Desa Karangpring, Mayang'),
                      const SizedBox(height: 16),
                      const Text('Data Alergi', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: _pfNavyDark)),
                      const SizedBox(height: 10),
                      const _AllergyBlock(title: 'Alergi Makanan', items: ['Telur', 'Ikan', 'Kacang tanah']),
                      const SizedBox(height: 12),
                      const _AllergyBlock(title: 'Alergi Obat', items: ['Aspirin', 'Antikonvulsan']),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _DetailRow extends StatelessWidget {
  final String label;
  final String value;

  const _DetailRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(fontSize: 11.5, color: _pfTextGrey)),
          const SizedBox(height: 3),
          Text(value, style: const TextStyle(fontSize: 14, color: _pfNavyDark, fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}

class _AllergyBlock extends StatelessWidget {
  final String title;
  final List<String> items;

  const _AllergyBlock({required this.title, required this.items});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: const TextStyle(fontSize: 12.5, fontWeight: FontWeight.w600, color: _pfNavyDark)),
        const SizedBox(height: 6),
        for (int i = 0; i < items.length; i++)
          Padding(
            padding: const EdgeInsets.only(bottom: 4),
            child: Text('${i + 1}. ${items[i]}', style: const TextStyle(fontSize: 13, color: _pfNavyDark)),
          ),
      ],
    );
  }
}

// =============================================================================
// 4) HALAMAN RIWAYAT (riwayat konsultasi & perawatan)
// =============================================================================
class _RiwayatEntry {
  final IconData icon;
  final String title;
  final String date;
  final String person;
  final String status;

  const _RiwayatEntry({
    required this.icon,
    required this.title,
    required this.date,
    required this.person,
    required this.status,
  });
}

const List<_RiwayatEntry> _riwayatEntries = [
  _RiwayatEntry(
    icon: Icons.chat_bubble_outline_rounded,
    title: 'Konsultasi',
    date: 'Sat, 16 Mei 2022',
    person: 'dr. Yolanda Silapu, M.A.R.S — Online',
    status: 'Selesai',
  ),
  _RiwayatEntry(
    icon: Icons.healing_rounded,
    title: 'Perawatan Luka',
    date: 'Wed, 20 Jun 2022',
    person: 'Venka Tyas, S.Kep., Ns.',
    status: 'Selesai',
  ),
];

class RiwayatScreen extends StatelessWidget {
  const RiwayatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: _pfBgGradient(),
        child: SafeArea(
          child: Column(
            children: [
              _pfTopBar(context, 'Riwayat', onAction: () => _pfShowComingSoon(context)),
              const SizedBox(height: 8),
              _pfNameHeader(),
              const SizedBox(height: 24),
              Expanded(
                child: Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
                  ),
                  child: ListView.separated(
                    padding: const EdgeInsets.fromLTRB(20, 24, 20, 20),
                    itemCount: _riwayatEntries.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 12),
                    itemBuilder: (context, index) => _RiwayatCard(entry: _riwayatEntries[index]),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _RiwayatCard extends StatelessWidget {
  final _RiwayatEntry entry;

  const _RiwayatCard({required this.entry});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: _pfCardBorder),
      ),
      child: Row(
        children: [
          Icon(entry.icon, color: _pfNavyDark, size: 20),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(entry.title, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 13.5, color: _pfNavyDark)),
                const SizedBox(height: 2),
                Text(entry.date, style: const TextStyle(fontSize: 11.5, color: _pfTextGrey)),
                Text(entry.person, style: const TextStyle(fontSize: 11.5, color: _pfTextGrey)),
              ],
            ),
          ),
          const Icon(Icons.check_circle_rounded, color: _pfCheckGreen, size: 20),
        ],
      ),
    );
  }
}

// =============================================================================
// 5) HALAMAN RIWAYAT KELUARGA
// =============================================================================
class RiwayatKeluargaScreen extends StatelessWidget {
  const RiwayatKeluargaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: _pfBgGradient(),
        child: SafeArea(
          child: Column(
            children: [
              _pfTopBar(context, 'Riwayat Keluarga', onAction: () => _pfShowComingSoon(context)),
              const SizedBox(height: 8),
              _pfNameHeader(),
              const SizedBox(height: 24),
              Expanded(
                child: Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
                  ),
                  child: ListView(
                    padding: const EdgeInsets.fromLTRB(20, 24, 20, 20),
                    children: const [
                      Text('Riwayat Penyakit Turunan', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: _pfNavyDark)),
                      SizedBox(height: 8),
                      Text(
                        'Ayah dari ibu saya memiliki riwayat diabetes sebelumnya, tetapi kakek saya memiliki riwayat diabetes tipe 1 dan sudah meninggal dunia.',
                        style: TextStyle(fontSize: 13, height: 1.5, color: _pfNavyDark),
                      ),
                      SizedBox(height: 20),
                      Text('Riwayat Penyakit Saya', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: _pfNavyDark)),
                      SizedBox(height: 8),
                      Text(
                        'Saya sebelumnya memiliki riwayat tekanan darah tinggi dan lemas.',
                        style: TextStyle(fontSize: 13, height: 1.5, color: _pfNavyDark),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}