part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class InitialSt extends AuthState {
  const InitialSt();

  @override
  String toString() => 'AuthState.InitialSt';

  @override
  List<Object> get props => [];
}

class AuthenticatedSt extends AuthState {
  const AuthenticatedSt();

  @override
  String toString() => 'AuthState.AuthenticatedSt';

  @override
  List<Object> get props => [];
}
