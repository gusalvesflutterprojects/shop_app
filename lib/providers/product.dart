import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

import 'products.dart';

class Product with ChangeNotifier {
  final String id;
  String title;
  String description;
  double price;
  final gradient;
  bool isFavorite;

  Product({
    @required this.id,
    @required this.title,
    @required this.description,
    @required this.price,
    @required this.gradient,
    this.isFavorite = false,
  });

  void toggleFavorite(BuildContext ctx) {
    isFavorite = !isFavorite;
    print('isFavorite $isFavorite');
    http.patch(
      'https://flutter-update-9ec59.firebaseio.com/products/$id.json',
      body: json.encode(
        {'isFavorite': !isFavorite},
      ),
    );
    notifyListeners();
    Provider.of<Products>(ctx).notifyListeners();
  }
}
