class CarniceriaState {
  final Map<String, List<bool>> optionsMap;
  final List<int> summaries;
  final List<dynamic> products;
  final String? selectedProductType;
  final bool isButchery;
  final Map<String, dynamic>? selectedScale;
  final Map<String, dynamic>? selectedPrinter;

  const CarniceriaState({
    required this.optionsMap,
    required this.summaries,
    this.products = const [],
    this.selectedProductType,
    required this.isButchery,
    this.selectedScale,
    this.selectedPrinter,
  });

  CarniceriaState copyWith({
    Map<String, List<bool>>? optionsMap,
    List<int>? summaries,
    List<dynamic>? products,
    String? selectedProductType,
    bool? isButchery,
    Map<String, dynamic>? selectedScale,
    Map<String, dynamic>? selectedPrinter,
    bool clearSelectedProductType = false,
  }) {
    return CarniceriaState(
      optionsMap: optionsMap ?? this.optionsMap,
      summaries: summaries ?? this.summaries,
      products: products ?? this.products,
      selectedProductType: clearSelectedProductType ? null : selectedProductType ?? this.selectedProductType,
      isButchery: isButchery ?? this.isButchery,
      selectedScale: selectedScale ?? this.selectedScale,
      selectedPrinter: selectedPrinter ?? this.selectedPrinter,
    );
  }

  @override
  List<Object?> get props => [optionsMap, summaries,products, selectedProductType, isButchery,selectedScale, selectedPrinter];
}
