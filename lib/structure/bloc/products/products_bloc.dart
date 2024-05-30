import 'package:bloc/bloc.dart';
import '../../../data/repositories/product_repository.dart';
import 'products_event.dart';
import 'products_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductRepository repository;

  ProductBloc({required this.repository}) : super(ProductLoaded(-1, false, false, [], 0, false)) {
    on<SelectArticle>((event, emit) {
      if (state is ProductLoaded) {
        final currentState = state as ProductLoaded;
        emit(ProductLoaded(
          event.articleIndex,
          event.isSpecial,
          event.isMandatoryLot,
          currentState.acceptedArticles, // Preservamos el estado actual de acceptedArticles
          currentState.lotNumber,
          currentState.showMultiPesIndicators,
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
          currentState.acceptedArticles, // Preservamos el estado actual de acceptedArticles
          currentState.lotNumber,
          currentState.showMultiPesIndicators,
          currentState.pendingArticles,
        ));
      }
    });

    on<AcceptArticle>((event, emit) {
      if (state is ProductLoaded) {
        final currentState = state as ProductLoaded;
        List<int> newAcceptedArticles = List<int>.from(currentState.acceptedArticles);
        if (newAcceptedArticles.contains(event.articleIndex)) {
          newAcceptedArticles.remove(event.articleIndex); // Eliminar si ya está aceptado
        } else {
          newAcceptedArticles.add(event.articleIndex); // Añadir si no está aceptado
        }
        emit(ProductLoaded(
          currentState.selectedArticle,
          currentState.isSpecial,
          currentState.isMandatoryLot,
          newAcceptedArticles, // Actualizamos acceptedArticles
          currentState.lotNumber,
          currentState.showMultiPesIndicators,
          currentState.pendingArticles,
        ));
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
        emit(ProductLoaded(
          currentState.selectedArticle,
          currentState.isSpecial,
          currentState.isMandatoryLot,
          currentState.acceptedArticles, // Preservamos el estado actual de acceptedArticles
          currentState.lotNumber,
          currentState.showMultiPesIndicators,
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
          currentState.acceptedArticles, // Preservamos el estado actual de acceptedArticles
          event.lotNumber,
          currentState.showMultiPesIndicators,
          currentState.pendingArticles,
        ));
      }
    });

    on<ToggleMultiPesIndicators>((event, emit) {
      if (state is ProductLoaded) {
        final currentState = state as ProductLoaded;
        emit(ProductLoaded(
          currentState.selectedArticle,
          currentState.isSpecial,
          currentState.isMandatoryLot,
          currentState.acceptedArticles, // Preservamos el estado actual de acceptedArticles
          currentState.lotNumber,
          !currentState.showMultiPesIndicators, // Toggle the state
          currentState.pendingArticles,
        ));
      }
    });
  }
}

