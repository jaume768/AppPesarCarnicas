import 'package:bloc/bloc.dart';
import '../../../data/repositories/product_repository.dart';
import 'products_event.dart';
import 'products_state.dart';

// BLoC
class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductRepository repository;

  ProductBloc({required this.repository}) : super(ProductLoaded(Set<int>())) {
    on<SelectArticle>((event, emit) {
      final newState = Set<int>.from(state.selectedArticles);
      newState.add(event.articleIndex);
      emit(ProductLoaded(newState));
    });

    on<DeselectArticle>((event, emit) {
      final newState = Set<int>.from(state.selectedArticles);
      newState.remove(event.articleIndex);
      emit(ProductLoaded(newState));
    });

    // Aquí podrías agregar eventos que utilicen el repositorio para cargar datos, etc.
  }
}
