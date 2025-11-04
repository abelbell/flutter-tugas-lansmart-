// lib/screens/load/load_screen.dart
import 'package:flutter/material.dart';
import 'dart:async';

class LoadScreen extends StatefulWidget {
  const LoadScreen({super.key});

  @override
  State<LoadScreen> createState() => _LoadScreenState();
}

class _LoadScreenState extends State<LoadScreen> {
  @override
  void initState() {
    super.initState();
    // Load 1–2 detik, lalu masuk HomeScreen
    Timer(const Duration(seconds: 2), () {
      Navigator.pushReplacementNamed(context, '/home');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFDD096), // cream
      body: Center(
        child: SizedBox(
          width: 200,
          height: 200,
          child: Image.asset(
            'assets/images/load.png',
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
