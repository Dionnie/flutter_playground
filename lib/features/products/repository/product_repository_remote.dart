// supabase_product_repository.dart
import 'package:supabase_flutter/supabase_flutter.dart';
import '../model/product.dart';
import 'product_repository.dart';

class SupabaseProductRepository implements ProductRepository {
  final SupabaseClient _client;

  SupabaseProductRepository(this._client);

  @override
  Future<List<Product>> getProducts() async {
    final response = await _client.from('products').select();
    return (response as List<dynamic>)
        .map((data) => Product.fromMap(data))
        .toList();
  }

  @override
  Future<Product?> getProductById(String id) async {
    final response = await _client
        .from('products')
        .select()
        .eq('id', id)
        .maybeSingle();

    if (response == null) return null;
    return Product.fromMap(response);
  }

  @override
  Future<Product> addProduct(Product product) async {
    final response = await _client
        .from('products')
        .insert(product.toMap())
        .select()
        .single();
    return Product.fromMap(response);
  }

  @override
  Future<Product> updateProduct(Product product) async {
    final response = await _client
        .from('products')
        .update(product.toMap())
        .eq('id', product.id)
        .select()
        .single();
    return Product.fromMap(response);
  }

  @override
  Future<void> deleteProduct(String id) async {
    await _client.from('products').delete().eq('id', id);
  }
}
