class CarniceriaState {
  final List<bool> options;
  final List<int> summaries;
  final String? selectedProductType;
  final bool isButchery;

  const CarniceriaState({
    required this.options,
    required this.summaries,
    this.selectedProductType,
    required this.isButchery,
  });

  CarniceriaState copyWith({
    List<bool>? options,
    List<int>? summaries,
    String? selectedProductType,
    bool? isButchery,
    bool clearSelectedProductType = false,
  }) {
    return CarniceriaState(
      options: options ?? this.options,
      summaries: summaries ?? this.summaries,
      selectedProductType: clearSelectedProductType ? null : selectedProductType ?? this.selectedProductType,
      isButchery: isButchery ?? this.isButchery,
    );
  }

  @override
  List<Object?> get props => [options, summaries, selectedProductType, isButchery];
}
