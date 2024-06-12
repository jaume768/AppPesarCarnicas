
abstract class ConfigurationEvent{
  const ConfigurationEvent();

  List<Object> get props => [];
}

class FetchConfiguration extends ConfigurationEvent {}

class SelectPrinter extends ConfigurationEvent {
  final dynamic printer;

  const SelectPrinter(this.printer);

  @override
  List<Object> get props => [printer];
}

class SelectScale extends ConfigurationEvent {
  final dynamic scale;

  const SelectScale(this.scale);

  @override
  List<Object> get props => [scale];
}

class SelectProductType extends ConfigurationEvent {
  final String productType;

  const SelectProductType(this.productType);

  @override
  List<Object> get props => [productType];
}