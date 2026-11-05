
import 'package:flutter/material.dart';
import '../utils/tax_utils.dart';
import '../widgets/tax_type_card.dart';
import '../widgets/info_card.dart';
import 'tax_form_page.dart';

// Halaman utama aplikasi TaxMate
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          // Judul halaman
          const Text(
            'Kalkulator Pajak',
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
              color: navy,
            ),
          ),
          const SizedBox(height: 6),
          const Text(
            'Kelola simulasi pajakmu dengan mudah.',
            style: TextStyle(color: Colors.grey),
          ),
          const SizedBox(height: 24),

          // Kartu utama untuk memulai simulasi pajak
          Container(
            padding: const EdgeInsets.all(22),
            decoration: BoxDecoration(
              color: navy,
              borderRadius: BorderRadius.circular(22),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(
                  Icons.account_balance,
                  color: gold,
                  size: 36,
                ),
                const SizedBox(height: 18),
                const Text(
                  'Simulasi Pajak',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Hitung estimasi pajak sesuai kebutuhanmu.',
                  style: TextStyle(color: Colors.white70),
                ),
                const SizedBox(height: 20),

                // Membuka form simulasi saat tombol ditekan
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: gold,
                      foregroundColor: navy,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                          const TaxFormPage(),
                        ),
                      );
                    },
                    child: const Text(
                      'Mulai Hitung',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 28),

          // Pilihan jenis pajak
          const Text(
            'Pilih Jenis Pajak',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: navy,
            ),
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              Expanded(
                child: TaxTypeCard(
                  title: 'PPh',
                  subtitle: 'Pajak penghasilan',
                  icon: Icons.work_outline,
                  onTap: () => openTaxForm(context, 'PPh'),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: TaxTypeCard(
                  title: 'PPN',
                  subtitle: 'Pajak barang/jasa',
                  icon: Icons.shopping_bag_outlined,
                  onTap: () => openTaxForm(context, 'PPN'),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: TaxTypeCard(
                  title: 'PBB',
                  subtitle: 'Pajak bangunan',
                  icon: Icons.home_work_outlined,
                  onTap: () => openTaxForm(context, 'PBB'),
                ),
              ),
            ],
          ),
          const SizedBox(height: 28),

          // Informasi singkat tentang pajak
          const Text(
            'Informasi Pajak',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: navy,
            ),
          ),
          const SizedBox(height: 12),
          const InfoCard(
            icon: Icons.receipt_long_outlined,
            title: 'Mengenal jenis pajak',
            subtitle: 'Pelajari PPh, PPN, dan PBB.',
          ),
          const InfoCard(
            icon: Icons.lightbulb_outline,
            title: 'Tips memahami pajak',
            subtitle: 'Kenali istilah pajak dasar.',
          ),
        ],
      ),
    );
  }
}

// Membuka halaman form dengan jenis pajak yang dipilih
void openTaxForm(BuildContext context, String type) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => TaxFormPage(initialType: type),
    ),
  );
}