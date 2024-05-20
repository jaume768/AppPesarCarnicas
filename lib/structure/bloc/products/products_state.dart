abstract class ProductState {
  final Set<int> selectedArticles;

  const ProductState(this.selectedArticles);

  @override
  List<Object> get props => [selectedArticles];
}

class ProductLoaded extends ProductState {
  ProductLoaded(Set<int> selectedArticles) : super(selectedArticles);

  @override
  List<Object> get props => [selectedArticles];
}