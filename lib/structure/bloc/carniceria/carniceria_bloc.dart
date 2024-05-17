import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/repositories/carniceria_repository.dart';
import 'carniceria_event.dart';
import 'carniceria_state.dart';

class CarniceriaBloc extends Bloc<CarniceriaEvent, CarniceriaState> {
  final CarniceriaRepository repository;

  CarniceriaBloc({required this.repository})
      : super(CarniceriaState(optionsMap: {}, summaries: [], isButchery: true)) {
    on<ToggleOption>(_onToggleOption);
    on<FetchSummaries>(_onFetchSummaries);
    on<ToggleButchery>(_onToggleButchery);
    on<FetchProductList>(_onFetchProductList);
    on<SelectScale>(_onSelectScale);
    on<SelectPrinter>(_onSelectPrinter);
  }

  void _onToggleOption(ToggleOption event, Emitter<CarniceriaState> emit) {
    if (state.selectedProductType != null) {
      final updatedOptions = List<bool>.from(state.optionsMap[state.selectedProductType!] ?? []);
      updatedOptions[event.index] = !updatedOptions[event.index];
      final updatedOptionsMap = Map<String, List<bool>>.from(state.optionsMap);
      updatedOptionsMap[state.selectedProductType!] = updatedOptions;
      emit(state.copyWith(optionsMap: updatedOptionsMap));
    }
  }

  Future<void> _onFetchSummaries(FetchSummaries event, Emitter<CarniceriaState> emit) async {
    try {
      final summaries = await repository.getSummaries(event.productType, state.isButchery);
      final optionsForProduct = List<bool>.filled(summaries.length, false);

      emit(state.copyWith(
          selectedProductType: event.productType,
          summaries: summaries,
          optionsMap: {event.productType: optionsForProduct}
      ));
    } catch (e) {
      print("Error al cargar los resúmenes: $e");
      emit(state.copyWith(
          selectedProductType: event.productType,
          summaries: [],
          optionsMap: {event.productType: []}
      ));
    }
  }

  void _onToggleButchery(ToggleButchery event, Emitter<CarniceriaState> emit) {
    emit(state.copyWith(
      isButchery: event.isButchery,
      clearSelectedProductType: true,
      summaries: [],
    ));
  }

  Future<void> _onFetchProductList(FetchProductList event, Emitter<CarniceriaState> emit) async {
    try {
      final products = await repository.getProductList(event.productType, event.butchery, event.summaries);
      emit(state.copyWith(products: products));
    } catch (e) {
      // Manejar el error si es necesario
    }
  }

  void _onSelectScale(SelectScale event, Emitter<CarniceriaState> emit) {
    emit(state.copyWith(selectedScale: event.scale));
  }

  void _onSelectPrinter(SelectPrinter event, Emitter<CarniceriaState> emit) {
    emit(state.copyWith(selectedPrinter: event.printer));
  }
}
