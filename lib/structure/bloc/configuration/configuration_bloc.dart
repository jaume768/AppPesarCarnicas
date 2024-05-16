import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/repositories/configuration_repository.dart';
import 'configuration_event.dart';
import 'configuration_state.dart';

class ConfigurationBloc extends Bloc<ConfigurationEvent, ConfigurationState> {
  final ConfigurationRepository repository;

  ConfigurationBloc({required this.repository}) : super(ConfigurationState()) {
    on<FetchConfiguration>(_onFetchConfiguration);
    on<SelectPrinter>(_onSelectPrinter);
    on<SelectScale>(_onSelectScale);
  }

  Future<void> _onFetchConfiguration(FetchConfiguration event, Emitter<ConfigurationState> emit) async {
    emit(state.copyWith(isLoading: true, error: null));
    try {
      final config = await repository.getConfiguration();
      emit(state.copyWith(printers: config['printers'], scales: config['scales'], isLoading: false));
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: e.toString()));
    }
  }

  void _onSelectPrinter(SelectPrinter event, Emitter<ConfigurationState> emit) {
    emit(state.copyWith(selectedPrinter: event.printer));
  }

  void _onSelectScale(SelectScale event, Emitter<ConfigurationState> emit) {
    emit(state.copyWith(selectedScale: event.scale));
  }
}
