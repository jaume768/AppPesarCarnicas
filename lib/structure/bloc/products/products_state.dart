abstract class ProductState {
  final int selectedArticle;
  final bool isSpecial;
  final bool isMandatoryLot;
  final Set<int> acceptedArticles;
  final int clientCode;

  const ProductState(this.selectedArticle, this.isSpecial, this.isMandatoryLot, this.acceptedArticles, this.clientCode);

  @override
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
      int clientCode, // Añadir este parámetro
      [Set<int> pendingArticles = const {}]
      ) : this.pendingArticles = pendingArticles,
        super(selectedArticle, isSpecial, isMandatoryLot, acceptedArticles, clientCode); // Añadir aquí

  @override
  List<Object> get props => super.props..addAll([pendingArticles, lotNumber]);
}
