import 'package:bloc/bloc.dart';
import '../../../data/repositories/product_repository.dart';
import 'products_event.dart';
import 'products_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductRepository repository;

  ProductBloc({required this.repository}) : super(ProductLoaded(-1)) {
    on<SelectArticle>((event, emit) {
      if (state is ProductLoaded) {
        final currentState = state as ProductLoaded;
        emit(ProductLoaded(event.articleIndex, currentState.pendingArticles));
      }
    });

    on<DeselectArticle>((event, emit) {
      if (state is ProductLoaded) {
        final currentState = state as ProductLoaded;
        emit(ProductLoaded(-1, currentState.pendingArticles));
      }
    });

    on<MarkAsPending>((event, emit) {
      if (state is ProductLoaded) {
        final currentState = state as ProductLoaded;
        // Agregar el índice del artículo a la lista de pendientes y emitir el nuevo estado
        final newPendingArticles = Set<int>.from(currentState.pendingArticles)
          ..add(event.articleIndex);
        emit(ProductLoaded(currentState.selectedArticle, newPendingArticles));
      }
    });
  }
}
