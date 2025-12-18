import '../../../../core/storage/secure_storage_service.dart';
import '../api/auth_api.dart';

class AuthRepo {
  final AuthApi authApi;

  AuthRepo({required this.authApi});

  Future<void> login({
    required String userName,
    required String password,
  }) async {
    try {
      print("start repo");
      final response = await authApi.login(
        data: {"username": userName, "password": password},
      );
      final Map<String, dynamic> data = response['data'];
      final String token = data['token'];

      SecureStorage.storeToken(token);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> changePassword({
    required String oldPassword,
    required String newPassword,
  }) async {
    try {
      print("start repo");
      final String token = await SecureStorage.getToken();
      await authApi.changePassword(
        token: token,
        data: {"old_password": oldPassword, "new_password": newPassword},
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<void> logout() async {
    try {
      print("start repo");
      final String token = await SecureStorage.getToken();
      await authApi.logout(token: token);
    } catch (e) {
      rethrow;
    }
  }
}
