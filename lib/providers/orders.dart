import 'package:flutter/material.dart';
import 'dart:math';
import 'package:random_color/random_color.dart';
import 'package:uuid/uuid.dart';

import '../models/order.dart';
import '../providers/product.dart';
import '../models/product_with_quantity.dart';

class Orders with ChangeNotifier {
  var uuid = Uuid();

  List<Order> _orders = [
    Order(
      id: Random().nextInt(1000000000),
      products: [
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
        ),
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
          qty: 2,
        ),
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
        ),
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
        ),
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
        ),
      ],
      totalPrice: 80.00,
    )
  ];

  List<Order> get orders => [..._orders];

  void addOrder(
      BuildContext ctx, List<ProductWithQuantity> productsWithQuantity) {
    _orders.add(
      Order(
        id: Random().nextInt(1000000000),
        products: productsWithQuantity,
        totalPrice: productsWithQuantity.fold(
            0, (val, item) => val + (item.product.price * item.qty)),
      ),
    );
    Navigator.of(ctx).pushNamed('/order-completed');
  }
}
