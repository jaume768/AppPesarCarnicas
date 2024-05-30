abstract class PesajeState {
  final double? weight;

  const PesajeState({this.weight});

  @override
  List<Object?> get props => [weight];
}

class PesajeInitial extends PesajeState {}

class PesajeLoading extends PesajeState {}

class PesajeLoaded extends PesajeState {
  final Map<String, dynamic> pesajeStatus;

  const PesajeLoaded(this.pesajeStatus, {double? weight}) : super(weight: weight);

  @override
  List<Object?> get props => [pesajeStatus, weight];
}

class PesajeError extends PesajeState {
  final String message;

  const PesajeError(this.message, {double? weight}) : super(weight: weight);

  @override
  List<Object?> get props => [message, weight];
}
