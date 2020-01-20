import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './screens/product_details_screen.dart';
import './screens/products_overview_screen.dart';
import './screens/shopping_cart_screen.dart';
import './screens/orders_screen.dart';
import './screens/order_completed.dart';
import './screens/user_products_screen.dart';
import './screens/edit_product_screen.dart';
import './screens/add_product_screen.dart';

import 'providers/product.dart';
import 'providers/products.dart';
import 'providers/shopping_cart.dart';
import 'providers/orders.dart';
import 'screens/not_found.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => Products(),
        ),
        ChangeNotifierProvider(
          create: (_) => ShoppingCart(),
        ),
        ChangeNotifierProvider(
          create: (_) => Orders(),
        ),
      ],
      child: MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.purple,
          accentColor: Colors.amber,
          fontFamily: 'Nunito',
          selectedRowColor: Colors.blue.withOpacity(0.4),
        ),
        title: 'Chopim App',
        initialRoute: '/',
        onGenerateRoute: (RouteSettings routeData) {
          final _args = routeData.arguments as Map<String, dynamic>;          
          switch (routeData.name) {
            case ProductDetailsScreen.routeName:
            final product = _args['product'] as Product;
              return MaterialPageRoute(
                settings: routeData,
                builder: (_) => ChangeNotifierProvider.value(
                  value: product,
                  child: ProductDetailsScreen(),
                ),
              );
              break;
            default:
              return MaterialPageRoute(
                builder: (_) => NotFound(),
              );
          }
        },
        routes: {
          '/': (_) => ProductsOverviewScreen(),
          ShoppingCartScreen.routeName: (_) => ShoppingCartScreen(),
          OrdersScreen.routeName: (_) => OrdersScreen(),
          OrderCompleted.routeName: (_) => OrderCompleted(),
          UserProductsScreen.routeName: (_) => UserProductsScreen(),
          EditProductScreen.routeName: (_) => EditProductScreen(),
          AddProductScreen.routeName: (_) => AddProductScreen(),
        },
      ),
    );
  }
}
