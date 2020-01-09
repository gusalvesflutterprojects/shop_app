import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './screens/product_details_screen.dart';
import './screens/products_overview_screen.dart';
import './screens/shopping_cart_screen.dart';
import './screens/orders_screen.dart';
import './screens/order_completed.dart';

import 'providers/products.dart';
import 'providers/shopping_cart.dart';
import 'providers/orders.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => Products(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => ShoppingCart(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => Orders(),
        ),
      ],
      child: MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.purple,
          accentColor: Colors.amber,
          fontFamily: 'Nunito',
        ),
        title: 'Chopim App',
        initialRoute: '/',
        routes: {
          '/': (ctx) => ProductsOverviewScreen(),
          ProductDetailsScreen.routeName: (ctx) => ProductDetailsScreen(),
          ShoppingCartScreen.routeName: (ctx) => ShoppingCartScreen(),
          OrdersScreen.routeName: (ctx) => OrdersScreen(),
          OrderCompleted.routeName: (ctx) => OrderCompleted(),
        },
      ),
    );
  }
}
