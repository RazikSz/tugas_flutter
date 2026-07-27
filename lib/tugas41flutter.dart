import 'package:flutter/material.dart';

class Tugas4Flutter extends StatelessWidget {
  const Tugas4Flutter({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Laporan & Riwayat Udara',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true, // biar di tengah
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
      ),
      // WAJIB: ListView sebagai root di body
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // --- BAGIAN FORM ---
          const Text(
            'Laporan Kondisi Udara',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),

          // 4 TextField
          const TextField(
            decoration: InputDecoration(
              labelText: 'Titik Lokasi (Nama Jalan/Gedung)',
              prefixIcon: Icon(Icons.transfer_within_a_station),
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 12),

          const TextField(
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: 'Skor AQI Teramati',
              prefixIcon: Icon(Icons.air),
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 12),

          const TextField(
            decoration: InputDecoration(
              labelText: 'Nama Pelapor',
              prefixIcon: Icon(Icons.person),
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 12),

          const TextField(
            maxLines: 2,
            decoration: InputDecoration(
              labelText: 'Catatan Tambahan (Misal: Berkabut)',
              prefixIcon: Icon(Icons.notes),
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 24),

          const Divider(),
          const SizedBox(height: 12),

          // --- BAGIAN DAFTAR / RIWAYAT ---
          const Text(
            'Riwayat Laporan Terakhir',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),

          // Minimal 5 ListTile ditulis manual, tanpa list
          _buildListTile(
            icon: Icons.warning,
            iconColor: Colors.red,
            title: 'Jakarta Pusat',
            subtitle: 'AQI: 156 - Tidak Sehat. Dilaporkan 5 menit lalu.',
          ),
          _buildListTile(
            icon: Icons.cloud,
            iconColor: Colors.orange,
            title: 'Bandung Kota',
            subtitle: 'AQI: 95 - Sedang. Dilaporkan 30 menit lalu.',
          ),
          _buildListTile(
            icon: Icons.check_circle,
            iconColor: Colors.green,
            title: 'Yogyakarta',
            subtitle: 'AQI: 42 - Baik. Dilaporkan 1 Hari lalu.',
          ),
          _buildListTile(
            icon: Icons.masks,
            iconColor: Colors.red,
            title: 'Semarang',
            subtitle: 'AQI: 120 - Sensitif. Dilaporkan 1 Hari lalu.',
          ),
          _buildListTile(
            icon: Icons.cloud,
            iconColor: Colors.orange,
            title: 'Surabaya',
            subtitle: 'AQI: 78 - Sedang. Dilaporkan 2 Hari lalu.',
          ),

          const SizedBox(height: 40),
        ],
      ),
    );
  }

  // Widget helper biar ga ngulang kode ListTile
  Widget _buildListTile({
    required IconData icon,
    required Color iconColor,
    required String title,
    required String subtitle,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: Icon(icon, color: iconColor), // Leading
        title: Text(title), // Title
        subtitle: Text(subtitle), // Subtitle
        trailing: const Icon(Icons.chevron_right),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        tileColor: Colors.grey[100],
      ),
    );
  }
}
