part of 'user_bloc.dart';

enum UserStateStatus {
  initial,
  loading,
  succeed,
  failed,
}

class UserState extends Equatable {
  const UserState({
    this.status = UserStateStatus.initial,
    this.data = const <UserEntity>[],
    this.error = const {},
  });

  final UserStateStatus status;
  final List<UserEntity> data;
  final Map error;

  UserState copyWith({
    UserStateStatus? status,
    List<UserEntity>? data,
    Map? error,
  }) {
    return UserState(
      status: status ?? this.status,
      data: data ?? this.data,
      error: error ?? this.error,
    );
  }

  @override
  String toString() =>
      'UserState { status: $status, data: ${data.length}, error: $error}';

  @override
  List<Object> get props => [status, data, error];
}
