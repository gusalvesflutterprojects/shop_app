import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:random_color/random_color.dart';

import '../providers/shopping_cart.dart';
import '../providers/product.dart';

class ProductDetailsScreen extends StatefulWidget {
  static const String routeName = '/product-details';

  @override
  _ProductDetailsScreenState createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  ScrollController _scrollController;
  Color _randomColor;
  bool _shouldShowHeader = false;
  int _quantity;

  void _scrollListener() {
    if (_scrollController.offset > MediaQuery.of(context).padding.top)
      setState(() => _shouldShowHeader = true);
    else
      setState(() => _shouldShowHeader = false);
  }

  void _decreaseQuantity() {
    if (_quantity > 1) setState(() => _quantity--);
  }

  @override
  void initState() {
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
    _randomColor =
        RandomColor().randomColor(colorBrightness: ColorBrightness.dark);
    _shouldShowHeader = false;
    _quantity = 1;
    super.initState();
  }

  Widget build(BuildContext context) {
    final ShoppingCart _cartData =
        Provider.of<ShoppingCart>(context, listen: false);

    final product = (ModalRoute.of(context).settings.arguments as Map<String, dynamic>)['product'];

    return Scaffold(
      bottomNavigationBar: FlatButton(
        shape: BeveledRectangleBorder(),
        padding: EdgeInsets.all(12),
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        onPressed: () {
          _cartData.addToCart(context, product, _quantity);
        },
        color: _randomColor,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              'Add to cart',
              style: TextStyle(fontSize: 24, color: Colors.white),
            ),
            Icon(
              Icons.add_shopping_cart,
              size: 38,
              color: Colors.white,
            ),
          ],
        ),
      ),
      body: Stack(
        children: <Widget>[
          SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Hero(
                  tag: "${product.id}Image",
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: product.gradient,
                    ),
                    height: (MediaQuery.of(context).size.height -
                            MediaQuery.of(context).padding.top) *
                        0.5,
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Hero(
                            key: ValueKey("${product.id}Title"),
                            tag: "${product.id}Title",
                            child: Material(
                              type: MaterialType.transparency,
                              child: Text(
                                product.title,
                                style: TextStyle(fontSize: 42),
                              ),
                            ),
                          ),
                          Hero(
                            key: ValueKey("${product.id}Price"),
                            tag: "${product.id}Price",
                            child: Material(
                              type: MaterialType.transparency,
                              child: Text(
                                '\$ ${product.price}',
                                style: TextStyle(fontSize: 24),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        width: 90,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                GestureDetector(
                                  onTap: () => setState(() => _quantity++),
                                  child: Container(
                                    child: Icon(Icons.add),
                                    color: Colors.greenAccent,
                                  ),
                                ),
                                Text('$_quantity'),
                                GestureDetector(
                                  onTap: _decreaseQuantity,
                                  child: Container(
                                    child: Icon(Icons.remove),
                                    color: Colors.redAccent,
                                  ),
                                ),
                              ],
                            ),
                            Consumer<Product>(
                              builder: (_, prod, ch) => Hero(
                                tag: "${product.id}Favorite",
                                child: GestureDetector(
                                  onTap: () => product.toggleFavorite(context),
                                  child: Icon(
                                    product.isFavorite
                                        ? Icons.favorite
                                        : Icons.favorite_border,
                                    color: Colors.red,
                                    size: 54,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: Container(
                      height: 800, child: Text('${product.description}')),
                ),
              ],
            ),
          ),
          AnimatedContainer(
            color: _shouldShowHeader
                ? Theme.of(context).canvasColor
                : Colors.transparent,
            duration: Duration(milliseconds: 200),
            height:
                _shouldShowHeader ? MediaQuery.of(context).padding.top + 48 : 0,
            curve: Curves.decelerate,
            child: AppBar(
              elevation: 0,
              backgroundColor: Colors.transparent,
              leading: Container(),
            ),
          ),
          IconButton(
            icon: Icon(Icons.arrow_back_ios),
            padding: EdgeInsets.symmetric(
              vertical: MediaQuery.of(context).padding.top + 12,
              horizontal: 12,
            ),
            onPressed: Navigator.of(context).pop,
          ),
        ],
      ),
    );
  }
}
