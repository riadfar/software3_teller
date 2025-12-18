part of 'customer_account_cubit.dart';

enum CustomerAccountStatus { initial, loading, loaded, error }

class CustomerAccountState extends Equatable {
  final CustomerAccountStatus status;
  final Customer customer;
  final Account account;
  final CreateResponse createResponse;
  final CustomError error;

  const CustomerAccountState({
    required this.status,
    required this.customer,
    required this.account,
    required this.createResponse,
    required this.error,
  });

  CustomerAccountState copyWith({
    CustomerAccountStatus? status,
    Customer? customer,
    Account? account,
    CreateResponse? createResponse,
    CustomError? error,
  }) {
    return CustomerAccountState(
      status: status ?? this.status,
      customer: customer ?? this.customer,
      account: account ?? this.account,
      createResponse: createResponse?? this.createResponse,
      error: error ?? this.error,
    );
  }

  factory CustomerAccountState.initial() => CustomerAccountState(
    status: CustomerAccountStatus.initial,
    customer: Customer.initial(),
    account: Account.initial(),
    createResponse: CreateResponse.initial(),
    error: CustomError.initial(),
  );

  @override
  List<Object> get props => [status, customer, account, error];
}
