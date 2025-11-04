// lib/screens/chat/chat_list_page.dart
import 'package:flutter/material.dart';

// ========================================
// CHAT DETAIL PAGE
// ========================================

class ChatDetailPage extends StatelessWidget {
  final String name;
  final String avatar;
  final bool isOnline;

  const ChatDetailPage({
    Key? key,
    required this.name,
    required this.avatar,
    required this.isOnline,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? Colors.grey[900] : Colors.grey[100],
      appBar: AppBar(
        backgroundColor: isDark ? Colors.grey[850] : Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: isDark ? Colors.white : Colors.black,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Row(
          children: [
            Stack(
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundImage: AssetImage(avatar),
                  backgroundColor: Colors.grey[300],
                ),
                if (isOnline)
                  Positioned(
                    right: 0,
                    bottom: 0,
                    child: Container(
                      width: 12,
                      height: 12,
                      decoration: BoxDecoration(
                        color: const Color(0xFF4CAF50),
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.white,
                          width: 2,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: TextStyle(
                      fontFamily: 'TomatoGrotesk',
                      color: isDark ? Colors.white : Colors.black,
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                  if (isOnline)
                    Text(
                      'Online',
                      style: TextStyle(
                        fontFamily: 'TomatoGrotesk',
                        color: isDark ? Colors.white60 : Colors.grey[600],
                        fontSize: 12,
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.call,
              color: isDark ? Colors.white : Colors.black,
            ),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(
              Icons.more_vert,
              color: isDark ? Colors.white : Colors.black,
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.chat_bubble_outline,
              size: 80,
              color: const Color(0xFFFFA726),
            ),
            const SizedBox(height: 16),
            Text(
              'Chat with $name',
              style: TextStyle(
                fontFamily: 'TomatoGrotesk',
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: isDark ? Colors.white : Colors.black,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'This chat is under development',
              style: TextStyle(
                fontFamily: 'TomatoGrotesk',
                fontSize: 14,
                color: isDark ? Colors.white60 : Colors.grey[600],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ========================================
// CHAT LIST PAGE (MAIN)
// ========================================

class ChatListPage extends StatelessWidget {
  const ChatListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? Colors.grey[900] : Colors.grey[100],
      appBar: AppBar(
        backgroundColor: isDark ? Colors.grey[850] : Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: isDark ? Colors.white : Colors.black,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Messages',
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
            icon: Icon(
              Icons.search,
              color: isDark ? Colors.white : Colors.black,
            ),
            onPressed: () {
              // Search functionality
            },
          ),
        ],
      ),
      body: Container(
        margin: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isDark ? Colors.grey[850] : Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            _buildChatItem(
              context,
              name: 'Emily Johnson',
              message: 'Text me!',
              time: 'Fri',
              avatar: 'assets/images/create.png',
              isOnline: true,
            ),
            _buildDivider(isDark),
            _buildChatItem(
              context,
              name: 'Michael Anderson',
              message: 'Call me back.',
              time: 'Mon',
              avatar: 'assets/images/forgot.png',
              isOnline: true,
            ),
            _buildDivider(isDark),
            _buildChatItem(
              context,
              name: 'Olivia Davis',
              message: 'I got you bro!!',
              time: '2 Hours',
              avatar: 'assets/images/onboarding.png',
              isOnline: false,
            ),
            _buildDivider(isDark),
            _buildChatItem(
              context,
              name: 'Daniel Wilson',
              message: 'Haha, i hit you up',
              time: '2 Min',
              avatar: 'assets/images/reset.png',
              isOnline: true,
            ),
            _buildDivider(isDark),
            _buildChatItem(
              context,
              name: 'Sophia Martinez',
              message: 'Call me back!',
              time: 'Sun',
              avatar: 'assets/images/signin.png',
              isOnline: false,
            ),
            _buildDivider(isDark),
            _buildChatItem(
              context,
              name: 'William Thompson',
              message: 'Text me!',
              time: '7 Aug 2025',
              avatar: 'assets/images/verify.png',
              isOnline: false,
            ),
            _buildDivider(isDark),
            _buildChatItem(
              context,
              name: 'Ava Hernandez',
              message: 'Haha, i hit you up',
              time: 'Tus',
              avatar: 'assets/images/reset.png',
              isOnline: false,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildChatItem(
    BuildContext context, {
    required String name,
    required String message,
    required String time,
    required String avatar,
    required bool isOnline,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ChatDetailPage(
              name: name,
              avatar: avatar,
              isOnline: isOnline,
            ),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            // Avatar with online indicator
            Stack(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundImage: AssetImage(avatar),
                  backgroundColor: Colors.grey[300],
                ),
                if (isOnline)
                  Positioned(
                    right: 0,
                    bottom: 0,
                    child: Container(
                      width: 16,
                      height: 16,
                      decoration: BoxDecoration(
                        color: const Color(0xFF4CAF50),
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.white,
                          width: 2,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(width: 12),
            // Name and message
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: TextStyle(
                      fontFamily: 'TomatoGrotesk',
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: isDark ? Colors.white : Colors.black,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    message,
                    style: TextStyle(
                      fontFamily: 'TomatoGrotesk',
                      fontSize: 14,
                      color: isDark ? Colors.white60 : Colors.grey[600],
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            // Time
            Text(
              time,
              style: TextStyle(
                fontFamily: 'TomatoGrotesk',
                fontSize: 12,
                color: isDark ? Colors.white60 : Colors.grey[500],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDivider(bool isDark) {
    return Divider(
      height: 1,
      thickness: 1,
      indent: 76,
      color: isDark ? Colors.grey[700] : Colors.grey[200],
    );
  }
}