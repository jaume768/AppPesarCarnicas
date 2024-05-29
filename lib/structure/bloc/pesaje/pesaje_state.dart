
abstract class PesajeState  {
  const PesajeState();

  @override
  List<Object?> get props => [];
}

class PesajeInitial extends PesajeState {}

class PesajeLoading extends PesajeState {}

class PesajeLoaded extends PesajeState {
  final Map<String, dynamic> pesajeStatus;

  const PesajeLoaded(this.pesajeStatus);

  @override
  List<Object?> get props => [pesajeStatus];
}
