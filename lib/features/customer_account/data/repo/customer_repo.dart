import '../../../../core/storage/secure_storage_service.dart';
import '../api/customer_api.dart';
import '../model/account.dart';
import '../model/createResponse.dart';

class CustomerRepo {
  final CustomerApi customerApi;

  CustomerRepo({required this.customerApi});

  Future<Account> getCustomerAccount({required String accountNumber}) async {
    try {
      print("start repo");
      final String token = await SecureStorage.getToken();
      final response = await customerApi.getCustomerAccount(
        accountNumber: accountNumber,
        token: token,
      );
      print(response);
      final data = response['data'] as Map<String, dynamic>;
      return Account.fromMap(data);
    } catch (e) {
      rethrow;
    }
  }

  Future<CreateResponse> createCustomer({
    required String fullName,
    required String nationalId,
    required String phone,
    required String address,
    required String birthDate,
    required String accountType,
  }) async {
    try {
      print("start repo");
      final String token = await SecureStorage.getToken();
      final response = await customerApi.createCustomer(
        token: token,
        data: {
          "full_name":fullName,
          "national_id":nationalId,
          "phone":phone,
          "address":address,
          "birth_date": birthDate,
          "account_type":accountType
        },
      );
        final data = response['data'];
        final CreateResponse createResponse= CreateResponse.fromMap(data);
        return createResponse;
    } catch (e) {
      rethrow;
    }
  }
}
