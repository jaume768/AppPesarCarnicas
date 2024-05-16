
class CarniceriaState{
  final List<bool> options;

  const CarniceriaState({required this.options});

  CarniceriaState copyWith({List<bool>? options}) {
    return CarniceriaState(
      options: options ?? this.options,
    );
  }

  @override
  List<Object> get props => [options];
}
