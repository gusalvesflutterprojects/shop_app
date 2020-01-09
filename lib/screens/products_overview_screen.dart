import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/shopping_cart.dart';

import '../widgets/products_grid.dart';
import '../widgets/main_drawer.dart';

import '../providers/products.dart';

class ProductsOverviewScreen extends StatefulWidget {
  @override
  _ProductsOverviewScreenState createState() => _ProductsOverviewScreenState();
}

enum FilterOptions {
  Favorites,
  All,
}

class _ProductsOverviewScreenState extends State<ProductsOverviewScreen> {
  @override
  Widget build(BuildContext context) {
    print('rebuild _ProductsOverviewScreenState');
    final Products _productsData =
        Provider.of<Products>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Text('Chopim'),
        actions: <Widget>[
          IconButton(
              icon: Stack(children: <Widget>[
                Icon(Icons.shopping_cart),
                Positioned(
                  bottom: -5,
                  right: -5,
                  child: CircleAvatar(
                    radius: 8,
                    child: Consumer<ShoppingCart>(
                      builder: (c, cartData, child) => (Text(
                        '${cartData.cartItemsProducts.length}',
                      )),
                    ),
                  ),
                )
              ]),
              onPressed: () {
                Navigator.of(context).pushNamed(
                  '/shopping-cart',
                );
              }),
          PopupMenuButton(
            icon: Icon(Icons.filter_list),
            onSelected: (FilterOptions selectedValue) {
              selectedValue == FilterOptions.Favorites
                  ? _productsData.showFavoritesOnly()
                  : _productsData.showAll();
            },
            itemBuilder: (_) => [
              PopupMenuItem(
                value: FilterOptions.Favorites,
                child: Row(
                  children: <Widget>[
                    Icon(
                      Icons.favorite,
                      color: Colors.redAccent,
                    ),
                    Text(' Favorites'),
                  ],
                ),
              ),
              PopupMenuItem(
                value: FilterOptions.All,
                child: Row(
                  children: <Widget>[
                    Icon(
                      Icons.grid_on,
                      color: Theme.of(context).accentColor,
                    ),
                    Text(' All products'),
                  ],
                ),
              ),
            ],
          )
        ],
      ),
      drawer: MainDrawer(),
      body: ProductsGrid(),
    );
  }
}
