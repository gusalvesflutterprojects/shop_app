import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../providers/product.dart';

class ProductWithQuantity {
  final Product product;
  int qty;

  ProductWithQuantity({
    @required this.product,
    @required this.qty,
  });
}
