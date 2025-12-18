import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/errors/custom_error.dart';
import '../../data/model/account.dart';
import '../../data/model/createResponse.dart';
import '../../data/model/customer.dart';
import '../../data/repo/customer_repo.dart';

part 'customer_account_state.dart';

class CustomerAccountCubit extends Cubit<CustomerAccountState> {
  final CustomerRepo customerRepo;

  CustomerAccountCubit({required this.customerRepo})
    : super(CustomerAccountState.initial());

  Future<void> getCustomerAccount({required String accountNumber}) async {
    emit(state.copyWith(status: CustomerAccountStatus.loading));
    try {
      Account account = await customerRepo.getCustomerAccount(
        accountNumber: accountNumber,
      );
      print('start emitting');
      emit(
        state.copyWith(
          status: CustomerAccountStatus.loaded,
          account: account,
          customer: account.customer,
        ),
      );
    } on CustomError catch (err) {
      emit(state.copyWith(status: CustomerAccountStatus.error, error: err));
    } catch (err) {
      emit(
        state.copyWith(
          status: CustomerAccountStatus.error,
          error: CustomError.initial().copyWith(messages: [err.toString()]),
        ),
      );
    }
  }

  Future<void> createCustomer({
    required String fullName,
    required String nationalId,
    required String phone,
    required String address,
    required String birthDate,
    required String accountType,
  }) async {
    emit(state.copyWith(status: CustomerAccountStatus.loading));
    try {
      CreateResponse createResponse = await customerRepo.createCustomer(
        fullName: fullName,
        nationalId: nationalId,
        phone: phone,
        address: address,
        birthDate: birthDate,
        accountType: accountType,
      );
      print('start emitting');
      emit(
        state.copyWith(
          status: CustomerAccountStatus.loaded,
          createResponse: createResponse,
        ),
      );
    } on CustomError catch (err) {
      emit(state.copyWith(status: CustomerAccountStatus.error, error: err));
    } catch (err) {
      emit(
        state.copyWith(
          status: CustomerAccountStatus.error,
          error: CustomError.initial().copyWith(messages: [err.toString()]),
        ),
      );
    }
  }
}
