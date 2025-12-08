// lib/models/forgot_password_screen.dart
import 'package:flutter/material.dart';
import 'verify_code_screen.dart'; // pastikan file ini ada di folder yang sama

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _emailController = TextEditingController();
  static const Color creamColor = Color(0xFFFFD794);

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            // === BACKGROUND IMAGE (TOP 40%) ===
            SizedBox(
              height: height * 0.4,
              width: double.infinity,
              child: Image.asset(
                'assets/images/forgot.png',
                fit: BoxFit.cover,
              ),
            ),

            // === WHITE CARD (BOTTOM 60%) ===
            Container(
              margin: EdgeInsets.only(top: height * 0.35),
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(24, 32, 24, 16),
                child: Column(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // === TITLE ===
                            const Text(
                              'Forgot Password',
                              style: TextStyle(
                                fontSize: 26,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'TomatoGrotesk',
                                color: Colors.black87,
                              ),
                            ),
                            const SizedBox(height: 8),

                            const Text(
                              'Enter the email associated with your account and we\'ll send an email to reset your password.',
                              style: TextStyle(
                                color: Colors.black54,
                                fontSize: 15,
                                fontFamily: 'TomatoGrotesk',
                              ),
                            ),
                            const SizedBox(height: 28),

                            // === EMAIL LABEL + FIELD ===
                            _buildLabel('Email Address', isRequired: true),
                            const SizedBox(height: 8),
                            _buildTextField(
                              _emailController,
                              hint: '',
                            ),
                            const SizedBox(height: 25),
                          ],
                        ),
                      ),
                    ),

                    // === SEND MAIL BUTTON ===
                    SizedBox(
                      width: double.infinity,
                      height: 54,
                      child: ElevatedButton(
                        onPressed: () {
                          // langsung navigasi tanpa validasi
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const VerifyCodeScreen(),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: creamColor,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        child: const Text(
                          'Send Mail',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                            fontFamily: 'TomatoGrotesk',
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 10),

                    // === BACK TO SIGN IN ===
                    Center(
                      child: TextButton(
                        onPressed: () => Navigator.pop(context),
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.zero,
                          minimumSize: Size.zero,
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                        child: RichText(
                          text: const TextSpan(
                            style: TextStyle(
                              fontFamily: 'TomatoGrotesk',
                              fontSize: 15,
                            ),
                            children: [
                              TextSpan(
                                text: 'Back To ',
                                style: TextStyle(color: Colors.black87),
                              ),
                              TextSpan(
                                text: 'Sign In',
                                style: TextStyle(
                                  color: creamColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // === BACK ARROW (TOP LEFT) ===
            Positioned(
              top: 10,
              left: 10,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.3),
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  icon: const Icon(Icons.arrow_back,
                      color: Colors.white, size: 20),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // === LABEL ===
  Widget _buildLabel(String text, {bool isRequired = false}) {
    return RichText(
      text: TextSpan(
        style: const TextStyle(
          fontFamily: 'TomatoGrotesk',
          fontSize: 14,
          color: Colors.black87,
        ),
        children: [
          TextSpan(text: text),
          if (isRequired)
            const TextSpan(
              text: ' *',
              style: TextStyle(color: Colors.red),
            ),
        ],
      ),
    );
  }

  // === TEXT FIELD ===
  Widget _buildTextField(
    TextEditingController controller, {
    required String hint,
  }) {
    return TextField(
      controller: controller,
      style: const TextStyle(fontFamily: 'TomatoGrotesk'),
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(
          color: Colors.grey.shade400,
          fontFamily: 'TomatoGrotesk',
        ),
        filled: true,
        fillColor: Colors.grey.shade50,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(16)),
          borderSide: BorderSide(color: creamColor, width: 1.5),
        ),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
      ),
    );
  }
}
