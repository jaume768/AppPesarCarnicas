import 'package:bloc/bloc.dart';
import '../../../data/repositories/product_repository.dart';
import 'products_event.dart';
import 'products_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductRepository repository;

  ProductBloc({required this.repository}) : super(ProductLoaded(-1, false, false, 0)) {
    on<SelectArticle>((event, emit) {
      if (state is ProductLoaded) {
        final currentState = state as ProductLoaded;
        emit(ProductLoaded(event.articleIndex, event.isSpecial, event.isMandatoryLot, currentState.lotNumber, currentState.pendingArticles));
      }
    });

    on<DeselectArticle>((event, emit) {
      if (state is ProductLoaded) {
        final currentState = state as ProductLoaded;
        emit(ProductLoaded(-1, false, false, currentState.lotNumber, currentState.pendingArticles));
      }
    });

    on<MarkAsPending>((event, emit) {
      if (state is ProductLoaded) {
        final currentState = state as ProductLoaded;
        Set<int> newPendingArticles = Set<int>.from(currentState.pendingArticles);
        if (newPendingArticles.contains(event.articleIndex)) {
          newPendingArticles.remove(event.articleIndex);
        } else {
          newPendingArticles.add(event.articleIndex);
        }
        emit(ProductLoaded(currentState.selectedArticle, currentState.isSpecial, currentState.isMandatoryLot, currentState.lotNumber, newPendingArticles));
      }
    });

    on<UpdateLotNumber>((event, emit) {
      if (state is ProductLoaded) {
        final currentState = state as ProductLoaded;
        emit(ProductLoaded(currentState.selectedArticle, currentState.isSpecial, currentState.isMandatoryLot, event.lotNumber, currentState.pendingArticles));
      }
    });
  }
}


