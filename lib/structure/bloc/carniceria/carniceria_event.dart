abstract class CarniceriaEvent {
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

class FetchSummaries extends CarniceriaEvent {
  final String productType;

  const FetchSummaries(this.productType);

  @override
  List<Object> get props => [productType];
}

class ToggleButchery extends CarniceriaEvent {
  final bool isButchery;

  const ToggleButchery(this.isButchery);

  @override
  List<Object> get props => [isButchery];
}

class FetchProductList extends CarniceriaEvent {
  final String productType;
  final bool butchery;
  final List<int> summaries;

  const FetchProductList(this.productType, this.butchery, this.summaries);

  @override
  List<Object> get props => [productType, butchery, summaries];
}
