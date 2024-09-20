import 'dart:async';
import 'package:flutter/material.dart';
import 'package:gemini_ai/main.dart';
import '../home/home.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // ضبط مؤقت ليعرض شاشة السبلاش لمدة 3 ثوانٍ قبل الانتقال إلى الشاشة الرئيسية
    Timer(const Duration(seconds: 5), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const BotScreen()),  // الانتقال إلى الشاشة الرئيسية
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,  // لون الخلفية (يمكن تغييره)
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/1.gif'),

            const SizedBox(height: 20),
            // اسم التطبيق
            const Text(
              'Gemini AI Bot',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.purple,
              ),
            ),
            const SizedBox(height: 10),
            // رسالة ترحيبية
            const Text(
              'Powered by Google Generative AI',
              style: TextStyle(
                fontSize: 16,
                color: Colors.purple,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

