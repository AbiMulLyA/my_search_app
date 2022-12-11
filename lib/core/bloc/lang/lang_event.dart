part of 'lang_bloc.dart';

abstract class LangEvent extends Equatable {
  const LangEvent();

  @override
  List<Object> get props => [];
}

class SwitchEv extends LangEvent {
  const SwitchEv({
    required this.langType,
  });

  final LangType langType;

  @override
  String toString() => 'LangEvent.SwitchEv';

  @override
  List<Object> get props => [langType];
}
