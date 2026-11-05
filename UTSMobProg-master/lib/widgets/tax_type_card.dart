
import 'package:flutter/material.dart';
import '../utils/tax_utils.dart';

// Widget untuk menampilkan kartu pilihan jenis pajak
class TaxTypeCard extends StatelessWidget {
  // Data yang diterima oleh kartu
  final String title;
  final String subtitle;
  final IconData icon;
  final VoidCallback onTap;

  // Constructor untuk menerima data kartu
  const TaxTypeCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      // Menjalankan fungsi ketika kartu ditekan
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),

      // Container untuk mengatur tampilan kartu
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: 18,
          horizontal: 6,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.grey.shade200),
        ),
        child: Column(
          children: [
            // Ikon yang mewakili jenis pajak
            Icon(icon, color: gold, size: 30),
            const SizedBox(height: 10),

            // Judul jenis pajak
            Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: navy,
              ),
            ),
            const SizedBox(height: 5),

            // Keterangan singkat jenis pajak
            Text(
              subtitle,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 10,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}