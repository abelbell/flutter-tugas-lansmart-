import 'package:eyewear_shop/firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';

// Providers
import 'providers/keranjang_provider.dart';
import 'providers/theme_provider.dart';
import 'providers/auth_provider.dart';  // ⬅️ WAJIB DITAMBAHKAN

// Screens
import 'screens/load/load_screen.dart';
import 'screens/splash/splash_screen.dart';
import 'screens/onboarding/onboarding_screen.dart';
import 'screens/auth/login_screen.dart';
import 'screens/auth/register_screen.dart';
import 'screens/auth/forgot_password_screen.dart';
import 'screens/home/home_page.dart';
import 'screens/category/category_screen.dart';
import 'screens/wishlist/wishlist_page.dart';
import 'screens/cart/cart_page.dart';
import 'screens/orders/orders_page.dart';
import 'screens/profile/profile_page.dart';
import 'screens/notifications/notifications_page.dart';
import 'screens/product/product_detail_screen.dart';

// 🔥 Firebase Config
// const firebaseConfig = FirebaseOptions(
//   apiKey: "ISI DARI FIREBASE",
//   authDomain: "ISI DARI FIREBASE",
//   projectId: "ISI DARI FIREBASE",
//   storageBucket: "ISI DARI FIREBASE",
//   messagingSenderId: "ISI DARI FIREBASE",
//   appId: "ISI DARI FIREBASE",
// );

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // ⬅️ INISIALISASI FIREBASE DARI firebase_options.dart
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => KeranjangProvider()),
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => AuthProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'LensMart',
      theme: ThemeProvider.lightTheme,
      darkTheme: ThemeProvider.darkTheme,
      themeMode: themeProvider.themeMode,

      home: const LoadScreen(),
      routes: {
        '/splash': (context) => const SplashScreen(),
        '/onboarding': (context) => const OnboardingScreen(),
        '/login': (context) => const LoginScreen(),
        '/register': (context) => const RegisterScreen(),
        '/forgot': (context) => const ForgotPasswordScreen(),
        '/home': (context) => const HomePage(),
        '/category': (context) => const CategoryScreen(),
        '/wishlist': (context) => const WishlistPage(),
        '/cart': (context) => const CartPage(),
        '/orders': (context) => const OrdersPage(),
        '/profile': (context) => const ProfilePage(),
        '/notifications': (context) => const NotificationsPage(),
      },
      onGenerateRoute: (settings) {
        if (settings.name == '/product-detail') {
          final args = settings.arguments as Map<String, dynamic>?;
          if (args != null) {
            return MaterialPageRoute(
              builder: (context) => ProductDetailScreen(product: args),
            );
          }
        }
        return null;
      },
    );
  }
}
