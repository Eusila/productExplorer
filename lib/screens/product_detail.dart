import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../services/product_service.dart';

class ProductDetail extends StatefulWidget {
  const ProductDetail({super.key});

  @override
  _ProductDetailState createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  final ProductService productService = ProductService();
  late Future<Map<String, dynamic>> _productDetail;

  @override
  void initState() {
    super.initState();
    final int productId = Get.arguments as int; // Retrieve product ID
    _productDetail = productService.fetchProductById(productId); // Use method from service
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Details'),
      ),
      body: FutureBuilder(
        future: _productDetail,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final product = snapshot.data as Map<String, dynamic>;

            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Image.network(
                      product['image'],
                      width: 200,
                      height: 200,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    product['title'],
                    style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'ID: ${product['id']}',
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '\$${product['price']}',
                    style: const TextStyle(fontSize: 20, color: Colors.green),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Description:',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(product['description']),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}

