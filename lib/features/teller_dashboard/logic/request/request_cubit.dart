import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../data/model/request.dart';
import '../../data/repo/request_repo.dart';

part 'request_state.dart';



class RequestCubit extends Cubit<RequestState> {
  final RequestRepo repo;

  RequestCubit({required this.repo}) : super(const RequestState());

  Future<void> fetchAllRequests() async {
    emit(state.copyWith(status: RequestStatus.loading));
    try {
      final requests = await repo.getAllRequests();
      emit(state.copyWith(status: RequestStatus.loaded, requests: requests));
    } catch (e) {
      emit(state.copyWith(status: RequestStatus.error, error: e.toString()));
    }
  }

  Future<void> acceptRequest(int requestId) async {
    try {
      await repo.accept(requestId: requestId);
      await fetchAllRequests();
    } catch (e) {
      emit(state.copyWith(status: RequestStatus.error, error: e.toString()));
    }
  }

  Future<void> rejectRequest(int requestId, String reason) async {
    try {
      await repo.reject(requestId: requestId, reason: reason);
      await fetchAllRequests();
    } catch (e) {
      emit(state.copyWith(status: RequestStatus.error, error: e.toString()));
    }
  }
}

