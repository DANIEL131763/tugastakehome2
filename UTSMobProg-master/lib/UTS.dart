
import 'package:flutter/material.dart';

import 'pages/home_page.dart';
import 'pages/calculator_page.dart';
import 'pages/information_page.dart';
import 'pages/profile_page.dart';
import 'utils/tax_utils.dart';

// Mengatur nama, tema, dan halaman awal aplikasi
class TaxMateApp extends StatelessWidget {
  const TaxMateApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TaxMate',

      // Mengatur tema dan warna utama aplikasi
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: lightBg,
        colorScheme: ColorScheme.fromSeed(seedColor: navy),
        appBarTheme: const AppBarTheme(
          backgroundColor: navy,
          foregroundColor: Colors.white,
          centerTitle: false,
        ),
      ),

      // Menampilkan navigasi utama setelah aplikasi dibuka
      home: const MainNavigation(),
    );
  }
}

// Mengatur perpindahan antarhalaman melalui menu bawah
class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  // Menentukan indeks halaman yang sedang dipilih
  int selectedIndex = 0;

  // Menyimpan daftar halaman aplikasi
  final pages = const [
    HomePage(),
    CalculatorPage(),
    InformationPage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Menampilkan halaman sesuai indeks yang dipilih
      body: IndexedStack(
        index: selectedIndex,
        children: pages,
      ),

      // Membuat menu navigasi di bagian bawah aplikasi
      bottomNavigationBar: NavigationBar(
        selectedIndex: selectedIndex,

        // Memperbarui halaman saat menu dipilih
        onDestinationSelected: (index) {
          setState(() {
            selectedIndex = index;
          });
        },

        backgroundColor: Colors.white,
        indicatorColor: gold.withValues(alpha: 0.25),

        // Daftar menu navigasi aplikasi
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: 'Beranda',
          ),
          NavigationDestination(
            icon: Icon(Icons.calculate_outlined),
            selectedIcon: Icon(Icons.calculate),
            label: 'Kalkulator',
          ),
          NavigationDestination(
            icon: Icon(Icons.menu_book_outlined),
            selectedIcon: Icon(Icons.menu_book),
            label: 'Informasi',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            selectedIcon: Icon(Icons.person),
            label: 'Profil',
          ),
        ],
      ),
    );
  }
}