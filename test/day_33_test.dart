import 'package:flutter_test/flutter_test.dart';
import 'package:tugas3flutter/day_33/models/auth_response.dart';
import 'package:tugas3flutter/day_33/models/profile_response.dart';
import 'package:tugas3flutter/day_33/services/token_storage.dart';

void main() {
  test('AuthResponse fromJson test', () {
    final json = {
      "message": "Registrasi berhasil",
      "data": {
        "token": "9260|0sURRNQeKAKIwXbmtfhonSEFfTkAiqiG6lmQcVMI71c914a1",
        "user": {
          "id": 1204,
          "name": "Test User",
          "email": "test@example.com",
          "batch_id": 4,
          "training_id": 1,
          "jenis_kelamin": "L",
          "profile_photo": null,
          "updated_at": "2026-09-03T03:46:47.000000Z",
          "created_at": "2026-09-03T03:46:47.000000Z",
        }
      }
    };
    final res = AuthResponse.fromJson(json);
    expect(res.message, "Registrasi berhasil");
    expect(res.data?.token, isNotEmpty);
    expect(res.data?.user?.id, 1204);
  });

  test('ProfileResponse fromJson test', () {
    final json = {
      "message": "Berhasil mengambil data profil pengguna",
      "data": {
        "id": 1204,
        "name": "Test User",
        "email": "test@example.com",
        "batch_ke": 5,
        "training_title": "Data Management Staff (Operator Komputer)",
        "batch": {
          "id": 4,
          "batch_ke": 5,
          "start_date": "2026-02-18",
          "end_date": "2026-04-22",
        },
        "training": {
          "id": 1,
          "title": "Data Management Staff (Operator Komputer)",
        },
        "jenis_kelamin": "L",
        "profile_photo": "profile_photo/photo.png",
        "profile_photo_url": "https://example.com/photo.png"
      }
    };
    final res = ProfileResponse.fromJson(json);
    expect(res.data?.id, 1204);
    expect(res.data?.displayPhotoUrl, "https://example.com/photo.png");
  });

  test('TokenStorage test', () async {
    TestWidgetsFlutterBinding.ensureInitialized();
    await TokenStorage.saveToken('test_token');
    final t = await TokenStorage.getToken();
    expect(t, 'test_token');
    final has = await TokenStorage.hasToken();
    expect(has, isTrue);
    await TokenStorage.clearToken();
    final cleared = await TokenStorage.getToken();
    expect(cleared, isNull);
  });
}
