import 'package:flutter/material.dart';
import 'package:random_color/random_color.dart';
import 'package:shop_app/models/product_with_quantity.dart';

import '../providers/product.dart';

class ShoppingCart with ChangeNotifier {
  List<ProductWithQuantity> _cartItems = [
    ProductWithQuantity(
      product: Product(
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
      qty: 1,
    )
  ];

  List<Product> get cartItemsProducts =>
      [..._cartItems.map((item) => item.product)];

  List<dynamic> get cartItemsWithQuantity => [..._cartItems];

  void addToCart(BuildContext ctx, Product product, int quantity) {
    final idx = cartItemsProducts.indexWhere((prd) => prd.id == product.id);

    if (idx == -1)
      _cartItems.add(
        ProductWithQuantity(
          product: product,
          qty: quantity,
        ),
      );

    Navigator.of(ctx).pushNamed('/shopping-cart');
    notifyListeners();
  }

  void incrementCartProduct(String productId) {
    final idx = cartItemsProducts.indexWhere((prd) => prd.id == productId);
    _cartItems[idx].qty++;
    notifyListeners();
  }

  void decrementCartProduct(String productId) {
    final idx = cartItemsProducts.indexWhere((prd) => prd.id == productId);
    _cartItems[idx].qty == 1 ? _cartItems.removeAt(idx) : _cartItems[idx].qty--;
    notifyListeners();
  }

  void removeFromCart(String productId) {
    final idx = cartItemsProducts.indexWhere((prd) => prd.id == productId);

    _cartItems.removeAt(idx);
    notifyListeners();
  }

  void emptyCart() {
    _cartItems.clear();
    notifyListeners();
  }

  double getShoppingCartTotal() => cartItemsWithQuantity.fold(
        0,
        (val, item) => val + (item.product.price * item.qty),
      );
}
