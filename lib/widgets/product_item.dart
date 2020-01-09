import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../screens/product_details_screen.dart';

import '../providers/product.dart';
// import '../providers/products.dart';
import '../providers/shopping_cart.dart';

class ProductItem extends StatefulWidget {
  // final Product product;

  // ProductItem(this.product);

  @override
  _ProductItemState createState() => _ProductItemState();
}

class _ProductItemState extends State<ProductItem> {
  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context, listen: false);
    final ShoppingCart _cartData =
        Provider.of<ShoppingCart>(context, listen: false);
    // final Function _toggleFavorite =
    //     Provider.of<Products>(context, listen: false).toggleFavorite;

    return ClipRRect(
      borderRadius: BorderRadius.circular(18),
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
              Container(
                decoration: BoxDecoration(
                  gradient: product.gradient,
                  borderRadius: BorderRadius.circular(12),
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
                Text(
                  product.title,
                  style: TextStyle(fontSize: 18),
                ),
                GestureDetector(
                  onTap: () => product.toggleFavorite(),
                  child: Consumer<Product>(
                    builder: (c, product, child) => Icon(
                      product.isFavorite
                          ? Icons.favorite
                          : Icons.favorite_border,
                      color: Colors.red,
                    ),
                    child: Text('') //here goes static data and it is passed as the child argument to the function above,
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
                  '\$${product.price}',
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
