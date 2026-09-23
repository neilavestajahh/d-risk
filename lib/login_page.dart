import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'home_page.dart';
import 'register_page.dart';
import 'user_store.dart';

/// Halaman Login D-risk (Diabetes Risk Screening)
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _isLoading = false;
  bool _obscurePassword = true;
  String? _errorMessage;

  static const Color primaryBlue = Color(0xFF1E6FE0);
  static const Color darkText = Color(0xFF1A2A44);
  static const Color grayLabel = Color(0xFF334155);
  static const Color graySubtext = Color(0xFF64748B);
  static const Color grayPlaceholder = Color(0xFF94A3B8);
  static const Color fieldBorderColor = Color(0xFFE2E8F0);

  @override
  void initState() {
    super.initState();
    _loadLastLogin();
  }

  /// Auto-fill email & password dari login terakhir yang berhasil.
  Future<void> _loadLastLogin() async {
    final last = await UserStore.getLastLogin();
    if (last != null && mounted) {
      setState(() {
        _emailController.text = last['email'] ?? '';
        _passwordController.text = last['password'] ?? '';
      });
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleLogin() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    final email = _emailController.text.trim();
    final password = _passwordController.text;

    await Future.delayed(const Duration(milliseconds: 800));
    final nama = await UserStore.login(email, password);

    if (!mounted) return;
    setState(() => _isLoading = false);

    if (nama == null) {
      setState(() {
        _errorMessage = 'Email atau password salah. Silakan coba lagi.';
      });
      return;
    }

    // Simpan email & password ini sebagai "login terakhir" untuk auto-fill
    await UserStore.saveLastLogin(email, password);

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Berhasil masuk sebagai $nama'),
        backgroundColor: primaryBlue,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (_) => HomePage(userName: nama),
      ),
      (route) => false,
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
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFE2F0FD),
              Color(0xFFEFF6FE),
              Colors.white,
              Colors.white,
            ],
            stops: [0.0, 0.22, 0.40, 1.0],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 48),
                  _buildHeaderSection(),
                  const SizedBox(height: 32),
                  _buildFormField(
                    label: 'Email',
                    child: TextFormField(
                      controller: _emailController,
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
                  const SizedBox(height: 18),
                  _buildFormField(
                    label: 'Password',
                    child: TextFormField(
                      controller: _passwordController,
                      obscureText: _obscurePassword,
                      style: _inputTextStyle(),
                      decoration: _inputDecoration(
                        hintText: 'Masukkan password Anda',
                        prefixIcon: Icons.lock_outline_rounded,
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscurePassword
                                ? Icons.visibility_off_outlined
                                : Icons.visibility_outlined,
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
                        final value = val ?? '';
                        if (value.isEmpty) {
                          return 'Password wajib diisi';
                        }
                        if (value.length < 6) {
                          return 'Password minimal 6 karakter';
                        }
                        return null;
                      },
                    ),
                  ),
                  if (_errorMessage != null) ...[
                    const SizedBox(height: 10),
                    Text(
                      _errorMessage!,
                      style: const TextStyle(
                        fontSize: 12.5,
                        color: Color(0xFFEF4444),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                  const SizedBox(height: 24),
                  _buildLoginButton(),
                  const SizedBox(height: 28),
                  _buildRegisterPrompt(),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeaderSection() {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Masuk',
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.w800,
            color: darkText,
            letterSpacing: -0.5,
          ),
        ),
        SizedBox(height: 8),
        Text(
          'Masukkan email dan password Anda untuk\nmelanjutkan skrining risiko diabetes',
          style: TextStyle(
            fontSize: 13,
            height: 1.45,
            color: graySubtext,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }

  Widget _buildFormField({required String label, required Widget child}) {
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

  TextStyle _inputTextStyle() {
    return const TextStyle(
      fontSize: 14.5,
      color: darkText,
      fontWeight: FontWeight.w500,
    );
  }

  InputDecoration _inputDecoration({
    required String hintText,
    IconData? prefixIcon,
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
      contentPadding:
          const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
      prefixIcon: prefixIcon != null
          ? Icon(prefixIcon, color: grayPlaceholder, size: 20)
          : null,
      suffixIcon: suffixIcon,
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: fieldBorderColor, width: 1.2),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: primaryBlue, width: 1.6),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Color(0xFFEF4444), width: 1.2),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Color(0xFFEF4444), width: 1.6),
      ),
      errorStyle: const TextStyle(fontSize: 11.5, color: Color(0xFFEF4444)),
    );
  }

  Widget _buildLoginButton() {
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
        onPressed: _isLoading ? null : _handleLogin,
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
                    'Masuk',
                    style: TextStyle(
                      fontSize: 15.5,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.3,
                    ),
                  ),
                  SizedBox(width: 8),
                  Icon(Icons.arrow_forward_rounded, size: 19, color: Colors.white),
                ],
              ),
      ),
    );
  }

  Widget _buildRegisterPrompt() {
    return Center(
      child: Text.rich(
        TextSpan(
          style: const TextStyle(fontSize: 13, color: graySubtext),
          children: [
            const TextSpan(text: 'Belum punya akun? '),
            TextSpan(
              text: 'Daftar di sini',
              style: const TextStyle(
                fontWeight: FontWeight.w700,
                color: primaryBlue,
              ),
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const RegisterPage()),
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