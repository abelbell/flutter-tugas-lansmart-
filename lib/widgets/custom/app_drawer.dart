import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/theme_provider.dart';
import '../../screens/splash/splash_screen.dart';
import '../../screens/home/home_page.dart';
import '../../screens/components/components_page.dart';
import '../../screens/pages/pages_page.dart' hide WishlistPage, CartPage;
import '../../screens/profile/profile_page.dart';
import '../../screens/chat/chat_list_page.dart';
import '../../screens/wishlist/wishlist_page.dart';
import '../../screens/cart/cart_page.dart';
import '../../screens/product/product_list_screen.dart';
import '../../screens/orders/orders_page.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Drawer(
      child: Column(
        children: [
          // HEADER
          UserAccountsDrawerHeader(
            accountName: Text(
              'Roopa',
              style: TextStyle(
                fontFamily: 'TomatoGrotesk',
                fontWeight: FontWeight.bold,
                color: isDark ? Colors.white : Colors.black,
              ),
            ),
            accountEmail: Text(
              'example@gmail.com',
              style: TextStyle(
                fontFamily: 'TomatoGrotesk',
                color: isDark ? Colors.white70 : Colors.black54,
              ),
            ),
            currentAccountPicture: const CircleAvatar(
              backgroundImage: AssetImage('assets/images/banner.png'),
            ),
            decoration: BoxDecoration(
              color: isDark ? Colors.grey[850] : Colors.white,
            ),
            margin: EdgeInsets.zero,
          ),

          // MENU ITEMS
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                _buildMenuItem(
                  context,
                  Icons.home_outlined,
                  'Home',
                  () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const HomePage(),
                      ),
                    );
                  },
                ),
                _buildMenuItem(
                  context,
                  Icons.shopping_bag_outlined,
                  'Products',
                  () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ProductListScreen(title: 'Products'),
                      ),
                    );
                  },
                ),
                _buildMenuItem(
                  context,
                  Icons.grid_view_outlined,
                  'Components',
                  () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ComponentsPage(),
                      ),
                    );
                  },
                ),
                _buildMenuItem(
                  context,
                  Icons.description_outlined,
                  'Pages',
                  () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const PagesPage(),
                      ),
                    );
                  },
                ),
                _buildMenuItem(
                  context,
                  Icons.star_border_outlined,
                  'Featured',
                  () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ProductListScreen(title: 'Featured Products'),
                      ),
                    );
                  },
                ),
                _buildMenuItem(
                  context,
                  Icons.favorite_border,
                  'Wishlist',
                  () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const WishlistPage(),
                      ),
                    );
                  },
                ),
                _buildMenuItem(
                  context,
                  Icons.receipt_long_outlined,
                  'Orders',
                  () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const OrdersPage(),
                      ),
                    );
                  },
                ),
                _buildMenuItem(
                  context,
                  Icons.shopping_cart_outlined,
                  'My Cart',
                  () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const CartPage(),
                      ),
                    );
                  },
                ),
                _buildMenuItem(
                  context,
                  Icons.person_outline,
                  'Profile',
                  () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ProfilePage(),
                      ),
                    );
                  },
                ),
                _buildMenuItem(
                  context,
                  Icons.chat_outlined,
                  'Chat List',
                  () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ChatListPage(),
                      ),
                    );
                  },
                ),

                // LOGOUT
                ListTile(
                  leading: const Icon(Icons.logout, color: Color(0xFFFFA726)),
                  title: Text(
                    'Logout',
                    style: TextStyle(
                      fontFamily: 'TomatoGrotesk',
                      color: isDark ? Colors.white : Colors.black,
                    ),
                  ),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () async {
                    Navigator.of(context).pop();
                    await Future.delayed(const Duration(milliseconds: 250));
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SplashScreen(),
                      ),
                      (route) => false,
                    );
                  },
                ),
              ],
            ),
          ),

          // THEME SWITCH
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Theme Option',
                  style: TextStyle(
                    fontFamily: 'TomatoGrotesk',
                    color: isDark ? Colors.white70 : Colors.black54,
                  ),
                ),
                Switch(
                  value: isDark,
                  activeColor: const Color(0xFFFFA726),
                  onChanged: (value) {
                    Provider.of<ThemeProvider>(context, listen: false)
                        .toggleTheme();
                  },
                ),
              ],
            ),
          ),

          // FOOTER
          Container(
            padding: const EdgeInsets.all(16),
            color: isDark ? Colors.grey[800] : Colors.grey[100],
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'LensMart Glasses Store',
                  style: TextStyle(
                    fontFamily: 'TomatoGrotesk',
                    fontWeight: FontWeight.w600,
                    color: Color(0xFFFFA726),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'App Version 1.0',
                  style: TextStyle(
                    fontFamily: 'TomatoGrotesk',
                    color: isDark ? Colors.white60 : Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem(
      BuildContext context, IconData icon, String title, VoidCallback onTap) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return ListTile(
      leading: Icon(icon, color: const Color(0xFFFFA726)),
      title: Text(
        title,
        style: TextStyle(
          fontFamily: 'TomatoGrotesk',
          color: isDark ? Colors.white : Colors.black,
        ),
      ),
      trailing: const Icon(Icons.chevron_right),
      onTap: () async {
        Navigator.pop(context);
        await Future.delayed(const Duration(milliseconds: 150));
        onTap();
      },
    );
  }
}