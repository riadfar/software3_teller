import '../../../customer_account/data/model/account.dart';

class Request {
  final int id;
  final int bankId;
  final String requestType;
  final String requestStatus;
  final String reason;
  final Account bankAccount;

  Request({
    required this.id,
    required this.bankId,
    required this.requestType,
    required this.requestStatus,
    required this.reason,
    required this.bankAccount,
  });

  factory Request.initial() => Request(
    id: -1,
    bankId: -1,
    requestType: '',
    requestStatus: '',
    reason: '',
    bankAccount: Account.initial(),
  );

  factory Request.fromMap(Map<String, dynamic> map) => Request(
    id: map['id'],
    bankId: map['bank_account_id'],
    requestType: map['type'],
    requestStatus: map['status'],
    reason: map['reason'],
    bankAccount: Account.fromMap(map['bank_account']),
  );
}
