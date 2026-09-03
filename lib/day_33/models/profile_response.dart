// Day 33: Model Data ProfileResponse
import 'dart:convert';
import 'training_batch_model.dart';

ProfileResponse profileResponseFromJson(String str) =>
    ProfileResponse.fromJson(json.decode(str) as Map<String, dynamic>);

String profileResponseToJson(ProfileResponse data) =>
    json.encode(data.toJson());

class ProfileResponse {
  final String? message;
  final ProfileData? data;

  ProfileResponse({this.message, this.data});

  factory ProfileResponse.fromJson(Map<String, dynamic> json) =>
      ProfileResponse(
        message: json['message'] as String?,
        data: json['data'] == null
            ? null
            : ProfileData.fromJson(json['data'] is Map<String, dynamic>
                ? json['data'] as Map<String, dynamic>
                : Map<String, dynamic>.from(json['data'] as Map)),
      );

  Map<String, dynamic> toJson() => {
        'message': message,
        'data': data?.toJson(),
      };
}

class ProfileData {
  final int? id;
  final String? name;
  final String? email;
  final String? emailVerifiedAt;
  final String? jenisKelamin;
  final String? profilePhoto;
  final String? profilePhotoUrl;
  final dynamic batchId;
  final dynamic trainingId;
  final int? batchKe;
  final String? trainingTitle;
  final String? role;
  final int? isActive;
  final String? createdAt;
  final String? updatedAt;
  final BatchModel? batch;
  final TrainingModel? training;

  ProfileData({
    this.id,
    this.name,
    this.email,
    this.emailVerifiedAt,
    this.jenisKelamin,
    this.profilePhoto,
    this.profilePhotoUrl,
    this.batchId,
    this.trainingId,
    this.batchKe,
    this.trainingTitle,
    this.role,
    this.isActive,
    this.createdAt,
    this.updatedAt,
    this.batch,
    this.training,
  });

  /// Getter untuk URL foto profil lengkap (mendukung URL absolut maupun path relatif dari server)
  String? get displayPhotoUrl {
    if (profilePhotoUrl != null && profilePhotoUrl!.isNotEmpty) {
      return profilePhotoUrl;
    }
    if (profilePhoto != null && profilePhoto!.isNotEmpty) {
      if (profilePhoto!.startsWith('http')) return profilePhoto;
      // Format URL publik standar backend Laravel
      return 'https://appabsensi.mobileprojp.com/public/$profilePhoto';
    }
    return null;
  }

  factory ProfileData.fromJson(Map<String, dynamic> json) => ProfileData(
        id: (json['id'] as num?)?.toInt(),
        name: json['name'] as String?,
        email: json['email'] as String?,
        emailVerifiedAt: json['email_verified_at'] as String?,
        jenisKelamin: json['jenis_kelamin'] as String?,
        profilePhoto: json['profile_photo'] as String?,
        profilePhotoUrl: json['profile_photo_url'] as String?,
        batchId: json['batch_id'],
        trainingId: json['training_id'],
        batchKe: (json['batch_ke'] as num?)?.toInt(),
        trainingTitle: json['training_title'] as String?,
        role: json['role'] as String?,
        isActive: (json['is_active'] as num?)?.toInt(),
        createdAt: json['created_at'] as String?,
        updatedAt: json['updated_at'] as String?,
        batch: json['batch'] != null && json['batch'] is Map
            ? BatchModel.fromJson(Map<String, dynamic>.from(json['batch'] as Map))
            : null,
        training: json['training'] != null && json['training'] is Map
            ? TrainingModel.fromJson(Map<String, dynamic>.from(json['training'] as Map))
            : null,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'email': email,
        'email_verified_at': emailVerifiedAt,
        'jenis_kelamin': jenisKelamin,
        'profile_photo': profilePhoto,
        'profile_photo_url': profilePhotoUrl,
        'batch_id': batchId,
        'training_id': trainingId,
        'batch_ke': batchKe,
        'training_title': trainingTitle,
        'role': role,
        'is_active': isActive,
        'created_at': createdAt,
        'updated_at': updatedAt,
        'batch': batch?.toJson(),
        'training': training?.toJson(),
      };
}
