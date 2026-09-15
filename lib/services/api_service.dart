import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/product.dart';

class ApiService {
  static const String _baseUrl = 'https://dummyjson.com';

  Future<List<Product>> getProducts({int limit = 20, int skip = 0}) async {
    final url = Uri.parse('$_baseUrl/products?limit=$limit&skip=$skip');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final Map<String, dynamic> body = json.decode(response.body);
      final List<dynamic> productsJson = body['products'];

      return productsJson.map((json) => Product.fromJson(json)).toList();
    } else {
      throw Exception('Failed to fetch products (Code: ${response.statusCode})');
    }
  }

  Future<Product> getProductById(int id) async {
    final url = Uri.parse('$_baseUrl/products/$id');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final Map<String, dynamic> body = json.decode(response.body);

      return Product.fromJson(body);
    } else {
      throw Exception('Failed to fetch product detail (Code: ${response.statusCode})');
    }
  }

  Future<List<Product>> searchProducts(String query) async {
    final url = Uri.parse('$_baseUrl/products/search?q=$query');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final Map<String, dynamic> body = json.decode(response.body);
      final List<dynamic> productsJson = body['products'];

      return productsJson.map((json) => Product.fromJson(json)).toList();
    } else {
      throw Exception ('Failed to search products (Code: ${response.statusCode})');
    }
  }
}