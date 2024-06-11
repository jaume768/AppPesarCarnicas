
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../ui/utils/lenguage.dart';
part 'locale_event.dart';
part 'locale_state.dart';

class LocaleBloc extends Bloc<LocaleEvent, LocaleState> {
  LocaleBloc() : super(LocaleInitial()) {
    on<ChangeLanguage>(_onChangeLanguage);
  }

  _onChangeLanguage(ChangeLanguage event, Emitter<LocaleState> emit) {
    emit(LocaleChanged(language: event.selectedLanguage));
  }
}