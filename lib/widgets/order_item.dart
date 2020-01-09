import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/product_with_quantity.dart';

class OrderItem extends StatelessWidget {
  final int id;
  final List<ProductWithQuantity> orderProducts;
  final DateTime orderDate;
  final double orderTotalPrice;

  OrderItem({
    this.id,
    this.orderProducts,
    this.orderDate,
    this.orderTotalPrice,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        color: Colors.black26,
        width: MediaQuery.of(context).size.width * 0.15,
        child: GridView.builder(
          itemCount: orderProducts.length <= 4 ? orderProducts.length : 4,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 1.1,
            crossAxisSpacing: 0,
            mainAxisSpacing: 0,
          ),
          itemBuilder: (ctx, i) {
            return Container(
              decoration: BoxDecoration(
                gradient: orderProducts[i].product.gradient,
              ),
            );
          },
        ),
      ),
      title: Text(
        '$id',
        style: TextStyle(fontSize: 24),
      ),
      subtitle: Text('${DateFormat('MMM dd yyyy').format(orderDate)}'),
      trailing: Column(
        children: <Widget>[
          Text(
            '${orderProducts.fold(0, (val, item) => val + item.qty)} items',
            style: TextStyle(fontSize: 16),
          ),
          Text(
            '\$${orderTotalPrice.toStringAsFixed(2)}',
            style: TextStyle(fontSize: 24),
          ),
        ],
      ),
    );
  }
}
