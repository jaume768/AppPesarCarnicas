abstract class ProductState {
  final int selectedArticle;
  final bool isSpecial;
  final bool isMandatoryLot;
  final Set<int> acceptedArticles;

  const ProductState(this.selectedArticle, this.isSpecial, this.isMandatoryLot, this.acceptedArticles);

  @override
  List<Object> get props => [selectedArticle, isSpecial, isMandatoryLot, acceptedArticles];
}

class ProductLoaded extends ProductState {
  final Set<int> pendingArticles;
  final int lotNumber;

  ProductLoaded(
      int selectedArticle,
      bool isSpecial,
      bool isMandatoryLot,
      Set<int> acceptedArticles,
      this.lotNumber, [
        Set<int> pendingArticles = const {},
      ])  : this.pendingArticles = pendingArticles,
        super(selectedArticle, isSpecial, isMandatoryLot, acceptedArticles);

  @override
  List<Object> get props => [
    selectedArticle,
    isSpecial,
    isMandatoryLot,
    pendingArticles,
    lotNumber,
    acceptedArticles,
  ];
}