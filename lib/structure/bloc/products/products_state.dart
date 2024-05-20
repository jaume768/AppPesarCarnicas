abstract class ProductState {
  final int selectedArticle;

  const ProductState(this.selectedArticle);

  @override
  List<Object> get props => [selectedArticle];
}

class ProductLoaded extends ProductState {
  ProductLoaded(int selectedArticle) : super(selectedArticle);

  @override
  List<Object> get props => [selectedArticle];
}