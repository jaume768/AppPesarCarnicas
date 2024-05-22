abstract class ProductEvent {
  @override
  List<Object> get props => [];
}

class SelectArticle extends ProductEvent {
  final int articleIndex;

  SelectArticle(this.articleIndex);

  @override
  List<Object> get props => [articleIndex];
}

class DeselectArticle extends ProductEvent {
  final int articleIndex;

  DeselectArticle(this.articleIndex);

  @override
  List<Object> get props => [articleIndex];
}

class MarkAsPending extends ProductEvent {
  final int articleIndex;

  MarkAsPending(this.articleIndex);

  @override
  List<Object> get props => [articleIndex];
}