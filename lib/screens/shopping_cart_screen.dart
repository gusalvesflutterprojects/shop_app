import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/shopping_cart_item.dart';
import '../widgets/nothing_to_display.dart';

import '../models/product_with_quantity.dart';
import '../providers/shopping_cart.dart';
import '../providers/orders.dart';

class ShoppingCartScreen extends StatelessWidget {
  static const routeName = '/shopping-cart';

  @override
  Widget build(BuildContext context) {
    final ShoppingCart _cartData = Provider.of<ShoppingCart>(context);
    final Orders _ordersData = Provider.of<Orders>(context, listen: false);
    final _cartItemsWithQuantity = _cartData.cartItemsWithQuantity;

    return Scaffold(
      appBar: AppBar(
        title: Text('My cart'),
        centerTitle: true,
      ),
      bottomNavigationBar: _cartItemsWithQuantity.isNotEmpty
          ? FlatButton(
              padding: EdgeInsets.zero,
              shape: BeveledRectangleBorder(),
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              onPressed: () {
                _ordersData.addOrder(
                  context,
                  _cartItemsWithQuantity
                      .map(
                        (item) => ProductWithQuantity(
                          product: item.product,
                          qty: item.qty,
                        ),
                      )
                      .toList(),
                );
                _cartData.emptyCart();
              },
              color: Colors.orangeAccent,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(left: 24),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'Place order',
                          style: TextStyle(
                            fontSize: 24,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(
                          width: 12,
                        ),
                        Icon(
                          Icons.playlist_add,
                          color: Colors.white,
                          size: 32,
                        )
                      ],
                    ),
                  ),
                  Row(
                    children: <Widget>[
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 24, vertical: 6),
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Text(
                              'Total',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).accentColor,
                              ),
                            ),
                            Text(
                                '\$${_cartData.shoppingCartTotal.toStringAsFixed(2)}',
                                style: TextStyle(
                                    fontSize: 20, color: Colors.white))
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )
          : SizedBox(),
      body: _cartItemsWithQuantity.isNotEmpty
          ? ListView.builder(
              itemCount: _cartItemsWithQuantity.length,
              itemBuilder: (_, i) =>
                  ShoppingCartItem(_cartItemsWithQuantity[i]),
            )
          : NothingToDisplay(
              icon: Icons.remove_shopping_cart,
              title: 'your cart is empty',
              subtitle: 'you\'re an embarassment to the world.',
            ),
    );
  }
}
