import 'dart:convert';

import '../../../../core/network/api_endpoints.dart';
import '../../../../core/network/dio_client.dart';
import '../../../../core/network/headers.dart';

class DepositApi {
  Future<Map<String, dynamic>> deposit({
    required Map<String, dynamic> data,
    required String token,
  }) async {
    try {
      print("Calling API: ${ApiEndpoints.deposit}");
      final response = await RemoteApi.post(
        ApiEndpoints.deposit,
        body: json.encode(data),
        headers: headersWithAuthContent(token),
      );
      print("API Response: ${response.data}");
      return response.data;
    } catch (e) {
      rethrow;
    }
  }
}