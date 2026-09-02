import 'package:flutter/material.dart';

class GridviewDay8 extends StatelessWidget {
  const GridviewDay8({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("GridView day 8"),
        backgroundColor: Colors.green,
      ),
      body:
          // === Versi 3: GridView.builder ===
          // Sangat direkomendasikan untuk jumlah item yang sangat banyak atau dinamis.
          // Hanya merender item yang terlihat di layar saja (lazy loading/lebih hemat memori).
          GridView.builder(
            // gridDelegate mengatur tata letak (layout) grid
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3, // Menentukan jumlah kolom pada grid (3 kolom)
              mainAxisSpacing:
                  4, // Jarak baris antar item (vertikal) sebesar 4 piksel
              crossAxisSpacing:
                  4, // Jarak kolom antar item (horizontal) sebesar 4 piksel
              childAspectRatio:
                  1 /
                  2, // Rasio lebar dibanding tinggi item (lebar : tinggi = 1 : 2)
            ),
            itemCount: 1000, // Total item yang akan di-generate
            // itemBuilder dipanggil untuk merender widget berdasarkan indeksnya
            itemBuilder: (BuildContext context, int index) {
              return Container(
                alignment: AlignmentDirectional.center,
                decoration: BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape
                      .circle, // Membuat bentuk container menjadi lingkaran
                ),
                child: Text("$index", style: TextStyle(fontSize: 30)),
              );
            },
          ),
      // === Versi 2: GridView.extent (Di-comment out) ===
      // GridView yang mengontrol jumlah kolom berdasarkan batas lebar maksimum tiap item (maxCrossAxisExtent).
      // GridView.extent(
      //   maxCrossAxisExtent:  2,
      //   children: <Widget> [
      //
      //   ],
      // ),
      // === Versi 1: GridView.count (Di-comment out) ===
      // GridView sederhana dengan jumlah kolom tetap yang memuat semua item sekaligus dalam memori (cocok untuk data sedikit).
      //  GridView.count(
      //   crossAxisSpacing: 10,
      //   mainAxisSpacing: 6,
      //   crossAxisCount: 3,
      //   children: <Widget>[
      //     Container(color: Colors.red, child: Text("1")),
      //     Container(color: Colors.yellow),
      //     Container(color: Colors.blue),
      //     Container(color: Colors.green),
      //     Container(color: Colors.blue),
      //     Container(color: Colors.yellow),
      //   ],
      // ),
    );
  }
}
