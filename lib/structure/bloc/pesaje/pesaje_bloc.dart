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
  }

  void _onStartPesajeMonitoring(StartPesajeMonitoring event, Emitter<PesajeState> emit) {
    _timer?.cancel();
    emit(PesajeLoading());

    _startPesajeZeroTimer(emit);
  }

  void _startPesajeZeroTimer(Emitter<PesajeState> emit) {
    _timer = Timer.periodic(Duration(milliseconds: 200), (timer) async {
      try {
        final pesajeStatus = await repository.getPesajeZero();
        add(UpdatePesajeStatus(pesajeStatus));
        await Future.delayed(Duration(seconds: 2));
        final pesajeStatus2 = await repository.getPesajeInestable();
        add(UpdatePesajeStatus(pesajeStatus2));
        print("inestable");
        await Future.delayed(Duration(seconds: 2));
        final pesajeStatus3 = await repository.getPesajeEstable();
        add(UpdatePesajeStatus(pesajeStatus3));
        print("estable");
        await Future.delayed(Duration(seconds: 2));
        if (pesajeStatus['tipoPes'] == 'ZERO') {
          timer.cancel();
        }
      } catch (error) {
        timer.cancel();
      }
    });
  }

  void _onStopPesajeMonitoring(StopPesajeMonitoring event, Emitter<PesajeState> emit) {
    _timer?.cancel();
    emit(PesajeInitial());
  }

  void _onUpdatePesajeStatus(UpdatePesajeStatus event, Emitter<PesajeState> emit) {
    emit(PesajeLoaded(event.pesajeStatus));
    if (event.pesajeStatus['tipoPes'] != 'ZERO' && event.pesajeStatus['tipoPes'] != 'INESTABLE') {
      add(StopPesajeMonitoring());
    }
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }
}
