// product_view_model.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/product.dart';
import '../repository/product_repository.dart';

class ProductState {
  final AsyncValue<List<Product>> products;
  final AsyncValue<Product?> selectedProduct;

  const ProductState({
    this.products = const AsyncValue.loading(),
    this.selectedProduct = const AsyncValue.data(null),
  });

  ProductState copyWith({
    AsyncValue<List<Product>>? products,
    AsyncValue<Product?>? selectedProduct,
  }) {
    return ProductState(
      products: products ?? this.products,
      selectedProduct: selectedProduct ?? this.selectedProduct,
    );
  }
}

class ProductViewModel extends StateNotifier<ProductState> {
  final ProductRepository _repository;

  ProductViewModel(this._repository) : super(const ProductState()) {
    fetchProducts();
  }

  Future<void> fetchProducts() async {
    state = state.copyWith(products: const AsyncValue.loading());
    try {
      final products = await _repository.getProducts();
      state = state.copyWith(products: AsyncValue.data(products));
    } catch (e, st) {
      state = state.copyWith(products: AsyncValue.error(e, st));
    }
  }

  Future<void> fetchProductById(String id) async {
    state = state.copyWith(selectedProduct: const AsyncValue.loading());
    try {
      final product = await _repository.getProductById(id);
      state = state.copyWith(selectedProduct: AsyncValue.data(product));
    } catch (e, st) {
      state = state.copyWith(selectedProduct: AsyncValue.error(e, st));
    }
  }

  Future<void> addProduct(Product product) async {
    try {
      await _repository.addProduct(product);
      await fetchProducts(); // refresh list
    } catch (e, st) {
      // handle error
    }
  }

  Future<void> updateProduct(Product product) async {
    try {
      await _repository.updateProduct(product);
      await fetchProducts(); // refresh list
    } catch (e, st) {
      // handle error
    }
  }

  Future<void> deleteProduct(String id) async {
    try {
      await _repository.deleteProduct(id);
      await fetchProducts(); // refresh list
    } catch (e, st) {
      // handle error
    }
  }
}
