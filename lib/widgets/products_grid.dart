import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

import '../widgets/nothing_to_display.dart';
import '../widgets/product_item.dart';

import '../providers/products.dart';

class ProductsGrid extends StatefulWidget {
  @override
  _ProductsGridState createState() => _ProductsGridState();
}

class _ProductsGridState extends State<ProductsGrid>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1200),
    );
    _animationController.forward();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Products _productsData = Provider.of<Products>(context);
    final _showingFavoritesOnly = _productsData.shouldShowFavoritesOnly;

    return FutureBuilder(
      future: _productsData.fetchProducts(),
      builder: (ctx, snapshot) {
        final _products = _showingFavoritesOnly
            ? _productsData.favoriteItems
            : _productsData.items;

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
              child: Container(
            height: 150,
            width: 150,
            color: Colors.red,
          ));
        } else {
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
                  itemBuilder: (_, i) {
                    return ChangeNotifierProvider.value(
                      value: _products[i],
                      child: ProductItem(),
                    );
                  },
                )
              : _showingFavoritesOnly
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        NothingToDisplay(
                          icon: Icons.sentiment_dissatisfied,
                          title: 'shit nigga',
                          subtitle:
                              'you have no favorites yet, as you are no one\'s favorite',
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        FlatButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(48)),
                          padding: EdgeInsets.all(24),
                          color: Colors.blueAccent,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              const Icon(
                                Icons.arrow_back,
                              ),
                              SizedBox(
                                width: 12,
                              ),
                              const Text(
                                "SEE ALL PRODUCTS",
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w900),
                              ),
                            ],
                          ),
                          onPressed: () => _productsData.showAll(),
                        ),
                      ],
                    )
                  : NothingToDisplay(
                      icon: Icons.close,
                      title: 'no products to show',
                      subtitle:
                          'you need to add more products if you wanna see something here',
                    );
        }
      },
    );
  }
}
