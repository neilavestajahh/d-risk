import 'package:flutter/material.dart';

import 'konfirmasi_booking_screen.dart';

const Color _dpPrimaryBlue = Color(0xFF1E6FE0);
const Color _dpTeal = Color(0xFF17A2B8);
const Color _dpNavyDark = Color(0xFF1B2A4A);
const Color _dpTextGrey = Color(0xFF7A8B9E);
const Color _dpFieldFillColor = Color(0xFFF1F5F9);
const Color _dpCardBorderColor = Color(0xFFE2E8F0);
const Color _dpLightBlueBg = Color(0xFFE8F1FD);

enum _JenisKelamin { perempuan, lakiLaki }

class DataPasienResult {
  final String namaLengkap;
  final DateTime? tanggalLahir;
  final String jenisKelamin;
  final String nomorTelepon;
  final String keluhan;

  const DataPasienResult({
    required this.namaLengkap,
    required this.tanggalLahir,
    required this.jenisKelamin,
    required this.nomorTelepon,
    required this.keluhan,
  });
}

class DataPasienScreen extends StatefulWidget {
  final String? initialNama;
  final String? initialNoRM;
  final DateTime? initialTanggalLahir;
  final String? initialNomorTelepon;
  final int currentStep;
  final int totalSteps;

  final String? doctorName;
  final String? doctorSpecialty;
  final double? doctorRating;
  final int? doctorReviewCount;
  final String? imageSeed;
  final String? jadwalTanggal;
  final String? jadwalJamMulai;
  final String? jadwalJamSelesai;
  final int? totalBiaya;

  final void Function(DataPasienResult result)? onContinue;

  const DataPasienScreen({
    super.key,
    this.initialNama,
    this.initialNoRM,
    this.initialTanggalLahir,
    this.initialNomorTelepon,
    this.currentStep = 1,
    this.totalSteps = 4,
    this.doctorName,
    this.doctorSpecialty,
    this.doctorRating,
    this.doctorReviewCount,
    this.imageSeed,
    this.jadwalTanggal,
    this.jadwalJamMulai,
    this.jadwalJamSelesai,
    this.totalBiaya,
    this.onContinue,
  });

  bool get _hasBookingSummaryData =>
      doctorName != null &&
      doctorSpecialty != null &&
      doctorRating != null &&
      doctorReviewCount != null &&
      imageSeed != null &&
      jadwalTanggal != null &&
      jadwalJamMulai != null &&
      jadwalJamSelesai != null &&
      totalBiaya != null;

  @override
  State<DataPasienScreen> createState() => _DataPasienScreenState();
}

class _DataPasienScreenState extends State<DataPasienScreen> {
  late final TextEditingController _namaController;
  late final TextEditingController _teleponController;
  final TextEditingController _keluhanController = TextEditingController();

  DateTime? _tanggalLahir;
  _JenisKelamin _jenisKelamin = _JenisKelamin.perempuan;

  static const int _keluhanMaxLength = 500;

  @override
  void initState() {
    super.initState();
    _namaController = TextEditingController(text: widget.initialNama ?? '');
    _teleponController =
        TextEditingController(text: widget.initialNomorTelepon ?? '');
    _tanggalLahir = widget.initialTanggalLahir;
    _keluhanController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _namaController.dispose();
    _teleponController.dispose();
    _keluhanController.dispose();
    super.dispose();
  }

  String _formatTanggal(DateTime date) {
    final dd = date.day.toString().padLeft(2, '0');
    final mm = date.month.toString().padLeft(2, '0');
    final yyyy = date.year.toString();
    return '$dd-$mm-$yyyy';
  }

  Future<void> _pickTanggalLahir() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: _tanggalLahir ?? DateTime(now.year - 20),
      firstDate: DateTime(1900),
      lastDate: now,
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(primary: _dpPrimaryBlue),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(() => _tanggalLahir = picked);
    }
  }

  bool get _isFormValid =>
      _namaController.text.trim().isNotEmpty &&
      _tanggalLahir != null &&
      _teleponController.text.trim().isNotEmpty;

  void _handleLanjutkan() {
    if (!_isFormValid) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Lengkapi data pasien terlebih dahulu'),
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    final result = DataPasienResult(
      namaLengkap: _namaController.text.trim(),
      tanggalLahir: _tanggalLahir,
      jenisKelamin:
          _jenisKelamin == _JenisKelamin.perempuan ? 'Perempuan' : 'Laki-laki',
      nomorTelepon: _teleponController.text.trim(),
      keluhan: _keluhanController.text.trim(),
    );

    if (widget.onContinue != null) {
      widget.onContinue!(result);
      return;
    }

    if (widget._hasBookingSummaryData) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => KonfirmasiBookingScreen(
            doctorName: widget.doctorName!,
            doctorSpecialty: widget.doctorSpecialty!,
            doctorRating: widget.doctorRating!,
            doctorReviewCount: widget.doctorReviewCount!,
            imageSeed: widget.imageSeed!,
            tanggal: widget.jadwalTanggal!,
            jamMulai: widget.jadwalJamMulai!,
            jamSelesai: widget.jadwalJamSelesai!,
            pasienNama: result.namaLengkap,
            pasienNoRM: widget.initialNoRM ?? '-',
            keluhan: result.keluhan,
            totalBiaya: widget.totalBiaya!,
          ),
        ),
      );
      return;
    }

    Navigator.of(context).pop(result);
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
          icon: const Icon(Icons.arrow_back, color: _dpNavyDark, size: 22),
          onPressed: () => Navigator.maybePop(context),
        ),
        title: const Text(
          'Data Pasien',
          style: TextStyle(
            color: _dpNavyDark,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SafeArea(
        top: false,
        child: Column(
          children: [
            _buildStepIndicator(),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildPatientCard(),
                    const SizedBox(height: 20),
                    _buildLabel('Nama Lengkap'),
                    const SizedBox(height: 8),
                    _buildTextField(
                      controller: _namaController,
                      hint: 'Masukkan nama lengkap',
                    ),
                    const SizedBox(height: 16),
                    _buildLabel('Tanggal Lahir'),
                    const SizedBox(height: 8),
                    _buildTanggalLahirField(),
                    const SizedBox(height: 16),
                    _buildLabel('Jenis Kelamin'),
                    const SizedBox(height: 8),
                    _buildJenisKelaminSelector(),
                    const SizedBox(height: 16),
                    _buildLabel('Nomor Telepon'),
                    const SizedBox(height: 8),
                    _buildTextField(
                      controller: _teleponController,
                      hint: '0812 3456 7890',
                      icon: Icons.phone_outlined,
                      keyboardType: TextInputType.phone,
                    ),
                    const SizedBox(height: 16),
                    _buildLabel('Keluhan / Alasan Kunjungan'),
                    const SizedBox(height: 8),
                    _buildKeluhanField(),
                  ],
                ),
              ),
            ),
            _buildLanjutkanButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildStepIndicator() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 4, 20, 12),
      child: Row(
        children: List.generate(widget.totalSteps * 2 - 1, (i) {
          if (i.isEven) {
            final stepIndex = i ~/ 2;
            final isDone = stepIndex < widget.currentStep;
            final isCurrent = stepIndex == widget.currentStep;
            final active = isDone || isCurrent;
            return Container(
              width: 10,
              height: 10,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: active ? _dpPrimaryBlue : const Color(0xFFE2E8F0),
              ),
            );
          } else {
            final lineIndex = i ~/ 2;
            final isDone = lineIndex < widget.currentStep;
            return Expanded(
              child: Container(
                height: 2,
                margin: const EdgeInsets.symmetric(horizontal: 4),
                color: isDone ? _dpPrimaryBlue : const Color(0xFFE2E8F0),
              ),
            );
          }
        }),
      ),
    );
  }

  Widget _buildPatientCard() {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: _dpLightBlueBg,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.person, color: _dpPrimaryBlue, size: 22),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.initialNama ?? _namaController.text,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: _dpNavyDark,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  'No. RM: ${widget.initialNoRM ?? '-'}',
                  style: const TextStyle(fontSize: 11.5, color: _dpTextGrey),
                ),
              ],
            ),
          ),
          OutlinedButton(
            onPressed: () {
              // TODO: navigasi ke halaman ubah data pasien tersimpan.
            },
            style: OutlinedButton.styleFrom(
              foregroundColor: _dpPrimaryBlue,
              side: const BorderSide(color: _dpPrimaryBlue),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
            ),
            child: const Text(
              'Ubah',
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.w600,
        color: _dpNavyDark,
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hint,
    IconData? icon,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: _dpFieldFillColor,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: _dpCardBorderColor),
      ),
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        onChanged: (_) => setState(() {}),
        style: const TextStyle(fontSize: 13, color: _dpNavyDark),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: const TextStyle(fontSize: 12.5, color: _dpTextGrey),
          prefixIcon: icon == null
              ? null
              : Icon(icon, size: 18, color: _dpTextGrey),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 14,
            vertical: 14,
          ),
        ),
      ),
    );
  }

  Widget _buildTanggalLahirField() {
    final label = _tanggalLahir == null
        ? 'Pilih tanggal lahir'
        : _formatTanggal(_tanggalLahir!);

    return InkWell(
      onTap: _pickTanggalLahir,
      borderRadius: BorderRadius.circular(14),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
        decoration: BoxDecoration(
          color: _dpFieldFillColor,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: _dpCardBorderColor),
        ),
        child: Row(
          children: [
            const Icon(Icons.calendar_today_outlined,
                size: 17, color: _dpTextGrey),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                label,
                style: TextStyle(
                  fontSize: 13,
                  color: _tanggalLahir == null ? _dpTextGrey : _dpNavyDark,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildJenisKelaminSelector() {
    return Row(
      children: [
        Expanded(
          child: _buildJenisKelaminOption(
            label: 'Perempuan',
            icon: Icons.female_rounded,
            value: _JenisKelamin.perempuan,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildJenisKelaminOption(
            label: 'Laki-laki',
            icon: Icons.male_rounded,
            value: _JenisKelamin.lakiLaki,
          ),
        ),
      ],
    );
  }

  Widget _buildJenisKelaminOption({
    required String label,
    required IconData icon,
    required _JenisKelamin value,
  }) {
    final isSelected = _jenisKelamin == value;

    return InkWell(
      onTap: () => setState(() => _jenisKelamin = value),
      borderRadius: BorderRadius.circular(14),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 13),
        decoration: BoxDecoration(
          color: isSelected ? _dpPrimaryBlue : Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: isSelected ? _dpPrimaryBlue : _dpCardBorderColor,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 18,
              color: isSelected ? Colors.white : _dpTextGrey,
            ),
            const SizedBox(width: 6),
            Text(
              label,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: isSelected ? Colors.white : _dpNavyDark,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildKeluhanField() {
    final length = _keluhanController.text.length;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Container(
          decoration: BoxDecoration(
            color: _dpFieldFillColor,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: _dpCardBorderColor),
          ),
          child: TextField(
            controller: _keluhanController,
            maxLines: 4,
            maxLength: _keluhanMaxLength,
            style: const TextStyle(fontSize: 13, color: _dpNavyDark),
            decoration: const InputDecoration(
              hintText: 'Jelaskan keluhan atau tujuan kunjungan...',
              hintStyle: TextStyle(fontSize: 12.5, color: _dpTextGrey),
              border: InputBorder.none,
              contentPadding: EdgeInsets.all(14),
              counterText: '',
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 4, right: 4),
          child: Text(
            '$length/$_keluhanMaxLength',
            style: const TextStyle(fontSize: 11, color: _dpTextGrey),
          ),
        ),
      ],
    );
  }

  Widget _buildLanjutkanButton() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 16),
      child: SizedBox(
        width: double.infinity,
        height: 52,
        child: ElevatedButton(
          onPressed: _handleLanjutkan,
          style: ElevatedButton.styleFrom(
            backgroundColor: _dpTeal,
            foregroundColor: Colors.white,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(26),
            ),
          ),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Lanjutkan',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
              ),
              SizedBox(width: 8),
              Icon(Icons.arrow_forward, size: 16),
            ],
          ),
        ),
      ),
    );
  }
}