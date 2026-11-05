
import 'package:flutter/material.dart';
import '../utils/tax_utils.dart';
import '../widgets/info_card.dart';
import '../widgets/tax_info_tile.dart';

// Halaman yang menjelaskan jenis-jenis pajak
class InformationPage extends StatelessWidget {
  const InformationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          // Judul halaman informasi
          const Text(
            'Informasi Pajak',
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
              color: navy,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Kenali beberapa jenis pajak melalui ringkasan berikut.',
            style: TextStyle(color: Colors.grey),
          ),
          const SizedBox(height: 24),

          // Penjelasan mengenai Pajak Penghasilan
          const TaxInfoTile(
            icon: Icons.work_outline,
            title: 'PPh',
            description:
            'Pajak atas penghasilan yang diterima atau diperoleh wajib pajak.',
          ),

          // Penjelasan mengenai Pajak Pertambahan Nilai
          const TaxInfoTile(
            icon: Icons.shopping_bag_outlined,
            title: 'PPN',
            description:
            'Pajak atas konsumsi barang dan jasa kena pajak sesuai ketentuan.',
          ),

          // Penjelasan mengenai Pajak Bumi dan Bangunan
          const TaxInfoTile(
            icon: Icons.home_work_outlined,
            title: 'PBB',
            description:
            'Pajak terkait bumi dan/atau bangunan sesuai jenis PBB yang berlaku.',
          ),

          const SizedBox(height: 18),

          // Pengingat untuk menggunakan sumber informasi resmi
          const InfoCard(
            icon: Icons.verified_user_outlined,
            title: 'Gunakan informasi resmi',
            subtitle:
            'Periksa ketentuan terbaru pada situs Direktorat Jenderal Pajak.',
          ),
        ],
      ),
    );
  }
}