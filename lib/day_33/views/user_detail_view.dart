import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../models/profile_response.dart';
import '../services/token_storage.dart';

class UserDetailView extends StatefulWidget {
  final ProfileData user;

  const UserDetailView({super.key, required this.user});

  @override
  State<UserDetailView> createState() => _UserDetailViewState();
}

class _UserDetailViewState extends State<UserDetailView> {
  String? _token;
  bool _showToken = false;

  @override
  void initState() {
    super.initState();
    _loadToken();
  }

  Future<void> _loadToken() async {
    final token = await TokenStorage.getToken();
    if (mounted) {
      setState(() {
        _token = token;
      });
    }
  }

  String _formatGender(String? jk) {
    if (jk == null || jk.isEmpty) return 'Belum Diatur';
    if (jk.toUpperCase() == 'L') return 'Laki-Laki';
    if (jk.toUpperCase() == 'P') return 'Perempuan';
    return jk;
  }

  @override
  Widget build(BuildContext context) {
    final user = widget.user;

    return Scaffold(
      backgroundColor: const Color(0xFFF7F8FC),
      appBar: AppBar(
        title: const Text(
          'Detail Informasi Akun',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: const Color(0xFF4A00E0),
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header Card
            Container(
              width: double.infinity,
              padding: const EdgeInsets.only(bottom: 32, top: 16),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xFF4A00E0),
                    Color(0xFF8E2DE2),
                  ],
                ),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
              ),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 3),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.2),
                          blurRadius: 12,
                          offset: const Offset(0, 6),
                        ),
                      ],
                    ),
                    child: CircleAvatar(
                      radius: 46,
                      backgroundColor: Colors.white.withValues(alpha: 0.9),
                      backgroundImage: (user.displayPhotoUrl != null &&
                              user.displayPhotoUrl!.isNotEmpty)
                          ? NetworkImage(user.displayPhotoUrl!)
                          : null,
                      onBackgroundImageError: (user.displayPhotoUrl != null &&
                              user.displayPhotoUrl!.isNotEmpty)
                          ? (exception, stackTrace) {}
                          : null,
                      child: (user.displayPhotoUrl == null ||
                              user.displayPhotoUrl!.isEmpty)
                          ? Text(
                              (user.name != null && user.name!.isNotEmpty)
                                  ? user.name![0].toUpperCase()
                                  : 'U',
                              style: const TextStyle(
                                fontSize: 36,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF4A00E0),
                              ),
                            )
                          : null,
                    ),
                  ),
                  const SizedBox(height: 14),
                  Text(
                    user.name ?? 'Nama Pengguna',
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    user.email ?? '-',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white.withValues(alpha: 0.85),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      'User ID: #${user.id ?? "-"}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Content Cards
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Informasi Profil Pribadi',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF2D3142),
                    ),
                  ),
                  const SizedBox(height: 12),
                  _buildCardSection([
                    _buildInfoTile(
                      icon: Icons.person_outline,
                      label: 'Nama Lengkap',
                      value: user.name ?? '-',
                    ),
                    const Divider(height: 1),
                    _buildInfoTile(
                      icon: Icons.email_outlined,
                      label: 'Alamat Email',
                      value: user.email ?? '-',
                    ),
                    const Divider(height: 1),
                    _buildInfoTile(
                      icon: Icons.verified_user_outlined,
                      label: 'Status Verifikasi Email',
                      value: user.emailVerifiedAt != null
                          ? 'Terverifikasi'
                          : 'Belum Terverifikasi',
                      valueColor: user.emailVerifiedAt != null
                          ? Colors.green
                          : Colors.orange,
                    ),
                    const Divider(height: 1),
                    _buildInfoTile(
                      icon: Icons.wc_outlined,
                      label: 'Jenis Kelamin',
                      value: _formatGender(user.jenisKelamin),
                    ),
                  ]),

                  const SizedBox(height: 20),
                  const Text(
                    'Pelatihan & Batch',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF2D3142),
                    ),
                  ),
                  const SizedBox(height: 12),
                  _buildCardSection([
                    _buildInfoTile(
                      icon: Icons.school_outlined,
                      label: 'Jurusan / Pelatihan',
                      value: user.training?.title ??
                          user.trainingTitle ??
                          (user.trainingId != null
                              ? 'Training #${user.trainingId}'
                              : 'Belum Terdaftar'),
                    ),
                    const Divider(height: 1),
                    _buildInfoTile(
                      icon: Icons.layers_outlined,
                      label: 'Batch Pelatihan',
                      value: user.batch?.batchKe != null
                          ? 'Batch ke-${user.batch!.batchKe}'
                          : (user.batchKe != null
                              ? 'Batch ke-${user.batchKe}'
                              : (user.batchId != null
                                  ? 'Batch #${user.batchId}'
                                  : 'Belum Terdaftar')),
                    ),
                  ]),

                  const SizedBox(height: 20),
                  const Text(
                    'Riwayat Akun',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF2D3142),
                    ),
                  ),
                  const SizedBox(height: 12),
                  _buildCardSection([
                    _buildInfoTile(
                      icon: Icons.calendar_today_outlined,
                      label: 'Tanggal Pendaftaran',
                      value: user.createdAt ?? '-',
                    ),
                    const Divider(height: 1),
                    _buildInfoTile(
                      icon: Icons.update_outlined,
                      label: 'Terakhir Diperbarui',
                      value: user.updatedAt ?? '-',
                    ),
                  ]),

                  const SizedBox(height: 20),
                  const Text(
                    'Sesi Keamanan & Token',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF2D3142),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.04),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: const Color(0xFF4A00E0).withValues(alpha: 0.1),
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.key_rounded,
                                color: Color(0xFF4A00E0),
                                size: 20,
                              ),
                            ),
                            const SizedBox(width: 12),
                            const Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Bearer Token Aktif',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                    ),
                                  ),
                                  Text(
                                    'Digunakan untuk otorisasi endpoint via Dio',
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            IconButton(
                              tooltip: _showToken ? 'Sembunyikan' : 'Tampilkan',
                              icon: Icon(
                                _showToken
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                                color: const Color(0xFF4A00E0),
                                size: 20,
                              ),
                              onPressed: () {
                                setState(() {
                                  _showToken = !_showToken;
                                });
                              },
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: const Color(0xFFF1F3F9),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: SelectableText(
                            _token == null
                                ? 'Tidak ada token'
                                : _showToken
                                    ? _token!
                                    : '${_token!.substring(0, _token!.length > 15 ? 15 : _token!.length)}••••••••••••••••',
                            style: const TextStyle(
                              fontFamily: 'monospace',
                              fontSize: 12,
                              color: Color(0xFF333333),
                            ),
                          ),
                        ),
                        if (_token != null) ...[
                          const SizedBox(height: 10),
                          Align(
                            alignment: Alignment.centerRight,
                            child: TextButton.icon(
                              onPressed: () {
                                Clipboard.setData(ClipboardData(text: _token!));
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Bearer Token berhasil disalin!'),
                                    duration: Duration(seconds: 2),
                                    backgroundColor: Color(0xFF4A00E0),
                                  ),
                                );
                              },
                              icon: const Icon(Icons.copy, size: 16),
                              label: const Text(
                                'Salin Token',
                                style: TextStyle(fontSize: 12),
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCardSection(List<Widget> children) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(children: children),
    );
  }

  Widget _buildInfoTile({
    required IconData icon,
    required String label,
    required String value,
    Color? valueColor,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: const Color(0xFF4A00E0).withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: const Color(0xFF4A00E0), size: 20),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
                const SizedBox(height: 2),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: valueColor ?? const Color(0xFF2D3142),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
