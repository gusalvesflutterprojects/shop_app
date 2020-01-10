import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../screens/product_details_screen.dart';

import '../providers/product.dart';
import '../providers/shopping_cart.dart';

class ProductItem extends StatefulWidget {
  @override
  _ProductItemState createState() => _ProductItemState();
}

class _ProductItemState extends State<ProductItem> {
  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context);
    final ShoppingCart _cartData =
        Provider.of<ShoppingCart>(context, listen: false);

    return ClipRRect(
      borderRadius: BorderRadius.circular(18),
      child: ChangeNotifierProvider.value(
        value: product,
        child: GestureDetector(
          onTap: () => Navigator.pushNamed(
            context,
            ProductDetailsScreen.routeName,
            arguments: {
              'product': product,
            },
          ),
          child: GridTile(
            child: Stack(
              children: <Widget>[
                Hero(
                  key: ValueKey(product.id),
                  tag: '${product.id}Image',
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: product.gradient,
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                Positioned(
                  bottom: -20,
                  left: -20,
                  child: InkWell(
                    onTap: () {
                      _cartData.addToCart(context, product, 1);
                    },
                    child: CircleAvatar(
                      backgroundColor: Theme.of(context).accentColor,
                      radius: 38,
                      child: Icon(
                        Icons.shopping_cart,
                        color: Colors.yellowAccent,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            header: Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Hero(
                    key: ValueKey('${product.id}Title'),
                    tag: '${product.id}Title',
                    child: Material(
                      type: MaterialType.transparency,
                      child: Text(
                        product.title,
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => product.toggleFavorite(),
                    child: Consumer<Product>(
                      builder: (c, product, child) => Hero(
                        key: ValueKey(product.id),
                        tag: '${product.id}Favorite',
                        child: Icon(
                          product.isFavorite
                              ? Icons.favorite
                              : Icons.favorite_border,
                          color: Colors.red,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            footer: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: Hero(
                    key: ValueKey('${product.id}Price'),
                    tag: '${product.id}Price',
                    child: Material(
                      type: MaterialType.transparency, // likely needed
                      child: Text(
                        '\$${product.price}',
                        style: TextStyle(fontSize: 28),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
