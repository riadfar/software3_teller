import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/errors/custom_error.dart';
import '../../../customer_account/data/model/account.dart';
import '../../../customer_account/data/repo/customer_repo.dart';
import '../../data/repo/withdrawal_repo.dart';

part 'withdrawal_state.dart';

class WithdrawalCubit extends Cubit<WithdrawalState> {
  final WithdrawalRepo withdrawalRepo;
  final CustomerRepo customerRepo;

  WithdrawalCubit({required this.withdrawalRepo,required this.customerRepo})
    : super(WithdrawalState.initial());

  Future<void> getCustomerAccount({required String accountNumber}) async {
    emit(state.copyWith(status: WithdrawalStatus.loading));
    try {
      final account = await customerRepo.getCustomerAccount(
        accountNumber: accountNumber,
      );

      emit(
        state.copyWith(
          status: WithdrawalStatus.founded,
          account: account,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: WithdrawalStatus.error,
          error: CustomError.initial().copyWith(messages: [e.toString()]),
        ),
      );
    }
  }


  Future<void> withdrawal({required int amount}) async {
    emit(state.copyWith(status: WithdrawalStatus.loading));
    try {
      await withdrawalRepo.withdrawal(
        accountNumber: state.account!.accountNumber,
        amount: amount,
      );

      emit(state.copyWith(status: WithdrawalStatus.loaded));
    } catch (e) {
      emit(
        state.copyWith(
          status: WithdrawalStatus.error,
          error: CustomError.initial().copyWith(messages: [e.toString()]),
        ),
      );
    }
  }
}
