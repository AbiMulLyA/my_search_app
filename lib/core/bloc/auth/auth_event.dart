part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class AppStartedEv extends AuthEvent {
  const AppStartedEv();

  @override
  String toString() => 'AuthEvent.AppStartedEv';

  @override
  List<Object> get props => [];
}
