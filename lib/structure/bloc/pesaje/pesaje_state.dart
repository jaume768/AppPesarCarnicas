abstract class PesajeState {
  final double? weight;
  final double accumulatedWeight;
  final int count;

  const PesajeState({this.weight, this.accumulatedWeight = 0.0, this.count = 0});

  List<Object?> get props => [weight, accumulatedWeight, count];
}

class PesajeInitial extends PesajeState {}

class PesajeLoading extends PesajeState {}

class PesajeLoaded extends PesajeState {
  final Map<String, dynamic> pesajeStatus;

  const PesajeLoaded(this.pesajeStatus, {double? weight, double accumulatedWeight = 0.0, int count = 0})
      : super(weight: weight, accumulatedWeight: accumulatedWeight, count: count);

  @override
  List<Object?> get props => [pesajeStatus, weight, accumulatedWeight, count];
}

class PesajeError extends PesajeState {
  final String message;

  const PesajeError(this.message, {double? weight, double accumulatedWeight = 0.0, int count = 0})
      : super(weight: weight, accumulatedWeight: accumulatedWeight, count: count);

  @override
  List<Object?> get props => [message, weight, accumulatedWeight, count];
}