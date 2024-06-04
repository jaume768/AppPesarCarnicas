abstract class PesajeEvent {
  const PesajeEvent();

  @override
  List<Object?> get props => [];
}

class StartPesajeMonitoring extends PesajeEvent {}

class StopPesajeMonitoring extends PesajeEvent {}

class UpdatePesajeStatus extends PesajeEvent {
  final Map<String, dynamic> pesajeStatus;

  const UpdatePesajeStatus(this.pesajeStatus);

  @override
  List<Object?> get props => [pesajeStatus];
}

class AccumulateWeight extends PesajeEvent {}

class IncrementCount extends PesajeEvent {}