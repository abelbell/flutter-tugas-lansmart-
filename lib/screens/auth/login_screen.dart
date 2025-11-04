import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passController = TextEditingController();

  static const Color creamColor = Color(0xFFFDD096);

  @override
  void dispose() {
    _emailController.dispose();
    _passController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Stack(
            children: [
              // === BACKGROUND IMAGE ===
              SizedBox(
                height: height * 0.35,
                width: double.infinity,
                child: Image.asset(
                  'assets/images/signin.png',
                  fit: BoxFit.cover,
                ),
              ),

              // === WHITE CARD (OVERLAP LENGKUNG) ===
              Container(
                margin: EdgeInsets.only(top: height * 0.3),
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
                ),
                padding: const EdgeInsets.fromLTRB(24, 32, 24, 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Sign In To Your Account',
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'TomatoGrotesk',
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 6),
                    const Text(
                      'Welcome Back. You\'ve Been Missed!',
                      style: TextStyle(
                        color: Colors.black54,
                        fontSize: 15,
                        fontFamily: 'TomatoGrotesk',
                      ),
                    ),
                    const SizedBox(height: 28),

                    // EMAIL FIELD
                    _buildLabel('Email Address', isRequired: true),
                    const SizedBox(height: 8),
                    _buildTextField(_emailController, hint: ''),
                    const SizedBox(height: 16),

                    // PASSWORD FIELD
                    _buildLabel('Password', isRequired: true),
                    const SizedBox(height: 8),
                    _buildTextField(_passController, hint: '', isPassword: true),
                    const SizedBox(height: 10),

                    // Forgot Password
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () =>
                            Navigator.pushNamed(context, '/forgot'),
                        child: const Text(
                          'Forgot Password?',
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'TomatoGrotesk',
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),

                    // SIGN IN BUTTON
                    SizedBox(
                      width: double.infinity,
                      height: 56,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pushReplacementNamed(context, '/home');
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: creamColor,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        child: const Text(
                          'Sign In',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                            fontFamily: 'TomatoGrotesk',
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),

                    // OR CONTINUE WITH
                    Row(
                      children: [
                        Expanded(child: Divider(color: Colors.grey.shade800)),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: Text(
                            'Or Continue With',
                            style: TextStyle(
                              color: Colors.grey.shade800,
                              fontSize: 14,
                              fontFamily: 'TomatoGrotesk',
                            ),
                          ),
                        ),
                        Expanded(child: Divider(color: Colors.grey.shade800)),
                      ],
                    ),
                    const SizedBox(height: 20),

                    // GOOGLE & APPLE BUTTONS
                    Column(
                      children: [
                        _socialButton(
                          icon: Image.asset(
                            'assets/images/google.png',
                            height: 20,
                            width: 20,
                            errorBuilder: (_, __, ___) =>
                                const Icon(Icons.g_mobiledata, size: 20),
                          ),
                          text: 'Sign In With Google',
                        ),
                        const SizedBox(height: 12),
                        _socialButton(
                          icon: const Icon(Icons.apple,
                              color: Colors.black, size: 26),
                          text: 'Sign In With Apple',
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),

                    // CREATE ACCOUNT
                    Center(
                      child: TextButton(
                        onPressed: () =>
                            Navigator.pushNamed(context, '/register'),
                        child: RichText(
                          text: TextSpan(
                            style: const TextStyle(
                              color: Colors.black87,
                              fontSize: 15,
                              fontFamily: 'TomatoGrotesk',
                            ),
                            children: [
                              const TextSpan(text: 'Not a member? '),
                              TextSpan(
                                text: 'Create an account',
                                style: TextStyle(
                                  color: creamColor,
                                  fontWeight: FontWeight.w600,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    // JARAK BAWAH SEDIKIT (rapat ke bawah)
                    SizedBox(height: MediaQuery.of(context).padding.bottom + 4),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

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

  Widget _buildTextField(
    TextEditingController controller, {
    required String hint,
    bool isPassword = false,
  }) {
    return TextField(
      controller: controller,
      obscureText: isPassword,
      style: const TextStyle(fontFamily: 'TomatoGrotesk'),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(color: Colors.grey.shade400, fontFamily: 'TomatoGrotesk'),
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
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide:
              const BorderSide(color: _LoginScreenState.creamColor, width: 1.5),
        ),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
      ),
    );
  }

  Widget _socialButton({
    required Widget icon,
    required String text,
  }) {
    return Container(
      width: double.infinity,
      height: 56,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Center(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            icon,
            const SizedBox(width: 12),
            Text(
              text,
              style: const TextStyle(
                fontFamily: 'TomatoGrotesk',
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
