import 'package:flutter/material.dart';
import 'reset_password_screen.dart'; // pastikan file ini ada dan benar namanya

class VerifyCodeScreen extends StatefulWidget {
  const VerifyCodeScreen({super.key});

  @override
  State<VerifyCodeScreen> createState() => _VerifyCodeScreenState();
}

class _VerifyCodeScreenState extends State<VerifyCodeScreen> {
  static const Color creamColor = Color(0xFFFDD096);

  void _verifyCode() {
    // langsung pindah tanpa validasi
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const ResetPasswordScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Stack(
        children: [
          // Background Image (Top)
          SizedBox(
            height: height * 0.4,
            width: double.infinity,
            child: Image.asset(
              'assets/images/verify.png',
              fit: BoxFit.cover,
            ),
          ),

          // White Card (Bottom)
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: height * 0.68,
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 28),
              child: Column(
                children: [
                  const Text(
                    'Enter Code',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'TomatoGrotesk',
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'An Authentication Code Has Sent To testing@gmail.com',
                    style: TextStyle(
                      color: Colors.black54,
                      fontFamily: 'TomatoGrotesk',
                      fontSize: 14,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 40),

                  // OTP Fields (tampilan saja)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: List.generate(
                      4,
                      (index) => Container(
                        width: 55,
                        height: 55,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade100,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Text(
                          '-',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.black26,
                            fontFamily: 'TomatoGrotesk',
                          ),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  TextButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Verification code resent!'),
                        ),
                      );
                    },
                    child: const Text(
                      'If you don\'t receive code! Resend',
                      style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'TomatoGrotesk',
                        fontSize: 14,
                      ),
                    ),
                  ),

                  const Spacer(),

                  // Button langsung aktif
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _verifyCode,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: creamColor,
                        foregroundColor: Colors.black,
                        shape: const StadiumBorder(),
                        elevation: 0,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                      child: const Text(
                        'Verify And Proceed',
                        style: TextStyle(
                          fontFamily: 'TomatoGrotesk',
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),

                  // === BACK TO SIGN IN ===
                  Center(
                    child: RichText(
                      text: TextSpan(
                        style: const TextStyle(
                          fontFamily: 'TomatoGrotesk',
                          fontSize: 15,
                        ),
                        children: [
                          const TextSpan(
                            text: 'Back To ',
                            style: TextStyle(color: Colors.black87),
                          ),
                          WidgetSpan(
                            alignment: PlaceholderAlignment.middle,
                            child: GestureDetector(
                              onTap: () => Navigator.popUntil(
                                context,
                                ModalRoute.withName('/login'),
                              ),
                              child: const Text(
                                'Sign In',
                                style: TextStyle(
                                  color: creamColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Back Arrow
          Positioned(
            top: 40,
            left: 16,
            child: IconButton(
              icon: const Icon(
                Icons.arrow_back_ios_new_rounded,
                color: Colors.white,
              ),
              onPressed: () => Navigator.pop(context),
            ),
          ),
        ],
      ),
    );
  }
}
