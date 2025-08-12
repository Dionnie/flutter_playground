import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/product.dart';
import 'product_repository_fake.dart';

abstract class ProductRepository {
  /// Fetch all products
  Future<List<Product>> getProducts();

  /// Fetch a single product by ID
  Future<Product?> getProductById(String id);

  /// Add a product
  Future<Product> addProduct(Product product);

  /// Update a product
  Future<Product> updateProduct(Product product);

  /// Delete a product
  Future<void> deleteProduct(String id);
}

final productRepositoryProvider = Provider<ProductRepository>((ref) {
  return FakeProductRepository();
});
