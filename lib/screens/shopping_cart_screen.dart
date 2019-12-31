import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/shopping_cart_item.dart';
import '../providers/shopping_cart.dart';

class ShoppingCartScreen extends StatelessWidget {
  static const routeName = '/shopping-cart';

  @override
  Widget build(BuildContext context) {
    final ShoppingCart _cartData = Provider.of<ShoppingCart>(context);
    final _cartItems = _cartData.cartItemsWithInfo;

    return Scaffold(
        appBar: AppBar(
          title: Text('My cart'),
          centerTitle: true,
        ),
        body: _cartItems.isNotEmpty
            ? ListView.builder(
                itemCount: _cartItems.length,
                itemBuilder: (ctx, i) => ShoppingCartItem(_cartItems[i]),
              )
            : Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      Icons.remove_shopping_cart,
                      size: 180,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 72),
                      child: Column(
                        children: <Widget>[
                          Divider(
                            indent: 24,
                            endIndent: 24,
                            color: Theme.of(context).accentColor,
                          ),
                          Text(
                            'YOUR CART IS EMPTY',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                          Text(
                            'you\'re an embarassment to the world.',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 24),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ));
  }
}
