
import 'package:flutter/material.dart';
import '../utils/tax_utils.dart';
import '../widgets/info_card.dart';

// Halaman profil pengguna aplikasi
class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          // Judul halaman profil
          const Text(
            'Profil',
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
              color: navy,
            ),
          ),
          const SizedBox(height: 28),

          // Ikon profil pengguna
          const CircleAvatar(
            radius: 42,
            backgroundColor: navy,
            child: Icon(
              Icons.person,
              color: Colors.white,
              size: 45,
            ),
          ),
          const SizedBox(height: 14),

          // Nama tampilan pengguna
          const Text(
            'Pengguna TaxMate',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 21,
              fontWeight: FontWeight.bold,
              color: navy,
            ),
          ),
          const SizedBox(height: 28),

          // Menu informasi data pengguna
          const InfoCard(
            icon: Icons.person_outline,
            title: 'Data Pengguna',
            subtitle: 'Kelola informasi profil',
          ),

          // Menu pengaturan aplikasi
          const InfoCard(
            icon: Icons.settings_outlined,
            title: 'Pengaturan',
            subtitle: 'Preferensi aplikasi',
          ),

          // Informasi singkat mengenai aplikasi
          const InfoCard(
            icon: Icons.info_outline,
            title: 'Tentang TaxMate',
            subtitle: 'Aplikasi simulasi kalkulator pajak',
          ),
        ],
      ),
    );
  }
}