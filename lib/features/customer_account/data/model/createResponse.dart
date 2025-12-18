class CreateResponse {
  final int customerID;
  final String fullName;
  final String accountNumber;
  final String tempPassword;

  CreateResponse({
    required this.customerID,
    required this.fullName,
    required this.accountNumber,
    required this.tempPassword,
  });

  factory CreateResponse.initial() => CreateResponse(
    customerID: -1,
    fullName: '',
    accountNumber: '',
    tempPassword: '',
  );

  factory CreateResponse.fromMap(Map<String, dynamic> map) {
    return CreateResponse(
      customerID: map['customer_id'],
      fullName: map["full_name"],
      accountNumber: map["account_number"],
      tempPassword: map["temporary_password"],
    );
  }
}
