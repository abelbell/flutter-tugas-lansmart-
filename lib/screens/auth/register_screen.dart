import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  static const Color creamColor = Color(0xFFFDD096);

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passController = TextEditingController();
  bool _agree = false; // tetap ada untuk UI, tapi tidak digunakan

  @override
  void dispose() {
    _nameController.dispose();
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
                  'assets/images/create.png',
                  fit: BoxFit.cover,
                ),
              ),

              // === WHITE CARD (OVERLAP CURVE) ===
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
                      'Create Your Account',
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'TomatoGrotesk',
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 6),
                    const Text(
                      'Welcome! Please fill in the details below',
                      style: TextStyle(
                        color: Colors.black54,
                        fontSize: 15,
                        fontFamily: 'TomatoGrotesk',
                      ),
                    ),
                    const SizedBox(height: 28),

                    // NAME FIELD
                    _buildLabel('Full Name', isRequired: true),
                    const SizedBox(height: 8),
                    _buildTextField(_nameController, hint: ''),
                    const SizedBox(height: 16),

                    // EMAIL FIELD
                    _buildLabel('Email', isRequired: true),
                    const SizedBox(height: 8),
                    _buildTextField(
                      _emailController,
                      hint: '',
                      keyboardType: TextInputType.emailAddress,
                    ),
                    const SizedBox(height: 16),

                    // PASSWORD FIELD
                    _buildLabel('Password', isRequired: true),
                    const SizedBox(height: 8),
                    _buildTextField(_passController,
                        hint: '', isPassword: true),
                    const SizedBox(height: 16),

                    // AGREEMENT CHECKBOX (UI only, tidak berpengaruh)
                    Row(
                      children: [
                        Checkbox(
                          value: _agree,
                          onChanged: (v) => setState(() => _agree = v ?? false),
                          activeColor: creamColor,
                        ),
                        const Expanded(
                          child: Text(
                            'I agree to all Terms, Privacy and Fees',
                            style: TextStyle(
                              fontFamily: 'TomatoGrotesk',
                              color: Colors.black87,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),

                    // SIGN UP BUTTON (SEKARANG SELALU AKTIF)
                    SizedBox(
                      width: double.infinity,
                      height: 56,
                      child: ElevatedButton(
                        onPressed: () {
                          // Langsung ke halaman login, tanpa validasi
                          Navigator.pushReplacementNamed(context, '/login');
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: creamColor,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        child: const Text(
                          'Sign Up',
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

                    // SOCIAL BUTTONS
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
                          text: 'Sign Up With Google',
                        ),
                        const SizedBox(height: 12),
                        _socialButton(
                          icon: const Icon(Icons.apple,
                              color: Colors.black, size: 26),
                          text: 'Sign Up With Apple',
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),

                    // ALREADY HAVE ACCOUNT
                    Center(
                      child: TextButton(
                        onPressed: () => Navigator.pushNamed(context, '/login'),
                        child: RichText(
                          text: TextSpan(
                            style: const TextStyle(
                              color: Colors.black87,
                              fontSize: 15,
                              fontFamily: 'TomatoGrotesk',
                            ),
                            children: [
                              const TextSpan(text: 'Already have an account? '),
                              TextSpan(
                                text: 'Sign In',
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

                    SizedBox(height: MediaQuery.of(context).padding.bottom + 4),
                  ],
                ),
              ),

              // BACK BUTTON
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
      ),
    );
  }

  // === REUSABLE LABEL ===
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

  // === REUSABLE TEXTFIELD ===
  Widget _buildTextField(
    TextEditingController controller, {
    required String hint,
    bool isPassword = false,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextField(
      controller: controller,
      obscureText: isPassword,
      keyboardType: keyboardType,
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
        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(16)),
          borderSide: BorderSide(color: creamColor, width: 1.5),
        ),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
      ),
    );
  }

  // === REUSABLE SOCIAL BUTTON ===
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