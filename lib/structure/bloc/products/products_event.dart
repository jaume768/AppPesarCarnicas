abstract class ProductEvent {
  @override
  List<Object> get props => [];
}

class SelectArticle extends ProductEvent {
  final int articleIndex;
  final bool isSpecial;
  final bool isMandatoryLot;

  SelectArticle(this.articleIndex, this.isSpecial, this.isMandatoryLot);

  @override
  List<Object> get props => [articleIndex, isSpecial, isMandatoryLot];
}

class DeselectArticle extends ProductEvent {
  final int articleIndex;

  DeselectArticle(this.articleIndex);

  @override
  List<Object> get props => [articleIndex];
}

class MarkAsPending extends ProductEvent {
  final int articleIndex;

  MarkAsPending(this.articleIndex);

  @override
  List<Object> get props => [articleIndex];
}

class UpdateLotNumber extends ProductEvent {
  final int lotNumber;

  UpdateLotNumber(this.lotNumber);

  @override
  List<Object> get props => [lotNumber];
}

class ToggleMultiPesIndicators extends ProductEvent {
  @override
  List<Object> get props => [];
}
