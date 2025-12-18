import '../../../../core/storage/secure_storage_service.dart';
import '../api/request_api.dart';
import '../model/request.dart';

class RequestRepo {
  final RequestApi requestApi;

  RequestRepo({required this.requestApi});

  Future<List<Request>> getAllRequests() async {
    try {
      print("start repo");
      final String token = await SecureStorage.getToken();
      final response = await requestApi.getAllRequests(token: token);
      final List list = response['data'] ?? [];
      final List<Request> requests = list
          .map((e) => Request.fromMap(e as Map<String, dynamic>))
          .toList();
      return requests;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> accept({required int requestId}) async {
    try {
      print("start repo");
      final String token = await SecureStorage.getToken();
      await requestApi.accept(
        requestId: requestId,
        token: token,
        data: {"action": "approve"},
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<void> reject({required int requestId, required String reason}) async {
    try {
      print("start repo");
      final String token = await SecureStorage.getToken();
      await requestApi.reject(
        requestId: requestId,
        token: token,
        data: {"action": "reject", "reason": reason},
      );
    } catch (e) {
      rethrow;
    }
  }
}
