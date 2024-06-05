part of 'article_bloc.dart';

abstract class ArticleState {
  const ArticleState();

  @override
  List<Object> get props => [];
}

class ArticleInitial extends ArticleState {}

class ArticleLoading extends ArticleState {}

class ArticleLoaded extends ArticleState {
  final List<Map<String, dynamic>> articles;

  const ArticleLoaded({required this.articles});

  @override
  List<Object> get props => [articles];
}

class ArticleError extends ArticleState {
  final String message;

  const ArticleError({required this.message});

  @override
  List<Object> get props => [message];
}
