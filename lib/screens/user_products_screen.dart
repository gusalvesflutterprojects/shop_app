import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/widgets/nothing_to_display.dart';

import '../widgets/user_product_item.dart';
import '../widgets/main_drawer.dart';
import './add_product_screen.dart';

import '../providers/products.dart';

class UserProductsScreen extends StatefulWidget {
  static const routeName = '/user-products';

  @override
  _UserProductsScreenState createState() => _UserProductsScreenState();
}

class _UserProductsScreenState extends State<UserProductsScreen> {
  int _currentNavigationIndex = 0;
  bool _isSelecting = false;
  List<SelectableItem> _selectedItems = [];

  @override
  Widget build(BuildContext context) {
    final _isShowingRemovedProducts = _currentNavigationIndex == 1;
    final productsData = Provider.of<Products>(context);
    final products = _isShowingRemovedProducts
        ? productsData.deletedItems
        : productsData.items;

    if (_selectedItems.isEmpty) {
      _selectedItems = products
          .map((prod) => SelectableItem(id: prod.id, isSelected: false))
          .toList();
    }

    bool _isSelected(String id) =>
        _selectedItems.firstWhere((item) => item.id == id).isSelected;

    int _totalSelectedItems() =>
        _selectedItems.fold(0, (val, item) => item.isSelected ? val + 1 : val);

    bool _allItemsSelected() => _totalSelectedItems() == products.length;

    bool _noItemsSelected() => _totalSelectedItems() == 0;

    void _toggleSelectSingleItem(String id) {
      final currentItem = _selectedItems.firstWhere((item) => item.id == id);

      setState(() => currentItem.isSelected = !currentItem.isSelected);
      if (_noItemsSelected())
        setState(() => _isSelecting = false);
      else
        setState(() => _isSelecting = true);
    }

    void _toggleSelectAllItems() {
      setState(
        () => _allItemsSelected()
            ? _selectedItems.forEach((item) => item.isSelected = false)
            : _selectedItems.forEach((item) => item.isSelected = true),
      );
    }

    void _emptySelectedItemsList() => setState(() => _selectedItems.clear());

    void _removeSelected() {
      _selectedItems.forEach((item) => productsData.deleteProduct(item.id));
      setState(() => _selectedItems.clear());
    }

    return DefaultTabController(
      length: 2,
      initialIndex: _currentNavigationIndex,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('My products'),
          actions: <Widget>[
            GestureDetector(
              onTap: _toggleSelectAllItems,
              child: !_noItemsSelected()
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          _allItemsSelected()
                              ? Icons.check_circle
                              : Icons.check_circle_outline,
                        ),
                        Text(
                          _totalSelectedItems().toString(),
                          style: TextStyle(fontSize: 12),
                        )
                      ],
                    )
                  : Container(),
            ),
            Builder(
              builder: (ctx) => IconButton(
                icon: const Icon(Icons.add),
                onPressed: () => Navigator.pushNamed(
                  ctx,
                  AddProductScreen.routeName,
                  arguments: ctx,
                ),
              ),
            )
          ],
          centerTitle: true,
        ),
        drawer: MainDrawer(),
        body: products.length > 0
            ? Builder(
                builder: (_) => ListView.builder(
                  itemCount: products.length,
                  itemBuilder: (_, i) {
                    return UserProductItem(
                      id: products[i].id,
                      title: products[i].title,
                      gradient: products[i].gradient,
                      showingRemovedProducts: _isShowingRemovedProducts,
                      isSelected: _isSelected(products[i].id),
                      isSelecting: _isSelecting,
                      toggleSelectSingleItem: _toggleSelectSingleItem,
                    );
                  },
                ),
              )
            : _isShowingRemovedProducts
                ? NothingToDisplay(
                    icon: Icons.restore_from_trash,
                    title: 'your trash is empty',
                    subtitle: 'why don\'t you come and get in here?',
                  )
                : NothingToDisplay(
                    icon: Icons.block,
                    title: 'you have nothing here',
                    subtitle: 'how the fuck will you manage nothing?',
                  ),
        bottomNavigationBar: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            AnimatedContainer(
              duration: Duration(milliseconds: 500),
              height: !_noItemsSelected()
                  ? MediaQuery.of(context).size.height * 0.1
                  : 0,
              child: FlatButton(
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                padding: EdgeInsets.all(8),
                color: Colors.red,
                child: Container(
                  width: double.infinity,
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                        Icons.delete_forever,
                        size: 36,
                        color: Colors.white,
                      ),
                      Text(
                        ' Remove selected',
                        style: TextStyle(
                          fontSize: 24,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                onPressed: _removeSelected,
              ),
            ),
            if (_isShowingRemovedProducts)
              AnimatedContainer(
                duration: Duration(milliseconds: 300),
                height: products.length > 0
                    ? MediaQuery.of(context).size.height * 0.075
                    : 0,
                child: FlatButton(
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  padding: EdgeInsets.all(8),
                  color: Colors.red,
                  child: Container(
                    width: double.infinity,
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.delete_forever,
                          size: 36,
                          color: Colors.white,
                        ),
                        Text(
                          ' Empty trash',
                          style: TextStyle(
                            fontSize: 24,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  onPressed: () => productsData.emptyTrash(),
                ),
              ),
            BottomNavigationBar(
              backgroundColor: Theme.of(context).accentColor,
              currentIndex: _currentNavigationIndex,
              onTap: (idx) {
                setState(() => _currentNavigationIndex = idx);
                setState(() => _emptySelectedItemsList());
              },
              items: [
                BottomNavigationBarItem(
                  icon: Icon(Icons.more),
                  title: Text('My items'),
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.delete),
                  title: Text('Deleted items'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class SelectableItem {
  final String id;
  bool isSelected;

  SelectableItem({
    this.id,
    this.isSelected = false,
  });
}
