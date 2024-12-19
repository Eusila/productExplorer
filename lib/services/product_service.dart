import 'package:dio/dio.dart';

class ProductService {
  final Dio _dio = Dio();


  Future<List<dynamic>> fetchProducts() async {
    const String apiUrl = 'https://fakestoreapi.com/products';
    try {
      final response = await _dio.get(apiUrl);
      if (response.statusCode == 200) {
        return response.data;
      } else {
        throw Exception('Failed to load products');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }


  Future<Map<String, dynamic>> fetchProductById(int id) async {
    const String apiUrl = 'https://fakestoreapi.com/products';
    try {
      final response = await _dio.get('$apiUrl/$id');
      if (response.statusCode == 200) {
        return response.data;
      } else {
        throw Exception('Failed to load product');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}

