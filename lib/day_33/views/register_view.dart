import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
import '../models/training_batch_model.dart';
import '../services/api_services.dart';
import '../services/dio_client.dart';
import '../services/token_storage.dart';
import 'profile_dashboard_view.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _apiService = ApiService(createDioClient());
  final _picker = ImagePicker();

  String _jenisKelamin = 'L'; // 'L' atau 'P'
  int _selectedBatchId = 1;
  int _selectedTrainingId = 1;
  String? _profilePhotoBase64;
  XFile? _pickedImage;

  bool _isLoading = false;
  bool _isLoadingBatchesTrainings = true;
  bool _obscurePassword = true;

  List<BatchModel> _batches = [];
  List<TrainingModel> _trainings = [];

  @override
  void initState() {
    super.initState();
    _loadBatchesAndTrainings();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _loadBatchesAndTrainings() async {
    try {
      final dio = createDioClient();
      final batchRes = await dio.get('/api/batches');
      final trainingRes = await dio.get('/api/trainings');

      final List<BatchModel> loadedBatches = [];
      if (batchRes.data != null && batchRes.data['data'] is List) {
        for (var item in batchRes.data['data']) {
          if (item is Map) {
            loadedBatches.add(BatchModel.fromJson(Map<String, dynamic>.from(item)));
          }
        }
      }

      final List<TrainingModel> loadedTrainings = [];
      if (trainingRes.data != null && trainingRes.data['data'] is List) {
        for (var item in trainingRes.data['data']) {
          if (item is Map) {
            loadedTrainings.add(TrainingModel.fromJson(Map<String, dynamic>.from(item)));
          }
        }
      }

      if (mounted) {
        setState(() {
          _batches = loadedBatches.where((b) => b.id != null).toList();
          _trainings = loadedTrainings.where((t) => t.id != null).toList();
          if (_batches.isNotEmpty) {
            _selectedBatchId = _batches.first.id!;
          }
          if (_trainings.isNotEmpty) {
            _selectedTrainingId = _trainings.first.id!;
          }
          _isLoadingBatchesTrainings = false;
        });
      }
    } catch (_) {
      // Jika gagal memuat dari API, gunakan fallback default
      if (mounted) {
        setState(() {
          _batches = [
            BatchModel(id: 3, batchKe: 4, startDate: '2026-01-08'),
            BatchModel(id: 4, batchKe: 5, startDate: '2026-02-18'),
          ];
          _trainings = [
            TrainingModel(id: 1, title: 'Data Management Staff (Operator Komputer)'),
            TrainingModel(id: 2, title: 'Bahasa Inggris'),
            TrainingModel(id: 3, title: 'Desainer Grafis Madya'),
            TrainingModel(id: 14, title: 'Web Programming'),
            TrainingModel(id: 16, title: 'Mobile Programming'),
          ];
          _selectedBatchId = 4;
          _selectedTrainingId = 1;
          _isLoadingBatchesTrainings = false;
        });
      }
    }
  }

  Future<void> _pickImage(ImageSource source) async {
    try {
      final pickedFile = await _picker.pickImage(
        source: source,
        maxWidth: 600,
        maxHeight: 600,
        imageQuality: 80,
      );

      if (pickedFile != null) {
        final bytes = await pickedFile.readAsBytes();
        final base64String = base64Encode(bytes);
        final mimeType = pickedFile.name.endsWith('.png') ? 'image/png' : 'image/jpeg';
        final dataUri = 'data:$mimeType;base64,$base64String';

        setState(() {
          _pickedImage = pickedFile;
          _profilePhotoBase64 = dataUri;
        });
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(source == ImageSource.camera
                ? 'Kamera tidak didukung di perangkat ini. Silakan pilih dari galeri.'
                : 'Gagal memilih gambar: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  void _showImageSourceDialog() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Pilih Sumber Foto Profil',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                ListTile(
                  leading: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: const Color(0xFF4A00E0).withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(Icons.camera_alt, color: Color(0xFF4A00E0)),
                  ),
                  title: const Text('Ambil dari Kamera'),
                  onTap: () {
                    Navigator.pop(context);
                    _pickImage(ImageSource.camera);
                  },
                ),
                ListTile(
                  leading: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: const Color(0xFF8E2DE2).withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(Icons.photo_library, color: Color(0xFF8E2DE2)),
                  ),
                  title: const Text('Pilih dari Galeri'),
                  onTap: () {
                    Navigator.pop(context);
                    _pickImage(ImageSource.gallery);
                  },
                ),
                if (_pickedImage != null)
                  ListTile(
                    leading: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.red.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(Icons.delete_outline, color: Colors.red),
                    ),
                    title: const Text('Hapus Foto Terpilih'),
                    onTap: () {
                      Navigator.pop(context);
                      setState(() {
                        _pickedImage = null;
                        _profilePhotoBase64 = null;
                      });
                    },
                  ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> _handleRegister() async {
    if (!_formKey.currentState!.validate()) return;

    FocusScope.of(context).unfocus();

    setState(() {
      _isLoading = true;
    });

    try {
      final body = <String, dynamic>{
        'name': _nameController.text.trim(),
        'email': _emailController.text.trim(),
        'password': _passwordController.text,
        'jenis_kelamin': _jenisKelamin,
        'batch_id': _selectedBatchId,
        'training_id': _selectedTrainingId,
      };
      if (_profilePhotoBase64 != null && _profilePhotoBase64!.isNotEmpty) {
        body['profile_photo'] = _profilePhotoBase64;
      }

      final response = await _apiService.register(body);

      // Simpan token
      final token = response.data?.token;
      if (token != null && token.isNotEmpty) {
        await TokenStorage.saveToken(token);
      }

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(response.message ?? 'Registrasi berhasil!'),
          backgroundColor: Colors.green.shade600,
          behavior: SnackBarBehavior.floating,
        ),
      );

      // Pindah ke Profile Dashboard
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (_) => const ProfileDashboardView(),
        ),
        (route) => false,
      );
    } on DioException catch (e) {
      if (!mounted) return;
      String errorMsg = 'Terjadi kesalahan pada server';
      if (e.response?.data != null) {
        final data = e.response!.data;
        if (data is Map && data.containsKey('errors') && data['errors'] is Map) {
          final List<String> list = [];
          (data['errors'] as Map).forEach((k, v) {
            if (v is List) {
              list.addAll(v.map((item) => item.toString()));
            } else {
              list.add(v.toString());
            }
          });
          if (list.isNotEmpty) errorMsg = list.join('\n');
        } else if (data is Map && data.containsKey('message')) {
          errorMsg = data['message'].toString();
        } else if (data is String && data.isNotEmpty) {
          errorMsg = data;
        }
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(errorMsg),
          backgroundColor: Colors.red.shade600,
          behavior: SnackBarBehavior.floating,
        ),
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Terjadi kesalahan: $e'),
          backgroundColor: Colors.red.shade600,
          behavior: SnackBarBehavior.floating,
        ),
      );
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F8FC),
      appBar: AppBar(
        title: const Text('Pendaftaran Akun Baru', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
        centerTitle: true,
        elevation: 0,
        backgroundColor: const Color(0xFF4A00E0),
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Top Banner
            Container(
              width: double.infinity,
              padding: const EdgeInsets.only(bottom: 24, top: 10),
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
                  // Photo Picker Preview
                  GestureDetector(
                    onTap: _showImageSourceDialog,
                    child: Stack(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 3),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.2),
                                blurRadius: 10,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: CircleAvatar(
                            radius: 42,
                            backgroundColor: Colors.white,
                            child: _profilePhotoBase64 != null
                                ? ClipOval(
                                    child: Image.memory(
                                      base64Decode(
                                        _profilePhotoBase64!.contains(',')
                                            ? _profilePhotoBase64!.split(',').last
                                            : _profilePhotoBase64!,
                                      ),
                                      fit: BoxFit.cover,
                                      width: 84,
                                      height: 84,
                                    ),
                                  )
                                : const Icon(
                                    Icons.person,
                                    size: 48,
                                    color: Color(0xFF4A00E0),
                                  ),
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: Container(
                            padding: const EdgeInsets.all(6),
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.camera_alt,
                              size: 16,
                              color: Color(0xFF4A00E0),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Sentuh untuk memilih foto profil',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),

            // Form Card
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
              child: Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.06),
                      blurRadius: 18,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Text(
                        'Isi Data Diri Anda',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF2D3142),
                        ),
                      ),
                      const SizedBox(height: 18),

                      // Nama
                      TextFormField(
                        controller: _nameController,
                        decoration: _inputDecoration(
                          label: 'Nama Lengkap',
                          hint: 'Budi Santoso',
                          icon: Icons.person_outline,
                        ),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Nama wajib diisi';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),

                      // Email
                      TextFormField(
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: _inputDecoration(
                          label: 'Email',
                          hint: 'budi@example.com',
                          icon: Icons.email_outlined,
                        ),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Email wajib diisi';
                          }
                          final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
                          if (!emailRegex.hasMatch(value.trim())) {
                            return 'Format email tidak valid';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),

                      // Password
                      TextFormField(
                        controller: _passwordController,
                        obscureText: _obscurePassword,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          hintText: 'Minimal 6 karakter',
                          helperText: 'Wajib kombinasi huruf besar, kecil & angka/simbol',
                          helperMaxLines: 2,
                          prefixIcon: const Icon(Icons.lock_outline, color: Color(0xFF4A00E0)),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _obscurePassword ? Icons.visibility_off : Icons.visibility,
                              color: Colors.grey,
                            ),
                            onPressed: () {
                              setState(() {
                                _obscurePassword = !_obscurePassword;
                              });
                            },
                          ),
                          filled: true,
                          fillColor: const Color(0xFFF9FAFD),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide.none,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(color: Colors.grey.shade200),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(color: Color(0xFF4A00E0), width: 1.5),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Password wajib diisi';
                          }
                          if (value.length < 6) {
                            return 'Password minimal 6 karakter';
                          }
                          if (!RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9\W])').hasMatch(value)) {
                            return 'Harus mengandung huruf besar, kecil & angka/simbol';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),

                      // Jenis Kelamin
                      const Text(
                        'Jenis Kelamin',
                        style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Color(0xFF4A4A68)),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Expanded(
                            child: InkWell(
                              onTap: () => setState(() => _jenisKelamin = 'L'),
                              borderRadius: BorderRadius.circular(12),
                              child: Container(
                                padding: const EdgeInsets.symmetric(vertical: 12),
                                decoration: BoxDecoration(
                                  color: _jenisKelamin == 'L'
                                      ? const Color(0xFF4A00E0).withValues(alpha: 0.1)
                                      : const Color(0xFFF9FAFD),
                                  border: Border.all(
                                    color: _jenisKelamin == 'L'
                                        ? const Color(0xFF4A00E0)
                                        : Colors.grey.shade300,
                                    width: _jenisKelamin == 'L' ? 1.5 : 1,
                                  ),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.male,
                                      color: _jenisKelamin == 'L' ? const Color(0xFF4A00E0) : Colors.grey,
                                    ),
                                    const SizedBox(width: 8),
                                    Text(
                                      'Laki-Laki',
                                      style: TextStyle(
                                        color: _jenisKelamin == 'L' ? const Color(0xFF4A00E0) : Colors.black87,
                                        fontWeight: _jenisKelamin == 'L' ? FontWeight.bold : FontWeight.normal,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: InkWell(
                              onTap: () => setState(() => _jenisKelamin = 'P'),
                              borderRadius: BorderRadius.circular(12),
                              child: Container(
                                padding: const EdgeInsets.symmetric(vertical: 12),
                                decoration: BoxDecoration(
                                  color: _jenisKelamin == 'P'
                                      ? const Color(0xFF8E2DE2).withValues(alpha: 0.1)
                                      : const Color(0xFFF9FAFD),
                                  border: Border.all(
                                    color: _jenisKelamin == 'P'
                                        ? const Color(0xFF8E2DE2)
                                        : Colors.grey.shade300,
                                    width: _jenisKelamin == 'P' ? 1.5 : 1,
                                  ),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.female,
                                      color: _jenisKelamin == 'P' ? const Color(0xFF8E2DE2) : Colors.grey,
                                    ),
                                    const SizedBox(width: 8),
                                    Text(
                                      'Perempuan',
                                      style: TextStyle(
                                        color: _jenisKelamin == 'P' ? const Color(0xFF8E2DE2) : Colors.black87,
                                        fontWeight: _jenisKelamin == 'P' ? FontWeight.bold : FontWeight.normal,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),

                      // Batch ID Dropdown
                      const Text(
                        'Batch Pelatihan',
                        style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Color(0xFF4A4A68)),
                      ),
                      const SizedBox(height: 8),
                      _isLoadingBatchesTrainings
                          ? const Center(child: LinearProgressIndicator())
                          : Builder(
                              builder: (context) {
                                final int? currentBatchValue = _batches.any((b) => b.id == _selectedBatchId)
                                    ? _selectedBatchId
                                    : (_batches.isNotEmpty ? _batches.first.id : null);
                                return DropdownButtonFormField<int>(
                                  key: ValueKey('batch_${currentBatchValue}_${_batches.length}'),
                                  initialValue: currentBatchValue,
                                  decoration: _dropdownDecoration(Icons.layers_outlined),
                                  isExpanded: true,
                                  items: _batches.map((batch) {
                                    return DropdownMenuItem<int>(
                                      value: batch.id,
                                      child: Text(
                                        batch.batchKe != null
                                            ? 'Batch ${batch.batchKe} (${batch.startDate ?? ""})'
                                            : 'Batch ID #${batch.id}',
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    );
                                  }).toList(),
                                  onChanged: (val) {
                                    if (val != null) {
                                      setState(() => _selectedBatchId = val);
                                    }
                                  },
                                  validator: (val) => val == null ? 'Pilih batch pelatihan' : null,
                                );
                              },
                            ),
                      const SizedBox(height: 16),

                      // Training ID Dropdown
                      const Text(
                        'Jurusan / Pelatihan',
                        style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Color(0xFF4A4A68)),
                      ),
                      const SizedBox(height: 8),
                      _isLoadingBatchesTrainings
                          ? const Center(child: LinearProgressIndicator())
                          : Builder(
                              builder: (context) {
                                final int? currentTrainingValue = _trainings.any((t) => t.id == _selectedTrainingId)
                                    ? _selectedTrainingId
                                    : (_trainings.isNotEmpty ? _trainings.first.id : null);
                                return DropdownButtonFormField<int>(
                                  key: ValueKey('training_${currentTrainingValue}_${_trainings.length}'),
                                  initialValue: currentTrainingValue,
                                  decoration: _dropdownDecoration(Icons.school_outlined),
                                  isExpanded: true,
                                  items: _trainings.map((training) {
                                    return DropdownMenuItem<int>(
                                      value: training.id,
                                      child: Text(
                                        training.title ?? 'Training ID #${training.id}',
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    );
                                  }).toList(),
                                  onChanged: (val) {
                                    if (val != null) {
                                      setState(() => _selectedTrainingId = val);
                                    }
                                  },
                                  validator: (val) => val == null ? 'Pilih kejuruan pelatihan' : null,
                                );
                              },
                            ),
                      const SizedBox(height: 28),

                      // Submit Button
                      SizedBox(
                        height: 52,
                        child: ElevatedButton(
                          onPressed: _isLoading ? null : _handleRegister,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF4A00E0),
                            foregroundColor: Colors.white,
                            elevation: 4,
                            shadowColor: const Color(0xFF4A00E0).withValues(alpha: 0.4),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
                          ),
                          child: _isLoading
                              ? const SizedBox(
                                  width: 24,
                                  height: 24,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2.5,
                                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                                  ),
                                )
                              : const Text(
                                  'Daftar Akun',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 0.5,
                                  ),
                                ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  InputDecoration _inputDecoration({
    required String label,
    required String hint,
    required IconData icon,
  }) {
    return InputDecoration(
      labelText: label,
      hintText: hint,
      prefixIcon: Icon(icon, color: const Color(0xFF4A00E0)),
      filled: true,
      fillColor: const Color(0xFFF9FAFD),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.grey.shade200),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Color(0xFF4A00E0), width: 1.5),
      ),
    );
  }

  InputDecoration _dropdownDecoration(IconData icon) {
    return InputDecoration(
      prefixIcon: Icon(icon, color: const Color(0xFF4A00E0)),
      filled: true,
      fillColor: const Color(0xFFF9FAFD),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.grey.shade200),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Color(0xFF4A00E0), width: 1.5),
      ),
    );
  }
}
