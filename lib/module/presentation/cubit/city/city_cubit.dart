// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:injectable/injectable.dart';
import 'package:my_search_app/core/usecase/usecase.dart';

import '../../../domain/entity/city_entity.dart';
import '../../../domain/usecase/city/city_usecase.dart';

part 'city_state.dart';

@injectable
class CityCubit extends Cubit<CityState> {
  final CityUseCase cityUseCase;
  CityCubit(
    this.cityUseCase,
  ) : super(const CityState());
  void fetchCity() async {
    final fetchData = await cityUseCase(NoParam());

    debugPrint('$runtimeType.event: fetchCity');

    fetchData.fold(
      (failure) {
        final Map error = {
          "code": failure.code,
          "message": failure.message,
          "type": failure.type,
        };

        emit(
          state.copyWith(
            status: CityStateStatus.failed,
            error: error,
          ),
        );
      },
      (data) {
        emit(
          state.copyWith(
            status: CityStateStatus.succeed,
            data: data,
            error: {},
          ),
        );
      },
    );
  }
}
