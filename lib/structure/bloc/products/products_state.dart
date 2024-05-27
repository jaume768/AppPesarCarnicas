abstract class ProductState {
  final int selectedArticle;
  final bool isSpecial;
  final bool isMandatoryLot;

  const ProductState(this.selectedArticle, this.isSpecial, this.isMandatoryLot);

  @override
  List<Object> get props => [selectedArticle, isSpecial, isMandatoryLot];
}

class ProductLoaded extends ProductState {
  final Set<int> pendingArticles;

  ProductLoaded(int selectedArticle, bool isSpecial, bool isMandatoryLot, [Set<int> pendingArticles = const {}])
      : this.pendingArticles = pendingArticles,
        super(selectedArticle, isSpecial, isMandatoryLot);

  @override
  List<Object> get props => [selectedArticle, isSpecial, isMandatoryLot, pendingArticles];
}
