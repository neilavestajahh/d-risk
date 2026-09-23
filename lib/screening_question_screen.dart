import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'screening_kesehatan_mandiri_screen.dart';

// ---------------------------------------------------------------------------
// COLORS
// ---------------------------------------------------------------------------
class AppColors {
  static const teal = Color(0xFF0BA5C9);
  static const tealLight = Color(0xFFE6F6FA);
  static const ink = Color(0xFF101828);
  static const sub = Color(0xFF667085);
  static const line = Color(0xFFE4E7EC);
  static const bg = Color(0xFFF7F8FA);
}

// ---------------------------------------------------------------------------
// SCREEN: SCREENING KESEHATAN MANDIRI
// ---------------------------------------------------------------------------
class ScreeningQuestionScreen extends StatefulWidget {
  const ScreeningQuestionScreen({super.key});

  @override
  State<ScreeningQuestionScreen> createState() => _ScreeningQuestionScreenState();
}

class _ScreeningQuestionScreenState extends State<ScreeningQuestionScreen> {
  static const totalQuestions = 24;

  String? selectedAge;
  String? selectedGender;
  final TextEditingController _weightController = TextEditingController();

  @override
  void dispose() {
    _weightController.dispose();
    super.dispose();
  }

  void _resetForm() {
    setState(() {
      selectedAge = null;
      selectedGender = null;
      _weightController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 8, 16, 10),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back_ios_new, size: 18, color: AppColors.ink),
                    onPressed: () => Navigator.of(context).maybePop(),
                  ),
                  const Expanded(
                    child: Text(
                      "Screening Kesehatan Mandiri",
                      style: TextStyle(fontSize: 15.5, fontWeight: FontWeight.bold, color: AppColors.teal),
                    ),
                  ),
                  const Icon(Icons.description_outlined, color: AppColors.teal, size: 20),
                ],
              ),
            ),

            // Konten form
            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(20, 8, 20, 12),
                children: [
                  StepBadge(step: 1, total: totalQuestions),
                  const SizedBox(height: 8),
                  const QuestionLabel("Berapa usia Anda saat ini?"),
                  const SizedBox(height: 10),
                  AgeDropdown(
                    value: selectedAge,
                    onChanged: (v) => setState(() => selectedAge = v),
                  ),
                  const SizedBox(height: 24),

                  StepBadge(step: 2, total: totalQuestions),
                  const SizedBox(height: 8),
                  const QuestionLabel("Apa jenis kelamin Anda?"),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: GenderOption(
                          label: "Laki-laki",
                          icon: Icons.male_rounded,
                          selected: selectedGender == "Laki-laki",
                          onTap: () => setState(() => selectedGender = "Laki-laki"),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: GenderOption(
                          label: "Perempuan",
                          icon: Icons.female_rounded,
                          selected: selectedGender == "Perempuan",
                          onTap: () => setState(() => selectedGender = "Perempuan"),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),

                  StepBadge(step: 3, total: totalQuestions),
                  const SizedBox(height: 8),
                  const QuestionLabel("Berapa berat badan Anda?"),
                  const SizedBox(height: 10),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: AppColors.line),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _weightController,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              hintText: "Masukkan berat badan (kg)",
                              hintStyle: TextStyle(color: AppColors.sub, fontSize: 13.5),
                              border: InputBorder.none,
                              isDense: true,
                              contentPadding: EdgeInsets.symmetric(vertical: 14),
                            ),
                          ),
                        ),
                        const Text("kg", style: TextStyle(color: AppColors.sub, fontSize: 13)),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Tombol aksi
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 12),
              child: Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 48,
                      child: OutlinedButton(
                        onPressed: _resetForm,
                        style: OutlinedButton.styleFrom(
                          foregroundColor: AppColors.teal,
                          side: const BorderSide(color: AppColors.teal),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        ),
                        child: const Text("Ulangi", style: TextStyle(fontWeight: FontWeight.w600)),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    flex: 2,
                    child: SizedBox(
                      height: 48,
                      child: ElevatedButton.icon(
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => const ScreeningKesehatanMandiriScreen(),
                            ),
                          );
                        },
                        icon: const Text("Selanjutnya", style: TextStyle(fontWeight: FontWeight.w600)),
                        label: const Icon(Icons.arrow_forward_rounded, size: 18),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.teal,
                          foregroundColor: Colors.white,
                          elevation: 0,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const BottomNav(activeIndex: 3),
          ],
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// WIDGET: BADGE NOMOR PERTANYAAN (mis. "1/24")
// ---------------------------------------------------------------------------
class StepBadge extends StatelessWidget {
  final int step;
  final int total;

  const StepBadge({super.key, required this.step, required this.total});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.teal,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        "$step/$total",
        style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// WIDGET: LABEL PERTANYAAN
// ---------------------------------------------------------------------------
class QuestionLabel extends StatelessWidget {
  final String text;

  const QuestionLabel(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(fontSize: 14.5, fontWeight: FontWeight.bold, color: AppColors.ink),
    );
  }
}

// ---------------------------------------------------------------------------
// WIDGET: DROPDOWN USIA
// ---------------------------------------------------------------------------
class AgeDropdown extends StatelessWidget {
  final String? value;
  final ValueChanged<String?> onChanged;

  const AgeDropdown({super.key, required this.value, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    final options = List.generate(83, (i) => "${i + 1}");

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.line),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          isExpanded: true,
          hint: const Text("Pilih usia (tahun)", style: TextStyle(color: AppColors.sub, fontSize: 13.5)),
          icon: const Icon(Icons.keyboard_arrow_down_rounded, color: AppColors.sub),
          items: options
              .map((o) => DropdownMenuItem(value: o, child: Text("$o tahun", style: const TextStyle(fontSize: 13.5))))
              .toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// WIDGET: PILIHAN JENIS KELAMIN
// ---------------------------------------------------------------------------
class GenderOption extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool selected;
  final VoidCallback onTap;

  const GenderOption({
    super.key,
    required this.label,
    required this.icon,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          color: selected ? AppColors.tealLight : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: selected ? AppColors.teal : AppColors.line),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 18, color: selected ? AppColors.teal : AppColors.sub),
            const SizedBox(width: 6),
            Text(
              label,
              style: TextStyle(
                fontSize: 13.5,
                fontWeight: FontWeight.w600,
                color: selected ? AppColors.teal : AppColors.sub,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// WIDGET: BOTTOM NAVIGATION (konsisten dengan halaman lainnya)
// ---------------------------------------------------------------------------
class BottomNav extends StatelessWidget {
  final int activeIndex;
  final ValueChanged<int>? onTap;

  const BottomNav({super.key, this.activeIndex = 0, this.onTap});

  static const _items = [
    (icon: Icons.home_outlined, label: "Beranda"),
    (icon: Icons.menu_book_outlined, label: "Book Health"),
    (icon: Icons.favorite_border, label: "Konsultasi"),
    (icon: Icons.monitor_heart_outlined, label: "Screening"),
    (icon: Icons.home_repair_service_outlined, label: "Home Care"),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 10, bottom: 20),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: AppColors.line)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(_items.length, (i) {
          final item = _items[i];
          final active = i == activeIndex;
          return GestureDetector(
            onTap: () => onTap?.call(i),
            child: SizedBox(
              width: 64,
              child: Column(
                children: [
                  Icon(item.icon, size: 22, color: active ? AppColors.teal : AppColors.sub),
                  const SizedBox(height: 4),
                  Text(
                    item.label,
                    style: TextStyle(
                      fontSize: 10.5,
                      fontWeight: FontWeight.w600,
                      color: active ? AppColors.teal : AppColors.sub,
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}