part of 'article_bloc.dart';

abstract class ArticleState {
  const ArticleState();
}

class ArticleInitial extends ArticleState {}

class ArticleLoading extends ArticleState {}

class ArticleLoaded extends ArticleState {
  final List<Map<String, dynamic>> articles;
  final String sortField;
  final bool isAscending;

  ArticleLoaded({required this.articles, this.sortField = 'kgs', this.isAscending = false});

  List<Map<String, dynamic>> get sortedArticles {
    var articlesCopy = List<Map<String, dynamic>>.from(articles);

    articlesCopy.sort((a, b) {
      dynamic aValue = a[sortField];
      dynamic bValue = b[sortField];

      int convertToNumeric(dynamic value) {
        if (value is String && value.isEmpty) {
          return 0;
        } else if (value is String) {
          return int.tryParse(value) ?? 0;
        }
        return value ?? 0;
      }

      aValue = convertToNumeric(aValue);
      bValue = convertToNumeric(bValue);

      if (isAscending) {
        if (aValue == 0 && bValue != 0) return 1;
        if (aValue != 0 && bValue == 0) return -1;
        return aValue.compareTo(bValue);
      } else {
        if (aValue == 0 && bValue != 0) return 1;
        if (aValue != 0 && bValue == 0) return -1;
        return bValue.compareTo(aValue);
      }
    });

    return articlesCopy;
  }
}

class ArticleError extends ArticleState {
  final String message;

  ArticleError({required this.message});
}
