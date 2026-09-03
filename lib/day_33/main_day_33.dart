import 'package:flutter/material.dart';
import 'views/splash_view.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const Day33App());
}

class Day33App extends StatelessWidget {
  const Day33App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tugas 16 Flutter - Autentikasi & CRUD Profile',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF4A00E0),
          primary: const Color(0xFF4A00E0),
          secondary: const Color(0xFF8E2DE2),
        ),
        useMaterial3: true,
      ),
      home: const SplashView(),
    );
  }
}
