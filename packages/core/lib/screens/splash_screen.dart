import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  final VoidCallback onFinished; // Callback to navigate based on flavor

  const SplashScreen({required this.onFinished});

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 2), onFinished);
    return Scaffold(body: Center(child: FlutterLogo(size: 100)));
  }
}
