
import 'package:flutter/material.dart';
import '../utils/tax_utils.dart';
import 'result_page.dart';

// Halaman untuk memasukkan data pajak
class TaxFormPage extends StatefulWidget {
  final String? initialType;

  const TaxFormPage({super.key, this.initialType});

  @override
  State<TaxFormPage> createState() => _TaxFormPageState();
}

class _TaxFormPageState extends State<TaxFormPage> {
  final formKey = GlobalKey<FormState>();
  final amountController = TextEditingController();

  String taxType = 'PPh';

  @override
  void initState() {
    super.initState();
    taxType = widget.initialType ?? 'PPh';
  }

  @override
  void dispose() {
    amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Menentukan label input sesuai jenis pajak
    String fieldLabel;
    String hintText;
    String helperText;

    switch (taxType) {
      case 'PPN':
        fieldLabel = 'Harga sebelum pajak (Rp)';
        hintText = 'Contoh: 100000';
        helperText = 'Masukkan harga barang atau jasa.';
        break;
      case 'PBB':
        fieldLabel = 'Nilai objek pajak / NJOP (Rp)';
        hintText = 'Contoh: 500000000';
        helperText = 'Masukkan NJOP bumi dan bangunan.';
        break;
      default:
        fieldLabel = 'Penghasilan bulanan (Rp)';
        hintText = 'Contoh: 5000000';
        helperText =
        'Simulasi PPh tahunan dengan asumsi wajib pajak TK/0.';
    }

    return Scaffold(
      backgroundColor: lightBg,
      appBar: AppBar(
        title: const Text('Form Simulasi Pajak'),
        backgroundColor: navy,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Form(
        key: formKey,
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            const Text(
              'Lengkapi Data',
              style: TextStyle(
                fontSize: 23,
                fontWeight: FontWeight.bold,
                color: navy,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Masukkan data untuk melihat hasil simulasi.',
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 24),

            const Text(
              'Jenis Pajak',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),

            DropdownButtonFormField<String>(
              value: taxType,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              items: const [
                DropdownMenuItem(
                  value: 'PPh',
                  child: Text('PPh - Penghasilan'),
                ),
                DropdownMenuItem(
                  value: 'PPN',
                  child: Text('PPN - Barang/Jasa'),
                ),
                DropdownMenuItem(
                  value: 'PBB',
                  child: Text('PBB - Bumi/Bangunan'),
                ),
              ],
              onChanged: (value) {
                if (value != null) {
                  setState(() {
                    taxType = value;
                  });
                }
              },
            ),

            const SizedBox(height: 22),

            Text(
              fieldLabel,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),

            TextFormField(
              controller: amountController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: hintText,
                helperText: helperText,
                prefixText: 'Rp ',
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              validator: (value) {
                final input = (value ?? '').trim();
                final amount = double.tryParse(input);

                if (input.isEmpty ||
                    amount == null ||
                    !amount.isFinite ||
                    amount <= 0) {
                  return 'Masukkan nominal yang valid.';
                }

                return null;
              },
            ),

            const SizedBox(height: 28),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: navy,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () {
                  if (!formKey.currentState!.validate()) {
                    return;
                  }

                  final amount = double.parse(
                    amountController.text.trim(),
                  );

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ResultPage(
                        taxType: taxType,
                        amount: amount,
                      ),
                    ),
                  );
                },
                child: const Text('Hitung Pajak'),
              ),
            ),

            const SizedBox(height: 16),

            const Text(
              'Perhitungan ini merupakan simulasi pembelajaran, '
                  'bukan nilai pajak resmi.',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}