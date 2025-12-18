class Customer {
  final String fullName;
  final String nationalId;
  final String phone;
  final String address;
  final String birthDate;

  Customer({
    required this.fullName,
    required this.nationalId,
    required this.phone,
    required this.address,
    required this.birthDate,
  });

  factory Customer.initial() => Customer(
    fullName: "test",
    nationalId: "09123000",
    phone: "0991239465",
    address: "test",
    birthDate: "1992-05-09",
  );

  @override
  String toString() {
    return 'Customer{full_name: $fullName, national_id: $nationalId, phone: $phone, address: $address, birth_date: $birthDate}';
  }

  Map<String, dynamic> toMap() {
    return {
      'full_name': fullName,
      'national_id': nationalId,
      'phone': phone,
      'address': address,
      'birth_date': birthDate,
    };
  }

  factory Customer.fromMap(Map<String, dynamic> map) {
    return Customer(
      fullName: map['full_name'] ?? "",
      nationalId: map['national_id'] ?? "",
      phone: map['phone'] ?? "",
      address: map['address'] ?? "",
      birthDate: map['birth_date'] ?? "",
    );
  }

}
