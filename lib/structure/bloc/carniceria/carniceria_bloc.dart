import 'package:flutter_bloc/flutter_bloc.dart';
import 'carniceria_event.dart';
import 'carniceria_state.dart';

class CarniceriaBloc extends Bloc<CarniceriaEvent, CarniceriaState> {
  CarniceriaBloc() : super(CarniceriaState(options: List<bool>.filled(8, false)));

  @override
  Stream<CarniceriaState> mapEventToState(CarniceriaEvent event) async* {
    if (event is ToggleOption) {
      final updatedOptions = List<bool>.from(state.options);
      updatedOptions[event.index] = !updatedOptions[event.index];
      yield state.copyWith(options: updatedOptions);
    }
  }
}
