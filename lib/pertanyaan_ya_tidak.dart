import 'package:flutter/material.dart';

// ============================================================
// FILE: pertanyaan_ya_tidak.dart
// Letakkan di: lib/pertanyaan_ya_tidak.dart
//
// Widget bersama yang dipakai oleh SEMUA halaman screening
// (screening_kesehatan_mandiri_screen.dart, _screen_2.dart, dst).
// Import file ini di setiap screen, JANGAN copy-paste class-nya lagi,
// supaya tidak terjadi "duplicate class" saat satu screen meng-import
// screen lainnya.
// ============================================================

class PertanyaanYaTidak extends StatelessWidget {
  final int nomor;
  final int totalPertanyaan;
  final String teks;
  final bool? jawaban; // null = belum dijawab, true = Ya, false = Tidak
  final ValueChanged<bool> onJawab;

  const PertanyaanYaTidak({
    super.key,
    required this.nomor,
    required this.totalPertanyaan,
    required this.teks,
    required this.jawaban,
    required this.onJawab,
  });

  static const Color kBlue = Color(0xFF2E9AFF);
  static const Color kBlueDark = Color(0xFF1E6FD9);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$nomor/$totalPertanyaan',
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w600,
            color: Colors.grey.shade500,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          teks,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            height: 1.4,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            Expanded(
              child: _JawabanButton(
                label: 'Ya',
                icon: Icons.check,
                selected: jawaban == true,
                onTap: () => onJawab(true),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _JawabanButton(
                label: 'Tidak',
                icon: Icons.close,
                selected: jawaban == false,
                onTap: () => onJawab(false),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _JawabanButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool selected;
  final VoidCallback onTap;

  const _JawabanButton({
    required this.label,
    required this.icon,
    required this.selected,
    required this.onTap,
  });

  static const Color kBlueDark = Color(0xFF1E6FD9);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: selected ? kBlueDark : Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: selected ? kBlueDark : const Color(0xFFBEE0FF),
            width: 1.4,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 16,
              color: selected ? Colors.white : kBlueDark,
            ),
            const SizedBox(width: 6),
            Text(
              label,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 13,
                color: selected ? Colors.white : kBlueDark,
              ),
            ),
          ],
        ),
      ),
    );
  }
}