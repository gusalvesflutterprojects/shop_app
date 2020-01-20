import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'products.dart';

class Product with ChangeNotifier {
  final String id;
  String title;
  String description;
  double price;
  final LinearGradient gradient;
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
    notifyListeners();
    Provider.of<Products>(ctx).notifyListeners();
  }
}
