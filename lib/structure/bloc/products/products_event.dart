abstract class ProductEvent {
  @override
  List<Object> get props => [];
}

class SelectArticle extends ProductEvent {
  final int articleId;
  final bool isSpecial;
  final bool isMandatoryLot;

  SelectArticle(this.articleId, this.isSpecial, this.isMandatoryLot);

  @override
  List<Object> get props => [articleId, isSpecial, isMandatoryLot];
}

class DeselectArticle extends ProductEvent {
  final int articleId;

  DeselectArticle(this.articleId);

  @override
  List<Object> get props => [articleId];
}

class MarkAsPending extends ProductEvent {
  final int articleId;

  MarkAsPending(this.articleId);

  @override
  List<Object> get props => [articleId];
}

class UpdateLotNumber extends ProductEvent {
  final int lotNumber;

  UpdateLotNumber(this.lotNumber);

  @override
  List<Object> get props => [lotNumber];
}

class AcceptArticle extends ProductEvent {
  final int articleId;

  AcceptArticle(this.articleId);

  @override
  List<Object> get props => [articleId];
}