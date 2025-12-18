part of 'request_cubit.dart';


enum RequestStatus { initial, loading, loaded, error }

class RequestState {
  final RequestStatus status;
  final List<Request> requests;
  final String? error;

  const RequestState({
    this.status = RequestStatus.initial,
    this.requests = const [],
    this.error,
  });

  RequestState copyWith({
    RequestStatus? status,
    List<Request>? requests,
    String? error,
  }) {
    return RequestState(
      status: status ?? this.status,
      requests: requests ?? this.requests,
      error: error,
    );
  }
}
