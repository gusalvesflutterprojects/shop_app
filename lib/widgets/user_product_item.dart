import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/products.dart';

class UserProductItem extends StatelessWidget {
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
  Widget build(BuildContext context) {
    final productsData = Provider.of<Products>(context);
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      color: isSelected ? Theme.of(context).selectedRowColor : null,
      padding: isSelected ? EdgeInsets.all(12) : EdgeInsets.zero,
      child: Column(
        children: <Widget>[
          GestureDetector(
            onLongPress: () => toggleSelectSingleItem(id),
            onTap: isSelecting ? () => toggleSelectSingleItem(id) : null,
            child: ListTile(
              contentPadding: EdgeInsets.all(24),
              selected: isSelected,
              leading: Hero(
                tag: "$id-gradient",
                child: Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(gradient: gradient),
                ),
              ),
              title: Text(title),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  if (!showingRemovedProducts)
                    IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () => Navigator.of(context).pushNamed(
                        '/edit-product',
                        arguments: {
                          'id': id,
                          'previousCtx': context,
                        },
                      ),
                    ),
                  if (!showingRemovedProducts)
                    IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () => showDialog(
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
                          (res) => res ? productsData.deleteProduct(id) : null),
                    ),
                  if (showingRemovedProducts)
                    IconButton(
                      icon: Icon(Icons.restore),
                      onPressed: () => productsData.restoreProduct(id),
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
