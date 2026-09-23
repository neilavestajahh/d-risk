import 'package:flutter/material.dart';

import 'data_pasien_screen.dart';

// Letakkan di: lib/jadwal_dokter_tanggal_screen.dart
// (langsung di lib/, BUKAN di lib/screens/)
//
// Halaman ini menggantikan JadwalBookingScreen versi date-strip:
// tampilannya kalender bulanan penuh (Sen–Min, bisa gonta-ganti bulan)
// + grid slot waktu + kotak ringkasan booking di bawah yang berfungsi
// sebagai tombol "Selanjutnya" menuju DataPasienScreen.

const Color _jdPrimaryBlue = Color(0xFF1E6FE0);
const Color _jdTeal = Color(0xFF17A2B8);
const Color _jdNavyDark = Color(0xFF1B2A4A);
const Color _jdTextGrey = Color(0xFF7A8B9E);
const Color _jdCardBorderColor = Color(0xFFE2E8F0);
const Color _jdStarYellow = Color(0xFFFFB020);
const Color _jdLightBg = Color(0xFFF1F5F9);
const Color _jdSummaryBarColor = Color(0xFF20263B);

const List<String> _bulanIndo = [
  'Januari', 'Februari', 'Maret', 'April', 'Mei', 'Juni',
  'Juli', 'Agustus', 'September', 'Oktober', 'November', 'Desember',
];
const List<String> _hariIndoSingkat = ['Sen', 'Sel', 'Rab', 'Kam', 'Jum', 'Sab', 'Min'];

/// Halaman "Jadwal Dokter & Tanggal" — kalender bulanan + pilih jam,
/// lalu lanjut ke DataPasienScreen membawa data dokter+jadwal terpilih.
class JadwalDokterTanggalScreen extends StatefulWidget {
  final String name;
  final String specialty;
  final double rating;
  final int reviewCount;
  final String imageSeed;
  final int biaya;

  const JadwalDokterTanggalScreen({
    super.key,
    required this.name,
    required this.specialty,
    required this.rating,
    required this.reviewCount,
    required this.imageSeed,
    this.biaya = 150000,
  });

  @override
  State<JadwalDokterTanggalScreen> createState() =>
      _JadwalDokterTanggalScreenState();
}

class _JadwalDokterTanggalScreenState
    extends State<JadwalDokterTanggalScreen> {
  static const List<String> _timeSlots = [
    '08:00', '09:00', '10:00', '11:00',
    '13:00', '14:00', '15:00', '16:00',
  ];

  late DateTime _visibleMonth; // tanggal 1 di bulan yang sedang ditampilkan
  DateTime? _selectedDate;
  String? _selectedJamMulai;

  @override
  void initState() {
    super.initState();
    final today = DateTime.now();
    _visibleMonth = DateTime(today.year, today.month, 1);
    // Tanggal hari ini otomatis ke-highlight (seperti tanggal 18 di desain),
    // tapi TIDAK otomatis dianggap "terpilih" sampai user benar-benar tap.
  }

  bool get _isToday {
    final now = DateTime.now();
    return now.year == _visibleMonth.year && now.month == _visibleMonth.month;
  }

  int get _daysInMonth {
    final firstDayNextMonth =
        DateTime(_visibleMonth.year, _visibleMonth.month + 1, 1);
    return firstDayNextMonth.subtract(const Duration(days: 1)).day;
  }

  /// weekday: 1=Senin..7=Minggu -> offset kolom kalender (0-indexed, Senin di kolom 0)
  int get _leadingBlankDays {
    final firstDay = DateTime(_visibleMonth.year, _visibleMonth.month, 1);
    return firstDay.weekday - 1;
  }

  void _goToPrevMonth() {
    setState(() {
      _visibleMonth =
          DateTime(_visibleMonth.year, _visibleMonth.month - 1, 1);
    });
  }

  void _goToNextMonth() {
    setState(() {
      _visibleMonth =
          DateTime(_visibleMonth.year, _visibleMonth.month + 1, 1);
    });
  }

  bool _isPastDate(DateTime date) {
    final today = DateTime.now();
    final todayOnly = DateTime(today.year, today.month, today.day);
    return date.isBefore(todayOnly);
  }

  String _jamSelesai(String jamMulai) {
    final parts = jamMulai.split(':');
    final hour = int.parse(parts[0]);
    final nextHour = (hour + 1).toString().padLeft(2, '0');
    return '$nextHour:${parts[1]}';
  }

  String get _formattedTanggalRingkas {
    if (_selectedDate == null) return '';
    final d = _selectedDate!;
    final bulan = _bulanIndo[d.month - 1];
    return '${d.day} $bulan ${d.year}';
  }

  String get _formattedTanggalLengkap {
    if (_selectedDate == null) return '';
    final d = _selectedDate!;
    const hariLengkap = [
      'Senin', 'Selasa', 'Rabu', 'Kamis', 'Jumat', 'Sabtu', 'Minggu',
    ];
    final hari = hariLengkap[d.weekday - 1];
    final bulan = _bulanIndo[d.month - 1];
    return '$hari, ${d.day} $bulan ${d.year}';
  }

  // Ini kuncinya: validasi HARUS berdasarkan state yang sama dengan yang
  // di-update lewat setState saat user tap tanggal/jam. Kalau widget
  // kalender kamu sebelumnya punya bug, biasanya karena ada 2 variabel state
  // berbeda (satu buat "tanggal yang di-highlight visual", satu lagi buat
  // "tanggal yang dianggap terpilih") yang gak sinkron.
  bool get _isFormValid => _selectedDate != null && _selectedJamMulai != null;

  void _handleTombolRingkasan() {
    if (!_isFormValid) {
      String pesan;
      if (_selectedDate == null && _selectedJamMulai == null) {
        pesan = 'Pilih tanggal dan jam terlebih dahulu';
      } else if (_selectedDate == null) {
        pesan = 'Pilih tanggal terlebih dahulu';
      } else {
        pesan = 'Pilih jam terlebih dahulu';
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(pesan),
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => DataPasienScreen(
          doctorName: widget.name,
          doctorSpecialty: widget.specialty,
          doctorRating: widget.rating,
          doctorReviewCount: widget.reviewCount,
          imageSeed: widget.imageSeed,
          jadwalTanggal: _formattedTanggalLengkap,
          jadwalJamMulai: _selectedJamMulai!,
          jadwalJamSelesai: _jamSelesai(_selectedJamMulai!),
          totalBiaya: widget.biaya,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        surfaceTintColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: _jdNavyDark, size: 22),
          onPressed: () => Navigator.maybePop(context),
        ),
        title: const Text(
          'Jadwal Dokter & Tanggal',
          style: TextStyle(
            color: _jdNavyDark,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SafeArea(
        top: false,
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(20, 8, 20, 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildDoctorCard(),
                    const SizedBox(height: 22),
                    const Text(
                      'Pilih Tanggal',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: _jdNavyDark,
                      ),
                    ),
                    const SizedBox(height: 12),
                    _buildCalendarCard(),
                    const SizedBox(height: 22),
                    const Text(
                      'Pilih Waktu',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: _jdNavyDark,
                      ),
                    ),
                    const SizedBox(height: 12),
                    _buildTimeSlotGrid(),
                    const SizedBox(height: 22),
                    _buildRingkasanBar(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // -------------------------------------------------------------------------
  // KARTU DOKTER
  // -------------------------------------------------------------------------

  Widget _buildDoctorCard() {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _jdCardBorderColor),
      ),
      child: Row(
        children: [
          ClipOval(
            child: Image.network(
              'https://api.dicebear.com/7.x/avataaars/png?seed=${Uri.encodeComponent(widget.name)}',
              width: 48,
              height: 48,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Container(
                width: 48,
                height: 48,
                color: _jdLightBg,
                child: const Icon(Icons.person, color: _jdTextGrey),
              ),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.name,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: _jdNavyDark,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  widget.specialty,
                  style: const TextStyle(fontSize: 12, color: _jdTextGrey),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(Icons.star_rounded,
                        color: _jdStarYellow, size: 15),
                    const SizedBox(width: 4),
                    Text(
                      '${widget.rating} (${widget.reviewCount} ulasan)',
                      style: const TextStyle(fontSize: 11, color: _jdTextGrey),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const Icon(Icons.favorite_border, color: _jdTextGrey),
        ],
      ),
    );
  }

  // -------------------------------------------------------------------------
  // KALENDER BULANAN
  // -------------------------------------------------------------------------

  Widget _buildCalendarCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _jdCardBorderColor),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: const Icon(Icons.chevron_left, color: _jdNavyDark),
                onPressed: _goToPrevMonth,
              ),
              Text(
                '${_bulanIndo[_visibleMonth.month - 1]} ${_visibleMonth.year}',
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: _jdNavyDark,
                ),
              ),
              IconButton(
                icon: const Icon(Icons.chevron_right, color: _jdNavyDark),
                onPressed: _goToNextMonth,
              ),
            ],
          ),
          Row(
            children: _hariIndoSingkat
                .map((h) => Expanded(
                      child: Center(
                        child: Text(
                          h,
                          style: const TextStyle(
                            fontSize: 12,
                            color: _jdTextGrey,
                          ),
                        ),
                      ),
                    ))
                .toList(),
          ),
          const SizedBox(height: 6),
          _buildCalendarGrid(),
        ],
      ),
    );
  }

  Widget _buildCalendarGrid() {
    final totalCells = _leadingBlankDays + _daysInMonth;
    final totalRows = (totalCells / 7).ceil();

    return Column(
      children: List.generate(totalRows, (row) {
        return Row(
          children: List.generate(7, (col) {
            final cellIndex = row * 7 + col;
            final dayNumber = cellIndex - _leadingBlankDays + 1;
            final isValidDay = dayNumber >= 1 && dayNumber <= _daysInMonth;

            if (!isValidDay) {
              return const Expanded(child: SizedBox(height: 48));
            }

            final date = DateTime(
              _visibleMonth.year,
              _visibleMonth.month,
              dayNumber,
            );
            final isPast = _isPastDate(date);
            final isSelected = _selectedDate != null &&
                _selectedDate!.year == date.year &&
                _selectedDate!.month == date.month &&
                _selectedDate!.day == date.day;
            final isToday = _isToday &&
                DateTime.now().day == dayNumber &&
                !isSelected;

            return Expanded(
              child: GestureDetector(
                // onTap TIDAK boleh dipasang kalau isPast — ini penyebab
                // umum bug lain: tanggal lampau ke-tap dan menyimpan
                // _selectedDate yang salah tanpa disadari.
                onTap: isPast
                    ? null
                    : () => setState(() => _selectedDate = date),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 3),
                  child: Container(
                    height: 42,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: isSelected
                          ? _jdTeal
                          : (isToday ? _jdTeal.withOpacity(0.12) : null),
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      '$dayNumber',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight:
                            isSelected ? FontWeight.w700 : FontWeight.w500,
                        color: isSelected
                            ? Colors.white
                            : (isPast
                                ? _jdCardBorderColor
                                : (isToday ? _jdTeal : _jdNavyDark)),
                      ),
                    ),
                  ),
                ),
              ),
            );
          }),
        );
      }),
    );
  }

  // -------------------------------------------------------------------------
  // SLOT WAKTU
  // -------------------------------------------------------------------------

  Widget _buildTimeSlotGrid() {
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: _timeSlots.map((jam) {
        final isSelected = jam == _selectedJamMulai;
        return ChoiceChip(
          label: Text(jam),
          selected: isSelected,
          onSelected: (_) => setState(() => _selectedJamMulai = jam),
          selectedColor: _jdTeal,
          backgroundColor: Colors.white,
          side: BorderSide(
            color: isSelected ? _jdTeal : _jdCardBorderColor,
          ),
          labelStyle: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: isSelected ? Colors.white : _jdNavyDark,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        );
      }).toList(),
    );
  }

  // -------------------------------------------------------------------------
  // KOTAK RINGKASAN / TOMBOL SELANJUTNYA
  // -------------------------------------------------------------------------

  Widget _buildRingkasanBar() {
    final String teks;
    if (_isFormValid) {
      teks =
          'Booking dengan ${widget.name} pada $_formattedTanggalRingkas, pukul $_selectedJamMulai';
    } else {
      teks = 'Pilih tanggal dan jam untuk melanjutkan booking';
    }

    return Material(
      color: _jdSummaryBarColor,
      borderRadius: BorderRadius.circular(14),
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: _handleTombolRingkasan,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  teks,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 13.5,
                    fontWeight: FontWeight.w500,
                    height: 1.4,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              const Icon(Icons.arrow_forward, color: Colors.white, size: 18),
            ],
          ),
        ),
      ),
    );
  }
}