import 'account_item.dart';

class CustomerSearchResult {
  final String id;
  final String name;
  final String phone;
  final List<AccountItem> accounts;

  CustomerSearchResult({required this.id, required this.name, required this.phone, required this.accounts});
}

