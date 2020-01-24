import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:random_color/random_color.dart';
import 'package:http/http.dart' as http;

import './product.dart';

class Products with ChangeNotifier {
  List<Product> _items = [];

  // Product(
  //   id: 'p1',
  //   title: 'Red Shirt',
  //   description: 'A red shirt - it is pretty red!',
  //   price: 29.99,
  //   gradient: LinearGradient(
  //     begin: Alignment.bottomLeft,
  //     end: Alignment.topRight,
  //     colors: RandomColor()
  //         .randomColors(count: 2, colorBrightness: ColorBrightness.veryLight),
  //   ),
  // ),
  // Product(
  //   id: 'p2',
  //   title: 'Trousers',
  //   description: 'A nice pair of trousers.',
  //   price: 59.99,
  //   gradient: LinearGradient(
  //     begin: Alignment.bottomLeft,
  //     end: Alignment.topRight,
  //     colors: RandomColor()
  //         .randomColors(count: 2, colorBrightness: ColorBrightness.veryLight),
  //   ),
  // ),
  // Product(
  //   id: 'p3',
  //   title: 'Yellow Scarf',
  //   description: 'Warm and cozy - exactly what you need for the winter.',
  //   price: 19.99,
  //   gradient: LinearGradient(
  //     begin: Alignment.bottomLeft,
  //     end: Alignment.topRight,
  //     colors: RandomColor()
  //         .randomColors(count: 2, colorBrightness: ColorBrightness.veryLight),
  //   ),
  // ),
  // Product(
  //   id: 'p4',
  //   title: 'A Pan',
  //   description: 'Prepare any meal you want.',
  //   price: 49.99,
  //   gradient: LinearGradient(
  //     begin: Alignment.bottomLeft,
  //     end: Alignment.topRight,
  //     colors: RandomColor()
  //         .randomColors(count: 2, colorBrightness: ColorBrightness.veryLight),
  //   ),
  // ),

  List<Product> _deletedItems = [];

  bool _showFavoritesOnly = false;

  Future<void> fetchProducts() async {
    List<Product> newProductsList = [];

    await http
        .get('https://flutter-update-9ec59.firebaseio.com/products.json')
        .then((res) => json.decode(res.body))
        .then(
          (res) => res.forEach(
            (id, item) => newProductsList.add(
              Product(
                id: id,
                title: item['title'],
                description: item['description'],
                price: item['price'],
                gradient: LinearGradient(
                  begin: Alignment.bottomLeft,
                  end: Alignment.topRight,
                  colors: RandomColor().randomColors(
                      count: 2, colorBrightness: ColorBrightness.veryLight),
                ),
              ),
            ),
          ),
        );

    _items = newProductsList;
  }

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

  Future<void> addProduct(
    String title,
    String description,
    double price,
    LinearGradient gradient,
  ) async {
    const url = 'https://flutter-update-9ec59.firebaseio.com/products.json';
    await http
        .post(
      url,
      body: json.encode(
        {
          'title': title,
          'description': description,
          'price': price,
        },
      ),
    )
        .then(
      (res) {
        if (res.statusCode == 200) {
          _items.add(
            Product(
              id: json.decode(res.body)['name'],
              title: title,
              description: description,
              price: price,
              gradient: gradient,
            ),
          );
          notifyListeners();
        }
      },
    );
  }

  Future<void> updateProduct(
      String productId, String title, String desc, double price) async {
    http
        .patch(
      'https://flutter-update-9ec59.firebaseio.com/products/$productId.json',
      body: json.encode(
        {
          'title': title,
          'description': desc,
          'price': price,
        },
      ),
    )
        .then(
      (res) {
        if (res.statusCode == 200) {
          final Product selectedProduct =
              _items.firstWhere((prod) => prod.id == productId);

          selectedProduct.title = title;
          selectedProduct.description = desc;
          selectedProduct.price = price;
          notifyListeners();
        }
      },
    );
  }

  Future<void> deleteProduct(String productId) async {
    final int prodIdx = _items.indexWhere((prod) => prod.id == productId);
    final urlPost =
        'https://flutter-update-9ec59.firebaseio.com/deletedProducts/$productId.json';
    final urlDelete =
        'https://flutter-update-9ec59.firebaseio.com/products/$productId.json';

    http
        .post(
      urlPost,
      body: json.encode(
        {
          'title': _items[prodIdx].title,
          'description': _items[prodIdx].description,
          'price': _items[prodIdx].price,
        },
      ),
    )
        .then((res) {
      if (res.statusCode == 200) {
        http
            .delete(
          urlDelete,
        )
            .then(
          (res) {
            if (res.statusCode == 200) {
              _deletedItems.add(_items[prodIdx]);
              _items.removeAt(prodIdx);
              notifyListeners();
            }
          },
        );
      }
    });
  }

  void restoreProduct(String productId) {
    final int prodIdx =
        _deletedItems.indexWhere((prod) => prod.id == productId);
    final urlPost =
        'https://flutter-update-9ec59.firebaseio.com/products/$productId.json';
    final urlDelete =
        'https://flutter-update-9ec59.firebaseio.com/deletedProducts/$productId.json';

    http
        .post(
      urlPost,
      body: json.encode(
        {
          'title': _deletedItems[prodIdx].title,
          'description': _deletedItems[prodIdx].description,
          'price': _deletedItems[prodIdx].price,
        },
      ),
    )
        .then((res) {
      if (res.statusCode == 200)
        http.delete(urlDelete).then((res) {
          if (res.statusCode == 200) {
            _items.add(_deletedItems[prodIdx]);
            _deletedItems.removeAt(prodIdx);
            notifyListeners();
          }
        });
    });
  }

  void emptyTrash() {
    _deletedItems.clear();
    notifyListeners();
  }
}
