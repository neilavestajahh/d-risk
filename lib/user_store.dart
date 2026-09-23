import 'package:shared_preferences/shared_preferences.dart';

/// Helper penyimpanan sederhana data user menggunakan SharedPreferences.
class UserStore {
  static const _keyEmail = 'user_email';
  static const _keyName = 'user_name';
  static const _keyPassword = 'user_password';

  // Key untuk auto-fill saat login (ingat email & password terakhir)
  static const _keyLastEmail = 'last_login_email';
  static const _keyLastPassword = 'last_login_password';

  /// Simpan data user saat berhasil registrasi.
  static Future<void> saveUser({
    required String name,
    required String email,
    required String password,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyEmail, _normalizeEmail(email));
    await prefs.setString(_keyName, name.trim());
    await prefs.setString(_keyPassword, password);
  }

  /// Cek login: email & password harus cocok dengan yang tersimpan.
  /// Return nama kalau berhasil, null kalau gagal (email tidak ditemukan
  /// atau password salah).
  static Future<String?> login(String email, String password) async {
    final prefs = await SharedPreferences.getInstance();
    final savedEmail = prefs.getString(_keyEmail);
    final savedName = prefs.getString(_keyName);
    final savedPassword = prefs.getString(_keyPassword);

    if (savedEmail != null &&
        savedName != null &&
        savedPassword != null &&
        savedEmail == _normalizeEmail(email) &&
        savedPassword == password) {
      return savedName;
    }
    return null;
  }

  /// Cek apakah ada user yang sudah pernah daftar di device ini.
  static Future<bool> hasRegisteredUser() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.containsKey(_keyEmail);
  }

  // ---------- Auto-save & auto-fill email/password terakhir ----------

  /// Simpan email & password terakhir yang berhasil dipakai login,
  /// supaya form login bisa auto-fill di kunjungan berikutnya.
  static Future<void> saveLastLogin(String email, String password) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyLastEmail, email.trim());
    await prefs.setString(_keyLastPassword, password);
  }

  /// Ambil email & password terakhir (untuk auto-fill form login).
  /// Return null kalau belum pernah ada yang login sebelumnya.
  static Future<Map<String, String>?> getLastLogin() async {
    final prefs = await SharedPreferences.getInstance();
    final email = prefs.getString(_keyLastEmail);
    final password = prefs.getString(_keyLastPassword);
    if (email != null && password != null) {
      return {'email': email, 'password': password};
    }
    return null;
  }

  static String _normalizeEmail(String email) => email.trim().toLowerCase();
}