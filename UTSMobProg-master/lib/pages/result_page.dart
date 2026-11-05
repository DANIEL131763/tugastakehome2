
import 'package:flutter/material.dart';
import '../utils/tax_utils.dart';

class ResultPage extends StatelessWidget {
  final String taxType;
  final double amount;

  const ResultPage({
    super.key,
    required this.taxType,
    required this.amount,
  });

  double calculatePPh() {
    // Simulasi PPh tahunan dengan PTKP Rp54 juta
    final annualIncome = amount * 12;
    final taxableIncome = annualIncome - 54000000;

    if (taxableIncome <= 0) return 0;

    double remaining = taxableIncome;
    double tax = 0;

    // Tarif progresif simulasi
    final brackets = [
      [60000000.0, 0.05],
      [190000000.0, 0.15],
      [250000000.0, 0.25],
      [4500000000.0, 0.30],
    ];

    for (final bracket in brackets) {
      final limit = bracket[0];
      final rate = bracket[1];

      final taxable = remaining > limit ? limit : remaining;
      tax += taxable * rate;
      remaining -= taxable;

      if (remaining <= 0) break;
    }

    if (remaining > 0) {
      tax += remaining * 0.35;
    }

    return tax;
  }

  double calculatePBB() {
    // Simulasi PBB: NJOPTKP Rp10 juta
    const njoptkp = 10000000.0;
    final taxableNjop = amount - njoptkp;

    if (taxableNjop <= 0) return 0;

    // Dasar pengenaan simulasi 20%, tarif 0,5%
    return taxableNjop * 0.20 * 0.005;
  }

  @override
  Widget build(BuildContext context) {
    late double tax;
    late String description;

    switch (taxType) {
      case 'PPh':
        tax = calculatePPh();
        description = 'Simulasi PPh progresif tahunan';
        break;
      case 'PBB':
        tax = calculatePBB();
        description = 'Simulasi PBB';
        break;
      case 'PPN':
        tax = amount * 0.11;
        description = 'Contoh tarif simulasi PPN 11%';
        break;
      default:
        tax = 0;
        description = 'Jenis pajak tidak dikenal';
    }

    final total = amount + tax;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Hasil Simulasi'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: navy,
              borderRadius: BorderRadius.circular(22),
            ),
            child: Column(
              children: [
                const Icon(
                  Icons.check_circle_outline,
                  color: gold,
                  size: 48,
                ),
                const SizedBox(height: 14),
                const Text(
                  'Estimasi Pajak',
                  style: TextStyle(color: Colors.white70),
                ),
                const SizedBox(height: 8),
                Text(
                  rupiah(tax),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  '$taxType • $description',
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.white70),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            'Rincian Perhitungan',
            style: TextStyle(
              fontSize: 19,
              fontWeight: FontWeight.bold,
              color: navy,
            ),
          ),
          const SizedBox(height: 14),
          detailRow(
            taxType == 'PPN'
                ? 'Harga sebelum pajak'
                : taxType == 'PBB'
                ? 'NJOP'
                : 'Penghasilan per bulan',
            rupiah(amount),
          ),
          const Divider(height: 24),
          if (taxType == 'PPh')
            detailRow(
              'Penghasilan per tahun',
              rupiah(amount * 12),
            ),
          if (taxType == 'PPh')
            detailRow(
              'PTKP tahunan',
              rupiah(54000000),
            ),
          if (taxType == 'PBB')
            detailRow(
              'NJOPTKP simulasi',
              rupiah(10000000),
            ),
          const Divider(height: 24),
          detailRow('Estimasi pajak', rupiah(tax)),
          if (taxType == 'PPN') ...[
            const Divider(height: 24),
            detailRow('Total setelah pajak', rupiah(total)),
          ],
          const SizedBox(height: 24),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: gold.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(14),
            ),
            child: const Text(
              'Perhatian: hasil ini merupakan simulasi pembelajaran. '
                  'Perhitungan pajak sebenarnya mengikuti ketentuan '
                  'perpajakan yang berlaku dan dapat berbeda.',
              style: TextStyle(fontSize: 12, color: navy),
            ),
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: navy,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 15),
            ),
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Kembali'),
          ),
        ],
      ),
    );
  }
}

Widget detailRow(String title, String value) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4),
    child: Row(
      children: [
        Expanded(
          child: Text(
            title,
            style: const TextStyle(color: Colors.grey),
          ),
        ),
        const SizedBox(width: 12),
        Flexible(
          child: Text(
            value,
            textAlign: TextAlign.end,
            style: const TextStyle(
              color: navy,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    ),
  );
}