part of 'withdrawal_cubit.dart';


enum WithdrawalStatus { initial, loading,founded, loaded, error }

class WithdrawalState extends Equatable {
  final WithdrawalStatus status;
  final Account? account;
  final CustomError error;

  const WithdrawalState({
    required this.status,
    required this.account,
    required this.error,
  });

  factory WithdrawalState.initial() => WithdrawalState(
    status: WithdrawalStatus.initial,
    account: null,
    error: CustomError.initial(),
  );

  WithdrawalState copyWith({
    WithdrawalStatus? status,
    Account? account,
    CustomError? error,
  }) {
    return WithdrawalState(
      status: status ?? this.status,
      account: account ?? this.account,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [status, account, error];
}
