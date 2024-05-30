abstract class ProductState {
  final int selectedArticle;
  final bool isSpecial;
  final bool isMandatoryLot;
  final List<int> acceptedArticles;

  const ProductState(this.selectedArticle, this.isSpecial, this.isMandatoryLot, this.acceptedArticles);

  @override
  List<Object> get props => [selectedArticle, isSpecial, isMandatoryLot, acceptedArticles];
}

class ProductLoaded extends ProductState {
  final Set<int> pendingArticles;
  final int lotNumber;
  final bool showMultiPesIndicators;

  ProductLoaded(
      int selectedArticle,
      bool isSpecial,
      bool isMandatoryLot,
      List<int> acceptedArticles,
      this.lotNumber,
      this.showMultiPesIndicators, [
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
    showMultiPesIndicators,
    acceptedArticles,
  ];
}
