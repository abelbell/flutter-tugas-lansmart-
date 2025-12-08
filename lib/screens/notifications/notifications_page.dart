// lib/models/notification_page.dart
import 'package:flutter/material.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({Key? key}) : super(key: key);

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  // Data dasar notifikasi (template)
  final List<Map<String, String>> baseNotifications = [
    {
      'title': 'New Arrivals Alert!',
      'date': '15 July 2023',
      'image': 'assets/images/verify.png', // Sesuaikan dengan nama file Anda
    },
    {
      'title': 'Flash Sale Announcement',
      'date': '15 July 2023',
      'image': 'assets/images/reset.png',
    },
    {
      'title': 'Exclusive Discounts Inside',
      'date': '15 July 2023',
      'image': 'assets/images/banner.png',
    },
    {
      'title': 'Limited Stock - Act Fast!',
      'date': '15 July 2023',
      'image': 'assets/images/signin.png',
    },
    {
      'title': 'Get Ready to Shop',
      'date': '15 July 2023',
      'image': 'assets/images/create.png',
    },
    {
      'title': "Don't Miss Out on Savings",
      'date': '15 July 2023',
      'image': 'assets/images/forgot.png',
    },
    {
      'title': 'Special Offer Just for You',
      'date': '15 July 2023',
      'image': 'assets/images/onboarding.png',
    },
    {
      'title': 'Get Ready to Shop',
      'date': '15 July 2023',
      'image': 'assets/images/signin.png',
    },
    {'title': 'Get Ready to Shop', 'date': '15 July 2023'},
  ];

  // List yang ditampilkan (hasil duplikasi)
  late final List<Map<String, String>> notifications;

  bool _permissionShown = false;

  @override
  void initState() {
    super.initState();
    // Gandakan list agar terlihat banyak (misal 5x lipat)
    notifications = List.generate(5, (_) =>
      baseNotifications.map((item) => Map<String, String>.from(item)).toList()
    ).expand((e) => e).toList();
    // Tampilkan modal izin sekali saat halaman dibuka
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!_permissionShown) {
        _permissionShown = true;
        _showPermissionSheet(context);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? Colors.grey[900] : Colors.white,
      appBar: AppBar(
        backgroundColor: isDark ? Colors.grey[900] : Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: isDark ? Colors.white : Colors.black,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Notifications',
          style: TextStyle(
            fontFamily: 'TomatoGrotesk',
            color: isDark ? Colors.white : Colors.black,
            fontWeight: FontWeight.w600,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: notifications.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.notifications_off_outlined,
                    size: 80,
                    color: isDark ? Colors.grey[600] : Colors.grey[400],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'No Notifications',
                    style: TextStyle(
                      fontFamily: 'TomatoGrotesk',
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: isDark ? Colors.grey[400] : Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'You\'re all caught up!',
                    style: TextStyle(
                      fontFamily: 'TomatoGrotesk',
                      fontSize: 14,
                      color: isDark ? Colors.grey[500] : Colors.grey[500],
                    ),
                  ),
                ],
              ),
            )
          : ListView.separated(
              padding: const EdgeInsets.symmetric(vertical: 8),
              itemCount: notifications.length,
              separatorBuilder: (context, index) => Divider(
                height: 1,
                thickness: 1,
                color: isDark ? Colors.grey[800] : Colors.grey[200],
                indent: 88,
              ),
              itemBuilder: (context, index) {
                final item = notifications[index];
                final String title = item['title'] ?? 'Notification';
                final String date = item['date'] ?? '';
                final String? imagePath = item['image'];
                return Dismissible(
                  key: Key('${title}_$index'),
                  direction: DismissDirection.endToStart,
                  background: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(
                          Icons.delete_outline,
                          color: Colors.white,
                          size: 24,
                        ),
                      ),
                    ),
                  ),
                  onDismissed: (direction) {
                    setState(() {
                      notifications.removeAt(index);
                    });
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('${item['title']} dismissed'),
                        duration: const Duration(seconds: 2),
                        action: SnackBarAction(
                          label: 'Undo',
                          onPressed: () {
                            setState(() {
                              notifications.insert(index, item);
                            });
                          },
                        ),
                      ),
                    );
                  },
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Container(
                        width: 56,
                        height: 56,
                        decoration: BoxDecoration(
                          color: isDark ? Colors.grey[800] : Colors.grey[200],
                        ),
                        child: imagePath != null && imagePath.isNotEmpty
                            ? Image.asset(
                                imagePath,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  // Fallback jika gambar tidak ditemukan
                                  return Container(
                                    color: isDark ? Colors.grey[800] : Colors.grey[200],
                                    child: Icon(
                                      Icons.notifications,
                                      color: isDark ? Colors.grey[600] : Colors.grey[400],
                                      size: 28,
                                    ),
                                  );
                                },
                              )
                            : Icon(
                                Icons.notifications,
                                color: isDark ? Colors.grey[600] : Colors.grey[400],
                                size: 28,
                              ),
                      ),
                    ),
                    title: Text(
                      title,
                      style: TextStyle(
                        fontFamily: 'TomatoGrotesk',
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                        color: isDark ? Colors.white : Colors.black,
                      ),
                    ),
                    subtitle: Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: Text(
                        date,
                        style: TextStyle(
                          fontFamily: 'TomatoGrotesk',
                          color: isDark ? Colors.grey[400] : Colors.grey[600],
                          fontSize: 13,
                        ),
                      ),
                    ),
                    trailing: Icon(
                      Icons.chevron_right,
                      color: isDark ? Colors.grey[600] : Colors.grey[400],
                    ),
                    onTap: () {
                      // TODO: Navigate to notification detail
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Opened: $title'),
                          duration: const Duration(seconds: 1),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
    );
  }

  void _showPermissionSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      isScrollControlled: false,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (ctx) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(16, 20, 16, 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    icon: const Icon(Icons.close, color: Colors.black),
                    onPressed: () => Navigator.pop(ctx),
                  ),
                ],
              ),
              Container(
                width: 90,
                height: 90,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.red.shade400, width: 2),
                ),
                child: Icon(Icons.notifications_none, size: 44, color: Colors.red.shade400),
              ),
              const SizedBox(height: 16),
              const Text(
                'Push Notifications',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 10),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8),
                child: Text(
                  'Stay informed with order updates, promotional offers, and platform communications.',
                  style: TextStyle(color: Colors.black87, fontSize: 15, height: 1.4),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(ctx); // here you would request permission
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFDD096),
                    foregroundColor: Colors.black,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                  ),
                  child: const Text('Give Permission', style: TextStyle(fontWeight: FontWeight.w700)),
                ),
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                height: 52,
                child: OutlinedButton(
                  onPressed: () {
                    Navigator.pop(ctx);
                    Navigator.pop(context); // take user back
                  },
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Colors.black12),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                    foregroundColor: Colors.black,
                  ),
                  child: const Text('Later, Take Me Back', style: TextStyle(fontWeight: FontWeight.w700)),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}