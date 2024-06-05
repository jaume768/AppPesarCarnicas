part of 'article_bloc.dart';

abstract class ArticleEvent {
  const ArticleEvent();

  @override
  List<Object> get props => [];
}

class FetchArticles extends ArticleEvent {
  final String productType;

  const FetchArticles({required this.productType});

  @override
  List<Object> get props => [productType];
}

class SortArticles extends ArticleEvent {
  final String sortField;
  final bool isAscending;

  SortArticles({required this.sortField, required this.isAscending});
}

