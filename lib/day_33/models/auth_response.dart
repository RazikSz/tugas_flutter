// Day 33: Model Data AuthResponse
import 'dart:convert';
import 'training_batch_model.dart';

AuthResponse authResponseFromJson(String str) =>
    AuthResponse.fromJson(json.decode(str) as Map<String, dynamic>);

String authResponseToJson(AuthResponse data) => json.encode(data.toJson());

class AuthResponse {
  final String? message;
  final Data? data;

  AuthResponse({this.message, this.data});

  factory AuthResponse.fromJson(Map<String, dynamic> json) => AuthResponse(
        message: json['message'] as String?,
        data: json['data'] == null
            ? null
            : Data.fromJson(json['data'] is Map<String, dynamic>
                ? json['data'] as Map<String, dynamic>
                : Map<String, dynamic>.from(json['data'] as Map)),
      );

  Map<String, dynamic> toJson() => {
        'message': message,
        'data': data?.toJson(),
      };
}

class Data {
  final String? token;
  final User? user;
  final String? profilePhotoUrl;

  Data({this.token, this.user, this.profilePhotoUrl});

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        token: json['token'] as String?,
        profilePhotoUrl: json['profile_photo_url'] as String?,
        user: json['user'] == null
            ? null
            : User.fromJson(json['user'] is Map<String, dynamic>
                ? json['user'] as Map<String, dynamic>
                : Map<String, dynamic>.from(json['user'] as Map)),
      );

  Map<String, dynamic> toJson() => {
        'token': token,
        'profile_photo_url': profilePhotoUrl,
        'user': user?.toJson(),
      };
}

class User {
  final int? id;
  final String? name;
  final String? email;
  final String? emailVerifiedAt;
  final String? jenisKelamin;
  final String? profilePhoto;
  final String? profilePhotoUrl;
  final dynamic batchId;
  final dynamic trainingId;
  final String? createdAt;
  final String? updatedAt;
  final BatchModel? batch;
  final TrainingModel? training;

  User({
    this.id,
    this.name,
    this.email,
    this.emailVerifiedAt,
    this.jenisKelamin,
    this.profilePhoto,
    this.profilePhotoUrl,
    this.batchId,
    this.trainingId,
    this.createdAt,
    this.updatedAt,
    this.batch,
    this.training,
  });

  String? get displayPhotoUrl {
    if (profilePhotoUrl != null && profilePhotoUrl!.isNotEmpty) {
      return profilePhotoUrl;
    }
    if (profilePhoto != null && profilePhoto!.isNotEmpty) {
      if (profilePhoto!.startsWith('http')) return profilePhoto;
      return 'https://appabsensi.mobileprojp.com/public/$profilePhoto';
    }
    return null;
  }

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: (json['id'] as num?)?.toInt(),
        name: json['name'] as String?,
        email: json['email'] as String?,
        emailVerifiedAt: json['email_verified_at'] as String?,
        jenisKelamin: json['jenis_kelamin'] as String?,
        profilePhoto: json['profile_photo'] as String?,
        profilePhotoUrl: json['profile_photo_url'] as String?,
        batchId: json['batch_id'],
        trainingId: json['training_id'],
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
        'created_at': createdAt,
        'updated_at': updatedAt,
        'batch': batch?.toJson(),
        'training': training?.toJson(),
      };
}
