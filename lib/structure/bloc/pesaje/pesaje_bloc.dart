import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/repositories/pesaje_repository.dart';
import 'pesaje_event.dart';
import 'pesaje_state.dart';

class PesajeBloc extends Bloc<PesajeEvent, PesajeState> {
  final PesajeRepository repository;
  Timer? _timer;

  PesajeBloc({required this.repository}) : super(PesajeInitial()) {
    on<StartPesajeMonitoring>(_onStartPesajeMonitoring);
    on<StopPesajeMonitoring>(_onStopPesajeMonitoring);
    on<UpdatePesajeStatus>(_onUpdatePesajeStatus);
    on<AccumulateWeight>(_onAccumulateWeight);
    on<IncrementCount>(_onIncrementCount);
  }

  void _onStartPesajeMonitoring(StartPesajeMonitoring event, Emitter<PesajeState> emit) {
    _timer?.cancel();
    emit(PesajeLoading());

    _startPesajeZeroTimer(emit);
  }

  void _startPesajeZeroTimer(Emitter<PesajeState> emit) {
    _timer = Timer.periodic(const Duration(milliseconds: 100), (timer) async {
      try {
        final pesajeStatus = await repository.getPesajeZero();
        add(UpdatePesajeStatus(pesajeStatus));
        add(StopPesajeMonitoring());
        await Future.delayed(const Duration(seconds: 2));
        final pesajeStatus2 = await repository.getPesajeInestable();
        add(UpdatePesajeStatus(pesajeStatus2));
        add(StopPesajeMonitoring());
        await Future.delayed(const Duration(seconds: 2));

        final pesajeStatus3 = await repository.getPesajeEstable();
        if (pesajeStatus3['tipoPes'] == 'ESTABLE') {
          timer.cancel();
          add(UpdatePesajeStatus(pesajeStatus3));
          add(StopPesajeMonitoring());
        }
      } catch (error) {
        timer.cancel();
        emit(PesajeError(error.toString()));
      }
    });
  }

  void _onStopPesajeMonitoring(StopPesajeMonitoring event, Emitter<PesajeState> emit) {
    _timer?.cancel();
  }

  void _onUpdatePesajeStatus(UpdatePesajeStatus event, Emitter<PesajeState> emit) {
    if (event.pesajeStatus['tipoPes'] == 'ESTABLE') {
      final weight = event.pesajeStatus['pes'];
      emit(PesajeLoaded(event.pesajeStatus, weight: weight, accumulatedWeight: state.accumulatedWeight, count: state.count));
    } else {
      emit(PesajeLoaded(event.pesajeStatus, weight: state.weight, accumulatedWeight: state.accumulatedWeight, count: state.count));
    }
  }

  void _onAccumulateWeight(AccumulateWeight event, Emitter<PesajeState> emit) {
    if (state is PesajeLoaded) {
      final currentState = state as PesajeLoaded;
      final accumulatedWeight = currentState.accumulatedWeight + (currentState.weight ?? 0);
      emit(PesajeLoaded(currentState.pesajeStatus, weight: currentState.weight, accumulatedWeight: accumulatedWeight, count: currentState.count));
    }
  }

  void _onIncrementCount(IncrementCount event, Emitter<PesajeState> emit) {
    if (state is PesajeLoaded) {
      final currentState = state as PesajeLoaded;
      final count = currentState.count + 1;
      emit(PesajeLoaded(currentState.pesajeStatus, weight: currentState.weight, accumulatedWeight: currentState.accumulatedWeight, count: count));
    }
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }
}
