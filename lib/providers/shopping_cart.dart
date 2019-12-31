import 'package:flutter/material.dart';
import 'package:random_color/random_color.dart';

import '../models/product.dart';

class ShoppingCart with ChangeNotifier {
  List<Map<String, dynamic>> _cartItems = [
    {
      'product': Product(
        id: 'p4',
        title: 'A Pan',
        description: 'Prepare any meal you want.',
        price: 49.99,
        gradient: LinearGradient(
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,
          colors: RandomColor().randomColors(
              count: 2, colorBrightness: ColorBrightness.veryLight),
        ),
      ),
      'quantity': 1,
    },
  ];

  List<dynamic> get cartItems =>
      _cartItems.map((item) => item['product']).toList();

  List<dynamic> get cartItemsWithInfo => [..._cartItems];

  void addToCart(BuildContext ctx, Product product) {
    final idx = cartItems.indexWhere((prd) => prd.id == product.id);

    if (idx == -1) {
      _cartItems.add({'product': product, 'quantity': 1});
      Navigator.of(ctx).pushNamed('/shopping-cart');
      notifyListeners();
    }
  }

  void incrementCartProduct(String productId) {
    final idx = cartItems.indexWhere((prd) => prd.id == productId);

    _cartItems[idx]['quantity']++;
    notifyListeners();
  }

  void decrementCartProduct(String productId) {
    final idx = cartItems.indexWhere((prd) => prd.id == productId);

    if (_cartItems[idx]['quantity'] == 1)
      _cartItems.removeAt(idx);
    else
      _cartItems[idx]['quantity']--;
    notifyListeners();
  }

  void removeFromCart(String productId) {
    final idx = cartItems.indexWhere((prd) => prd.id == productId);

    _cartItems.removeAt(idx);
    notifyListeners();
  }
}
