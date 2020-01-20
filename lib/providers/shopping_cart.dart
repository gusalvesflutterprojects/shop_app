import 'package:flutter/material.dart';
import 'package:shop_app/models/product_with_quantity.dart';

import '../providers/product.dart';

class ShoppingCart with ChangeNotifier {
  List<ProductWithQuantity> _items = [];

  List<Product> get cartItemsProducts =>
      [..._items.map((item) => item.product)];

  List<dynamic> get cartItemsWithQuantity => [..._items];

  double get shoppingCartTotal => cartItemsWithQuantity.fold(
        0,
        (val, item) => val + (item.product.price * item.qty),
      );

  int get cartItemsCount => _items.length;

  void addToCart(BuildContext ctx, Product product, int quantity) {
    final idx = cartItemsProducts.indexWhere((prd) => prd.id == product.id);

    if (idx == -1)
      _items.add(
        ProductWithQuantity(
          product: product,
          qty: quantity,
        ),
      );

    // Scaffold.of(ctx).hideCurrentSnackBar();
    // Scaffold.of(ctx).showSnackBar(
    //   SnackBar(
    //     action: SnackBarAction(
    //       label: 'UNDO',
    //       onPressed: () => decrementCartProduct(product.id),
    //     ),
    //     backgroundColor: Colors.green,
    //     elevation: 40,
    //     duration: Duration(seconds: 2),
    //     content: Container(
    //       height: MediaQuery.of(ctx).size.height * 0.05,
    //       child: Row(
    //         mainAxisSize: MainAxisSize.min,
    //         children: <Widget>[
    //           Icon(Icons.check, size: 36),
    //           Text(' Item added to cart!', style: TextStyle(fontSize: 20)),
    //         ],
    //       ),
    //     ),
    //   ),
    // );
    Navigator.of(ctx).popUntil(ModalRoute.withName('/'));
    Navigator.of(ctx).pushNamed('/shopping-cart');
    notifyListeners();
  }

  void incrementCartProduct(String productId) {
    final idx = cartItemsProducts.indexWhere((prd) => prd.id == productId);
    _items[idx].qty++;
    notifyListeners();
  }

  void decrementCartProduct(String productId) {
    final idx = cartItemsProducts.indexWhere((prd) => prd.id == productId);
    _items[idx].qty == 1 ? _items.removeAt(idx) : _items[idx].qty--;
    notifyListeners();
  }

  void removeFromCart(String productId) {
    final idx = cartItemsProducts.indexWhere((prd) => prd.id == productId);

    _items.removeAt(idx);
    notifyListeners();
  }

  void emptyCart() {
    _items.clear();
    notifyListeners();
  }
}
