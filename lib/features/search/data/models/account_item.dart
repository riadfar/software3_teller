class AccountItem {
  final String id;
  final String name;
  final String balance;
  final bool isFrozen;
  final List<AccountItem>? subAccounts; // Composite Pattern (Children)

  AccountItem({
    required this.id,
    required this.name,
    required this.balance,
    this.isFrozen = false,
    this.subAccounts
  });
}