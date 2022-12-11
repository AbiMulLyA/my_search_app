import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../../config/lang/lang.dart';

part 'lang_event.dart';
part 'lang_state.dart';

@lazySingleton
class LangBloc extends HydratedBloc<LangEvent, LangState> {
  LangBloc() : super(LangState(locale: mySearchLang[LangType.id]!));

  @override
  Stream<LangState> mapEventToState(
    LangEvent event,
  ) async* {
    if (event is SwitchEv) {
      yield LangState(locale: mySearchLang[event.langType]!);
    }
  }

  @override
  LangState fromJson(Map<String, dynamic> json) {
    return LangState(
      locale: _mapStringToData(json['langType'].toString()),
    );
  }

  @override
  Map<String, dynamic> toJson(LangState state) {
    return {
      'langType': _mapDataToString(state.locale),
    };
  }

  Locale _mapStringToData(String langType) {
    if (langType == 'LangType.id') {
      return mySearchLang[LangType.id]!;
    } else {
      return mySearchLang[LangType.en]!;
    }
  }

  String _mapDataToString(Locale locale) {
    if (locale == mySearchLang[LangType.id]) {
      return 'LangType.id';
    } else {
      return 'LangType.en';
    }
  }
}
