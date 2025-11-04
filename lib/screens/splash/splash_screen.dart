import 'package:flutter/material.dart';
import 'dart:async';
import '../onboarding/onboarding_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _logoCtrl;
  late final Animation<double> _logoScale;
  late final Animation<double> _logoFade;

  final String _text = 'LensMart';
  final List<bool> _letterVisible = List.filled(8, false);
  Timer? _letterTimer;

  @override
  void initState() {
    super.initState();

    _logoCtrl = AnimationController(
      duration: const Duration(milliseconds: 700),
      vsync: this,
    );

    _logoScale = Tween<double>(begin: 0.3, end: 1.0).animate(
      CurvedAnimation(parent: _logoCtrl, curve: Curves.easeOutBack),
    );

    _logoFade = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _logoCtrl, curve: Curves.easeIn),
    );

    // Jalankan animasi tanpa frame kosong
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await _logoCtrl.forward();
      _startLetterAnimation();
    });

    // Setelah semua animasi selesai → langsung ke Onboarding
    Future.delayed(const Duration(milliseconds: 1800), () {
      if (!mounted) return;
      Navigator.of(context).pushReplacement(
        PageRouteBuilder(
          pageBuilder: (_, __, ___) => const OnboardingScreen(),
          transitionsBuilder: (_, animation, __, child) =>
              FadeTransition(opacity: animation, child: child),
          transitionDuration: const Duration(milliseconds: 300),
        ),
      );
    });
  }

  void _startLetterAnimation() {
    int index = 0;
    _letterTimer = Timer.periodic(const Duration(milliseconds: 70), (timer) {
      if (index < _text.length) {
        setState(() => _letterVisible[index] = true);
        index++;
      } else {
        timer.cancel();
      }
    });
  }

  @override
  void dispose() {
    _logoCtrl.dispose();
    _letterTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'assets/images/bg1.png',
            fit: BoxFit.cover,
          ),
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                FadeTransition(
                  opacity: _logoFade,
                  child: ScaleTransition(
                    scale: _logoScale,
                    child: Image.asset(
                      'assets/images/logo.png',
                      height: 100,
                      errorBuilder: (_, __, ___) => const Icon(
                        Icons.visibility,
                        size: 90,
                        color: Colors.orange,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: _buildLetters(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildLetters() {
    return List.generate(_text.length, (i) {
      final char = _text[i];
      final isBold = i < 4;
      return AnimatedSlide(
        offset: _letterVisible[i] ? Offset.zero : const Offset(0, 1.5),
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOutBack,
        child: AnimatedOpacity(
          opacity: _letterVisible[i] ? 1.0 : 0.0,
          duration: const Duration(milliseconds: 180),
          child: Text(
            char,
            style: TextStyle(
              fontFamily: 'TomatoGrotesk',
              fontSize: 42,
              fontWeight: isBold ? FontWeight.w700 : FontWeight.w400,
              color: Colors.black,
              letterSpacing: 1.2,
            ),
          ),
        ),
      );
    });
  }
}
