import 'package:flutter/material.dart';
import 'info_pajak_page.dart';
import 'home_page.dart';
import 'form_pajak_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Kalkulator Pajak',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.grey[100],
      ),
      home: const MainNavigation(),
    );
  }
}

// Navigasi Utama Aplikasi
class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _currentIndex = 0;

  // Daftar halaman. Index 0 dan 1 adalah placeholder untuk Nelson & Yosia.
  // Index 2 adalah halaman buatanmu.
  final List<Widget> _pages = const [
    HomePagePlaceholder(),     // Porsi Nelson/Yosia
    FormPajakPlaceholder(),    // Porsi Nelson/Yosia
    InfoPajakPage(),           // Porsi Daniel
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        selectedItemColor: Colors.blue[800],
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: 'Beranda',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calculate_outlined),
            activeIcon: Icon(Icons.calculate),
            label: 'Kalkulator',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.article_outlined),
            activeIcon: Icon(Icons.article),
            label: 'Info Pajak',
          ),
        ],
      ),
    );
  }
}

// ==============================================================
// PLACEHOLDER UNTUK TEMANMU (Tinggal mereka ubah nanti)
// ==============================================================
class HomePagePlaceholder extends StatelessWidget {
  const HomePagePlaceholder({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Beranda', style: TextStyle(color: Colors.white)), backgroundColor: Colors.blue[800]),
      body: const Center(child: Text('Halaman Home (Tugas Nelson/Yosia)')),
    );
  }
}

class FormPajakPlaceholder extends StatelessWidget {
  const FormPajakPlaceholder({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Kalkulator', style: TextStyle(color: Colors.white)), backgroundColor: Colors.blue[800]),
      body: const Center(child: Text('Halaman Form Pajak (Tugas Nelson/Yosia)')),
    );
  }
}