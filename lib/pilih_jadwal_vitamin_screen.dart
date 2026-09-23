import 'package:flutter/material.dart';

// Letakkan di: lib/pilih_jadwal_vitamin_screen.dart
// (langsung di lib/, BUKAN di lib/screens/)
//
// Catatan: versi ini TIDAK pakai package intl lagi.
// Format tanggal Indonesia dibuat manual di bawah (lihat _formatTanggalIndonesia),
// supaya tidak butuh dependency tambahan.

const Color _pjTeal = Color(0xFF17A2B8);
const Color _pjNavyDark = Color(0xFF1B2A4A);
const Color _pjTextGrey = Color(0xFF7A8B9E);
const Color _pjCardBorderColor = Color(0xFFE2E8F0);
const Color _pjInfoBg = Color(0xFFEAF6F9);

// ---------------------------------------------------------------------------
// FORMAT TANGGAL INDONESIA (pengganti manual untuk package intl)
// Contoh hasil: "Senin, 15 September 2026"
// ---------------------------------------------------------------------------
const List<String> _pjNamaHari = [
  'Senin',
  'Selasa',
  'Rabu',
  'Kamis',
  'Jumat',
  'Sabtu',
  'Minggu',
];

const List<String> _pjNamaBulan = [
  'Januari',
  'Februari',
  'Maret',
  'April',
  'Mei',
  'Juni',
  'Juli',
  'Agustus',
  'September',
  'Oktober',
  'November',
  'Desember',
];

String _formatTanggalIndonesia(DateTime date) {
  final namaHari = _pjNamaHari[date.weekday - 1]; // weekday: 1=Senin ... 7=Minggu
  final namaBulan = _pjNamaBulan[date.month - 1];
  return '$namaHari, ${date.day} $namaBulan ${date.year}';
}

/// Halaman "Pilih Jadwal" khusus untuk layanan Vitamin Booster.
/// Berbeda dari Perawatan Luka / Kunjungan Dokter, di sini tidak perlu
/// memilih dokter/perawat terlebih dahulu — user langsung memilih
/// jenis vitamin, tanggal, jam kunjungan, dan alamat.
class PilihJadwalVitaminScreen extends StatefulWidget {
  /// Jenis vitamin yang sudah dipilih dari halaman sebelumnya (opsional).
  final String? selectedVitamin;

  const PilihJadwalVitaminScreen({super.key, this.selectedVitamin});

  @override
  State<PilihJadwalVitaminScreen> createState() =>
      _PilihJadwalVitaminScreenState();
}

class _PilihJadwalVitaminScreenState extends State<PilihJadwalVitaminScreen> {
  static const List<String> _vitaminOptions = [
    'Vitamin C',
    'Vitamin D',
    'Multivitamin',
  ];

  static const List<String> _timeSlots = [
    '08:00 - 10:00',
    '10:00 - 12:00',
    '13:00 - 15:00',
    '15:00 - 17:00',
  ];

  final TextEditingController _addressController = TextEditingController();

  late String _selectedVitamin;
  DateTime? _selectedDate;
  String? _selectedTimeSlot;

  @override
  void initState() {
    super.initState();
    _selectedVitamin = widget.selectedVitamin ?? _vitaminOptions.first;
  }

  @override
  void dispose() {
    _addressController.dispose();
    super.dispose();
  }

  Future<void> _pickDate() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? now,
      firstDate: now,
      lastDate: now.add(const Duration(days: 60)),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(primary: _pjTeal),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(() => _selectedDate = picked);
    }
  }

  bool get _isFormValid =>
      _selectedDate != null &&
      _selectedTimeSlot != null &&
      _addressController.text.trim().isNotEmpty;

  void _confirmBooking() {
    if (!_isFormValid) return;

    final formattedDate = _formatTanggalIndonesia(_selectedDate!);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text('Booking Berhasil'),
        content: Text(
          'Jadwal $_selectedVitamin pada $formattedDate, '
          '$_selectedTimeSlot telah dikonfirmasi.',
          style: const TextStyle(fontSize: 13.5, height: 1.4),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // tutup dialog
              Navigator.of(context).pop(); // kembali dari halaman jadwal
            },
            child: const Text('Selesai'),
          ),
        ],
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
          icon: const Icon(Icons.arrow_back, color: _pjNavyDark, size: 22),
          onPressed: () => Navigator.maybePop(context),
        ),
        title: const Text(
          'Jadwal Vitamin Booster',
          style: TextStyle(
            color: _pjNavyDark,
            fontSize: 16,
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
                    _buildInfoBanner(),
                    const SizedBox(height: 20),
                    _buildSectionTitle('Jenis Vitamin'),
                    const SizedBox(height: 10),
                    _buildVitaminSelector(),
                    const SizedBox(height: 20),
                    _buildSectionTitle('Tanggal Kunjungan'),
                    const SizedBox(height: 10),
                    _buildDatePicker(),
                    const SizedBox(height: 20),
                    _buildSectionTitle('Jam Kunjungan'),
                    const SizedBox(height: 10),
                    _buildTimeSlotGrid(),
                    const SizedBox(height: 20),
                    _buildSectionTitle('Alamat'),
                    const SizedBox(height: 10),
                    _buildAddressField(),
                  ],
                ),
              ),
            ),
            _buildBookingButton(),
          ],
        ),
      ),
    );
  }

  // -------------------------------------------------------------------------
  // BANNER INFO
  // -------------------------------------------------------------------------

  Widget _buildInfoBanner() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: _pjInfoBg,
        borderRadius: BorderRadius.circular(14),
      ),
      child: const Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.info_outline_rounded, color: _pjTeal, size: 18),
          SizedBox(width: 10),
          Expanded(
            child: Text(
              'Petugas home care akan datang ke alamat Anda sesuai jadwal yang dipilih untuk pemberian vitamin booster.',
              style: TextStyle(fontSize: 12.5, color: _pjNavyDark, height: 1.4),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.w700,
        color: _pjNavyDark,
      ),
    );
  }

  // -------------------------------------------------------------------------
  // PILIH JENIS VITAMIN
  // -------------------------------------------------------------------------

  Widget _buildVitaminSelector() {
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: _vitaminOptions.map((vitamin) {
        final isSelected = vitamin == _selectedVitamin;
        return ChoiceChip(
          label: Text(vitamin),
          selected: isSelected,
          onSelected: (_) => setState(() => _selectedVitamin = vitamin),
          selectedColor: _pjTeal.withOpacity(0.15),
          backgroundColor: Colors.white,
          side: BorderSide(
            color: isSelected ? _pjTeal : _pjCardBorderColor,
          ),
          labelStyle: TextStyle(
            fontSize: 12.5,
            fontWeight: FontWeight.w600,
            color: isSelected ? _pjTeal : _pjNavyDark,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        );
      }).toList(),
    );
  }

  // -------------------------------------------------------------------------
  // PILIH TANGGAL
  // -------------------------------------------------------------------------

  Widget _buildDatePicker() {
    final label = _selectedDate == null
        ? 'Pilih tanggal kunjungan'
        : _formatTanggalIndonesia(_selectedDate!);

    return InkWell(
      onTap: _pickDate,
      borderRadius: BorderRadius.circular(14),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: _selectedDate == null ? _pjCardBorderColor : _pjTeal,
          ),
        ),
        child: Row(
          children: [
            Icon(
              Icons.calendar_today_rounded,
              size: 18,
              color: _selectedDate == null ? _pjTextGrey : _pjTeal,
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                label,
                style: TextStyle(
                  fontSize: 13,
                  color: _selectedDate == null ? _pjTextGrey : _pjNavyDark,
                  fontWeight:
                      _selectedDate == null ? FontWeight.w400 : FontWeight.w600,
                ),
              ),
            ),
            const Icon(Icons.chevron_right_rounded, color: _pjTextGrey),
          ],
        ),
      ),
    );
  }

  // -------------------------------------------------------------------------
  // PILIH JAM
  // -------------------------------------------------------------------------

  Widget _buildTimeSlotGrid() {
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: _timeSlots.map((slot) {
        final isSelected = slot == _selectedTimeSlot;
        return ChoiceChip(
          label: Text(slot),
          selected: isSelected,
          onSelected: (_) => setState(() => _selectedTimeSlot = slot),
          selectedColor: _pjTeal.withOpacity(0.15),
          backgroundColor: Colors.white,
          side: BorderSide(
            color: isSelected ? _pjTeal : _pjCardBorderColor,
          ),
          labelStyle: TextStyle(
            fontSize: 12.5,
            fontWeight: FontWeight.w600,
            color: isSelected ? _pjTeal : _pjNavyDark,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        );
      }).toList(),
    );
  }

  // -------------------------------------------------------------------------
  // ALAMAT
  // -------------------------------------------------------------------------

  Widget _buildAddressField() {
    return TextField(
      controller: _addressController,
      maxLines: 3,
      onChanged: (_) => setState(() {}),
      style: const TextStyle(fontSize: 13, color: _pjNavyDark),
      decoration: InputDecoration(
        hintText: 'Tuliskan alamat lengkap kunjungan...',
        hintStyle: const TextStyle(fontSize: 12.5, color: _pjTextGrey),
        filled: true,
        fillColor: const Color(0xFFF1F5F9),
        contentPadding: const EdgeInsets.all(14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  // -------------------------------------------------------------------------
  // TOMBOL KONFIRMASI
  // -------------------------------------------------------------------------

  Widget _buildBookingButton() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 16),
      child: SizedBox(
        width: double.infinity,
        height: 52,
        child: ElevatedButton(
          onPressed: _isFormValid ? _confirmBooking : null,
          style: ElevatedButton.styleFrom(
            backgroundColor: _pjTeal,
            disabledBackgroundColor: _pjTeal.withOpacity(0.4),
            foregroundColor: Colors.white,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(26),
            ),
          ),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.calendar_today_rounded, size: 16),
              SizedBox(width: 8),
              Text(
                'Konfirmasi Jadwal',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ),
      ),
    );
  }
}