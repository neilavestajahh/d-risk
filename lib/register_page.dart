import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'home_page.dart';
import 'login_page.dart';
import 'user_store.dart';

/// Halaman Registrasi Pengguna D-risk (Diabetes Risk Screening)
class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  // Warna sesuai spesifikasi desain
  static const Color primaryBlue = Color(0xFF1E6FE0);
  static const Color greenBadge = Color(0xFF4CAF50);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();

  // Form Controllers
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _contactController = TextEditingController();
  final TextEditingController _birthDateController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // State values
  DateTime? _selectedBirthDate;
  String? _selectedGender;
  bool _obscurePassword = true;
  bool _isLoading = false;

  // Warna sesuai spesifikasi desain
  static const Color primaryBlue = RegisterPage.primaryBlue;
  static const Color darkText = Color(0xFF1A2A44);
  static const Color grayLabel = Color(0xFF334155);
  static const Color graySubtext = Color(0xFF64748B);
  static const Color grayPlaceholder = Color(0xFF94A3B8);
  static const Color fieldBorderColor = Color(0xFFE2E8F0);

  @override
  void dispose() {
    _nameController.dispose();
    _contactController.dispose();
    _birthDateController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  /// Format tanggal Indonesia: dd MMMM yyyy
  String _formatDateIndonesian(DateTime date) {
    const months = [
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
    return '${date.day} ${months[date.month - 1]} ${date.year}';
  }

  /// Membuka dialog DatePicker untuk memilih tanggal lahir
  Future<void> _pickBirthDate() async {
    final now = DateTime.now();
    final initialDate = _selectedBirthDate ?? DateTime(2000, 1, 1);
    final picked = await showDatePicker(
      context: context,
      initialDate: initialDate.isAfter(now) ? now : initialDate,
      firstDate: DateTime(1920),
      lastDate: now,
      helpText: 'Pilih Tanggal Lahir',
      cancelText: 'Batal',
      confirmText: 'Pilih',
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: primaryBlue,
              onPrimary: Colors.white,
              onSurface: darkText,
            ),
            dialogTheme: const DialogThemeData(
              backgroundColor: Colors.white,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      setState(() {
        _selectedBirthDate = picked;
        _birthDateController.text = _formatDateIndonesian(picked);
      });
    }
  }

  /// Handler submit form registrasi
  Future<void> _handleRegister() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;

    setState(() => _isLoading = true);

    await Future.delayed(const Duration(milliseconds: 1200));
    if (!mounted) return;

    final nama = _nameController.text.trim();
    final email = _contactController.text.trim();
    // FIX: ambil juga password dari controller-nya
    final password = _passwordController.text;

    // Simpan nama, email & password ke penyimpanan lokal supaya nanti saat
    // Login (yang pakai email + password) bisa dicek kecocokannya, dan nama
    // yang benar bisa ditampilkan di Home.
    await UserStore.saveUser(name: nama, email: email, password: password);

    if (!mounted) return;
    setState(() => _isLoading = false);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Pendaftaran berhasil! Selamat datang, $nama'),
        backgroundColor: primaryBlue,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );

    // Masuk ke Beranda dan hapus seluruh stack login/register
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (_) => HomePage(userName: nama),
      ),
      (route) => false,
    );
  }

  /// Modal dialog sederhana untuk Syarat & Ketentuan dan Kebijakan Privasi
  void _showInfoDialog(String title, String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        title: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: darkText,
          ),
        ),
        content: Text(
          message,
          style: const TextStyle(
            fontSize: 13.5,
            color: graySubtext,
            height: 1.45,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(
              'Tutup',
              style: TextStyle(
                color: primaryBlue,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          // 2. Background gradient biru muda ke putih di bagian atas
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFE2F0FD), // Biru muda lembut
              Color(0xFFEFF6FE), // Transisi halus
              Colors.white,
              Colors.white,
            ],
            stops: [0.0, 0.22, 0.40, 1.0],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // 1. AppBar transparan dengan tombol back di pojok kiri atas
              _buildTopAppBar(),

              // Konten Form Scrollable
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // 3. Header: Teks "Daftar", subteks & ilustrasi dokter wanita
                        _buildHeaderSection(),

                        const SizedBox(height: 24),

                        // Form Fields
                        _buildFormField(
                          label: 'Nama Panggilan',
                          child: TextFormField(
                            controller: _nameController,
                            textCapitalization: TextCapitalization.words,
                            style: _inputTextStyle(),
                            decoration: _inputDecoration(
                              hintText: 'Masukkan nama panggilan Anda',
                              prefixIcon: Icons.person_outline_rounded,
                            ),
                            validator: (val) {
                              if (val == null || val.trim().isEmpty) {
                                return 'Nama panggilan wajib diisi';
                              }
                              return null;
                            },
                          ),
                        ),

                        const SizedBox(height: 16),

                        _buildFormField(
                          label: 'Email',
                          child: TextFormField(
                            controller: _contactController,
                            keyboardType: TextInputType.emailAddress,
                            style: _inputTextStyle(),
                            decoration: _inputDecoration(
                              hintText: 'Masukkan email Anda',
                              prefixIcon: Icons.mail_outline_rounded,
                            ),
                            validator: (val) {
                              final value = val?.trim() ?? '';
                              if (value.isEmpty) {
                                return 'Email wajib diisi';
                              }
                              final emailRegex =
                                  RegExp(r'^[\w.+-]+@[\w-]+\.[\w.-]+$');
                              if (!emailRegex.hasMatch(value)) {
                                return 'Masukkan email yang valid';
                              }
                              return null;
                            },
                          ),
                        ),

                        const SizedBox(height: 16),

                        _buildFormField(
                          label: 'Tanggal Lahir',
                          child: TextFormField(
                            controller: _birthDateController,
                            readOnly: true,
                            onTap: _pickBirthDate,
                            style: _inputTextStyle(),
                            decoration: _inputDecoration(
                              hintText: 'Pilih tanggal lahir',
                              prefixIcon: Icons.calendar_today_outlined,
                              suffixIcon: IconButton(
                                icon: const Icon(
                                  Icons.calendar_today_outlined,
                                  color: grayPlaceholder,
                                  size: 19,
                                ),
                                onPressed: _pickBirthDate,
                              ),
                            ),
                            validator: (val) {
                              if (val == null || val.trim().isEmpty) {
                                return 'Tanggal lahir wajib dipilih';
                              }
                              return null;
                            },
                          ),
                        ),

                        const SizedBox(height: 16),

                        _buildFormField(
                          label: 'Jenis Kelamin',
                          child: DropdownButtonFormField<String>(
                            initialValue: _selectedGender,
                            style: _inputTextStyle(),
                            dropdownColor: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            icon: const Icon(
                              Icons.keyboard_arrow_down_rounded,
                              color: grayPlaceholder,
                            ),
                            decoration: _inputDecoration(
                              hintText: 'Pilih jenis kelamin',
                              prefixWidget: const Padding(
                                padding: EdgeInsets.only(left: 12, right: 8),
                                child: GenderSymbolIcon(size: 20),
                              ),
                            ),
                            items: const [
                              DropdownMenuItem(
                                value: 'Laki-laki',
                                child: Text('Laki-laki'),
                              ),
                              DropdownMenuItem(
                                value: 'Perempuan',
                                child: Text('Perempuan'),
                              ),
                            ],
                            onChanged: (val) {
                              setState(() => _selectedGender = val);
                            },
                            validator: (val) {
                              if (val == null || val.isEmpty) {
                                return 'Jenis kelamin wajib dipilih';
                              }
                              return null;
                            },
                          ),
                        ),

                        const SizedBox(height: 16),

                        _buildFormField(
                          label: 'Password',
                          child: TextFormField(
                            controller: _passwordController,
                            obscureText: _obscurePassword,
                            style: _inputTextStyle(),
                            decoration: _inputDecoration(
                              hintText: 'Minimal 8 karakter',
                              prefixIcon: Icons.lock_outline_rounded,
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _obscurePassword
                                      ? Icons.visibility_outlined
                                      : Icons.visibility_off_outlined,
                                  color: grayPlaceholder,
                                  size: 20,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _obscurePassword = !_obscurePassword;
                                  });
                                },
                              ),
                            ),
                            validator: (val) {
                              if (val == null || val.isEmpty) {
                                return 'Password wajib diisi';
                              }
                              if (val.length < 8) {
                                return 'Minimal 8 karakter';
                              }
                              return null;
                            },
                          ),
                        ),

                        const SizedBox(height: 24),

                        // 5. Tombol "Daftar" full width, solid blue (#1E6FE0)
                        _buildRegisterButton(),

                        const SizedBox(height: 16),

                        // 6. Syarat & Ketentuan dan Kebijakan Privasi
                        _buildTermsAndPrivacy(),

                        const SizedBox(height: 28),

                        // 7. Footer: "Sudah punya akun? Masuk di sini"
                        _buildLoginPrompt(),

                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// 1. Baris AppBar atas transparan dengan tombol back panah kiri
  Widget _buildTopAppBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
      child: Row(
        children: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const LoginPage()),
              );
            },
            icon: const Icon(
              Icons.chevron_left_rounded,
              color: darkText,
              size: 32,
            ),
            tooltip: 'Kembali ke Login',
          ),
        ],
      ),
    );
  }

  /// 3. Header: Teks "Daftar", subteks & ilustrasi dokter wanita
  Widget _buildHeaderSection() {
    return const Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Teks Judul dan Subteks
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Daftar',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w800,
                  color: darkText,
                  letterSpacing: -0.5,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Buat akun untuk memulai\npemeriksaan risiko diabetes Anda',
                style: TextStyle(
                  fontSize: 13,
                  height: 1.45,
                  color: graySubtext,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),

        SizedBox(width: 8),

        // Ilustrasi dokter wanita berjas putih + badge lingkaran hijau
        Flexible(
          child: DoctorHeaderIllustration(
            width: 125,
            height: 105,
          ),
        ),
      ],
    );
  }

  /// Wrapper untuk Label di atas TextField
  Widget _buildFormField({
    required String label,
    required Widget child,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 13.5,
            fontWeight: FontWeight.w600,
            color: grayLabel,
          ),
        ),
        const SizedBox(height: 7),
        child,
      ],
    );
  }

  /// Gaya input text
  TextStyle _inputTextStyle() {
    return const TextStyle(
      fontSize: 14.5,
      color: darkText,
      fontWeight: FontWeight.w500,
    );
  }

  /// Dekorasi seragam untuk TextField & Dropdown
  InputDecoration _inputDecoration({
    required String hintText,
    IconData? prefixIcon,
    Widget? prefixWidget,
    Widget? suffixIcon,
  }) {
    return InputDecoration(
      filled: true,
      fillColor: Colors.white,
      hintText: hintText,
      hintStyle: const TextStyle(
        fontSize: 13.5,
        color: grayPlaceholder,
        fontWeight: FontWeight.w400,
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
      prefixIcon: prefixWidget ??
          (prefixIcon != null
              ? Icon(
                  prefixIcon,
                  color: grayPlaceholder,
                  size: 20,
                )
              : null),
      suffixIcon: suffixIcon,
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(
          color: fieldBorderColor,
          width: 1.2,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(
          color: primaryBlue,
          width: 1.6,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(
          color: Color(0xFFEF4444),
          width: 1.2,
        ),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(
          color: Color(0xFFEF4444),
          width: 1.6,
        ),
      ),
      errorStyle: const TextStyle(
        fontSize: 11.5,
        color: Color(0xFFEF4444),
      ),
    );
  }

  /// 5. Tombol "Daftar" full width, solid blue (#1E6FE0)
  Widget _buildRegisterButton() {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: primaryBlue.withValues(alpha: 0.35),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: _isLoading ? null : _handleRegister,
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryBlue,
          foregroundColor: Colors.white,
          disabledBackgroundColor: primaryBlue.withValues(alpha: 0.65),
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: _isLoading
            ? const SizedBox(
                width: 22,
                height: 22,
                child: CircularProgressIndicator(
                  strokeWidth: 2.4,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              )
            : const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Daftar',
                    style: TextStyle(
                      fontSize: 15.5,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.3,
                    ),
                  ),
                  SizedBox(width: 8),
                  Icon(
                    Icons.arrow_forward_rounded,
                    size: 19,
                    color: Colors.white,
                  ),
                ],
              ),
      ),
    );
  }

  /// 6. Teks kecil Syarat & Ketentuan dan Kebijakan Privasi
  Widget _buildTermsAndPrivacy() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          style: const TextStyle(
            fontSize: 11.5,
            color: graySubtext,
            height: 1.45,
          ),
          children: [
            const TextSpan(text: 'Dengan mendaftar, Anda setuju dengan '),
            TextSpan(
              text: 'Syarat &\nKetentuan',
              style: const TextStyle(
                color: primaryBlue,
                fontWeight: FontWeight.w600,
              ),
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  _showInfoDialog(
                    'Syarat & Ketentuan',
                    'Dengan menggunakan aplikasi D-risk, Anda menyetujui pemrosesan data skrining risiko diabetes secara aman sesuai ketentuan operasional medis dan privasi.',
                  );
                },
            ),
            const TextSpan(text: ' dan '),
            TextSpan(
              text: 'Kebijakan Privasi',
              style: const TextStyle(
                color: primaryBlue,
                fontWeight: FontWeight.w600,
              ),
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  _showInfoDialog(
                    'Kebijakan Privasi',
                    'Data profil dan hasil pemeriksaan kesehatan Anda dilindungi dan dienkripsi untuk privasi keamanan akun pengguna D-risk.',
                  );
                },
            ),
          ],
        ),
      ),
    );
  }

  /// 7. Link "Sudah punya akun? Masuk di sini"
  Widget _buildLoginPrompt() {
    return Center(
      child: Text.rich(
        TextSpan(
          style: const TextStyle(
            fontSize: 13,
            color: graySubtext,
          ),
          children: [
            const TextSpan(text: 'Sudah punya akun? '),
            TextSpan(
              text: 'Masuk di sini',
              style: const TextStyle(
                fontWeight: FontWeight.w700,
                color: primaryBlue,
              ),
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const LoginPage()),
                  );
                },
            ),
          ],
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}

// ============================================================================
// WIDGET IKON SIMBOL GENDER (Custom Vector)
// ============================================================================

class GenderSymbolIcon extends StatelessWidget {
  final double size;

  const GenderSymbolIcon({
    super.key,
    this.size = 20,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: CustomPaint(
        painter: _GenderSymbolPainter(),
      ),
    );
  }
}

class _GenderSymbolPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final scale = size.width / 24.0;
    canvas.save();
    canvas.scale(scale, scale);

    final strokePaint = Paint()
      ..color = const Color(0xFF94A3B8)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    // Lingkaran tengah
    canvas.drawCircle(const Offset(10.5, 13.5), 5.5, strokePaint);

    // Panah Male (kanan atas)
    canvas.drawLine(const Offset(14.5, 9.5), const Offset(19.5, 4.5), strokePaint);
    canvas.drawLine(const Offset(15.5, 4.5), const Offset(19.5, 4.5), strokePaint);
    canvas.drawLine(const Offset(19.5, 4.5), const Offset(19.5, 8.5), strokePaint);

    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// ============================================================================
// WIDGET ILUSTRASI DOKTER WANITA + BADGE HATI HIJAU
// ============================================================================

class DoctorHeaderIllustration extends StatelessWidget {
  final double width;
  final double height;
  final Color badgeColor;

  const DoctorHeaderIllustration({
    super.key,
    this.width = 125,
    this.height = 105,
    this.badgeColor = RegisterPage.greenBadge,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: CustomPaint(
        painter: _DoctorHeaderIllustrationPainter(badgeColor: badgeColor),
      ),
    );
  }
}

class _DoctorHeaderIllustrationPainter extends CustomPainter {
  final Color badgeColor;

  const _DoctorHeaderIllustrationPainter({
    required this.badgeColor,
  });
  @override
  void paint(Canvas canvas, Size size) {
    // Normalisasi skala ke referensi koordinat 125 x 105
    canvas.save();
    canvas.scale(size.width / 125.0, size.height / 105.0);

    const brownHair = Color(0xFFA86641);
    const skinTone = Color(0xFFFFDFC5);
    const blushPink = Color(0xFFFFAAA7);
    const mouthRed = Color(0xFFE54D4D);
    const cyanScrub = Color(0xFF00B4D8);
    const magentaLiquid = Color(0xFFF43F5E);
    const outlineGray = Color(0xFFCBD5E1);

    // -------------------------------------------------------------
    // 1. BADGE HIJAU DENGAN IKON HATI PUTIH (di kiri atas kepala)
    // -------------------------------------------------------------
    const badgeCenter = Offset(24, 22);
    const badgeRadius = 13.0;

    // Subtle shadow
    final badgeShadow = Paint()
      ..color = badgeColor.withValues(alpha: 0.35)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 4.0);
    canvas.drawCircle(badgeCenter.translate(0, 2), badgeRadius, badgeShadow);

    // Green badge circle
    final badgePaint = Paint()..color = badgeColor;
    canvas.drawCircle(badgeCenter, badgeRadius, badgePaint);

    // White heart shape inside badge
    final heartPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;
    final heartPath = Path();
    heartPath.moveTo(24, 26.5);
    heartPath.cubicTo(19.8, 23.2, 17.5, 20.0, 17.5, 18.2);
    heartPath.cubicTo(17.5, 16.2, 19.2, 14.8, 21.0, 14.8);
    heartPath.cubicTo(22.4, 14.8, 23.4, 15.6, 24, 16.7);
    heartPath.cubicTo(24.6, 15.6, 25.6, 14.8, 27.0, 14.8);
    heartPath.cubicTo(28.8, 14.8, 30.5, 16.2, 30.5, 18.2);
    heartPath.cubicTo(30.5, 20.0, 28.2, 23.2, 24, 26.5);
    canvas.drawPath(heartPath, heartPaint);

    // -------------------------------------------------------------
    // 2. TETESAN CAIRAN PINK DI ATAS ALAT (Droplets)
    // -------------------------------------------------------------
    final dropPaint = Paint()..color = magentaLiquid;

    // Tetesan 1 (dekat jarum)
    canvas.save();
    canvas.translate(101, 30);
    canvas.rotate(-0.4);
    canvas.drawOval(const Rect.fromLTWH(-2.2, -4, 4.4, 8), dropPaint);
    canvas.restore();

    // Tetesan 2 (sedikit ke kanan atas)
    canvas.save();
    canvas.translate(112, 32);
    canvas.rotate(0.35);
    canvas.drawOval(const Rect.fromLTWH(-1.8, -3.2, 3.6, 6.4), dropPaint);
    canvas.restore();

    // -------------------------------------------------------------
    // 3. RAMBUT BELAKANG (Bob hair)
    // -------------------------------------------------------------
    final hairPaint = Paint()..color = brownHair;
    final hairBackRect = RRect.fromRectAndRadius(
      const Rect.fromLTWH(50, 24, 46, 52),
      const Radius.circular(23),
    );
    canvas.drawRRect(hairBackRect, hairPaint);

    // -------------------------------------------------------------
    // 4. LEHER & KERAH V-NECK BIRU CYAN
    // -------------------------------------------------------------
    final skinPaint = Paint()..color = skinTone;
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        const Rect.fromLTWH(67, 58, 12, 16),
        const Radius.circular(4),
      ),
      skinPaint,
    );

    // Bayangan di leher
    final neckShadowPaint = Paint()..color = const Color(0xFFEDBCA0);
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        const Rect.fromLTWH(67, 58, 12, 4.5),
        const Radius.circular(2),
      ),
      neckShadowPaint,
    );

    // Baju dalam cyan
    final scrubPaint = Paint()..color = cyanScrub;
    final scrubPath = Path()
      ..moveTo(63, 68)
      ..lineTo(83, 68)
      ..lineTo(73, 81)
      ..close();
    canvas.drawPath(scrubPath, scrubPaint);

    // -------------------------------------------------------------
    // 5. JAS DOKTER PUTIH (Lab Coat)
    // -------------------------------------------------------------
    final coatPaint = Paint()..color = Colors.white;
    final coatStroke = Paint()
      ..color = outlineGray
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.4
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    // Badan jas putih
    final coatPath = Path()
      ..moveTo(47, 105)
      ..lineTo(47, 85)
      ..cubicTo(47, 73, 56, 68, 64, 68)
      ..lineTo(82, 68)
      ..cubicTo(90, 68, 98, 73, 98, 85)
      ..lineTo(98, 105)
      ..close();
    canvas.drawPath(coatPath, coatPaint);
    canvas.drawPath(coatPath, coatStroke);

    // Kerah/Lapel Jas Kiri
    final lapelLeft = Path()
      ..moveTo(64, 68)
      ..lineTo(56, 80)
      ..lineTo(68, 83)
      ..lineTo(69, 105);
    canvas.drawPath(lapelLeft, coatStroke);

    // Kerah/Lapel Jas Kanan
    final lapelRight = Path()
      ..moveTo(82, 68)
      ..lineTo(90, 80)
      ..lineTo(78, 83)
      ..lineTo(77, 105);
    canvas.drawPath(lapelRight, coatStroke);

    // -------------------------------------------------------------
    // 6. WAJAH (Skin)
    // -------------------------------------------------------------
    final facePath = Path()
      ..moveTo(57, 44)
      ..cubicTo(57, 30, 89, 30, 89, 44)
      ..cubicTo(89, 61, 84, 67, 73, 67)
      ..cubicTo(62, 67, 57, 61, 57, 44)
      ..close();
    canvas.drawPath(facePath, skinPaint);

    // -------------------------------------------------------------
    // 7. PONI & RAMBUT DEPAN (Hair Front & Bangs)
    // -------------------------------------------------------------
    final bangsPath = Path()
      ..moveTo(50, 46)
      ..cubicTo(50, 24, 96, 24, 96, 46)
      ..lineTo(96, 58)
      ..cubicTo(96, 62, 92, 61, 90, 55)
      ..lineTo(89, 43)
      // Lekukan poni di dahi
      ..cubicTo(84, 46, 79, 44, 75, 41)
      ..cubicTo(71, 44, 64, 46, 57, 43)
      ..lineTo(56, 55)
      ..cubicTo(54, 61, 50, 62, 50, 58)
      ..close();
    canvas.drawPath(bangsPath, hairPaint);

    // -------------------------------------------------------------
    // 8. MATA, ALIS, BLUSH, DAN SENYUM
    // -------------------------------------------------------------
    // Mata
    final eyePaint = Paint()
      ..color = const Color(0xFF261914)
      ..style = PaintingStyle.fill;
    canvas.drawCircle(const Offset(65.5, 48), 2.7, eyePaint);
    canvas.drawCircle(const Offset(80.5, 48), 2.7, eyePaint);

    // Kilau mata putih
    final eyeShine = Paint()..color = Colors.white;
    canvas.drawCircle(const Offset(64.7, 47.2), 1.0, eyeShine);
    canvas.drawCircle(const Offset(79.7, 47.2), 1.0, eyeShine);

    // Pipi merona (Blush)
    final blushPaint = Paint()..color = blushPink;
    canvas.drawOval(const Rect.fromLTWH(60, 51.5, 6.5, 4), blushPaint);
    canvas.drawOval(const Rect.fromLTWH(79.5, 51.5, 6.5, 4), blushPaint);

    // Mulut tersenyum ceria
    final mouthPaint = Paint()..color = mouthRed;
    final mouthPath = Path()
      ..moveTo(69, 54)
      ..quadraticBezierTo(73, 61.5, 77, 54)
      ..close();
    canvas.drawPath(mouthPath, mouthPaint);

    // Gigi putih kecil di senyum
    final teethPaint = Paint()..color = Colors.white;
    final teethPath = Path()
      ..moveTo(70, 54)
      ..lineTo(76, 54)
      ..lineTo(75.2, 55.5)
      ..lineTo(70.8, 55.5)
      ..close();
    canvas.drawPath(teethPath, teethPaint);

    // -------------------------------------------------------------
    // 9. TANGAN MEMEGANG ALAT / JARUM MEDIS (Syringe / Tool)
    // -------------------------------------------------------------
    // Badan suntikan / alat medis
    final syringePaint = Paint()..color = const Color(0xFFF1F5F9);
    final syringeStroke = Paint()
      ..color = outlineGray
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.2;

    final toolRect = RRect.fromRectAndRadius(
      const Rect.fromLTWH(95, 48, 7.5, 26),
      const Radius.circular(2.5),
    );
    canvas.drawRRect(toolRect, syringePaint);
    canvas.drawRRect(toolRect, syringeStroke);

    // Cairan magenta / pink di dalam alat
    final liquidPaint = Paint()..color = magentaLiquid;
    final liquidRect = RRect.fromRectAndRadius(
      const Rect.fromLTWH(95.5, 55, 6.5, 18.5),
      const Radius.circular(1.5),
    );
    canvas.drawRRect(liquidRect, liquidPaint);

    // Jarum tipis perak di ujung atas alat
    final needlePaint = Paint()
      ..color = const Color(0xFF94A3B8)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5
      ..strokeCap = StrokeCap.round;
    canvas.drawLine(const Offset(98.75, 48), const Offset(98.75, 38), needlePaint);

    // Garis ukur alat (tick marks)
    final markPaint = Paint()
      ..color = Colors.white.withValues(alpha: 0.85)
      ..strokeWidth = 1.0;
    canvas.drawLine(const Offset(96.5, 58), const Offset(98.5, 58), markPaint);
    canvas.drawLine(const Offset(96.5, 62), const Offset(98.5, 62), markPaint);
    canvas.drawLine(const Offset(96.5, 66), const Offset(98.5, 66), markPaint);

    // Tangan dokter memegang alat
    final handPaint = Paint()..color = skinTone;
    final handStroke = Paint()
      ..color = outlineGray
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.1;

    // Jemari melingkar di alat
    final handPath = Path()
      ..moveTo(93, 62)
      ..cubicTo(91, 62, 90, 72, 94, 76)
      ..lineTo(102, 76)
      ..cubicTo(106, 75, 105, 66, 100, 65)
      ..lineTo(98, 62)
      ..close();
    canvas.drawPath(handPath, handPaint);
    canvas.drawPath(handPath, handStroke);

    // Lengan jas putih terhubung ke tangan
    final sleevePath = Path()
      ..moveTo(93, 76)
      ..lineTo(90, 88)
      ..lineTo(102, 88)
      ..lineTo(102, 76)
      ..close();
    canvas.drawPath(sleevePath, coatPaint);
    canvas.drawPath(sleevePath, coatStroke);

    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}