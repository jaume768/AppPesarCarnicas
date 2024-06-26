import 'package:bloc/bloc.dart';
import '../../../data/repositories/product_repository.dart';
import 'products_event.dart';
import 'products_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductRepository repository;

  ProductBloc({required this.repository}) : super(ProductLoaded(-1, false, false, {}, 0, 0)) {
    on<SelectArticle>((event, emit) {
      if (state is ProductLoaded) {
        final currentState = state as ProductLoaded;
        emit(ProductLoaded(
          event.articleId,
          event.isSpecial,
          event.isMandatoryLot,
          currentState.acceptedArticles,
          0,
          event.clientCode,
          currentState.pendingArticles,
        ));
      }
    });

    on<DeselectArticle>((event, emit) {
      if (state is ProductLoaded) {
        final currentState = state as ProductLoaded;
        emit(ProductLoaded(
          -1,
          false,
          false,
          currentState.acceptedArticles,
          currentState.lotNumber,
          currentState.clientCode,
          currentState.pendingArticles,
        ));
      }
    });

    on<AcceptArticle>((event, emit) {
      if (state is ProductLoaded) {
        final currentState = state as ProductLoaded;
        Set<int> newAcceptedArticles = Set<int>.from(currentState.acceptedArticles);
        if(event.llevar){
          if (newAcceptedArticles.contains(event.articleId)) {
            newAcceptedArticles.remove(event.articleId);
          } else {
            newAcceptedArticles.add(event.articleId);
          }
        }
        emit(ProductLoaded(
          currentState.selectedArticle,
          currentState.isSpecial,
          currentState.isMandatoryLot,
          newAcceptedArticles,
          currentState.lotNumber,
          currentState.clientCode,
          currentState.pendingArticles,
        ));
      }
    });

    on<MarkAsPending>((event, emit) {
      if (state is ProductLoaded) {
        final currentState = state as ProductLoaded;
        Set<int> newPendingArticles = Set<int>.from(currentState.pendingArticles);
        if(event.llevar){
          if (newPendingArticles.contains(event.articleId)) {
            newPendingArticles.remove(event.articleId);
          } else {
            newPendingArticles.add(event.articleId);
          }
        }
        emit(ProductLoaded(
          currentState.selectedArticle,
          currentState.isSpecial,
          currentState.isMandatoryLot,
          currentState.acceptedArticles,
          currentState.lotNumber,
          currentState.clientCode,
          newPendingArticles,
        ));
      }
    });

    on<UpdateLotNumber>((event, emit) {
      if (state is ProductLoaded) {
        final currentState = state as ProductLoaded;
        emit(ProductLoaded(
          currentState.selectedArticle,
          currentState.isSpecial,
          currentState.isMandatoryLot,
          currentState.acceptedArticles,
          event.lotNumber,
          currentState.clientCode,
          currentState.pendingArticles,
        ));
      }
    });

    on<RemoveArticleFromLists>((event, emit) {
        final currentState = state as ProductLoaded;
        Set<int> newAcceptedArticles = Set<int>.from(currentState.acceptedArticles);
        Set<int> newPendingArticles = Set<int>.from(currentState.pendingArticles);

        newAcceptedArticles.remove(event.articleId);
        newPendingArticles.remove(event.articleId);

        emit(ProductLoaded(
          currentState.selectedArticle,
          currentState.isSpecial,
          currentState.isMandatoryLot,
          newAcceptedArticles,
          currentState.lotNumber,
          currentState.clientCode,
          newPendingArticles,
        ));
    });
  }
}
