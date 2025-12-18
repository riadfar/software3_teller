import 'Account.dart';

class Customer {
  final String id;
  final String name;
  final String phone;
  final String email;
  final List<Account> accounts;

  Customer({
    required this.id,
    required this.name,
    required this.phone,
    required this.email,
    required this.accounts,
  });
}