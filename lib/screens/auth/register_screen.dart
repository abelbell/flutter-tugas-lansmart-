// lib/screens/auth/register_screen.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../providers/auth_provider.dart';

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

  bool _agree = false;
  bool _loading = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passController.dispose();
    super.dispose();
  }

  // ============================================================
  // 🔥 REGISTER MENGGUNAKAN AUTH PROVIDER
  // ============================================================
  Future<void> _register() async {
    if (_nameController.text.trim().isEmpty ||
        _emailController.text.trim().isEmpty ||
        _passController.text.trim().isEmpty) {
      _showMessage("Semua field wajib diisi.");
      return;
    }

    if (!_agree) {
      _showMessage("Kamu harus setuju dengan Terms & Privacy.");
      return;
    }

    setState(() => _loading = true);

    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    String? error = await authProvider.registerUser(
      name: _nameController.text.trim(),
      email: _emailController.text.trim(),
      password: _passController.text.trim(),
    );

    setState(() => _loading = false);

    if (error == null) {
      // sukses
      Navigator.pushReplacementNamed(context, '/home');
    } else {
      // gagal
      _showMessage(error);
    }
  }

  void _showMessage(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          msg,
          style: const TextStyle(fontFamily: 'TomatoGrotesk'),
        ),
        backgroundColor: Colors.redAccent,
      ),
    );
  }

  // ============================================================
  // UI SECTION
  // ============================================================

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
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

                  // === WHITE CARD ===
                  Container(
                    margin: EdgeInsets.only(top: height * 0.3),
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                      BorderRadius.vertical(top: Radius.circular(25)),
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
                        _buildTextField(
                          _passController,
                          hint: '',
                          isPassword: true,
                        ),
                        const SizedBox(height: 16),

                        // AGREEMENT CHECKBOX
                        Row(
                          children: [
                            Checkbox(
                              value: _agree,
                              onChanged: (v) =>
                                  setState(() => _agree = v ?? false),
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

                        // SIGN UP BUTTON
                        SizedBox(
                          width: double.infinity,
                          height: 56,
                          child: ElevatedButton(
                            onPressed: _loading ? null : _register,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: creamColor,
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                            child: _loading
                                ? const CircularProgressIndicator(
                              color: Colors.black,
                            )
                                : const Text(
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

                        // ALREADY HAVE ACCOUNT
                        Center(
                          child: TextButton(
                            onPressed: () =>
                                Navigator.pushNamed(context, '/login'),
                            child: RichText(
                              text: TextSpan(
                                style: const TextStyle(
                                  color: Colors.black87,
                                  fontSize: 15,
                                  fontFamily: 'TomatoGrotesk',
                                ),
                                children: [
                                  const TextSpan(
                                      text: 'Already have an account? '),
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

                        SizedBox(height: MediaQuery.of(context).padding.bottom),
                      ],
                    ),
                  ),
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
                  icon: const Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                    size: 20,
                  ),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // REUSABLE COMPONENTS
  // ============================================================

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
        TextInputType keyboardType = TextInputType.text,
      }) {
    return TextField(
      controller: controller,
      obscureText: isPassword,
      keyboardType: keyboardType,
      style: const TextStyle(fontFamily: 'TomatoGrotesk'),
      decoration: InputDecoration(
        hintText: hint,
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
