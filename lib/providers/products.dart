import 'package:flutter/material.dart';
import 'package:random_color/random_color.dart';

import '../models/product.dart';

class Products with ChangeNotifier {
  List<Product> _items = [
    Product(
      id: 'p1',
      title: 'Red Shirt',
      description: 'A red shirt - it is pretty red!',
      price: 29.99,
      gradient: LinearGradient(
        begin: Alignment.bottomLeft,
        end: Alignment.topRight,
        colors: RandomColor()
            .randomColors(count: 2, colorBrightness: ColorBrightness.veryLight),
      ),
    ),
    Product(
      id: 'p2',
      title: 'Trousers',
      description: 'A nice pair of trousers.',
      price: 59.99,
      gradient: LinearGradient(
        begin: Alignment.bottomLeft,
        end: Alignment.topRight,
        colors: RandomColor()
            .randomColors(count: 2, colorBrightness: ColorBrightness.veryLight),
      ),
    ),
    Product(
      id: 'p3',
      title: 'Yellow Scarf',
      description: 'Warm and cozy - exactly what you need for the winter.',
      price: 19.99,
      gradient: LinearGradient(
        begin: Alignment.bottomLeft,
        end: Alignment.topRight,
        colors: RandomColor()
            .randomColors(count: 2, colorBrightness: ColorBrightness.veryLight),
      ),
    ),
    Product(
      id: 'p4',
      title: 'A Pan',
      description: 'Prepare any meal you want.',
      price: 49.99,
      gradient: LinearGradient(
        begin: Alignment.bottomLeft,
        end: Alignment.topRight,
        colors: RandomColor()
            .randomColors(count: 2, colorBrightness: ColorBrightness.veryLight),
      ),
    ),
  ];

  List<Product> get items {
    return [..._items];
  }

  List<Product> get favoriteItems {
    return items.where((product) => product.isFavorite == true);
  }

  void toggleFavorite(String productId) {
    final idx = items.indexWhere((prod) => prod.id == productId);

    if (idx >= 0) items[idx].isFavorite = !items[idx].isFavorite;
    notifyListeners();
  }

  void addProduct(Product product) {
    _items.add(product);
    notifyListeners();
  }
}
