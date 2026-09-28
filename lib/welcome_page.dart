import 'package:flutter/material.dart';
import 'home_page.dart'; // sesuaikan path/nama halaman tujuan setelah login
import 'register_page.dart';
import 'user_store.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  // GANTI DI SINI SAJA: path logo kamu (harus sama persis dengan nama file
  // di folder assets/images/, termasuk huruf besar/kecil dan ekstensinya).
  static const String _logoPath = 'assets/images/logo_drisk.png';

  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _obscurePassword = true;
  bool _ingatSaya = false;
  bool _isLoading = false;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _loadLastLogin();
  }

  /// Auto-fill email & password dari login terakhir yang berhasil (kalau ada).
  Future<void> _loadLastLogin() async {
    final last = await UserStore.getLastLogin();
    if (last != null && mounted) {
      setState(() {
        _emailController.text = last['email'] ?? '';
        _passwordController.text = last['password'] ?? '';
        _ingatSaya = true;
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
    if (!_formKey.currentState!.validate()) return;

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

    // Simpan email & password sebagai "login terakhir" hanya jika "Ingat saya" dicentang
    if (_ingatSaya) {
      await UserStore.saveLastLogin(email, password);
    }

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Berhasil masuk sebagai $nama'),
        backgroundColor: Theme.of(context).colorScheme.primary,
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

  void _handleGoogleSignIn() {
    // TODO: implementasikan Google Sign-In
  }

  void _handleForgotPassword() {
    // TODO: arahkan ke halaman lupa password
  }

  void _handleDaftar() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const RegisterPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFFE3F2FD), // biru muda
              Color(0xFFE8F5E9), // hijau muda
            ],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 24),

                  // ===== Logo & Judul =====
                  Center(
                    child: Column(
                      children: [
                        Container(
                          width: 130,
                          height: 130,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.08),
                                blurRadius: 12,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: ClipOval(
                            child: Padding(
                              padding: const EdgeInsets.all(6),
                              child: Image.asset(
                                _logoPath,
                                fit: BoxFit.contain,
                                errorBuilder: (context, error, stackTrace) {
                                  return Icon(
                                    Icons.favorite,
                                    size: 56,
                                    color: colorScheme.primary,
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'D-risk',
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: colorScheme.primary,
                          ),
                        ),
                        const SizedBox(height: 4),
                        const Text(
                          '(Diabetes Risk Screening)',
                          style: TextStyle(
                            fontSize: 13,
                            fontStyle: FontStyle.italic,
                            color: Colors.black54,
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'Kelola Diabetes, Hidup Lebih Sehat',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 13, color: Colors.black54),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 32),

                  // ===== Email =====
                  TextFormField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      hintText: 'Email atau nomor telepon',
                      prefixIcon: const Icon(Icons.email_outlined),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Email tidak boleh kosong';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 12),

                  // ===== Password =====
                  TextFormField(
                    controller: _passwordController,
                    obscureText: _obscurePassword,
                    decoration: InputDecoration(
                      hintText: 'Password',
                      prefixIcon: const Icon(Icons.lock_outline),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscurePassword
                              ? Icons.visibility_off_outlined
                              : Icons.visibility_outlined,
                        ),
                        onPressed: () {
                          setState(() => _obscurePassword = !_obscurePassword);
                        },
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Password tidak boleh kosong';
                      }
                      return null;
                    },
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

                  const SizedBox(height: 8),

                  // ===== Ingat saya & Lupa password =====
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          SizedBox(
                            height: 24,
                            width: 24,
                            child: Checkbox(
                              value: _ingatSaya,
                              onChanged: (value) {
                                setState(() => _ingatSaya = value ?? false);
                              },
                            ),
                          ),
                          const SizedBox(width: 4),
                          const Text('Ingat saya',
                              style: TextStyle(fontSize: 13)),
                        ],
                      ),
                      TextButton(
                        onPressed: _handleForgotPassword,
                        child: const Text('Lupa password?'),
                      ),
                    ],
                  ),

                  const SizedBox(height: 8),

                  // ===== Tombol Masuk =====
                  SizedBox(
                    height: 48,
                    child: ElevatedButton(
                      onPressed: _isLoading ? null : _handleLogin,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: colorScheme.primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: _isLoading
                          ? const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 2,
                              ),
                            )
                          : const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('Masuk',
                                    style: TextStyle(
                                        fontSize: 16, color: Colors.white)),
                                SizedBox(width: 8),
                                Icon(Icons.arrow_forward,
                                    size: 18, color: Colors.white),
                              ],
                            ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // ===== Divider "atau" =====
                  Row(
                    children: const [
                      Expanded(child: Divider()),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 12),
                        child: Text('atau',
                            style: TextStyle(color: Colors.black45)),
                      ),
                      Expanded(child: Divider()),
                    ],
                  ),

                  const SizedBox(height: 20),

                  // ===== Tombol Google =====
                  SizedBox(
                    height: 48,
                    child: OutlinedButton.icon(
                      onPressed: _handleGoogleSignIn,
                      style: OutlinedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        side: const BorderSide(color: Colors.black12),
                      ),
                      icon: Image.network(
                        'https://www.google.com/favicon.ico',
                        height: 18,
                        width: 18,
                        errorBuilder: (context, error, stackTrace) =>
                            const Icon(Icons.g_mobiledata, size: 22),
                      ),
                      label: const Text(
                        'Masuk dengan Google',
                        style: TextStyle(color: Colors.black87),
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),

                  // ===== Belum punya akun =====
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Belum punya akun? ',
                          style: TextStyle(fontSize: 13)),
                      GestureDetector(
                        onTap: _handleDaftar,
                        child: Text(
                          'Daftar sekarang',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                            color: colorScheme.primary,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}