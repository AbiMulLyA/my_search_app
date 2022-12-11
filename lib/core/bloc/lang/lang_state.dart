part of 'lang_bloc.dart';

class LangState extends Equatable {
  const LangState({
    required this.locale,
  });

  final Locale locale;

  @override
  List<Object> get props => [locale];
}
