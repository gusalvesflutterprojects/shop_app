import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../models/product_with_quantity.dart';

class Order {
  final int id;
  final List<ProductWithQuantity> products;
  final double totalPrice;
  final DateTime date = DateTime.now();

  Order({
    @required this.id,
    @required this.products,
    @required this.totalPrice,
  });
}
