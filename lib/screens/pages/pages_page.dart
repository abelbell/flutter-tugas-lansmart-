// lib/screens/pages/pages_page.dart
import 'package:flutter/material.dart';

// ========================================
// TEMPLATE HALAMAN SEDERHANA
// ========================================

class SimplePage extends StatelessWidget {
  final String title;
  
  const SimplePage({
    Key? key,
    required this.title,
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
        title: Text(
          title,
          style: TextStyle(
            fontFamily: 'TomatoGrotesk',
            color: isDark ? Colors.white : Colors.black,
            fontWeight: FontWeight.w600,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.pages_outlined,
              size: 80,
              color: const Color(0xFFFFA726),
            ),
            const SizedBox(height: 16),
            Text(
              title,
              style: TextStyle(
                fontFamily: 'TomatoGrotesk',
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: isDark ? Colors.white : Colors.black,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'This page is under development',
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
// PAGES SPESIFIK
// ========================================

class WelcomePage extends StatelessWidget {
  const WelcomePage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) => const SimplePage(title: 'Welcome');
}

class SignInPage extends StatelessWidget {
  const SignInPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) => const SimplePage(title: 'Sign In');
}

class SignUpPage extends StatelessWidget {
  const SignUpPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) => const SimplePage(title: 'Sign Up');
}

class ForgotPasswordPage extends StatelessWidget {
  const ForgotPasswordPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) => const SimplePage(title: 'Forgot Password');
}

class OTPConfirmPage extends StatelessWidget {
  const OTPConfirmPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) => const SimplePage(title: 'OTP Confirm');
}

class ChangePasswordPage extends StatelessWidget {
  const ChangePasswordPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) => const SimplePage(title: 'Change Password');
}

class WishlistPage extends StatelessWidget {
  const WishlistPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) => const SimplePage(title: 'Wishlist');
}

class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) => const SimplePage(title: 'Cart');
}

class CategoryPage extends StatelessWidget {
  const CategoryPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) => const SimplePage(title: 'Category');
}

class ProductsPage extends StatelessWidget {
  const ProductsPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) => const SimplePage(title: 'Products');
}

class AddCardPage extends StatelessWidget {
  const AddCardPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) => const SimplePage(title: 'Add Card');
}

class CheckoutPage extends StatelessWidget {
  const CheckoutPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) => const SimplePage(title: 'Checkout');
}

class EditProfilePage extends StatelessWidget {
  const EditProfilePage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) => const SimplePage(title: 'Edit Profile');
}

class SearchPage extends StatelessWidget {
  const SearchPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) => const SimplePage(title: 'Search');
}

class NotificationPage extends StatelessWidget {
  const NotificationPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) => const SimplePage(title: 'Notification');
}

class CallPage extends StatelessWidget {
  const CallPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) => const SimplePage(title: 'Call');
}

class MyOrderPage extends StatelessWidget {
  const MyOrderPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) => const SimplePage(title: 'My Order');
}

class TrackOrderPage extends StatelessWidget {
  const TrackOrderPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) => const SimplePage(title: 'Track Order');
}

class WriteReviewPage extends StatelessWidget {
  const WriteReviewPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) => const SimplePage(title: 'Write Review');
}

class CouponsPage extends StatelessWidget {
  const CouponsPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) => const SimplePage(title: 'Coupons');
}

class FAQPage extends StatelessWidget {
  const FAQPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) => const SimplePage(title: 'FAQ');
}

class Error404Page extends StatelessWidget {
  const Error404Page({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) => const SimplePage(title: 'Error - 404');
}

// ========================================
// PAGES PAGE (MAIN)
// ========================================

class PagesPage extends StatelessWidget {
  const PagesPage({Key? key}) : super(key: key);

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
          'Pages',
          style: TextStyle(
            fontFamily: 'TomatoGrotesk',
            color: isDark ? Colors.white : Colors.black,
            fontWeight: FontWeight.w600,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
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
            _buildPageItem(context, 'Welcome', () => _navigateTo(context, const WelcomePage())),
            _buildDivider(isDark),
            _buildPageItem(context, 'Sign In', () => _navigateTo(context, const SignInPage())),
            _buildDivider(isDark),
            _buildPageItem(context, 'Sign Up', () => _navigateTo(context, const SignUpPage())),
            _buildDivider(isDark),
            _buildPageItem(context, 'Forgot Password', () => _navigateTo(context, const ForgotPasswordPage())),
            _buildDivider(isDark),
            _buildPageItem(context, 'OTP Confirm', () => _navigateTo(context, const OTPConfirmPage())),
            _buildDivider(isDark),
            _buildPageItem(context, 'Change Password', () => _navigateTo(context, const ChangePasswordPage())),
            _buildDivider(isDark),
            _buildPageItem(context, 'Home', () => Navigator.pop(context)),
            _buildDivider(isDark),
            _buildPageItem(context, 'Wishlist', () => _navigateTo(context, const WishlistPage())),
            _buildDivider(isDark),
            _buildPageItem(context, 'Cart', () => _navigateTo(context, const CartPage())),
            _buildDivider(isDark),
            _buildPageItem(context, 'Category', () => _navigateTo(context, const CategoryPage())),
            _buildDivider(isDark),
            _buildPageItem(context, 'Profile', () => Navigator.pop(context)),
            _buildDivider(isDark),
            _buildPageItem(context, 'Products', () => _navigateTo(context, const ProductsPage())),
            _buildDivider(isDark),
            _buildPageItem(context, 'Add Card', () => _navigateTo(context, const AddCardPage())),
            _buildDivider(isDark),
            _buildPageItem(context, 'Checkout', () => _navigateTo(context, const CheckoutPage())),
            _buildDivider(isDark),
            _buildPageItem(context, 'Edit Profile', () => _navigateTo(context, const EditProfilePage())),
            _buildDivider(isDark),
            _buildPageItem(context, 'Search', () => _navigateTo(context, const SearchPage())),
            _buildDivider(isDark),
            _buildPageItem(context, 'Notification', () => _navigateTo(context, const NotificationPage())),
            _buildDivider(isDark),
            _buildPageItem(context, 'Chat List', () => Navigator.pop(context)),
            _buildDivider(isDark),
            _buildPageItem(context, 'Chat', () => Navigator.pop(context)),
            _buildDivider(isDark),
            _buildPageItem(context, 'Call', () => _navigateTo(context, const CallPage())),
            _buildDivider(isDark),
            _buildPageItem(context, 'My Order', () => _navigateTo(context, const MyOrderPage())),
            _buildDivider(isDark),
            _buildPageItem(context, 'Track Order', () => _navigateTo(context, const TrackOrderPage())),
            _buildDivider(isDark),
            _buildPageItem(context, 'Write Review', () => _navigateTo(context, const WriteReviewPage())),
            _buildDivider(isDark),
            _buildPageItem(context, 'Coupons', () => _navigateTo(context, const CouponsPage())),
            _buildDivider(isDark),
            _buildPageItem(context, 'FAQ', () => _navigateTo(context, const FAQPage())),
            _buildDivider(isDark),
            _buildPageItem(context, 'Error - 404', () => _navigateTo(context, const Error404Page())),
          ],
        ),
      ),
    );
  }

  void _navigateTo(BuildContext context, Widget page) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => page),
    );
  }

  Widget _buildPageItem(BuildContext context, String title, VoidCallback onTap) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: const Color(0xFFFFA726),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Center(
                child: Text(
                  'B',
                  style: TextStyle(
                    fontFamily: 'TomatoGrotesk',
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontFamily: 'TomatoGrotesk',
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: isDark ? Colors.white : Colors.black,
                ),
              ),
            ),
            Icon(
              Icons.chevron_right,
              color: isDark ? Colors.white60 : Colors.grey,
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
      indent: 72,
      color: isDark ? Colors.grey[700] : const Color(0xFFE0E0E0),
    );
  }
}