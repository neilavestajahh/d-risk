import 'package:flutter/material.dart';

/// Model data untuk satu item notifikasi
class NotificationItem {
  final String title;
  final String message;
  final DateTime time;
  final IconData icon;
  bool isRead;

  NotificationItem({
    required this.title,
    required this.message,
    required this.time,
    this.icon = Icons.notifications,
    this.isRead = false,
  });
}

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  // Data dummy — ganti dengan data dari API/database sesuai kebutuhanmu
  final List<NotificationItem> _notifications = [
    NotificationItem(
      title: 'Pendaftaran Berhasil',
      message: 'Pendaftaran rawat jalan Anda telah dikonfirmasi.',
      time: DateTime.now().subtract(const Duration(minutes: 10)),
      icon: Icons.check_circle,
    ),
    NotificationItem(
      title: 'Pengingat Jadwal',
      message: 'Jadwal kontrol Anda besok pukul 09.00.',
      time: DateTime.now().subtract(const Duration(hours: 3)),
      icon: Icons.event,
    ),
    NotificationItem(
      title: 'Informasi Antrian',
      message: 'Nomor antrian Anda: A-024.',
      time: DateTime.now().subtract(const Duration(days: 1)),
      icon: Icons.confirmation_number,
      isRead: true,
    ),
  ];

  void _markAsRead(int index) {
    setState(() {
      _notifications[index].isRead = true;
    });
  }

  void _markAllAsRead() {
    setState(() {
      for (var n in _notifications) {
        n.isRead = true;
      }
    });
  }

  String _formatTime(DateTime time) {
    final diff = DateTime.now().difference(time);
    if (diff.inMinutes < 60) return '${diff.inMinutes} menit lalu';
    if (diff.inHours < 24) return '${diff.inHours} jam lalu';
    return '${diff.inDays} hari lalu';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifikasi'),
        actions: [
          if (_notifications.any((n) => !n.isRead))
            TextButton(
              onPressed: _markAllAsRead,
              child: const Text(
                'Tandai semua dibaca',
                style: TextStyle(color: Colors.white),
              ),
            ),
        ],
      ),
      body: _notifications.isEmpty
          ? const Center(
              child: Text(
                'Belum ada notifikasi',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            )
          : ListView.separated(
              itemCount: _notifications.length,
              separatorBuilder: (_, __) => const Divider(height: 1),
              itemBuilder: (context, index) {
                final item = _notifications[index];
                return ListTile(
                  leading: CircleAvatar(
                    backgroundColor:
                        item.isRead ? Colors.grey.shade300 : Colors.blue.shade100,
                    child: Icon(
                      item.icon,
                      color: item.isRead ? Colors.grey : Colors.blue,
                    ),
                  ),
                  title: Text(
                    item.title,
                    style: TextStyle(
                      fontWeight:
                          item.isRead ? FontWeight.normal : FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(item.message),
                  trailing: Text(
                    _formatTime(item.time),
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                  onTap: () => _markAsRead(index),
                );
              },
            ),
    );
  }
}