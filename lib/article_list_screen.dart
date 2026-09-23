import 'package:flutter/material.dart';

// ---------------------------------------------------------------------------
// COLORS
// ---------------------------------------------------------------------------
class ArticleColors {
  static const blue = Color(0xFF2F6BFF);
  static const blueLight = Color(0xFFEAF0FF);
  static const ink = Color(0xFF101828);
  static const sub = Color(0xFF667085);
  static const line = Color(0xFFEEF0F4);
  static const bg = Color(0xFFF7F8FA);
  static const green = Color(0xFF12B76A);
  static const cyan = Color(0xFF0BA5D9);
  static const orange = Color(0xFFFF9F43);
  static const orangeSoft = Color(0xFFFFF1E6);
}

// ---------------------------------------------------------------------------
// MODEL: SECTION ARTIKEL (bagian dalam satu artikel, tiap section punya ikon
// & gradient sendiri yang sesuai tema section-nya — bukan foto internet).
// ---------------------------------------------------------------------------
class ArticleSection {
  final String title;
  final IconData icon;
  final List<Color> gradient;
  final String imageLabel;
  final String description;

  const ArticleSection({
    required this.title,
    required this.icon,
    required this.gradient,
    required this.imageLabel,
    required this.description,
  });
}

// ---------------------------------------------------------------------------
// MODEL: ARTIKEL
// ---------------------------------------------------------------------------
class Article {
  final String tag;
  final Color tagColor;
  final String title;
  final String date;
  final String readTime;
  final List<Color> thumbGradient;
  final IconData heroIcon;
  final String intro;
  final String highlightTitle;
  final String highlightText;
  final List<ArticleSection> sections;

  const Article({
    required this.tag,
    required this.tagColor,
    required this.title,
    required this.date,
    required this.readTime,
    required this.thumbGradient,
    required this.heroIcon,
    this.intro = '',
    this.highlightTitle = '',
    this.highlightText = '',
    this.sections = const [],
  });
}

const List<String> categories = ["Semua", "Diabetes", "Nutrisi", "Gaya Hidup"];

final List<Article> articles = [
  Article(
    tag: "Diabetes",
    tagColor: ArticleColors.blue,
    title: "Diabetes Penyakit yang Perlu Diwaspadai",
    date: "12 Apr 2025",
    readTime: "3 menit baca",
    thumbGradient: const [Color(0xFF3B3F45), Color(0xFF111318)],
    heroIcon: Icons.bloodtype_rounded,
    intro:
        "Diabetes adalah penyakit kronis yang terjadi ketika tubuh tidak "
        "mampu memproduksi cukup insulin atau tidak dapat menggunakan "
        "insulin secara efektif. Kondisi ini sering disebut sebagai 'ibu "
        "dari segala penyakit' karena dapat menjadi cikal bakal berbagai "
        "komplikasi serius jika tidak dikelola dengan baik sejak dini.",
    highlightTitle: "Apa yang membuat diabetes berbahaya?",
    highlightText:
        "Kadar gula darah yang tidak terkontrol dapat menyebabkan "
        "komplikasi pada organ-organ vital termasuk jantung, ginjal, mata, "
        "dan sistem saraf. Berikut dampaknya pada tubuh:",
    sections: const [
      ArticleSection(
        title: "Dampak pada Jantung",
        icon: Icons.favorite_rounded,
        gradient: [Color(0xFFFF6B6B), Color(0xFFB3261E)],
        imageLabel: "CARDIAC RISK",
        description:
            "Kadar gula darah tinggi yang berlangsung lama dapat merusak "
            "pembuluh darah dan saraf yang mengendalikan jantung, sehingga "
            "meningkatkan risiko penyakit jantung koroner, serangan "
            "jantung, dan stroke.",
      ),
      ArticleSection(
        title: "Dampak pada Ginjal",
        icon: Icons.water_drop_rounded,
        gradient: [Color(0xFF5FA8D3), Color(0xFF1B5E7A)],
        imageLabel: "RENAL FUNCTION",
        description:
            "Diabetes yang tidak terkontrol dapat merusak pembuluh darah "
            "kecil di ginjal, menurunkan kemampuannya menyaring limbah "
            "dari darah dan berpotensi menyebabkan gagal ginjal.",
      ),
    ],
  ),
  Article(
    tag: "Berita Medis",
    tagColor: ArticleColors.cyan,
    title: "Jumlah Penderita Diabetes Meningkat, Ini Kata WHO",
    date: "10 Apr 2025",
    readTime: "2 menit baca",
    thumbGradient: const [Color(0xFF6B93C9), Color(0xFF3A5F96)],
    heroIcon: Icons.public_rounded,
    intro:
        "Organisasi Kesehatan Dunia (WHO) melaporkan bahwa jumlah penderita "
        "diabetes di seluruh dunia terus meningkat dalam beberapa dekade "
        "terakhir. Menurut data terbaru, lebih dari 537 juta orang dewasa "
        "hidup dengan diabetes pada tahun 2021, dan angka ini diperkirakan "
        "akan terus naik.",
    highlightTitle: "Mengapa jumlahnya terus naik?",
    highlightText:
        "Faktor gaya hidup modern seperti pola makan tinggi gula, kurang "
        "aktivitas fisik, dan obesitas menjadi pendorong utama peningkatan "
        "kasus diabetes di berbagai negara, termasuk di kalangan usia "
        "muda.",
    sections: const [
      ArticleSection(
        title: "Faktor Risiko Utama",
        icon: Icons.warning_amber_rounded,
        gradient: [Color(0xFFFFB020), Color(0xFFB3760A)],
        imageLabel: "RISK FACTORS",
        description:
            "Obesitas, kurangnya aktivitas fisik, dan konsumsi makanan "
            "tinggi gula serta lemak menjadi kontributor terbesar "
            "meningkatnya kasus diabetes tipe 2 secara global.",
      ),
      ArticleSection(
        title: "Upaya Respons Global",
        icon: Icons.public_rounded,
        gradient: [Color(0xFF6B93C9), Color(0xFF3A5F96)],
        imageLabel: "GLOBAL RESPONSE",
        description:
            "WHO mendorong negara-negara untuk memperluas akses skrining "
            "dini, edukasi gizi, dan pengobatan diabetes agar dampak "
            "jangka panjangnya bisa ditekan.",
      ),
    ],
  ),
  Article(
    tag: "Diabetes",
    tagColor: ArticleColors.blue,
    title: "Studi Terbaru: Bisa Dicegah Sejak Dini",
    date: "8 Apr 2025",
    readTime: "4 menit baca",
    thumbGradient: const [Color(0xFFD8C6B0), Color(0xFFA9876B)],
    heroIcon: Icons.eco_rounded,
    intro:
        "Pola makan sehat dan aktivitas fisik rutin terbukti dapat "
        "menurunkan risiko diabetes tipe 2 secara signifikan. Studi "
        "terbaru menunjukkan bahwa perubahan gaya hidup sejak usia muda "
        "memberi dampak jangka panjang terhadap kadar gula darah.",
    highlightTitle: "Bisakah diabetes benar-benar dicegah?",
    highlightText:
        "Sejumlah studi jangka panjang menunjukkan bahwa perubahan "
        "kebiasaan sederhana sehari-hari mampu menurunkan risiko diabetes "
        "tipe 2 hingga signifikan, bahkan pada orang dengan riwayat "
        "keluarga diabetes.",
    sections: const [
      ArticleSection(
        title: "Pola Makan Seimbang",
        icon: Icons.restaurant_rounded,
        gradient: [Color(0xFFD8C6B0), Color(0xFFA9876B)],
        imageLabel: "NUTRITION",
        description:
            "Mengurangi konsumsi gula tambahan dan memperbanyak serat "
            "dari sayur, buah, serta biji-bijian utuh membantu menjaga "
            "kadar gula darah tetap stabil.",
      ),
      ArticleSection(
        title: "Aktivitas Fisik Rutin",
        icon: Icons.directions_run_rounded,
        gradient: [Color(0xFF9FD39A), Color(0xFF4F9A5A)],
        imageLabel: "ACTIVE LIFESTYLE",
        description:
            "Olahraga ringan selama 30 menit sehari, seperti jalan cepat "
            "atau bersepeda, terbukti meningkatkan sensitivitas insulin "
            "dan menurunkan risiko diabetes.",
      ),
    ],
  ),
  Article(
    tag: "Kesehatan",
    tagColor: ArticleColors.green,
    title: "Kenali Gejala yang Sering Salah Diartikan",
    date: "6 Apr 2025",
    readTime: "3 menit baca",
    thumbGradient: const [Color(0xFF9FD39A), Color(0xFF4F9A5A)],
    heroIcon: Icons.health_and_safety_rounded,
    intro:
        "Beberapa gejala awal diabetes seperti sering haus, mudah lelah, "
        "dan sering buang air kecil kerap dianggap sepele atau disalah "
        "artikan sebagai kelelahan biasa. Mengenali gejala ini sejak awal "
        "penting agar penanganan bisa dilakukan lebih cepat.",
    highlightTitle: "Gejala apa saja yang perlu diwaspadai?",
    highlightText:
        "Sejumlah gejala diabetes kerap dianggap sepele dan diabaikan. "
        "Mengenalinya sejak dini membantu penanganan lebih cepat sebelum "
        "komplikasi muncul.",
    sections: const [
      ArticleSection(
        title: "Sering Haus dan Lapar",
        icon: Icons.local_drink_rounded,
        gradient: [Color(0xFF5FA8D3), Color(0xFF1B5E7A)],
        imageLabel: "EARLY SIGNS",
        description:
            "Rasa haus dan lapar berlebihan yang muncul terus-menerus "
            "bisa jadi tanda tubuh sedang kesulitan mengatur kadar gula "
            "darah dengan normal.",
      ),
      ArticleSection(
        title: "Mudah Lelah dan Luka Sulit Sembuh",
        icon: Icons.healing_rounded,
        gradient: [Color(0xFFFFB020), Color(0xFFB3760A)],
        imageLabel: "WARNING SIGNS",
        description:
            "Kelelahan yang tidak wajar serta luka kecil yang lama "
            "sembuh juga termasuk gejala yang sering diabaikan, padahal "
            "penting untuk segera diperiksakan.",
      ),
    ],
  ),
  Article(
    tag: "Berita Medis",
    tagColor: ArticleColors.cyan,
    title: "Pola Makan Sehat Tingkatkan Imunitas",
    date: "4 Apr 2025",
    readTime: "4 menit baca",
    thumbGradient: const [Color(0xFFE3B45F), Color(0xFFC98A3E)],
    heroIcon: Icons.shield_rounded,
    intro:
        "Selain menjaga kadar gula darah, pola makan sehat dengan gizi "
        "seimbang juga berperan penting dalam meningkatkan sistem imun "
        "tubuh, sehingga tubuh lebih tahan terhadap infeksi dan penyakit.",
    highlightTitle: "Bagaimana makanan memengaruhi imunitas?",
    highlightText:
        "Nutrisi yang cukup dan seimbang membantu tubuh melawan infeksi "
        "sekaligus menjaga kadar gula darah tetap stabil, terutama bagi "
        "penderita atau yang berisiko diabetes.",
    sections: const [
      ArticleSection(
        title: "Sumber Nutrisi Penting",
        icon: Icons.eco_rounded,
        gradient: [Color(0xFF9FD39A), Color(0xFF4F9A5A)],
        imageLabel: "KEY NUTRIENTS",
        description:
            "Vitamin C, zinc, dan antioksidan dari buah dan sayur segar "
            "membantu memperkuat sistem imun sekaligus menjaga metabolisme "
            "gula darah tetap sehat.",
      ),
      ArticleSection(
        title: "Kebiasaan Makan Sehat",
        icon: Icons.restaurant_menu_rounded,
        gradient: [Color(0xFFE3B45F), Color(0xFFC98A3E)],
        imageLabel: "HEALTHY HABITS",
        description:
            "Makan dengan porsi teratur, menghindari makanan olahan "
            "berlebih, dan cukup minum air putih adalah kebiasaan "
            "sederhana yang berdampak besar bagi imunitas tubuh.",
      ),
    ],
  ),
];

// ---------------------------------------------------------------------------
// SCREEN: LIST ARTIKEL
// ---------------------------------------------------------------------------
class ArticleListScreen extends StatefulWidget {
  const ArticleListScreen({super.key});

  @override
  State<ArticleListScreen> createState() => _ArticleListScreenState();
}

class _ArticleListScreenState extends State<ArticleListScreen> {
  String activeCategory = "Semua";
  String query = "";

  List<Article> get _filtered {
    return articles.where((a) {
      final matchCategory = activeCategory == "Semua" ||
          a.tag == activeCategory ||
          (activeCategory == "Gaya Hidup" && a.tag == "Kesehatan");
      final matchQuery = a.title.toLowerCase().contains(query.toLowerCase());
      return matchCategory && matchQuery;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final filtered = _filtered;

    return Scaffold(
      backgroundColor: ArticleColors.bg,
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 8, 8, 14),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back_ios_new, size: 18, color: ArticleColors.ink),
                      onPressed: () => Navigator.of(context).maybePop(),
                    ),
                  ),
                  const Text(
                    "Artikel Kesehatan",
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: ArticleColors.ink),
                  ),
                ],
              ),
            ),

            // Content
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                children: [
                  // Search bar
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: ArticleColors.line),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.search, size: 18, color: Color(0xFF98A2B3)),
                        const SizedBox(width: 10),
                        Expanded(
                          child: TextField(
                            onChanged: (v) => setState(() => query = v),
                            decoration: const InputDecoration(
                              hintText: "Cari artikel...",
                              hintStyle: TextStyle(color: ArticleColors.sub, fontSize: 14),
                              border: InputBorder.none,
                              isDense: true,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 14),

                  // Category chips
                  SizedBox(
                    height: 40,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: categories.length,
                      separatorBuilder: (_, __) => const SizedBox(width: 8),
                      itemBuilder: (context, i) {
                        final cat = categories[i];
                        final active = cat == activeCategory;
                        return GestureDetector(
                          onTap: () => setState(() => activeCategory = cat),
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 9),
                            decoration: BoxDecoration(
                              color: active ? ArticleColors.blue : Colors.white,
                              borderRadius: BorderRadius.circular(999),
                              border: Border.all(color: active ? ArticleColors.blue : ArticleColors.line),
                            ),
                            child: Center(
                              child: Text(
                                cat,
                                style: TextStyle(
                                  fontSize: 13.5,
                                  fontWeight: FontWeight.w600,
                                  color: active ? Colors.white : ArticleColors.sub,
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 18),

                  // Article list
                  if (filtered.isEmpty)
                    const Padding(
                      padding: EdgeInsets.only(top: 40),
                      child: Center(
                        child: Text("Artikel tidak ditemukan.", style: TextStyle(color: ArticleColors.sub)),
                      ),
                    )
                  else
                    ...filtered.map(
                      (a) => Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: ArticleCard(
                          article: a,
                          onTap: () => Navigator.of(context).push(
                            MaterialPageRoute(builder: (_) => ArticleDetailScreen(article: a)),
                          ),
                        ),
                      ),
                    ),
                  const SizedBox(height: 12),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// WIDGET: KARTU ARTIKEL (untuk list) — thumbnail ikon + gradient sesuai tema
// ---------------------------------------------------------------------------
class ArticleCard extends StatelessWidget {
  final Article article;
  final VoidCallback? onTap;

  const ArticleCard({super.key, required this.article, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Ink(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: ArticleColors.line),
        ),
        child: Row(
          children: [
            Container(
              width: 64,
              height: 64,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: article.thumbGradient,
                ),
              ),
              child: Icon(article.heroIcon, color: Colors.white, size: 28),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    article.tag,
                    style: TextStyle(fontSize: 11.5, fontWeight: FontWeight.bold, color: article.tagColor),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    article.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 14.5, fontWeight: FontWeight.bold, color: ArticleColors.ink),
                  ),
                  const SizedBox(height: 5),
                  Row(
                    children: [
                      const Icon(Icons.calendar_today, size: 12, color: ArticleColors.sub),
                      const SizedBox(width: 4),
                      Text(
                        "${article.date} · ${article.readTime}",
                        style: const TextStyle(fontSize: 11.5, color: ArticleColors.sub),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const Icon(Icons.chevron_right, color: Color(0xFFC6CBD4)),
          ],
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// SCREEN: DETAIL ARTIKEL (dibuka saat item di list diklik)
// ---------------------------------------------------------------------------
class ArticleDetailScreen extends StatefulWidget {
  final Article article;

  const ArticleDetailScreen({super.key, required this.article});

  @override
  State<ArticleDetailScreen> createState() => _ArticleDetailScreenState();
}

class _ArticleDetailScreenState extends State<ArticleDetailScreen> {
  bool _isBookmarked = false;

  Article get article => widget.article;

  List<Article> get _relatedArticles {
    return articles.where((a) => a.title != article.title).take(2).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          // ---------------- HEADER / HERO (ikon + gradient sesuai tema) ----------------
          SliverAppBar(
            expandedHeight: 240,
            pinned: true,
            backgroundColor: Colors.white,
            elevation: 0,
            leading: Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircleAvatar(
                backgroundColor: Colors.black.withValues(alpha: 0.35),
                child: IconButton(
                  icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 18),
                  onPressed: () => Navigator.maybePop(context),
                ),
              ),
            ),
            title: const Text(
              'Artikel Kesehatan',
              style: TextStyle(color: Colors.black87, fontWeight: FontWeight.w600, fontSize: 16),
            ),
            centerTitle: true,
            actions: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CircleAvatar(
                  backgroundColor: Colors.black.withValues(alpha: 0.35),
                  child: IconButton(
                    icon: Icon(
                      _isBookmarked ? Icons.bookmark : Icons.bookmark_border,
                      color: Colors.white,
                      size: 18,
                    ),
                    onPressed: () => setState(() => _isBookmarked = !_isBookmarked),
                  ),
                ),
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: article.thumbGradient,
                      ),
                    ),
                    child: Center(
                      child: Icon(
                        article.heroIcon,
                        size: 84,
                        color: Colors.white.withValues(alpha: 0.85),
                      ),
                    ),
                  ),
                  DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.black.withValues(alpha: 0.0),
                          Colors.black.withValues(alpha: 0.25),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // ---------------- BODY ----------------
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Badge kategori
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: article.tagColor.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      article.tag,
                      style: TextStyle(color: article.tagColor, fontWeight: FontWeight.w600, fontSize: 12),
                    ),
                  ),
                  const SizedBox(height: 10),

                  // Judul artikel
                  Text(
                    article.title,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      height: 1.3,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 10),

                  // Meta info: tanggal & waktu baca
                  Row(
                    children: [
                      const Icon(Icons.calendar_today, size: 14, color: Colors.grey),
                      const SizedBox(width: 4),
                      Text(article.date, style: TextStyle(fontSize: 12, color: Colors.grey.shade600)),
                      const SizedBox(width: 10),
                      Text('•', style: TextStyle(color: Colors.grey.shade400)),
                      const SizedBox(width: 10),
                      const Icon(Icons.access_time, size: 14, color: Colors.grey),
                      const SizedBox(width: 4),
                      Text(article.readTime, style: TextStyle(fontSize: 12, color: Colors.grey.shade600)),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Kalimat pembuka
                  if (article.intro.isNotEmpty)
                    Text(
                      article.intro,
                      style: TextStyle(fontSize: 14, height: 1.6, color: Colors.grey.shade700),
                    ),
                  const SizedBox(height: 16),

                  // Highlight box oranye
                  if (article.highlightTitle.isNotEmpty)
                    HighlightBox(
                      title: article.highlightTitle,
                      text: article.highlightText,
                    ),
                  if (article.sections.isNotEmpty) const SizedBox(height: 24),

                  // Section-section artikel
                  for (int i = 0; i < article.sections.length; i++) ...[
                    SectionArtikel(
                      nomor: i + 1,
                      judul: article.sections[i].title,
                      icon: article.sections[i].icon,
                      gradient: article.sections[i].gradient,
                      labelGambar: article.sections[i].imageLabel,
                      deskripsi: article.sections[i].description,
                    ),
                    if (i != article.sections.length - 1) const SizedBox(height: 24),
                  ],

                  if (_relatedArticles.isNotEmpty) ...[
                    const SizedBox(height: 28),
                    const Text(
                      'Artikel Terkait',
                      style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.black87),
                    ),
                    const SizedBox(height: 10),
                    ..._relatedArticles.map(
                      (a) => Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: RelatedArticleCard(
                          article: a,
                          onTap: () => Navigator.of(context).pushReplacement(
                            MaterialPageRoute(builder: (_) => ArticleDetailScreen(article: a)),
                          ),
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// WIDGET: Kotak highlight oranye
// ---------------------------------------------------------------------------
class HighlightBox extends StatelessWidget {
  final String title;
  final String text;

  const HighlightBox({super.key, required this.title, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: ArticleColors.orangeSoft,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.lightbulb_outline, color: ArticleColors.orange, size: 20),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Colors.black87),
                ),
              ),
            ],
          ),
          if (text.isNotEmpty) ...[
            const SizedBox(height: 8),
            Text(
              text,
              style: TextStyle(fontSize: 13, height: 1.5, color: Colors.grey.shade800),
            ),
          ],
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// WIDGET: Reusable section untuk tiap bagian artikel — ikon + gradient
// sesuai tema section (bukan foto internet), dengan label pojok kanan atas.
// ---------------------------------------------------------------------------
class SectionArtikel extends StatelessWidget {
  final int nomor;
  final String judul;
  final IconData icon;
  final List<Color> gradient;
  final String labelGambar;
  final String deskripsi;

  const SectionArtikel({
    super.key,
    required this.nomor,
    required this.judul,
    required this.icon,
    required this.gradient,
    required this.labelGambar,
    required this.deskripsi,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$nomor. $judul',
          style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: Colors.black87),
        ),
        const SizedBox(height: 10),
        ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Stack(
            children: [
              AspectRatio(
                aspectRatio: 16 / 9,
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: gradient,
                    ),
                  ),
                  child: Center(
                    child: Icon(icon, size: 52, color: Colors.white.withValues(alpha: 0.9)),
                  ),
                ),
              ),
              Positioned(
                top: 10,
                right: 10,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: 0.45),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    labelGambar,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        Text(
          deskripsi,
          style: TextStyle(fontSize: 14, height: 1.6, color: Colors.grey.shade700),
        ),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// WIDGET: Kartu artikel terkait (di bagian bawah detail)
// ---------------------------------------------------------------------------
class RelatedArticleCard extends StatelessWidget {
  final Article article;
  final VoidCallback? onTap;

  const RelatedArticleCard({super.key, required this.article, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.shade200),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.03),
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: article.thumbGradient,
                  ),
                ),
                child: Icon(article.heroIcon, color: Colors.white, size: 26),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(
                      color: article.tagColor.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      article.tag,
                      style: TextStyle(fontSize: 10, fontWeight: FontWeight.w700, color: article.tagColor),
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    article.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                      height: 1.3,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    '${article.date}  •  ${article.readTime}',
                    style: const TextStyle(fontSize: 11, color: Colors.grey),
                  ),
                ],
              ),
            ),
            const Icon(Icons.chevron_right, color: Colors.grey, size: 22),
          ],
        ),
      ),
    );
  }
}