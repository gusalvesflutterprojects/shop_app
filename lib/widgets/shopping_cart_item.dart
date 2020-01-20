import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/shopping_cart.dart';
import '../models/product_with_quantity.dart';

class ShoppingCartItem extends StatelessWidget {
  final ProductWithQuantity cartItem;

  ShoppingCartItem(this.cartItem);

  @override
  Widget build(BuildContext context) {
    final ShoppingCart _cartData =
        Provider.of<ShoppingCart>(context, listen: false);

    return Dismissible(
      key: ValueKey(cartItem.product.id),
      onDismissed: (_) => _cartData.removeFromCart(cartItem.product.id),
      confirmDismiss: (DismissDirection direction) => showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.white70,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                FlatButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(48)),
                  padding: EdgeInsets.all(20),
                  color: Colors.blueAccent,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Icon(Icons.cancel),
                      SizedBox(
                        width: 6,
                      ),
                      Text(
                        ' KEEP ITEM',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                  onPressed: () => Navigator.of(context).pop(false),
                ),
                SizedBox(
                  height: 12,
                ),
                FlatButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(48)),
                  padding: EdgeInsets.all(20),
                  color: Colors.redAccent,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const Icon(
                        Icons.delete,
                      ),
                      SizedBox(
                        width: 12,
                      ),
                      const Text(
                        "REMOVE",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  onPressed: () => Navigator.of(context).pop(true),
                ),
              ],
            ),
          );
        },
      ),
      direction: DismissDirection.endToStart,
      background: Container(
        color: Colors.redAccent,
        child: Container(
          alignment: Alignment.centerRight,
          padding: const EdgeInsets.only(right: 24),
          child: Icon(
            Icons.delete,
            size: 32,
          ),
        ),
      ),
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: <Widget>[
                Hero(
                  key: ValueKey(cartItem.product.id),
                  tag: "${cartItem.product.id}Image",
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.2,
                    height: MediaQuery.of(context).size.width * 0.2,
                    decoration: BoxDecoration(
                      gradient: cartItem.product.gradient,
                    ),
                  ),
                ),
                Expanded(
                  child: ListTile(
                    title: Text(
                      cartItem.product.title,
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(cartItem.product.description),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.3,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      GestureDetector(
                        onTap: () =>
                            _cartData.decrementCartProduct(cartItem.product.id),
                        child: CircleAvatar(
                          radius: 12,
                          child: Icon(
                            Icons.remove,
                          ),
                        ),
                      ),
                      Text('${cartItem.qty}', style: TextStyle(fontSize: 18)),
                      GestureDetector(
                        onTap: () =>
                            _cartData.incrementCartProduct(cartItem.product.id),
                        child: CircleAvatar(
                          radius: 12,
                          child: Icon(
                            Icons.add,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Text(
                    'Item ',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).accentColor),
                  ),
                  Text('\$${cartItem.product.price}'),
                ],
              ),
              Row(
                children: <Widget>[
                  Text(
                    'Subtotal ',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).primaryColor),
                  ),
                  Text(
                    '\$${(cartItem.product.price * cartItem.qty).toStringAsFixed(2)}',
                  ),
                ],
              ),
            ],
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
