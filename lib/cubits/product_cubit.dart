import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/product.dart';
import '../services/api_service.dart';

abstract class ProductState {}

class ProductInitialState extends ProductState {}

class ProductLoadingState extends ProductState {}

class ProductLoadedState extends ProductState {
  final List<Product> products;
  final bool hasReachedMax;

  ProductLoadedState({
    required this.products,
    this.hasReachedMax = false,
  });
}

class ProductEmptyState extends ProductState {}

class ProductErrorState extends ProductState {
    final String message;
    
    ProductErrorState(this.message);
}

class ProductCubit extends Cubit<ProductState> {
  final ApiService apiService;

  ProductCubit(this.apiService) : super(ProductInitialState());

  List<Product> _allProducts = [];
  int _currentSkip = 0;
  bool _isFetchingMore = false;

  Future<void> loadInitialProducts() async {
    emit(ProductLoadingState());
    _currentSkip = 0;
    _allProducts.clear();

    try {
      final products = await apiService.getProducts(
        limit: 20,
        skip: 0
      );

      _allProducts = products;

      if (products.isEmpty) {
        emit(ProductEmptyState());
      } else {
        emit(ProductLoadedState(
          products: _allProducts,
          hasReachedMax: products.length < 20,
        ));
      }
    } catch (e) {
      emit(ProductErrorState(e.toString()));
    }
  }

  Future<void> fetchMoreProducts() async {
    if (_isFetchingMore) return;
    _isFetchingMore = true;
    _currentSkip += 20;

    try {
      final newProducts = await apiService.getProducts(
        limit: 20,
        skip: _currentSkip,
      );

      if (newProducts.isEmpty) {
        emit(ProductLoadedState(
          products: _allProducts,
          hasReachedMax: true,
        ));
      } else {
        _allProducts.addAll(newProducts);
        emit(ProductLoadedState(
          products: _allProducts,
          hasReachedMax: newProducts.length < 20,
        ));
      }
    } catch (_) {

    } finally {
      _isFetchingMore = false;
    }
  }

  Future<void> searchProducts(String query) async {
    if (query.trim().isEmpty) {
      await loadInitialProducts();
      return;
    }

    emit(ProductLoadingState());

    try {
      final results = await apiService.searchProducts(query);

      if (results.isEmpty) {
        emit(ProductEmptyState());
      } else {
        emit (ProductLoadedState(
          products: results,
          hasReachedMax: true,
        ));
      }
    } catch (e) {
      emit(ProductErrorState(e.toString()));
    }
  }
}