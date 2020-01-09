import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/order_item.dart';

import '../providers/orders.dart';

class OrdersScreen extends StatelessWidget {
  static const routeName = '/my-orders';

  @override
  Widget build(BuildContext context) {
    final Orders _ordersData = Provider.of<Orders>(context);
    final _orders = _ordersData.orders;

    return Scaffold(
        appBar: AppBar(
          title: Text('My orders'),
          centerTitle: true,
        ),
        body: _orders.isNotEmpty
            ? ListView.builder(
                itemCount: _orders.length,
                itemBuilder: (ctx, i) => OrderItem(
                  id: _orders[i].id,
                  orderProducts: _orders[i].products,
                  orderDate: _orders[i].date,
                  orderTotalPrice: _orders[i].totalPrice,
                ),
              )
            : Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      Icons.sentiment_dissatisfied,
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
                            'YOU HAVE NO ORDERS YET',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                          Text(
                            'if you didn\'t buy anything, you\'re obviously not gonna see anything here. JERK.',
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
