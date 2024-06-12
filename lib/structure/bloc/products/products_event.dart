abstract class ProductEvent {

  List<Object> get props => [];
}

class SelectArticle extends ProductEvent {
  final int articleId;
  final bool isSpecial;
  final bool isMandatoryLot;
  final int clientCode;

  SelectArticle(this.articleId, this.isSpecial, this.isMandatoryLot, this.clientCode);

  @override
  List<Object> get props => [articleId, isSpecial, isMandatoryLot, clientCode];
}

class DeselectArticle extends ProductEvent {
  final int articleId;

  DeselectArticle(this.articleId);

  @override
  List<Object> get props => [articleId];
}

class MarkAsPending extends ProductEvent {
  final int articleId;
  final bool llevar;

  MarkAsPending(this.articleId,this.llevar);

  @override
  List<Object> get props => [articleId,llevar];
}

class UpdateLotNumber extends ProductEvent {
  final int lotNumber;

  UpdateLotNumber(this.lotNumber);

  @override
  List<Object> get props => [lotNumber];
}

class AcceptArticle extends ProductEvent {
  final int articleId;
  final bool llevar;

  AcceptArticle(this.articleId,this.llevar);

  @override
  List<Object> get props => [articleId,llevar];
}

class RemoveArticleFromLists extends ProductEvent {
  final int articleId;

  RemoveArticleFromLists(this.articleId);
}