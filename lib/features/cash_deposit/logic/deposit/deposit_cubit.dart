import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/errors/custom_error.dart';
import '../../../customer_account/data/model/account.dart';
import '../../../customer_account/data/repo/customer_repo.dart';
import '../../data/repo/deposit_repo.dart';

part 'deposit_state.dart';

class DepositCubit extends Cubit<DepositState> {
  final DepositRepo depositRepo;
  final CustomerRepo customerRepo;

  DepositCubit({required this.depositRepo, required this.customerRepo})
    : super(DepositState.initial());

  Future<void> getCustomerAccount({required String accountNumber}) async {
    emit(state.copyWith(status: DepositStatus.loading));
    try {
      final account = await customerRepo.getCustomerAccount(
        accountNumber: accountNumber,
      );

      emit(
        state.copyWith(
          status: DepositStatus.founded,
          account: account,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: DepositStatus.error,
          error: CustomError.initial().copyWith(messages: [e.toString()]),
        ),
      );
    }
  }

  Future<void> deposit({required int amount}) async {
    emit(state.copyWith(status: DepositStatus.loading));
    try {
      await depositRepo.deposit(
        accountNumber: state.account!.accountNumber,
        amount: amount,
      );

      emit(state.copyWith(status: DepositStatus.loaded));
    } catch (e) {
      emit(
        state.copyWith(
          status: DepositStatus.error,
          error: CustomError.initial().copyWith(messages: [e.toString()]),
        ),
      );
    }
  }
}
