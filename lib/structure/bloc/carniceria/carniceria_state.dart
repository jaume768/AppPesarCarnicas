class CarniceriaState {
  final Map<String, List<bool>> optionsMap;
  final List<int> summaries;
  final String? selectedProductType;
  final bool isButchery;

  const CarniceriaState({
    required this.optionsMap,
    required this.summaries,
    this.selectedProductType,
    required this.isButchery,
  });

  CarniceriaState copyWith({
    Map<String, List<bool>>? optionsMap,
    List<int>? summaries,
    String? selectedProductType,
    bool? isButchery,
    bool clearSelectedProductType = false,
  }) {
    return CarniceriaState(
      optionsMap: optionsMap ?? this.optionsMap,
      summaries: summaries ?? this.summaries,
      selectedProductType: clearSelectedProductType ? null : selectedProductType ?? this.selectedProductType,
      isButchery: isButchery ?? this.isButchery,
    );
  }

  @override
  List<Object?> get props => [optionsMap, summaries, selectedProductType, isButchery];
}
