import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/shopping_cart.dart';

class ShoppingCartItem extends StatelessWidget {
  final Map cartItem;

  ShoppingCartItem(this.cartItem);

  @override
  Widget build(BuildContext context) {
    final ShoppingCart _cartData = Provider.of<ShoppingCart>(context);

    return Dismissible(
      onDismissed: (direction) {
        if (direction == DismissDirection.endToStart)
          return _cartData.removeFromCart(cartItem['product'].id);
      },
      key: UniqueKey(),
      background: Container(
        color: Colors.redAccent,
        child: Padding(
          padding: const EdgeInsets.only(right: 24),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Icon(
                Icons.delete,
                size: 32,
              ),
              Text(
                'Delete item',
                style: TextStyle(fontSize: 18),
              ),
            ],
          ),
        ),
      ),
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width * 0.2,
                  height: MediaQuery.of(context).size.width * 0.2,
                  decoration: BoxDecoration(
                    gradient: cartItem['product'].gradient,
                  ),
                ),
                Expanded(
                  child: ListTile(
                    title: Text(
                      cartItem['product'].title,
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(cartItem['product'].description),
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.width * 0.2,
                  child: Row(
                    children: <Widget>[
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          GestureDetector(
                            onTap: () => _cartData
                                .incrementCartProduct(cartItem['product'].id),
                            child: CircleAvatar(
                              radius: 12,
                              child: Icon(
                                Icons.add,
                              ),
                            ),
                          ),
                          Text('${cartItem['quantity']}',
                              style: TextStyle(fontSize: 18)),
                          GestureDetector(
                            onTap: () => _cartData.decrementCartProduct(
                                cartItem['product'].id),
                            child: CircleAvatar(
                              radius: 12,
                              child: Icon(
                                Icons.remove,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 24,
                      ),
                      Text(
                        '\$${cartItem['product'].price}',
                        style: TextStyle(fontSize: 24),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Divider(
            indent: 24,
            endIndent: 24,
          ),
        ],
      ),
    );
  }
}
