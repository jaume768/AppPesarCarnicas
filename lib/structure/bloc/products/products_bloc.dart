import 'package:bloc/bloc.dart';
import '../../../data/repositories/product_repository.dart';
import 'products_event.dart';
import 'products_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductRepository repository;

  ProductBloc({required this.repository}) : super(ProductLoaded(-1)) {
    on<SelectArticle>((event, emit) {
      emit(ProductLoaded(event.articleIndex));
    });

    on<DeselectArticle>((event, emit) {
      emit(ProductLoaded(-1));
    });
  }
}