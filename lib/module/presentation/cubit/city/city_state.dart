part of 'city_cubit.dart';

enum CityStateStatus {
  initial,
  loading,
  succeed,
  failed,
}

class CityState extends Equatable {
  const CityState({
    this.status = CityStateStatus.initial,
    this.data = const <CityEntity>[],
    this.error = const {},
  });

  final CityStateStatus status;
  final List<CityEntity> data;
  final Map error;

  CityState copyWith({
    CityStateStatus? status,
    List<CityEntity>? data,
    Map? error,
  }) {
    return CityState(
      status: status ?? this.status,
      data: data ?? this.data,
      error: error ?? this.error,
    );
  }

  @override
  String toString() =>
      'CityState { status: $status, data: ${data.length}, error: $error}';

  @override
  List<Object> get props => [status, data, error];
}
