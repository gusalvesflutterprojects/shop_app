import 'dart:math';

import 'package:flutter/material.dart';
import 'package:random_color/random_color.dart';

import './product.dart';

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

  List<Product> _deletedItems = [];

  bool _showFavoritesOnly = false;

  bool get shouldShowFavoritesOnly => _showFavoritesOnly;

  void showFavoritesOnly() {
    _showFavoritesOnly = true;
    notifyListeners();
  }

  void showAll() {
    _showFavoritesOnly = false;
    notifyListeners();
  }

  List<Product> get items {
    return [..._items];
  }

  List<Product> get deletedItems {
    return [..._deletedItems];
  }

  List<Product> get favoriteItems {
    return _items.where((product) => product.isFavorite == true).toList();
  }

  Product getProductInfo(String productId) {
    return _items.firstWhere((prd) => productId == prd.id);
  }

  void addProduct(String title, String description, double price,
      List<Color> gradientColors) {
    _items.add(
      Product(
        id: Random().nextInt(1000000000).toString(),
        title: title,
        description: description,
        price: price,
        gradient: LinearGradient(
          colors: gradientColors,
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,
        ),
      ),
    );
    notifyListeners();
  }

  void updateProduct(
      String productId, String title, String desc, double price) {
    final Product selectedProduct =
        _items.firstWhere((prod) => prod.id == productId);

    selectedProduct.title = title;
    selectedProduct.description = desc;
    selectedProduct.price = price;
    notifyListeners();
  }

  void deleteProduct(String productId) {
    final int prodIdx = _items.indexWhere((prod) => prod.id == productId);

    _deletedItems.add(_items[prodIdx]);
    _items.removeAt(prodIdx);
    notifyListeners();
  }

  void restoreProduct(String productId) {
    final int prodIdx =
        _deletedItems.indexWhere((prod) => prod.id == productId);

    _items.add(_deletedItems[prodIdx]);
    _deletedItems.removeAt(prodIdx);
    notifyListeners();
  }

  void emptyTrash() {
    _deletedItems.clear();
    notifyListeners();
  }
}
