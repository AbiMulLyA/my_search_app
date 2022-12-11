// ignore_for_file: public_member_api_docs, sort_constructors_first, void_checks
// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:injectable/injectable.dart';

import '../../../domain/entity/user_entity.dart';
import '../../../domain/usecase/user/add_user_usecase.dart';
import '../../../domain/usecase/user/get_user_usecase.dart';
import '../../../domain/usecase/user/user_param.dart';

part 'user_event.dart';
part 'user_state.dart';

@injectable
class UserBloc extends Bloc<UserEvent, UserState> {
  final GetUserUseCase getUserUseCase;
  final AddUserUseCase addUserUseCase;
  UserBloc(
    this.getUserUseCase,
    this.addUserUseCase,
  ) : super(const UserState()) {
    on<UserEvent>(
      (event, emit) async {
        if (event is UserListFetchEv) {
          emit(state.copyWith(
            status: UserStateStatus.loading,
          ));
          debugPrint('$runtimeType.DebugContentFollowStateStatus.loading');

          final fetchData = await getUserUseCase(
            UserParam(name: event.name, city: event.city),
          );

          return fetchData.fold(
            (failure) {
              final Map error = {
                "code": failure.code,
                "message": failure.message,
                "type": failure.type,
              };

              debugPrint('$runtimeType.state.data: ${state.data.length}');

              emit(
                state.copyWith(
                  status: UserStateStatus.failed,
                  error: error,
                ),
              );
            },
            (data) {
              emit(
                state.copyWith(
                  status: UserStateStatus.succeed,
                  data: data,
                  error: {},
                ),
              );
            },
          );
        }
        if (event is AddUserEv) {
          emit(state.copyWith(
            status: UserStateStatus.loading,
          ));
          debugPrint('$runtimeType.DebugContentFollowStateStatus.loading');

          final fetchData = await addUserUseCase(
            UserParam(
                name: event.name,
                city: event.city,
                email: event.email,
                phoneNumber: event.phoneNumber,
                address: event.address),
          );

          return fetchData.fold(
            (failure) {
              final Map error = {
                "code": failure.code,
                "message": failure.message,
                "type": failure.type,
              };

              debugPrint('$runtimeType.state.data: ${state.data.length}');

              emit(
                state.copyWith(
                  status: UserStateStatus.failed,
                  error: error,
                ),
              );
            },
            (data) {
              emit(
                state.copyWith(
                  status: UserStateStatus.succeed,
                  error: {},
                ),
              );
            },
          );
        }
      },
    );
  }
}
