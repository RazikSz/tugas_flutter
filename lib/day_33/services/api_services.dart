// Day 33: Retrofit API Service Interface
// Memanfaatkan package Retrofit untuk mengelola HTTP Endpoint berdasarkan Postman collection.

import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../models/auth_response.dart';
import '../models/profile_response.dart';

part 'api_services.g.dart';

@RestApi(baseUrl: 'https://appabsensi.mobileprojp.com')
abstract class ApiService {
  factory ApiService(Dio dio, {String baseUrl}) = _ApiService;

  // Endpoint Registrasi Pengguna Baru
  @POST('/api/register')
  Future<AuthResponse> register(@Body() Map<String, dynamic> body);

  // Endpoint Login Pengguna
  @POST('/api/login')
  Future<AuthResponse> login(@Body() Map<String, dynamic> body);

  // Endpoint Mengambil Profile Pengguna
  @GET('/api/profile')
  Future<ProfileResponse> getProfile(
    @Header('Authorization') String token,
  );

  // Endpoint Mengubah Profile Pengguna
  @PUT('/api/profile')
  Future<ProfileResponse> updateProfile(
    @Header('Authorization') String token,
    @Body() Map<String, dynamic> body,
  );

  // Endpoint Mengubah Foto Profile Pengguna
  @PUT('/api/profile/photo')
  Future<dynamic> updateProfilePhoto(
    @Header('Authorization') String token,
    @Body() Map<String, dynamic> body,
  );

  // Endpoint Mengambil List Batches
  @GET('/api/batches')
  Future<dynamic> getBatches();

  // Endpoint Mengambil List Trainings
  @GET('/api/trainings')
  Future<dynamic> getTrainings();
}
