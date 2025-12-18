import 'dart:convert';

import '../../../../core/network/api_endpoints.dart';
import '../../../../core/network/dio_client.dart';
import '../../../../core/network/headers.dart';

class RequestApi {
  Future<Map<String, dynamic>> getAllRequests({
    required String token,
  }) async {
    try {
      print("Calling API: ${ApiEndpoints.getRequests}");
      final response = await RemoteApi.get(
        ApiEndpoints.getRequests,
        headers: headersWithAuthContent(token),
      );
      print("API Response: ${response.data}");
      return response.data;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> accept({
    required Map<String, String> data,
    required int requestId,
    required String token,
  }) async {
    try {
      print("Calling API: ${ApiEndpoints.acceptOrReject(requestId)}");
      final response = await RemoteApi.post(
        ApiEndpoints.acceptOrReject(requestId),
        body :json.encode(data),
        headers: headersWithAuthContent(token),
      );
      print("API Response: ${response.data}");
      return response.data;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> reject({
    required Map<String, String> data,
    required int requestId,
    required String token,
  }) async {
    try {
      print("Calling API: ${ApiEndpoints.acceptOrReject(requestId)}");
      final response = await RemoteApi.post(
        ApiEndpoints.acceptOrReject(requestId),
        body :json.encode(data),
        headers: headersWithAuthContent(token),
      );
      print("API Response: ${response.data}");
      return response.data;
    } catch (e) {
      rethrow;
    }
  }


}