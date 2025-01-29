import 'package:flutter/material.dart';
import 'dart:async';
import 'onboarding_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;

  static const int splashDuration = 3;

  @override
  void initState() {
    super.initState();

    //　アニメーション初期化
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1), // 1秒間のアニメーション
    );

    _fadeAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
    );

    _controller.forward();

    // Splash screenの表示後、Onboarding screenに遷移
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(const Duration(seconds: splashDuration), () {
        if (mounted) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => OnboardingScreen()),
          );
        }
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFDF3E7),
      body: Center(
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.create,
                size: 100,
                color: Colors.black,
              ), // 로고
              SizedBox(height: 16),
              Text(
                'Plan Us',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Spacer(),
              Text(
                'Copyrights 2025. ITSolutions. All rights reserved.',
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
              SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
