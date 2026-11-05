
import 'package:flutter/material.dart';
import '../utils/tax_utils.dart';

// Widget untuk menampilkan kartu informasi
class InfoCard extends StatelessWidget {
  // Data informasi yang ditampilkan
  final IconData icon;
  final String title;
  final String subtitle;

  // Constructor untuk menerima data informasi
  const InfoCard({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      // Mengatur jarak di bagian bawah kartu
      margin: const EdgeInsets.only(bottom: 10),

      // Mengatur jarak antara isi dan tepi kartu
      padding: const EdgeInsets.all(16),

      // Mengatur warna dan bentuk kartu
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: [
          // Ikon informasi di sebelah kiri
          Icon(icon, color: navy, size: 28),
          const SizedBox(width: 14),

          // Judul dan deskripsi informasi
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Judul kartu
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: navy,
                  ),
                ),
                const SizedBox(height: 4),

                // Deskripsi kartu
                Text(
                  subtitle,
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),

          // Ikon panah di sisi kanan
          const Icon(
            Icons.chevron_right,
            color: Colors.grey,
          ),
        ],
      ),
    );
  }
}