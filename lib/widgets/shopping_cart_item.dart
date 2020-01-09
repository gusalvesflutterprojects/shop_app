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
      onDismissed: (_) => _cartData.removeFromCart(cartItem.product.id),
      confirmDismiss: (DismissDirection direction) async {
        final bool res = await showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text("Remove item?"),
              content: Text("Are you sure you wish to remove ${cartItem.product.title} from your cart?"),
              actions: <Widget>[
                FlatButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: const Text("CANCEL"),
                ),
                FlatButton(
                  onPressed: () => Navigator.of(context).pop(true),
                  child: const Text(
                    "REMOVE",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            );
          },
        );
        return res;
      },
      direction: DismissDirection.endToStart,
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
                'Remove item',
                style: TextStyle(fontSize: 18),
              ),
            ],
          ),
        ),
      ),
      key: UniqueKey(),
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
                    gradient: cartItem.product.gradient,
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
