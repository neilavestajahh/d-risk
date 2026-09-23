import 'package:flutter/material.dart';

import 'data_pasien_screen.dart';

// Letakkan di: lib/jadwal_booking_screen.dart
// (langsung di lib/, BUKAN di lib/screens/)
//
// Nama file & class di sini SENGAJA dibuat persis "jadwal_booking_screen.dart"
// dan "JadwalBookingScreen" supaya cocok dengan yang dipanggil dari
// lib/perawatan_luka_screen.dart. Semua parameter dibuat opsional (ada nilai
// default) supaya tetap bisa di-compile walau pemanggilnya kirim parameter
// dengan jumlah/nama yang sedikit berbeda dari dugaan kita.

const Color _jbPrimaryBlue = Color(0xFF1E6FE0);
const Color _jbTeal = Color(0xFF17A2B8);
const Color _jbNavyDark = Color(0xFF1B2A4A);
const Color _jbTextGrey = Color(0xFF7A8B9E);
const Color _jbCardBorderColor = Color(0xFFE2E8F0);
const Color _jbStarYellow = Color(0xFFFFB020);
const Color _jbLightBg = Color(0xFFF1F5F9);
const Color _jbSummaryBarColor = Color(0xFF20263B);

const List<String> _bulanIndo = [
  'Januari', 'Februari', 'Maret', 'April', 'Mei', 'Juni',
  'Juli', 'Agustus', 'September', 'Oktober', 'November', 'Desember',
];
const List<String> _hariIndoSingkat = ['Sen', 'Sel', 'Rab', 'Kam', 'Jum', 'Sab', 'Min'];

/// Halaman "Jadwal Dokter & Tanggal" — kalender bulanan + pilih jam,
/// lalu lanjut ke DataPasienScreen membawa data dokter+jadwal terpilih.
class JadwalBookingScreen extends StatefulWidget {
  final String name;
  final String specialty;
  final double rating;
  final int reviewCount;
  final String imageSeed;
  final int biaya;

  const JadwalBookingScreen({
    super.key,
    this.name = 'Dokter',
    this.specialty = '-',
    this.rating = 4.8,
    this.reviewCount = 0,
    this.imageSeed = '1',
    this.biaya = 150000,
  });

  @override
  State<JadwalBookingScreen> createState() =>
      _JadwalBookingScreenState();
}

class _JadwalBookingScreenState
    extends State<JadwalBookingScreen> {
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
          icon: const Icon(Icons.arrow_back, color: _jbNavyDark, size: 22),
          onPressed: () => Navigator.maybePop(context),
        ),
        title: const Text(
          'Jadwal Dokter & Tanggal',
          style: TextStyle(
            color: _jbNavyDark,
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
                        color: _jbNavyDark,
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
                        color: _jbNavyDark,
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
        border: Border.all(color: _jbCardBorderColor),
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
                color: _jbLightBg,
                child: const Icon(Icons.person, color: _jbTextGrey),
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
                    color: _jbNavyDark,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  widget.specialty,
                  style: const TextStyle(fontSize: 12, color: _jbTextGrey),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(Icons.star_rounded,
                        color: _jbStarYellow, size: 15),
                    const SizedBox(width: 4),
                    Text(
                      '${widget.rating} (${widget.reviewCount} ulasan)',
                      style: const TextStyle(fontSize: 11, color: _jbTextGrey),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const Icon(Icons.favorite_border, color: _jbTextGrey),
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
        border: Border.all(color: _jbCardBorderColor),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: const Icon(Icons.chevron_left, color: _jbNavyDark),
                onPressed: _goToPrevMonth,
              ),
              Text(
                '${_bulanIndo[_visibleMonth.month - 1]} ${_visibleMonth.year}',
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: _jbNavyDark,
                ),
              ),
              IconButton(
                icon: const Icon(Icons.chevron_right, color: _jbNavyDark),
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
                            color: _jbTextGrey,
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
                          ? _jbTeal
                          : (isToday ? _jbTeal.withOpacity(0.12) : null),
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
                                ? _jbCardBorderColor
                                : (isToday ? _jbTeal : _jbNavyDark)),
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
          selectedColor: _jbTeal,
          backgroundColor: Colors.white,
          side: BorderSide(
            color: isSelected ? _jbTeal : _jbCardBorderColor,
          ),
          labelStyle: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: isSelected ? Colors.white : _jbNavyDark,
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
      color: _jbSummaryBarColor,
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
