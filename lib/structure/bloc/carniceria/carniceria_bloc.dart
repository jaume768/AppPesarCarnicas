import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/repositories/carniceria_repository.dart';
import 'carniceria_event.dart';
import 'carniceria_state.dart';

class CarniceriaBloc extends Bloc<CarniceriaEvent, CarniceriaState> {
  final CarniceriaRepository repository;

  CarniceriaBloc({required this.repository})
      : super(CarniceriaState(options: List<bool>.filled(8, false), summaries: [], isButchery: true)) {
    on<ToggleOption>(_onToggleOption);
    on<FetchSummaries>(_onFetchSummaries);
    on<ToggleButchery>(_onToggleButchery);
  }

  void _onToggleOption(ToggleOption event, Emitter<CarniceriaState> emit) {
    final updatedOptions = List<bool>.from(state.options);
    updatedOptions[event.index] = !updatedOptions[event.index];
    emit(state.copyWith(options: updatedOptions));
  }

  Future<void> _onFetchSummaries(FetchSummaries event, Emitter<CarniceriaState> emit) async {
    if (state.selectedProductType == event.productType) {
      emit(state.copyWith(
        clearSelectedProductType: true,
        summaries: [],
        options: List<bool>.filled(8, false),
      ));
    } else {
      emit(state.copyWith(selectedProductType: event.productType));
      try {
        final summaries = await repository.getSummaries(event.productType, state.isButchery);
        emit(state.copyWith(summaries: summaries));
      } catch (e) {
        // Manejar el error si es necesario
      }
    }
  }

  void _onToggleButchery(ToggleButchery event, Emitter<CarniceriaState> emit) {
    emit(state.copyWith(
      isButchery: event.isButchery,
      clearSelectedProductType: true,
      summaries: [],
      options: List<bool>.filled(8, false),
    ));
  }
}
