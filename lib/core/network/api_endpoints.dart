import 'dart:io';

class ApiEndpoints {

  static String get baseUrl {

      return 'http://10.108.110.242:8000';

  }

  // Auth endpoints
  static const String login = '/api/login';
  static const String logout = '/api/logout';
  static const String changePassword = '/api/change-password';



  // Teller endpoints
  static const String customerAccount = '/api/teller/customer-account';
  static const String getRequests = '/api/teller/requests/freeze';
  static String acceptOrReject(int requestId) {
    return '/api/teller/freeze-request/$requestId';
  }


  static String customerAccountEndpoint(String accountNumber) {
    return '${ApiEndpoints.customerAccount}?search=$accountNumber';
  }


  static const String createCustomer ='/api/teller/create-customer';

  static const String deposit ='/api/teller/deposit';
  static const String withdrawal ='/api/teller/withdrawal';


}
String token = "";