import '../../../../core/storage/secure_storage_service.dart';
import '../api/withdrawal_api.dart';

class WithdrawalRepo {
  final WithdrawalApi withdrawalApi;

  WithdrawalRepo({required this.withdrawalApi});
  Future<void> withdrawal({
    required String accountNumber,
    required int amount,
  }) async {
    try {
      print("start repo");
      final String token = await SecureStorage.getToken();
      await withdrawalApi.withdrawal(
        token: token,
        data: {"account_number": accountNumber, "amount": amount},
      );
    } catch (e) {
      rethrow;
    }
  }
}