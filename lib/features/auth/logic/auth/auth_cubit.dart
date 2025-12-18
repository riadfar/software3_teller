import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/errors/custom_error.dart';
import '../../data/repo/auth_repo.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepo authRepo;

  AuthCubit({required this.authRepo}) : super(AuthState.initial());


  Future<void> login({required String userName, required String password}) async {
    emit(state.copyWith(status: AuthStatus.loading));
    try {
      await authRepo.login(userName: userName, password: password);
      print('start emitting');
      emit(state.copyWith(status: AuthStatus.loaded,));
    } on CustomError catch (err) {
      emit(state.copyWith(status: AuthStatus.error, error: err));
    } catch (err) {
      emit(
        state.copyWith(
          status: AuthStatus.error,
          error: CustomError.initial().copyWith(messages: [err.toString()]),
        ),
      );
    }
  }

  Future<void> changePassword({required String oldPassword, required String newPassword}) async {
    emit(state.copyWith(status: AuthStatus.loading));
    try {
      await authRepo.changePassword(oldPassword: oldPassword, newPassword: newPassword);
      print('start emitting');
      emit(state.copyWith(status: AuthStatus.loaded,));
    } on CustomError catch (err) {
      emit(state.copyWith(status: AuthStatus.error, error: err));
    } catch (err) {
      emit(
        state.copyWith(
          status: AuthStatus.error,
          error: CustomError.initial().copyWith(messages: [err.toString()]),
        ),
      );
    }
  }

  Future<void> logout() async{
    emit(state.copyWith(status: AuthStatus.loading));
    try {
      await authRepo.logout();
      print('start emitting');
      emit(state.copyWith(status: AuthStatus.loaded,));
    } on CustomError catch (err) {
      emit(state.copyWith(status: AuthStatus.error, error: err));
    } catch (err) {
      emit(
        state.copyWith(
          status: AuthStatus.error,
          error: CustomError.initial().copyWith(messages: [err.toString()]),
        ),
      );
    }
  }




}
