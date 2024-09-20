import 'package:flutter/material.dart';
import 'package:gemini_ai/Featuers/splashe/splash_screen.dart';

void main() => runApp(GeminiAIApp());

class GeminiAIApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}

