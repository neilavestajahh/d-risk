import 'package:flutter/material.dart';

// ---------------------------------------------------------------------------
// MODEL DATA
// ---------------------------------------------------------------------------

enum SenderType { doctor, user }

class ChatMessage {
  final SenderType sender;
  final String text;
  final String time;

  const ChatMessage({
    required this.sender,
    required this.text,
    required this.time,
  });
}

// ---------------------------------------------------------------------------
// HALAMAN CHAT KONSULTASI
// ---------------------------------------------------------------------------

class ChatKonsultasiScreen extends StatefulWidget {
  final String doctorName;
  final String doctorSpecialty;

  const ChatKonsultasiScreen({
    super.key,
    required this.doctorName,
    required this.doctorSpecialty,
  });

  @override
  State<ChatKonsultasiScreen> createState() => _ChatKonsultasiScreenState();
}

class _ChatKonsultasiScreenState extends State<ChatKonsultasiScreen> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  // Catatan: list ini SENGAJA tidak const, karena isinya ditambah lewat
  // _sendMessage() saat pengguna mengirim pesan baru.
  final List<ChatMessage> _messages = [
    const ChatMessage(
      sender: SenderType.doctor,
      text:
          'Selamat pagi, Anda dapat menjelaskan keluhan atau pertanyaan terkait kondisi kesehatan Anda. Saya akan membantu sebaik mungkin.',
      time: '09:40',
    ),
    const ChatMessage(
      sender: SenderType.user,
      text:
          'Selamat pagi dok, saya ingin konsultasi mengenai risiko diabetes. Saya sering merasa cepat lelah, terutama setelah makan, dan berat badan saya akhir-akhir ini sedikit naik.',
      time: '09:42',
    ),
    const ChatMessage(
      sender: SenderType.doctor,
      text:
          'Baik, terima kasih atas informasinya. Untuk memberikan saran yang tepat, saya akan menanyakan beberapa hal terlebih dahulu. Apakah ada riwayat keluarga dengan diabetes?',
      time: '09:43',
    ),
  ];

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _sendMessage() {
    final text = _messageController.text.trim();
    if (text.isEmpty) return;
    setState(() {
      _messages.add(ChatMessage(
        sender: SenderType.user,
        text: text,
        time: 'Sekarang',
      ));
      _messageController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppBar(),
      body: SafeArea(
        top: false,
        child: Column(
          children: [
            _buildDoctorInfoBar(),
            _buildPrivacyNotice(),
            Expanded(
              child: ListView.builder(
                controller: _scrollController,
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                itemCount: _messages.length,
                itemBuilder: (context, index) => _buildMessageBubble(_messages[index]),
              ),
            ),
            _buildMessageInputBar(),
          ],
        ),
      ),
    );
  }

  // -------------------------------------------------------------------------
  // APP BAR
  // -------------------------------------------------------------------------

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      surfaceTintColor: Colors.white,
      centerTitle: true,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.black87, size: 22),
        onPressed: () => Navigator.maybePop(context),
      ),
      title: const Text(
        'Konsultasi',
        style: TextStyle(
          color: Colors.black87,
          fontSize: 17,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  // -------------------------------------------------------------------------
  // INFO DOKTER
  // -------------------------------------------------------------------------

  Widget _buildDoctorInfoBar() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 4, 16, 8),
      child: Row(
        children: [
          // Avatar dokter — pakai ikon placeholder (belum ada foto asli).
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: const Color(0xFFE8F1FD),
              borderRadius: BorderRadius.circular(24),
            ),
            alignment: Alignment.center,
            child: const Icon(Icons.person, color: Color(0xFF2F80ED), size: 22),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.doctorName,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: Colors.black87,
                  ),
                ),
                Text(
                  widget.doctorSpecialty,
                  style: const TextStyle(fontSize: 11, color: Colors.black54),
                ),
                const SizedBox(height: 2),
                Row(
                  children: const [
                    Icon(Icons.circle, color: Color(0xFF27AE60), size: 7),
                    SizedBox(width: 4),
                    Text(
                      'Online',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF27AE60),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.more_vert, color: Colors.black54),
            onPressed: () {
              // TODO: tampilkan opsi tambahan
            },
          ),
        ],
      ),
    );
  }

  // -------------------------------------------------------------------------
  // NOTIFIKASI PRIVASI
  // -------------------------------------------------------------------------

  Widget _buildPrivacyNotice() {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 0, 16, 8),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: const Color(0xFFE8F1FD),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Icon(Icons.verified_user, color: Color(0xFF2F80ED), size: 16),
          SizedBox(width: 8),
          Expanded(
            child: Text(
              'Konsultasi ini bersifat rahasia dan hanya dapat diakses oleh Anda dan dokter.',
              style: TextStyle(fontSize: 11.5, color: Color(0xFF2F80ED), height: 1.4),
            ),
          ),
        ],
      ),
    );
  }

  // -------------------------------------------------------------------------
  // BUBBLE PESAN
  // -------------------------------------------------------------------------

  Widget _buildMessageBubble(ChatMessage message) {
    final isDoctor = message.sender == SenderType.doctor;

    final bubble = Container(
      constraints: const BoxConstraints(maxWidth: 230),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: isDoctor ? const Color(0xFFF1F2F4) : const Color(0xFF2F80ED),
        borderRadius: BorderRadius.only(
          topLeft: const Radius.circular(16),
          topRight: const Radius.circular(16),
          bottomLeft: Radius.circular(isDoctor ? 4 : 16),
          bottomRight: Radius.circular(isDoctor ? 16 : 4),
        ),
      ),
      child: Text(
        message.text,
        style: TextStyle(
          fontSize: 13,
          height: 1.4,
          color: isDoctor ? Colors.black87 : Colors.white,
        ),
      ),
    );

    final timeLabel = Padding(
      padding: const EdgeInsets.only(top: 4),
      child: Text(
        message.time,
        style: const TextStyle(fontSize: 10, color: Colors.black38),
      ),
    );

    if (isDoctor) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 14),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Avatar kecil di tiap bubble dokter — ikon placeholder juga.
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: const Color(0xFFE8F1FD),
                borderRadius: BorderRadius.circular(16),
              ),
              alignment: Alignment.center,
              child: const Icon(Icons.person, size: 16, color: Color(0xFF2F80ED)),
            ),
            const SizedBox(width: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [bubble, timeLabel],
            ),
          ],
        ),
      );
    } else {
      return Padding(
        padding: const EdgeInsets.only(bottom: 14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [bubble, timeLabel],
        ),
      );
    }
  }

  // -------------------------------------------------------------------------
  // INPUT PESAN
  // -------------------------------------------------------------------------

  Widget _buildMessageInputBar() {
    return Container(
      padding: const EdgeInsets.fromLTRB(12, 10, 12, 10),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Colors.grey.shade200)),
      ),
      child: SafeArea(
        top: false,
        child: Row(
          children: [
            IconButton(
              icon: const Icon(Icons.attach_file, color: Colors.black54),
              onPressed: () {
                // TODO: aksi lampirkan file/gambar
              },
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: const Color(0xFFF5F7FA),
                  borderRadius: BorderRadius.circular(24),
                ),
                child: TextField(
                  controller: _messageController,
                  minLines: 1,
                  maxLines: 4,
                  decoration: const InputDecoration(
                    hintText: 'Tulis pesan...',
                    hintStyle: TextStyle(color: Colors.grey, fontSize: 13),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 8),
            InkWell(
              onTap: _sendMessage,
              borderRadius: BorderRadius.circular(24),
              child: Container(
                width: 42,
                height: 42,
                decoration: const BoxDecoration(
                  color: Color(0xFF2F80ED),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.send, color: Colors.white, size: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }
}