abstract class ProductState {
  final int selectedArticle;

  const ProductState(this.selectedArticle);

  @override
  List<Object> get props => [selectedArticle];
}

class ProductLoaded extends ProductState {
  final Set<int> pendingArticles;  // Nuevo campo

  ProductLoaded(int selectedArticle, [Set<int> pendingArticles = const {}])
      : this.pendingArticles = pendingArticles,
        super(selectedArticle);

  @override
  List<Object> get props => [selectedArticle, pendingArticles];
}

