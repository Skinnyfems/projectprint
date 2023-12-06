import 'package:flutter/material.dart';
import 'package:easy_splash_screen/easy_splash_screen.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'main.dart'; // Gantilah dengan nama file dan lokasi sesuai struktur proyek Anda

void main() {
  FlutterBluePlus.setLogLevel(LogLevel.verbose, color: true);
  runApp(const MyApp());
}

class SplashScreenPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: EasySplashScreen(
        logo: Image.asset(
            'assets/image.png'), // Ganti dengan path gambar logo Anda
        title: const Text(
          'My App',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20.0,
            color: Colors.white,
          ),
        ),
        backgroundColor: const Color(0xFF5C0087),
        navigator: MaterialPageRoute(builder: (context) => const MyApp()),
        durationInSeconds: 7,
        logoWidth: 100.0,
      ),
    );
  }
}
