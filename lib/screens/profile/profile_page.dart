// lib/models/profile_page.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../orders/orders_page.dart';
import '../../widgets/custom/custom_bottom_nav.dart';
import '../wishlist/wishlist_page.dart';
import '../profile/edit_profile_page.dart';
import '../profile/saved_cards_page.dart';
import '../profile/saved_addresses_page.dart';
import '../notifications/notifications_page.dart';
import '../profile/reviews_page.dart';
import '../profile/questions_page.dart';
import '../profile/coupons_page.dart';
import '../profile/track_order_page.dart';

import '../../providers/auth_provider.dart';   // ⬅ WAJIB DITAMBAHKAN

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String selectedLang = 'English';
  String selectedFlag = 'assets/images/flag/united_states.png';

  // Navigasi
  void _navigateTo(BuildContext context, String feature) {
    Widget? page;

    switch (feature) {
      case 'Your Order':
        page = const OrdersPage();
        break;
      case 'Wishlist':
        page = const WishlistPage();
        break;
      case 'Coupons':
        page = const CouponsPage();
        break;
      case 'Track Order':
        page = const TrackOrderPage();
        break;
      case 'Edit Profile':
        page = const EditProfilePage();
        break;
      case 'Saved Cards & Wallet':
        page = SavedCardsPage();
        break;
      case 'Saved Addresses':
        page = const SavedAddressesPage();
        break;
      case 'Select Language':
        _showLanguageSelector(context);
        return;
      case 'Notifications Settings':
        page = const NotificationsPage();
        break;
      case 'Reviews':
        page = ReviewsPage(product: {
          'name': 'Silver Purple Full Rim Cat Eye',
          'price': 1100,
          'image': 'assets/images/product2.png',
        });
        break;
      case 'Questions & Answers':
        page = const QuestionsPage();
        break;
      default:
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Fitur $feature belum tersedia")),
        );
        return;
    }

    if (page != null) {
      Navigator.push(context, MaterialPageRoute(builder: (_) => page!));
    }
  }

  // Bahasa
  void _showLanguageSelector(BuildContext context) {
    final languages = [
      {'name': 'Hindi', 'flag': 'assets/images/flag/india.png'},
      {'name': 'English', 'flag': 'assets/images/flag/united_states.png'},
      {'name': 'German', 'flag': 'assets/images/flag/germany.png'},
      {'name': 'Italian', 'flag': 'assets/images/flag/italy.png'},
      {'name': 'Spanish', 'flag': 'assets/images/flag/spain.png'},
    ];

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (_) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Padding(
              padding: EdgeInsets.all(12),
              child: Text(
                'Language',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            const Divider(height: 1),
            ...languages.map((lang) {
              return ListTile(
                leading:
                Image.asset(lang['flag']!, width: 32, height: 32),
                title: Text(lang['name']!, style: const TextStyle(fontSize: 16)),
                onTap: () {
                  setState(() {
                    selectedLang = lang['name']!;
                    selectedFlag = lang['flag']!;
                  });
                  Navigator.pop(context);
                },
              );
            }),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    // ⬇ AMBIL PROVIDER
    final auth = Provider.of<AuthProvider>(context);

    // ⬇ DATA USER DARI FIRESTORE
    final user = auth.userData;

    // Default jika belum ada user
    final displayName = user?["name"] ?? "Guest";
    final displayEmail = user?["email"] ?? "";
    final photoUrl = user?["photoUrl"];

    return Scaffold(
      backgroundColor: isDark ? Colors.grey[900] : Colors.white,
      appBar: AppBar(
        backgroundColor: isDark ? Colors.grey[900] : Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Text(
          'LensMart',
          style: TextStyle(
            fontFamily: 'TomatoGrotesk',
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: isDark ? Colors.white : Colors.black,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications_outlined,
                color: isDark ? Colors.white : Colors.black),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const NotificationsPage()),
              );
            },
          ),
          IconButton(
            icon:
            Icon(Icons.search, color: isDark ? Colors.white : Colors.black),
            onPressed: () {},
          ),
          const SizedBox(width: 8),
        ],
      ),

      // BODY
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(bottom: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // HEADER PROFILE
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => _navigateTo(context, 'Edit Profile'),
                    child: CircleAvatar(
                      radius: 28,
                      backgroundColor:
                      isDark ? Colors.grey[800] : Colors.grey[300],

                      // ⬇ TAMPILKAN FOTO USER
                      backgroundImage: photoUrl != null
                          ? NetworkImage(photoUrl)
                          : const AssetImage('assets/images/verify.png')
                      as ImageProvider,
                    ),
                  ),
                  const SizedBox(width: 12),

                  // TULISAN Hello, <nama>
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Hello,",
                        style: TextStyle(
                          fontSize: 18,
                          color: isDark ? Colors.white : Colors.black,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        displayName,
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFFFFA726),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 8),

            // SHORTCUT BUTTONS
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  Row(
                    children: [
                      _buildShortcut(context, 'Your Order',
                          Icons.receipt_long_outlined, isDark),
                      _buildShortcut(
                          context, 'Wishlist', Icons.favorite_border, isDark),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      _buildShortcut(context, 'Coupons',
                          Icons.local_offer_outlined, isDark),
                      _buildShortcut(context, 'Track Order',
                          Icons.local_shipping_outlined, isDark),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            _buildSectionHeader('Account Settings', isDark),
            _buildSettingsTile(
                context, Icons.person_outline, 'Edit Profile', isDark),
            _buildSettingsTile(
                context, Icons.credit_card, 'Saved Cards & Wallet', isDark),
            _buildSettingsTile(context, Icons.location_on_outlined,
                'Saved Addresses', isDark),
            _buildSettingsTile(
                context, Icons.language, 'Select Language', isDark),
            _buildSettingsTile(context, Icons.notifications_outlined,
                'Notifications Settings', isDark),

            const SizedBox(height: 20),

            _buildSectionHeader('My Activity', isDark),
            _buildSettingsTile(context, Icons.star_border, 'Reviews', isDark),
            _buildSettingsTile(context, Icons.question_answer_outlined,
                'Questions & Answers', isDark),
          ],
        ),
      ),

      bottomNavigationBar: CustomBottomNav(currentIndex: 4, onTap: (_) {}),
    );
  }

  Widget _buildShortcut(
      BuildContext context, String label, IconData icon, bool isDark) {
    return Expanded(
      child: GestureDetector(
        onTap: () => _navigateTo(context, label),
        child: Container(
          height: 56,
          margin: const EdgeInsets.symmetric(horizontal: 6),
          decoration: BoxDecoration(
            color: isDark ? Colors.grey[850] : Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(isDark ? 0.3 : 0.1),
                blurRadius: 8,
                spreadRadius: 1,
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: const Color(0xFFFFA726), size: 20),
              const SizedBox(width: 8),
              Text(
                label,
                style: TextStyle(
                  fontFamily: 'TomatoGrotesk',
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: isDark ? Colors.white : Colors.black87,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title, bool isDark) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Text(
        title,
        style: TextStyle(
          fontFamily: 'TomatoGrotesk',
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: isDark ? Colors.white : Colors.black87,
        ),
      ),
    );
  }

  Widget _buildSettingsTile(
      BuildContext context, IconData icon, String title, bool isDark) {
    final bool isLanguage = title == 'Select Language';

    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16),
      leading: isLanguage
          ? CircleAvatar(
        radius: 20,
        backgroundColor: const Color(0xFFFFA726).withOpacity(0.12),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Image.asset(selectedFlag, width: 24, height: 24),
        ),
      )
          : Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: const Color(0xFFFFA726).withOpacity(0.12),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: const Color(0xFFFFA726), size: 20),
      ),
      title: isLanguage
          ? Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: TextStyle(
                  fontFamily: 'TomatoGrotesk',
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: isDark ? Colors.white : Colors.black)),
          Text(selectedLang,
              style: TextStyle(
                  fontFamily: 'TomatoGrotesk',
                  fontSize: 12,
                  color: isDark ? Colors.grey[400] : Colors.grey[700])),
        ],
      )
          : Text(title,
          style: TextStyle(
              fontFamily: 'TomatoGrotesk',
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: isDark ? Colors.white : Colors.black)),
      trailing: Icon(Icons.chevron_right,
          color: isDark ? Colors.grey[600] : Colors.grey),
      onTap: () => _navigateTo(context, title),
    );
  }
}
