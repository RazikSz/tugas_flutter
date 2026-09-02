import 'package:flutter/material.dart';

class TextFieldDay8 extends StatelessWidget {
  const TextFieldDay8({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("TextField day 8"),
        backgroundColor: Colors.green,
      ),
      // Padding memberikan jarak 8.0 piksel di sekeliling layout Column agar input tidak mepet ke tepi layar.
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            // TextField 1: Input dasar untuk Email dengan border kotak (OutlineInputBorder).
            TextField(
              decoration: InputDecoration(
                hintText:
                    "Masukkan Email", // Teks petunjuk (placeholder) yang hilang saat mulai mengetik.
                border:
                    OutlineInputBorder(), // Garis batas luar berbentuk persegi default.
              ),
            ),
            // Memberikan jarak vertikal kecil antar TextField
            const SizedBox(height: 10),
            // TextField 2: Input untuk Password dengan sudut border bulat (borderRadius sebesar 50).
            TextField(
              decoration: InputDecoration(
                hintText: "Masukkan Password",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(
                    50,
                  ), // Mengubah garis batas menjadi bentuk oval/rounded.
                ),
              ),
            ),
            const SizedBox(height: 10),
            // TextField 3: Input untuk Nama dengan tambahan warna latar belakang (filled).
            TextField(
              decoration: InputDecoration(
                hintText: "Masukkan Nama",
                fillColor: Colors
                    .red[100], // Menentukan warna latar belakang TextField (merah muda).
                filled:
                    true, // Wajib diset true agar properti fillColor dapat diterapkan.
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
              ),
            ),
            const SizedBox(height: 10),
            // TextField 4: Input dengan ikon di sisi kanan (suffixIcon).
            TextField(
              decoration: InputDecoration(
                hintText: "Masukkan Kata Si Sandi",
                suffixIcon: Icon(
                  Icons.visibility,
                ), // Menampilkan ikon mata di bagian akhir/kanan input.
                fillColor: Colors.red[100],
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
              ),
            ),
            const SizedBox(height: 10),
            // TextField 5: Input polos tanpa kustomisasi dekorasi sama sekali (hanya garis bawah default).
            TextField(),
          ],
        ),
      ),
    );
  }
}
