import 'package:bloc/bloc.dart';

import '../../../data/repositories/product_repository.dart';
part 'article_event.dart';
part 'article_state.dart';

class ArticleBloc extends Bloc<ArticleEvent, ArticleState> {
  final ProductRepository productRepository;

  ArticleBloc({required this.productRepository}) : super(ArticleInitial()) {
    on<FetchArticles>(_onFetchArticles);
    on<SortArticles>(_onSortArticles);
  }

  void _onFetchArticles(FetchArticles event, Emitter<ArticleState> emit) async {
    emit(ArticleLoading());
    try {
      final articles = await productRepository.getArticleList(event.productType);
      emit(ArticleLoaded(articles: articles));
    } catch (e) {
      emit(ArticleError(message: e.toString()));
    }
  }

  void _onSortArticles(SortArticles event, Emitter<ArticleState> emit) {
    if (state is ArticleLoaded) {
      final currentState = state as ArticleLoaded;
      emit(ArticleLoaded(
        articles: currentState.articles,
        sortField: event.sortField,
        isAscending: event.isAscending,
      ));
    }
  }

}
