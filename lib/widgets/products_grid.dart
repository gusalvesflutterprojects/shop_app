import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/nothing_to_display.dart';
import '../widgets/product_item.dart';

import '../providers/products.dart';

class ProductsGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Products _productsData = Provider.of<Products>(context);
    final _products = _productsData.shouldShowFavoritesOnly
        ? _productsData.favoriteItems
        : _productsData.items;

    return _products.length > 0
        ? GridView.builder(
            padding: const EdgeInsets.all(12),
            itemCount: _products.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 3 / 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            itemBuilder: (ctx, i) {
              return ChangeNotifierProvider.value(
                value: _products[i],
                child: ProductItem(),
              );
            },
          )
        : NothingToDisplay(
            icon: Icons.sentiment_dissatisfied,
            title: 'shit nigga',
            subtitle:
                'you have no favorites yet, as you are no one\'s favorite',
          );
  }
}
