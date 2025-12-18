import '../../../../core/storage/secure_storage_service.dart';
import '../api/deposit_api.dart';

class DepositRepo {
  final DepositApi depositApi;

  DepositRepo({required this.depositApi});

  Future<void> deposit({
    required String accountNumber,
    required int amount,
  }) async {
    try {
      print("start repo");
      final String token = await SecureStorage.getToken();
      await depositApi.deposit(
        token: token,
        data: {"account_number": accountNumber, "amount": amount},
      );
    } catch (e) {
      rethrow;
    }
  }
}
