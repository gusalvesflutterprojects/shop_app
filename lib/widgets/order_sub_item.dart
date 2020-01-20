import 'package:flutter/material.dart';

import '../screens/product_details_screen.dart';
import '../providers/product.dart';

class OrderSubItem extends StatelessWidget {
  final Product product;
  final int qty;

  OrderSubItem(this.product, this.qty);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 72,
      color: Colors.grey[200],
      child: Column(
        children: <Widget>[
          GestureDetector(
            onTap: () => Navigator.of(context).pushNamed(
                ProductDetailsScreen.routeName,
                arguments: {'product': product}),
            child: ListTile(
              contentPadding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * 0.065),
              leading: Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(gradient: product.gradient),
              ),
              title: Text(product.title),
              subtitle: Text(product.price.toString()),
              trailing: Text('${qty}x'),
            ),
          ),
          Divider(
            height: 0,
          )
        ],
      ),
    );
  }
}
