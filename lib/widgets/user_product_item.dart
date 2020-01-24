import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

import '../providers/products.dart';

class UserProductItem extends StatefulWidget {
  final String id;
  final String title;
  final Gradient gradient;
  final bool showingRemovedProducts;
  final bool isSelected;
  final bool isSelecting;
  final Function toggleSelectSingleItem;

  UserProductItem({
    @required this.id,
    @required this.title,
    @required this.gradient,
    @required this.isSelecting,
    this.showingRemovedProducts,
    this.isSelected = false,
    this.toggleSelectSingleItem,
  });

  @override
  _UserProductItemState createState() => _UserProductItemState();
}

class _UserProductItemState extends State<UserProductItem>
    with SingleTickerProviderStateMixin {
  bool _isDeleting = false;

  AnimationController _animationController;

  @override
  void initState() {
    _animationController = AnimationController(
      duration: Duration(
        milliseconds: 500,
      ),
      vsync: this,
    );
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Products>(context);
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      color: widget.isSelected ? Theme.of(context).selectedRowColor : null,
      padding: widget.isSelected ? EdgeInsets.all(12) : EdgeInsets.zero,
      child: Column(
        children: <Widget>[
          GestureDetector(
            onLongPress: () => widget.toggleSelectSingleItem(widget.id),
            onTap: widget.isSelecting
                ? () => widget.toggleSelectSingleItem(widget.id)
                : null,
            child: ListTile(
              contentPadding: EdgeInsets.all(24),
              selected: widget.isSelected,
              leading: Hero(
                tag: "${widget.id}-gradient",
                child: Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(gradient: widget.gradient),
                ),
              ),
              title: Text(widget.title),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  if (!widget.showingRemovedProducts)
                    IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () => Navigator.of(context).pushNamed(
                        '/edit-product',
                        arguments: {
                          'id': widget.id,
                          'previousCtx': context,
                        },
                      ),
                    ),
                  if (!widget.showingRemovedProducts)
                    IconButton(
                      icon: _isDeleting
                          ? SpinKitFadingCircle(
                              color: Colors.red,
                              size: 32,
                              controller: _animationController,
                            )
                          : Icon(
                              Icons.delete,
                            ),
                      onPressed: () async => await showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            backgroundColor: Colors.white70,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12)),
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                FlatButton(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(48)),
                                  padding: EdgeInsets.all(20),
                                  color: Colors.blueAccent,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      Icon(Icons.cancel),
                                      SizedBox(
                                        width: 6,
                                      ),
                                      Text(
                                        ' KEEP ITEM',
                                        style: TextStyle(
                                          fontSize: 16,
                                        ),
                                      ),
                                    ],
                                  ),
                                  onPressed: () =>
                                      Navigator.of(context).pop(false),
                                ),
                                SizedBox(
                                  height: 12,
                                ),
                                FlatButton(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(48)),
                                  padding: EdgeInsets.all(20),
                                  color: Colors.redAccent,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      const Icon(
                                        Icons.delete,
                                      ),
                                      SizedBox(
                                        width: 12,
                                      ),
                                      const Text(
                                        "REMOVE",
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                  onPressed: () =>
                                      Navigator.of(context).pop(true),
                                ),
                              ],
                            ),
                          );
                        },
                      ).then(
                        (res) async {
                          if (res) {
                            setState(() => _isDeleting = !_isDeleting);
                            await productsData.deleteProduct(widget.id);
                          }
                        },
                      )
                    ),
                  if (widget.showingRemovedProducts)
                    IconButton(
                      icon: Icon(Icons.restore),
                      onPressed: () => productsData.restoreProduct(widget.id),
                    )
                ],
              ),
            ),
          ),
          Divider(
            height: 0,
          ),
        ],
      ),
    );
  }
}
