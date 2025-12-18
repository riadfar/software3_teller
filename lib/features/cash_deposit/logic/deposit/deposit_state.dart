part of 'deposit_cubit.dart';

enum DepositStatus { initial, loading,founded, loaded, error }

class DepositState extends Equatable {
  final DepositStatus status;
  final Account? account;
  final CustomError error;

  const DepositState({
    required this.status,
    required this.account,
    required this.error,
  });

  factory DepositState.initial() => DepositState(
    status: DepositStatus.initial,
    account: null,
    error: CustomError.initial(),
  );

  DepositState copyWith({
    DepositStatus? status,
    Account? account,
    CustomError? error,
  }) {
    return DepositState(
      status: status ?? this.status,
      account: account ?? this.account,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [status, account, error];
}

