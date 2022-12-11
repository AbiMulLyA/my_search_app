// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

part 'auth_event.dart';
part 'auth_state.dart';

@lazySingleton
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(const InitialSt()) {
    on<AuthEvent>(
      (event, emit) async {
        if (event is AppStartedEv) {
          emit(const AuthenticatedSt());
        }
      },
    );
  }
}
