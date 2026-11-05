
import 'package:flutter/material.dart';
import '../utils/tax_utils.dart';

// Widget untuk menampilkan penjelasan jenis pajak
class TaxInfoTile extends StatelessWidget {
  // Data informasi jenis pajak
  final IconData icon;
  final String title;
  final String description;

  // Constructor untuk menerima data pajak
  const TaxInfoTile({
    super.key,
    required this.icon,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      // Memberikan jarak di bawah setiap kartu
      margin: const EdgeInsets.only(bottom: 14),

      // Mengatur jarak isi kartu dari tepinya
      padding: const EdgeInsets.all(18),

      // Mengatur latar belakang dan sudut kartu
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Ikon jenis pajak
          Icon(icon, color: gold, size: 30),
          const SizedBox(width: 14),

          // Menampilkan judul dan penjelasan pajak
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Nama jenis pajak
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: navy,
                  ),
                ),
                const SizedBox(height: 8),

                // Penjelasan mengenai jenis pajak
                Text(
                  description,
                  style: const TextStyle(
                    color: Colors.black54,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}