import 'package:flutter/material.dart';
import '../utils/tax_utils.dart';
import '../widgets/tax_type_card.dart';
import 'tax_form_page.dart';

class CalculatorPage extends StatelessWidget {
  const CalculatorPage({super.key});

  // Membuka halaman formulir pajak
  void openTaxForm(BuildContext context, String type) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TaxFormPage(initialType: type),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightBg,
      appBar: AppBar(
        title: const Text(
          'Kalkulator Pajak',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: navy,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Pilih Jenis Pajak',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: navy,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Pilih jenis pajak yang ingin kamu hitung.',
              style: TextStyle(
                fontSize: 14,
                color: Colors.black54,
              ),
            ),
            const SizedBox(height: 24),

            // Kartu kalkulator PPh
            TaxTypeCard(
              title: 'Pajak Penghasilan (PPh)',
              subtitle: 'Hitung pajak berdasarkan penghasilan.',
              icon: Icons.account_balance_wallet,
              onTap: () => openTaxForm(context, 'PPh'),
            ),
            const SizedBox(height: 16),

            // Kartu kalkulator PPN
            TaxTypeCard(
              title: 'Pajak Pertambahan Nilai (PPN)',
              subtitle: 'Hitung pajak dari harga barang atau jasa.',
              icon: Icons.shopping_cart,
              onTap: () => openTaxForm(context, 'PPN'),
            ),
            const SizedBox(height: 16),

            // Kartu kalkulator PBB
            TaxTypeCard(
              title: 'Pajak Bumi dan Bangunan (PBB)',
              subtitle: 'Hitung pajak berdasarkan nilai properti.',
              icon: Icons.home_work,
              onTap: () => openTaxForm(context, 'PBB'),
            ),
          ],
        ),
      ),
    );
  }
}