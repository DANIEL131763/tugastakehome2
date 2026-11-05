
import 'package:flutter/material.dart';

// Warna utama aplikasi
const navy = Color(0xFF10213B);
const gold = Color(0xFFD7AD55);
const lightBg = Color(0xFFF5F6F8);

// Fungsi untuk mengubah angka menjadi format Rupiah
String rupiah(double value) {
  // Mengubah angka menjadi teks tanpa angka desimal
  String angka = value.toInt().toString();
  String hasil = '';
  int hitung = 0;

  // Memproses angka dari belakang untuk menambahkan titik ribuan
  for (int i = angka.length - 1; i >= 0; i--) {
    hasil = angka[i] + hasil;
    hitung++;

    // Menambahkan titik setiap tiga digit
    if (hitung % 3 == 0 && i != 0) {
      hasil = '.$hasil';
    }
  }

  // Mengembalikan angka dengan awalan Rupiah
  return 'Rp $hasil';
}