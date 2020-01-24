import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/products_grid.dart';
import '../widgets/main_drawer.dart';
import '../widgets/badge.dart';

import '../providers/shopping_cart.dart';
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
    final Products _productsData =
        Provider.of<Products>(context, listen: false);

    _buildPopupMenuItem(
      FilterOptions value,
      IconData icon,
      Color color,
      String title,
    ) =>
        PopupMenuItem(
          value: value,
          child: Row(
            children: <Widget>[
              Icon(
                icon,
                color: color,
              ),
              Text(' $title'),
            ],
          ),
        );

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Consumer<Products>(
          builder: (ctx, prodData, child) => Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(prodData.shouldShowFavoritesOnly
                  ? 'Favorites '
                  : 'All products '),
              prodData.shouldShowFavoritesOnly
                  ? Icon(
                      Icons.favorite,
                      size: 28,
                      color: Colors.redAccent,
                    )
                  : Icon(
                      Icons.grid_on,
                      size: 28,
                      color: Theme.of(context).accentColor,
                    ),
            ],
          ),
        ),
        actions: <Widget>[
          Consumer<ShoppingCart>(
            builder: (_, cartData, ch) => Badge(
              value: cartData.cartItemsCount,
              color: Theme.of(context).primaryColor.withRed(230),
              icon: ch,
            ),
            child: Icon(Icons.shopping_cart),
          ),
          PopupMenuButton(
            icon: Icon(Icons.filter_list),
            onSelected: (FilterOptions selectedValue) {
              selectedValue == FilterOptions.Favorites
                  ? _productsData.showFavoritesOnly()
                  : _productsData.showAll();
            },
            itemBuilder: (_) => [
              _buildPopupMenuItem(
                FilterOptions.All,
                Icons.grid_on,
                Theme.of(context).accentColor,
                'All products',
              ),
              _buildPopupMenuItem(
                FilterOptions.Favorites,
                Icons.favorite,
                Colors.red,
                'Favorites',
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
