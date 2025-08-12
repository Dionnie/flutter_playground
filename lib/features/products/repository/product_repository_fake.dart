// fake_product_repository.dart
import 'dart:async';
import '../model/product.dart';
import 'product_repository.dart';

class FakeProductRepository implements ProductRepository {
  final List<Product> _products = [
    Product(id: '1', name: 'Laptop', price: 50000),
    Product(id: '2', name: 'Smartphone', price: 25000),
    Product(id: '3', name: 'Headphones', price: 3000),
  ];

  @override
  Future<List<Product>> getProducts() async {
    await Future.delayed(const Duration(milliseconds: 300)); // simulate latency
    return List<Product>.from(_products);
  }

  @override
  Future<Product?> getProductById(String id) async {
    try {
      return _products.firstWhere((p) => p.id == id);
    } catch (_) {
      return null;
    }
  }

  @override
  Future<Product> addProduct(Product product) async {
    _products.add(product);
    return product;
  }

  @override
  Future<Product> updateProduct(Product product) async {
    final index = _products.indexWhere((p) => p.id == product.id);
    if (index != -1) {
      _products[index] = product;
    }
    return product;
  }

  @override
  Future<void> deleteProduct(String id) async {
    _products.removeWhere((p) => p.id == id);
  }
}
