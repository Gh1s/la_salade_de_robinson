//import 'package:flutter/foundation.dart';

import 'products.dart';

class ProductsRepository {
  static List<Product> loadProducts(Category category) {
    const allProducts = <Product> [
      Product(
          category: Category.all,
          id: 0,
          isFeatured: true,
          name: 'Batavia',
          price: 120,
      ),
    ];
    if (category == Category.all) {
      return allProducts;

    } else {
      return allProducts.where((Product p) {
        return p.category == category;
      }).toList();
    }
  }
}