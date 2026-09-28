import 'package:flutter/material.dart';

import 'bot_dokter.dart';

// Letakkan di: lib/chat_konsultasi_screen.dart
// (langsung di lib/, BUKAN di lib/screens/)
// Pastikan lib/bot_dokter.dart juga sudah ada.

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

  /// true saat bot sedang "mengetik" balasan.
  bool _isTyping = false;

  // List ini SENGAJA tidak const, karena isinya ditambah lewat
  // _sendMessage() saat pengguna mengirim pesan baru.
  final List<ChatMessage> _messages = [
    const ChatMessage(
      sender: SenderType.doctor,
      text:
          'Halo, saya asisten konsultasi diabetes. Silakan ceritakan keluhan atau pertanyaanmu, misalnya soal gejala, risiko, kadar gula darah, pola makan, atau olahraga.',
      time: '09:40',
    ),
  ];

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  String _nowTime() {
    final now = DateTime.now();
    final h = now.hour.toString().padLeft(2, '0');
    final m = now.minute.toString().padLeft(2, '0');
    return '$h:$m';
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!_scrollController.hasClients) return;
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOut,
      );
    });
  }

  Future<void> _sendMessage() async {
    final text = _messageController.text.trim();
    if (text.isEmpty || _isTyping) return;

    setState(() {
      _messages.add(ChatMessage(
        sender: SenderType.user,
        text: text,
        time: _nowTime(),
      ));
      _messageController.clear();
      _isTyping = true;
    });
    _scrollToBottom();

    // Jeda supaya terasa seperti dokter sedang mengetik.
    await Future.delayed(const Duration(milliseconds: 1200));
    if (!mounted) return;

    final balasan = BotDokter.balas(text);

    setState(() {
      _messages.add(ChatMessage(
        sender: SenderType.doctor,
        text: balasan,
        time: _nowTime(),
      ));
      _isTyping = false;
    });
    _scrollToBottom();
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
                itemCount: _messages.length + (_isTyping ? 1 : 0),
                itemBuilder: (context, index) {
                  if (index == _messages.length) {
                    return _buildTypingBubble();
                  }
                  return _buildMessageBubble(_messages[index]);
                },
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
                  children: [
                    const Icon(Icons.circle, color: Color(0xFF27AE60), size: 7),
                    const SizedBox(width: 4),
                    Text(
                      _isTyping ? 'Sedang mengetik...' : 'Online',
                      style: const TextStyle(
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
      child: const Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.verified_user, color: Color(0xFF2F80ED), size: 16),
          SizedBox(width: 8),
          Expanded(
            child: Text(
              'Balasan di sini bersifat otomatis dan berupa informasi umum, bukan diagnosis dokter.',
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

  Widget _buildDoctorAvatar() {
    return Container(
      width: 32,
      height: 32,
      decoration: BoxDecoration(
        color: const Color(0xFFE8F1FD),
        borderRadius: BorderRadius.circular(16),
      ),
      alignment: Alignment.center,
      child: const Icon(Icons.person, size: 16, color: Color(0xFF2F80ED)),
    );
  }

  Widget _buildTypingBubble() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _buildDoctorAvatar(),
          const SizedBox(width: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            decoration: const BoxDecoration(
              color: Color(0xFFF1F2F4),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
                bottomLeft: Radius.circular(4),
                bottomRight: Radius.circular(16),
              ),
            ),
            child: const Text(
              '...',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black45,
                height: 1,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMessageBubble(ChatMessage message) {
    final isDoctor = message.sender == SenderType.doctor;

    final bubble = Container(
      constraints: const BoxConstraints(maxWidth: 260),
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
            _buildDoctorAvatar(),
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
                  textInputAction: TextInputAction.send,
                  onSubmitted: (_) => _sendMessage(),
                  decoration: const InputDecoration(
                    hintText: 'Tulis pesan...',
                    hintStyle: TextStyle(color: Colors.grey, fontSize: 13),
                    border: InputBorder.none,
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 16, vertical: 10),
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