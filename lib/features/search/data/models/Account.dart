class Account {
  final String id;
  final bool isSub;
  final String name;
  final String balance;
  final bool isFrozen;
  final List<Account>? subAccounts; // لدعم الـ Composite Pattern

  Account({
    required this.id,
    required this.name,
    required this.balance,
    required this.isSub,
    this.isFrozen = false,
    this.subAccounts,
  });

  // هل الحساب مركب (مجموعة)؟
  bool get isComposite => subAccounts != null && subAccounts!.isNotEmpty;
}