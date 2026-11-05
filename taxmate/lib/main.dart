import 'package:flutter/material.dart';

void main() {
  runApp(const TaxMateApp());
}

class TaxMateApp extends StatelessWidget {
  const TaxMateApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TaxMate',
      // 1. SETUP TEMA WARNA NAVY & GOLD
      theme: ThemeData(
        primaryColor: const Color(0xFF000080), // Navy Blue
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF000080),
          secondary: const Color(0xFFFFD700), // Gold
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF000080),
          foregroundColor: Colors.white, // Teks AppBar putih
        ),
        scaffoldBackgroundColor: Colors.grey[100],
      ),

      // 2. SETUP NAVIGASI (ROUTES)
      initialRoute: '/',
      routes: {
        '/': (context) => const HomeScreen(),
        '/calculator': (context) => const CalculatorScreen(),
        '/information': (context) => const InformationScreen(),
        '/profile': (context) => const ProfileScreen(),
      },
    );
  }
}

// ==========================================
// 3. KERANGKA HALAMAN KOSONG
// (Nanti bisa dipisah ke file masing-masing)
// ==========================================

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('TaxMate - Home')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, '/calculator'),
              child: const Text('Ke Kalkulator'),
            ),
            // Tambahkan tombol lain untuk test navigasi
          ],
        ),
      ),
    );
  }
}

class CalculatorScreen extends StatelessWidget {
  const CalculatorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Kalkulator Pajak')),
      // Nanti kamu tambahkan TextField, Dropdown, Radio di sini
      body: const Center(child: Text('Halaman Kalkulator (Bagian Daniel & Nelson)')),
    );
  }
}

class InformationScreen extends StatelessWidget {
  const InformationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Informasi Perpajakan')),
      // Nanti Yosia akan nambahin API ListView di sini
      body: const Center(child: Text('Halaman Informasi (Bagian Yosia)')),
    );
  }
}

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profil Pengguna')),
      // Nanti kamu tambahkan Toggle/Switch di sini
      body: const Center(child: Text('Halaman Profil')),
    );
  }
}