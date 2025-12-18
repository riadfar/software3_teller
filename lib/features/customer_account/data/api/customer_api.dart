import 'dart:convert';

import '../../../../core/network/api_endpoints.dart';
import '../../../../core/network/dio_client.dart';
import '../../../../core/network/headers.dart';

class CustomerApi {
  Future<Map<String, dynamic>> getCustomerAccount({
    required String accountNumber,
    required String token,
  }) async {
    try {
      print("Calling API: ${ApiEndpoints.customerAccountEndpoint(accountNumber)}");
      final response = await RemoteApi.get(
        ApiEndpoints.customerAccountEndpoint(accountNumber),
        headers: headersWithAuthContent(token),
      );
      print("API Response: ${response.data}");
      return response.data;
    } catch (e) {
      rethrow;
    }
  }


  Future<Map<String, dynamic>> createCustomer({
    required Map<String,dynamic> data,
    required String token,
  }) async {
    try {
      print("Calling API: ${ApiEndpoints.createCustomer}");
      final response = await RemoteApi.post(
        ApiEndpoints.createCustomer,
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