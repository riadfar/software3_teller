part of 'auth_cubit.dart';

enum AuthStatus { initial, loading, loaded, error, changedPassword, loggedOut }

class AuthState extends Equatable {
  final AuthStatus status;
  final CustomError error;

  const AuthState({required this.status, required this.error});

  factory AuthState.initial() =>
      AuthState(status: AuthStatus.initial, error: CustomError.initial());

  AuthState copyWith({AuthStatus? status, CustomError? error}) {
    return AuthState(status: status ?? this.status, error: error ?? this.error);
  }

  @override
  List<Object> get props => [status, error];
}
