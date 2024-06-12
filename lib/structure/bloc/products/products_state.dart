abstract class ProductState {
  final int selectedArticle;
  final bool isSpecial;
  final bool isMandatoryLot;
  final Set<int> acceptedArticles;
  final int clientCode;

  const ProductState(this.selectedArticle, this.isSpecial, this.isMandatoryLot, this.acceptedArticles, this.clientCode);

  List<Object> get props => [selectedArticle, isSpecial, isMandatoryLot, acceptedArticles, clientCode];
}

class ProductLoaded extends ProductState {
  final Set<int> pendingArticles;
  final int lotNumber;

  ProductLoaded(
      int selectedArticle,
      bool isSpecial,
      bool isMandatoryLot,
      Set<int> acceptedArticles,
      this.lotNumber,
      int clientCode, 
      [this.pendingArticles = const {}]
      ) : super(selectedArticle, isSpecial, isMandatoryLot, acceptedArticles, clientCode);

  @override
  List<Object> get props => super.props..addAll([pendingArticles, lotNumber]);
}
