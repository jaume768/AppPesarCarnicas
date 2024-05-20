
import '../../../models/client.dart';

class CarniceriaState {
  final Map<String, List<bool>> optionsMap;
  final List<int> summaries;
  final List<Client> products; // Cambiar a List<Client>
  final String? selectedProductType;
  final bool isButchery;

  const CarniceriaState({
    required this.optionsMap,
    required this.summaries,
    this.products = const [],
    this.selectedProductType,
    required this.isButchery,
  });

  CarniceriaState copyWith({
    Map<String, List<bool>>? optionsMap,
    List<int>? summaries,
    List<Client>? products, // Cambiar a List<Client>
    String? selectedProductType,
    bool? isButchery,
    Map<String, dynamic>? selectedScale,
    Map<String, dynamic>? selectedPrinter,
    bool clearSelectedProductType = false,
  }) {
    return CarniceriaState(
      optionsMap: optionsMap ?? this.optionsMap,
      summaries: summaries ?? this.summaries,
      products: products ?? this.products, // Cambiar a List<Client>
      selectedProductType: clearSelectedProductType ? null : selectedProductType ?? this.selectedProductType,
      isButchery: isButchery ?? this.isButchery,
    );
  }

  @override
  List<Object?> get props => [optionsMap, summaries, products, selectedProductType, isButchery];
}
