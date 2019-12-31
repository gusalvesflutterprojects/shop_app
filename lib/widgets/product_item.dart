import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../screens/product_details_screen.dart';

import '../models/product.dart';
import '../providers/products.dart';
import '../providers/shopping_cart.dart';

class ProductItem extends StatefulWidget {
  final Product product;

  ProductItem(this.product);

  @override
  _ProductItemState createState() => _ProductItemState();
}

class _ProductItemState extends State<ProductItem> {
  @override
  Widget build(BuildContext context) {
    final ShoppingCart _cartData = Provider.of<ShoppingCart>(context);

    final Function _toggleFavorite =
        Provider.of<Products>(context).toggleFavorite;

    return ClipRRect(
      borderRadius: BorderRadius.circular(18),
      child: GestureDetector(
        onTap: () {
          Navigator.pushNamed(
            context,
            ProductDetailsScreen.routeName,
            arguments: {
              'product': widget.product,
            },
          );
        },
        child: GridTile(
          child: Stack(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  gradient: widget.product.gradient,
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              Positioned(
                bottom: -20,
                left: -20,
                child: InkWell(
                  onTap: () {
                    _cartData.addToCart(context, widget.product);
                  },
                  child: CircleAvatar(
                      backgroundColor: Theme.of(context).accentColor,
                      radius: 38,
                      child: Icon(
                        Icons.shopping_cart,
                        color: Colors.yellowAccent,
                      )),
                ),
              ),
            ],
          ),
          header: Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  widget.product.title,
                  style: TextStyle(fontSize: 18),
                ),
                GestureDetector(
                  onTap: () => _toggleFavorite(widget.product.id),
                  child: Icon(
                    widget.product.isFavorite
                        ? Icons.favorite
                        : Icons.favorite_border,
                    color: Colors.red,
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
                child: Text(
                  '\$${widget.product.price}',
                  style: TextStyle(fontSize: 28),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
