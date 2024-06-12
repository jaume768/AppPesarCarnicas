class ConfigurationState {
  final List<dynamic> printers;
  final List<dynamic> scales;
  final dynamic selectedPrinter;
  final dynamic selectedScale;
  final String? selectedProductType; // Agregar esta línea
  final bool isLoading;
  final String? error;

  const ConfigurationState({
    this.printers = const [],
    this.scales = const [],
    this.selectedPrinter,
    this.selectedScale,
    this.selectedProductType, // Agregar esta línea
    this.isLoading = false,
    this.error,
  });

  ConfigurationState copyWith({
    List<dynamic>? printers,
    List<dynamic>? scales,
    dynamic selectedPrinter,
    dynamic selectedScale,
    String? selectedProductType, // Agregar esta línea
    bool? isLoading,
    String? error,
  }) {
    return ConfigurationState(
      printers: printers ?? this.printers,
      scales: scales ?? this.scales,
      selectedPrinter: selectedPrinter ?? this.selectedPrinter,
      selectedScale: selectedScale ?? this.selectedScale,
      selectedProductType: selectedProductType ?? this.selectedProductType, // Agregar esta línea
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }

  List<Object?> get props => [printers, scales, selectedPrinter, selectedScale, selectedProductType, isLoading, error];
}
