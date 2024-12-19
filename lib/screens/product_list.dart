import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../services/product_service.dart';

class ProductList extends StatelessWidget {
  const ProductList ({super.key});

  @override
  Widget build(BuildContext context) {
    final ProductService productService = ProductService();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Product List'),
      ),
      body: FutureBuilder(
        future: productService.fetchProducts(), // Fetch products from API
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || (snapshot.data as List).isEmpty) {
            return const Center(child: Text('No products available.'));
          } else {
            final products = snapshot.data as List;

            return ListView.builder(
              itemCount: products.length,
              itemBuilder: (context, index) {
                final product = products[index];

                return Card(
                  margin: const EdgeInsets.all(8.0),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.blue.shade100,
                      child: Text('${product['id']}'),
                    ),
                    title: Text(product['title']),
                    subtitle: Text('ID: ${product['id']}'),
                    onTap: () {

                      Get.toNamed('/productDetail', arguments: product['id']);
                    },
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
