part of 'locale_bloc.dart';

sealed class LocaleState {
  final Language selectedLanguage;
  const LocaleState({Language? language})
      : selectedLanguage = language ?? Language.catalan;

  List<Object> get props => [selectedLanguage];
}

final class LocaleInitial extends LocaleState {}

final class LocaleChanged extends LocaleState {
  const LocaleChanged({super.language});
}