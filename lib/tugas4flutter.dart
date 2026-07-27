import 'package:flutter/material.dart';

class Tugas4Flutter extends StatelessWidget {
  const Tugas4Flutter({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'VibeTech Xyz',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
      ),
      // WAJIB: ListView sebagai root di body
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // --- BAGIAN FORM ---
          const Text(
            'Form Penjualan Baru',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),

          // 4 TextField disesuaikan
          const TextField(
            decoration: InputDecoration(
              labelText: 'Nama Pelanggan',
              prefixIcon: Icon(Icons.person),
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 12),

          const TextField(
            decoration: InputDecoration(
              labelText: 'Paket VPS / Panel Hosting',
              hintText: 'Contoh: VPS 2GB, cPanel 5 Domain',
              prefixIcon: Icon(Icons.cloud),
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 12),

          const TextField(
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: 'Durasi (Bulan)',
              prefixIcon: Icon(Icons.calendar_month),
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 12),

          const TextField(
            maxLines: 2,
            decoration: InputDecoration(
              labelText: 'Catatan Tambahan (Misal: Butuh Setup Awal)',
              prefixIcon: Icon(Icons.notes),
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 24),

          const Divider(),
          const SizedBox(height: 12),

          // --- BAGIAN DAFTAR / RIWAYAT ---
          const Text(
            'Riwayat Penjualan Terakhir',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),

          // Minimal 5 ListTile ditulis manual
          _buildListTile(
            icon: Icons.computer,
            iconColor: Colors.teal,
            title: 'Budi Santoso',
            subtitle: 'VPS 4GB - 12 Bulan. Dibayar 5 menit lalu.',
          ),
          _buildListTile(
            icon: Icons.dns,
            iconColor: Colors.blue,
            title: 'PT Maju Jaya',
            subtitle: 'Panel WHMCS - 3 Bulan. Dibayar 30 menit lalu.',
          ),
          _buildListTile(
            icon: Icons.storage,
            iconColor: Colors.green,
            title: 'Siti Aminah',
            subtitle: 'Hosting SSD 10GB - 1 Tahun. Dibayar 1 Hari lalu.',
          ),
          _buildListTile(
            icon: Icons.security,
            iconColor: Colors.orange,
            title: 'Riko Firmansyah',
            subtitle: 'VPS 8GB + DDOS - 6 Bulan. Dibayar 1 Hari lalu.',
          ),
          _buildListTile(
            icon: Icons.receipt_long,
            iconColor: Colors.purple,
            title: 'CV Digital Kreatif',
            subtitle: 'Panel Pterodactyl - 1 Bulan. Dibayar 2 Hari lalu.',
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
        leading: Icon(icon, color: iconColor),
        title: Text(title),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.chevron_right),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        tileColor: Colors.grey[100],
      ),
    );
  }
}
