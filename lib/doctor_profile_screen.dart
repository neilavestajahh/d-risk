import 'package:flutter/material.dart';

import 'chat_konsultasi_screen.dart';
// Catatan: import ke jadwal_booking_screen.dart TIDAK dipakai lagi di file ini,
// karena tombol "Mulai Konsultasi" sekarang langsung membuka halaman chat.
// Sesuaikan nama file import 'chat_konsultasi_screen.dart' di atas dengan
// nama file tempat kamu menyimpan class ChatKonsultasiScreen.

// Letakkan di: lib/doctor_profile_screen.dart
// (langsung di lib/, BUKAN di lib/screens/)

const Color _ddPrimaryBlue = Color(0xFF1E6FE0);
const Color _ddNavyDark = Color(0xFF1B2A4A);
const Color _ddTextGrey = Color(0xFF7A8B9E);
const Color _ddCardBorderColor = Color(0xFFE2E8F0);
const Color _ddChipBg = Color(0xFFEFF4FF);
const Color _ddAccentGreen = Color(0xFF22A45D);
const Color _ddStarYellow = Color(0xFFFFA726);

/// Halaman Detail Dokter (dibuka setelah memilih dokter dari
/// KonsultasiDokterScreen). Tombol "Mulai Konsultasi" langsung membuka
/// halaman chat (ChatKonsultasiScreen) dengan dokter yang dipilih.
class DoctorProfileScreen extends StatelessWidget {
  final String name;
  final String specialty;
  final double rating;
  final int reviewCount;
  final String imageSeed;
  final String experience;
  final List<String> tags;
  final String about;
  final String scheduleDays;
  final String scheduleTime;

  const DoctorProfileScreen({
    super.key,
    required this.name,
    required this.specialty,
    this.rating = 4.8,
    this.reviewCount = 120,
    required this.imageSeed,
    this.experience = '5 tahun pengalaman',
    this.tags = const ['Konsultasi Umum'],
    this.about = '',
    this.scheduleDays = 'Senin - Sabtu',
    this.scheduleTime = '08:00 - 16:00 WIB',
  });

  @override
  Widget build(BuildContext context) {
    final String aboutText = about.isNotEmpty
        ? about
        : '$name adalah dokter yang berfokus pada $specialty, '
            'siap membantu menjawab keluhan kesehatanmu dengan pendekatan yang ramah dan profesional.';

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 4, 8, 0),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back, color: _ddNavyDark, size: 22),
                    onPressed: () => Navigator.maybePop(context),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(20, 4, 20, 16),
                children: [
                  Center(
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        ClipOval(
                          child: Image.network(
                            'https://api.dicebear.com/7.x/avataaars/png?seed=${Uri.encodeComponent(name)}',
                            width: 96,
                            height: 96,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) => Container(
                              width: 96,
                              height: 96,
                              color: const Color(0xFFF1F5F9),
                              child: const Icon(Icons.person, color: _ddTextGrey, size: 40),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 4,
                          right: 4,
                          child: Container(
                            width: 16,
                            height: 16,
                            decoration: BoxDecoration(
                              color: _ddAccentGreen,
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.white, width: 2),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 6),
                  const Center(
                    child: Text(
                      'Online',
                      style: TextStyle(fontSize: 12, color: _ddAccentGreen, fontWeight: FontWeight.w600),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Center(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          name,
                          style: const TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                            color: _ddNavyDark,
                          ),
                        ),
                        const SizedBox(width: 4),
                        const Icon(Icons.verified_rounded, color: _ddPrimaryBlue, size: 18),
                      ],
                    ),
                  ),
                  const SizedBox(height: 2),
                  Center(
                    child: Text(
                      specialty,
                      style: const TextStyle(fontSize: 13, color: _ddTextGrey),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Center(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.star_rounded, color: _ddStarYellow, size: 18),
                        const SizedBox(width: 2),
                        Text(
                          '$rating',
                          style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: _ddNavyDark),
                        ),
                        Text(
                          ' ($reviewCount ulasan)',
                          style: const TextStyle(fontSize: 12, color: _ddTextGrey),
                        ),
                        const SizedBox(width: 12),
                        const Icon(Icons.work_outline_rounded, color: _ddTextGrey, size: 16),
                        const SizedBox(width: 3),
                        Text(
                          experience,
                          style: const TextStyle(fontSize: 12, color: _ddTextGrey),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  Wrap(
                    alignment: WrapAlignment.center,
                    spacing: 8,
                    runSpacing: 8,
                    children: tags
                        .map(
                          (tag) => Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                            decoration: BoxDecoration(
                              color: _ddChipBg,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              tag,
                              style: const TextStyle(fontSize: 12, color: _ddPrimaryBlue, fontWeight: FontWeight.w500),
                            ),
                          ),
                        )
                        .toList(),
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    'Tentang Dokter',
                    style: TextStyle(fontSize: 14.5, fontWeight: FontWeight.w700, color: _ddNavyDark),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    aboutText,
                    style: const TextStyle(fontSize: 13, color: _ddTextGrey, height: 1.5),
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    'Jadwal Praktik',
                    style: TextStyle(fontSize: 14.5, fontWeight: FontWeight.w700, color: _ddNavyDark),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: _ddCardBorderColor),
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: _ddChipBg,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Icon(Icons.calendar_today_rounded, color: _ddPrimaryBlue, size: 18),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                scheduleDays,
                                style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: _ddNavyDark),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                scheduleTime,
                                style: const TextStyle(fontSize: 12, color: _ddTextGrey),
                              ),
                            ],
                          ),
                        ),
                        const Icon(Icons.chevron_right_rounded, color: _ddTextGrey),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 16),
              child: SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ChatKonsultasiScreen(
                          doctorName: name,
                          doctorSpecialty: specialty,
                        ),
                      ),
                    );
                  },
                  icon: const Icon(Icons.chat_bubble_rounded, size: 18),
                  label: const Text(
                    'Mulai Konsultasi',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _ddPrimaryBlue,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                    elevation: 0,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}