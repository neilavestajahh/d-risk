// Letakkan di: lib/bot_dokter.dart
//
// Bot konsultasi sederhana berbasis kata kunci, khusus topik DIABETES
// (deteksi risiko, gejala, gula darah, pola hidup). Tanpa internet & API key.
//
// Cara pakai di chat_konsultasi_screen.dart:
//
//   import 'bot_dokter.dart';
//   ...
//   final balasan = BotDokter.balas(teksPesanUser);

class _Aturan {
  final List<String> kataKunci;
  final String jawaban;
  const _Aturan(this.kataKunci, this.jawaban);
}

class BotDokter {
  static const String _pengingat =
      '\n\nCatatan: ini informasi umum, bukan diagnosis. Untuk kepastian, lakukan pemeriksaan gula darah di fasilitas kesehatan.';

  // URUTAN PENTING: aturan paling atas dicek lebih dulu.
  static const List<_Aturan> _aturan = [
    // ---- DARURAT ----
    _Aturan(
      ['pingsan', 'tidak sadar', 'kejang', 'napas bau buah', 'sesak napas', 'muntah terus', 'kesadaran menurun'],
      'Gejala yang kamu sebutkan bisa berbahaya, terutama pada penderita diabetes. '
          'Segera ke IGD atau hubungi layanan darurat terdekat, jangan menunggu. '
          'Kalau ada orang di dekatmu, minta ditemani.',
    ),

    // ---- GULA DARAH RENDAH ----
    _Aturan(
      ['gemetar', 'keringat dingin', 'lemas mendadak', 'hipoglikemia', 'gula rendah', 'gula darah turun', 'berdebar'],
      'Gejala seperti gemetar, keringat dingin, dan lemas mendadak bisa menandakan gula darah terlalu rendah. '
          'Kalau kamu sadar penuh, segera minum air gula atau teh manis (sekitar 3 sendok makan gula), '
          'lalu cek gula darah 15 menit kemudian. Kalau belum membaik atau sering terulang, segera periksa ke dokter.',
    ),

    // ---- HASIL / ANGKA GULA DARAH ----
    _Aturan(
      ['hba1c', 'gula puasa', 'gula darah puasa', 'gula sewaktu', 'hasil lab', 'hasil cek', 'angka gula', 'mg/dl', 'normal gula'],
      'Patokan umum kadar gula darah:\n'
          '- Puasa: normal di bawah 100 mg/dL, prediabetes 100-125, diabetes 126 atau lebih.\n'
          '- 2 jam setelah makan: normal di bawah 140, prediabetes 140-199, diabetes 200 atau lebih.\n'
          '- HbA1c: normal di bawah 5,7%, prediabetes 5,7-6,4%, diabetes 6,5% atau lebih.\n'
          'Berapa hasil yang kamu dapat? Kalau angkanya di atas normal, sebaiknya dikonfirmasi dokter.',
    ),
    _Aturan(
      ['gula darah tinggi', 'hiperglikemia', 'gula tinggi', 'gula naik'],
      'Gula darah tinggi biasanya ditandai sering haus, sering buang air kecil, dan cepat lelah. '
          'Perbanyak air putih, batasi makanan dan minuman manis, dan tetap aktif bergerak ringan. '
          'Kalau hasilnya terus tinggi atau kamu merasa tidak enak badan, segera konsultasi ke dokter.',
    ),

    // ---- GEJALA & DETEKSI ----
    _Aturan(
      ['gejala', 'ciri', 'tanda', 'sering haus', 'sering kencing', 'sering buang air', 'cepat lapar', 'berat badan turun', 'lemas', 'lelah', 'penglihatan', 'mata kabur', 'kesemutan', 'kebas', 'gatal'],
      'Gejala awal diabetes yang perlu diwaspadai: sering haus, sering buang air kecil (terutama malam hari), '
          'cepat lapar, berat badan turun tanpa sebab, mudah lelah, penglihatan kabur, kesemutan di tangan atau kaki, '
          'dan luka yang lama sembuh. Gejala mana yang kamu alami, dan sudah berapa lama?',
    ),
    _Aturan(
      ['risiko', 'faktor', 'keturunan', 'keluarga', 'genetik', 'obesitas', 'gemuk', 'bmi', 'usia', 'skrining', 'deteksi', 'cek diabetes', 'tes diabetes'],
      'Faktor risiko diabetes tipe 2 antara lain: berat badan berlebih atau lingkar perut besar, '
          'ada keluarga dengan diabetes, usia di atas 40 tahun, kurang olahraga, tekanan darah tinggi, '
          'serta riwayat diabetes saat hamil. Kamu bisa mengisi skrining risiko di aplikasi ini. '
          'Apakah ada faktor di atas yang sesuai dengan kondisimu?',
    ),
    _Aturan(
      ['prediabetes', 'pra diabetes', 'pradiabetes'],
      'Prediabetes berarti gula darah di atas normal tapi belum masuk kategori diabetes. '
          'Kabar baiknya, ini masih bisa dicegah menjadi diabetes dengan menurunkan berat badan bila berlebih, '
          'mengatur makan, dan rutin olahraga sekitar 150 menit per minggu. Cek ulang gula darah secara berkala ya.',
    ),
    _Aturan(
      ['tipe 1', 'tipe 2', 'jenis diabetes', 'beda diabetes', 'apa itu diabetes', 'diabetes itu', 'kencing manis', 'penyebab'],
      'Diabetes adalah kondisi kadar gula darah tinggi karena tubuh kurang atau tidak bisa memakai insulin dengan baik. '
          'Tipe 1 biasanya muncul sejak muda karena tubuh tidak memproduksi insulin. '
          'Tipe 2 paling umum, berkaitan dengan gaya hidup, berat badan, dan faktor keturunan. '
          'Ada yang ingin kamu ketahui lebih lanjut?',
    ),

    // ---- POLA HIDUP ----
    _Aturan(
      ['makan', 'diet', 'menu', 'nasi', 'karbohidrat', 'manis', 'gula pasir', 'buah', 'sayur', 'minum', 'teh manis', 'kopi', 'camilan', 'jajan'],
      'Prinsip makan untuk menjaga gula darah: pilih karbohidrat kompleks (nasi porsi secukupnya, gandum, umbi), '
          'perbanyak sayur dan protein, batasi minuman manis, sirup, dan camilan tinggi gula, '
          'serta makan teratur dengan porsi seimbang. Kalau mau, ceritakan pola makanmu sehari-hari.',
    ),
    _Aturan(
      ['olahraga', 'jalan', 'senam', 'latihan', 'aktivitas', 'gerak', 'lari'],
      'Olahraga membantu tubuh memakai gula darah dengan lebih baik. '
          'Targetnya sekitar 150 menit per minggu, misalnya jalan cepat 30 menit, 5 kali seminggu. '
          'Mulai bertahap sesuai kemampuan, dan bawa camilan atau air gula kalau kamu sudah didiagnosis diabetes.',
    ),
    _Aturan(
      ['berat badan', 'kurus', 'turun bb', 'menurunkan'],
      'Menurunkan berat badan 5-7% saja bisa menurunkan risiko diabetes secara bermakna. '
          'Caranya dengan mengatur porsi makan dan rutin bergerak, bukan diet ekstrem. Ada kebiasaan yang ingin kamu ubah lebih dulu?',
    ),
    _Aturan(
      ['tidur', 'stres', 'begadang', 'rokok', 'merokok'],
      'Tidur kurang, stres berkepanjangan, dan merokok bisa memperburuk kontrol gula darah. '
          'Usahakan tidur 7-8 jam, kelola stres dengan aktivitas yang kamu suka, dan hindari rokok.',
    ),

    // ---- KOMPLIKASI & PERAWATAN ----
    _Aturan(
      ['luka', 'kaki', 'borok', 'ulkus', 'bengkak', 'nanah', 'infeksi'],
      'Luka pada penderita diabetes perlu ekstra hati-hati karena lebih lambat sembuh dan mudah infeksi. '
          'Bersihkan dengan air bersih dan cairan steril, jaga tetap kering dan tertutup, periksa kaki setiap hari, '
          'dan jangan memakai alas kaki yang sempit. Kalau ada nanah, bau, kemerahan yang meluas, atau demam, segera ke dokter. '
          'Kamu juga bisa memesan layanan Perawatan Luka di menu Home Care.',
    ),
    _Aturan(
      ['obat', 'insulin', 'metformin', 'suntik', 'dosis'],
      'Untuk obat dan insulin, dosis dan jadwalnya harus sesuai resep dokter, jadi aku tidak bisa menyarankan mengubah atau menghentikannya. '
          'Kalau ada efek samping atau gula darah sulit terkontrol, sampaikan ke dokter yang menanganimu.',
    ),
    _Aturan(
      ['ginjal', 'jantung', 'komplikasi', 'stroke', 'hipertensi', 'tekanan darah', 'kolesterol'],
      'Gula darah yang lama tidak terkontrol bisa memengaruhi mata, ginjal, saraf, dan jantung. '
          'Karena itu penting rutin cek gula darah, tekanan darah, dan kolesterol, serta kontrol berkala ke dokter.',
    ),

    // ---- UMUM ----
    _Aturan(
      ['halo', 'hai', 'selamat pagi', 'selamat siang', 'selamat sore', 'selamat malam', 'permisi'],
      'Halo! Saya asisten konsultasi diabetes. Kamu bisa bertanya tentang gejala, risiko, kadar gula darah, '
          'pola makan, olahraga, atau perawatan luka. Apa yang ingin kamu tanyakan?',
    ),
    _Aturan(
      ['terima kasih', 'makasih', 'thanks', 'thank you'],
      'Sama-sama! Semoga sehat selalu. Jangan lupa cek gula darah secara berkala ya.',
    ),
  ];

  static String balas(String pesan) {
    final teks = pesan.toLowerCase();

    for (final aturan in _aturan) {
      if (aturan.kataKunci.any(teks.contains)) {
        return aturan.jawaban + _pengingat;
      }
    }

    return 'Terima kasih sudah bercerita. Aku fokus membantu seputar diabetes. '
        'Bisa dijelaskan lebih detail, misalnya gejala yang kamu rasakan, hasil cek gula darah, '
        'atau kebiasaan makan dan olahragamu?$_pengingat';
  }
}