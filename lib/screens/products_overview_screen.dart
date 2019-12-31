import 'package:flutter/material.dart';

import '../widgets/products_grid.dart';
import '../widgets/main_drawer.dart';

class ProductsOverviewScreen extends StatefulWidget {
  @override
  _ProductsOverviewScreenState createState() => _ProductsOverviewScreenState();
}

class _ProductsOverviewScreenState extends State<ProductsOverviewScreen> {
  @override
  Widget build(BuildContext context) {
    var scaffold = Scaffold(
      appBar: AppBar(
        title: Text('Chopim'),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.shopping_cart),
              onPressed: () {
                Navigator.of(context).pushNamed(
                  '/shopping-cart',
                );
              }),
          IconButton(icon: Icon(Icons.more_vert), onPressed: () {}),
        ],
      ),
      drawer: MainDrawer(),
      body: ProductsGrid(),
    );
    return scaffold;
  }
}
