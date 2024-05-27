abstract class ProductState {
  final int selectedArticle;
  final bool isSpecial;

  const ProductState(this.selectedArticle, this.isSpecial);

  @override
  List<Object> get props => [selectedArticle, isSpecial];
}

class ProductLoaded extends ProductState {
  final Set<int> pendingArticles;

  ProductLoaded(int selectedArticle, bool isSpecial, [Set<int> pendingArticles = const {}])
      : this.pendingArticles = pendingArticles,
        super(selectedArticle, isSpecial);

  @override
  List<Object> get props => [selectedArticle, isSpecial, pendingArticles];
}
