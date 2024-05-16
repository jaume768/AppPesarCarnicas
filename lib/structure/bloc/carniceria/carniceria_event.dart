
abstract class CarniceriaEvent  {
  const CarniceriaEvent();

  @override
  List<Object> get props => [];
}

class ToggleOption extends CarniceriaEvent {
  final int index;

  const ToggleOption(this.index);

  @override
  List<Object> get props => [index];
}
