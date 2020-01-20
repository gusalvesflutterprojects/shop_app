import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/products.dart';

class EditProductScreen extends StatefulWidget {
  static const routeName = '/edit-product';

  @override
  _EditProductScreenState createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final _descriptionFocusNode = FocusNode();
  final _priceFocusNode = FocusNode();
  final _form = GlobalKey<FormState>();

  String _title;
  String _desc;
  double _price;

  @override
  void dispose() {
    _descriptionFocusNode.dispose();
    _priceFocusNode.dispose();
    super.dispose();
  }

  String _titleDescValidator(String value) {
    if (value.isNotEmpty && value.length <= 3)
      return 'This field cannot be empty or contain less than 3 characters';
    return null;
  }

  String _priceValidator(String value) {
    if (double.parse(value) <= 3) return 'Price cannot be less than \$1';
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final routeArgs =
        ModalRoute.of(context).settings.arguments as Map<String, dynamic>;
    final productsData = Provider.of<Products>(context);
    final product = productsData.getProductInfo(routeArgs['id']);

    void submitChanges() {
      final isFormValid = _form.currentState.validate();
      if (isFormValid) {
        _form.currentState.save();
        productsData.updateProduct(
          routeArgs['id'],
          _title,
          _desc,
          _price,
        );

        Navigator.of(context).pop();
        Scaffold.of(routeArgs['previousCtx']).hideCurrentSnackBar();
        Scaffold.of(routeArgs['previousCtx']).showSnackBar(SnackBar(
          backgroundColor: Colors.green,
          elevation: 40,
          duration: Duration(seconds: 2),
          content: Container(
            height: MediaQuery.of(context).size.height * 0.05,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Icon(Icons.check, size: 36),
                    Text(' $_title details updated.',
                        style: TextStyle(fontSize: 20)),
                  ],
                ),
                Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(gradient: product.gradient),
                )
              ],
            ),
          ),
        ));
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Editing ${product.title}'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Hero(
              tag: "${routeArgs['id']}-gradient",
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
              padding: EdgeInsets.all(12),
              child: Form(
                key: _form,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: EdgeInsets.all(12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          TextFormField(
                            initialValue: product.title,
                            autofocus: true,
                            decoration: InputDecoration(
                              labelText: 'Title',
                              labelStyle: TextStyle(fontSize: 18),
                            ),
                            textInputAction: TextInputAction.next,
                            validator: (v) => _titleDescValidator(v),
                            onChanged: (value) =>
                                setState(() => _title = value),
                            onFieldSubmitted: (_) => FocusScope.of(context)
                                .requestFocus(_descriptionFocusNode),
                            onSaved: (value) => setState(() => _title = value),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: EdgeInsets.all(12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          TextFormField(
                            initialValue: product.description,
                            decoration: InputDecoration(
                              labelText: 'Description',
                              labelStyle: TextStyle(fontSize: 18),
                            ),
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.multiline,
                            validator: (v) => _titleDescValidator(v),
                            maxLines: 3,
                            focusNode: _descriptionFocusNode,
                            onChanged: (value) => setState(() => _desc = value),
                            onSaved: (value) => setState(() => _desc = value),
                            onFieldSubmitted: (_) => FocusScope.of(context)
                                .requestFocus(_priceFocusNode),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: EdgeInsets.all(12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          TextFormField(
                            initialValue: product.price.toStringAsFixed(2),
                            decoration: InputDecoration(
                              labelText: 'Price',
                              labelStyle: TextStyle(fontSize: 18),
                            ),
                            textInputAction: TextInputAction.done,
                            keyboardType: TextInputType.number,
                            validator: (v) => _priceValidator(v),
                            focusNode: _priceFocusNode,
                            onChanged: (value) =>
                                setState(() => _price = double.parse(value)),
                            onSaved: (value) =>
                                setState(() => _price = double.parse(value)),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Builder(
        builder: (ctx) => Container(
          height: 60,
          child: FlatButton(
            padding: EdgeInsets.zero,
            shape: BeveledRectangleBorder(),
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            color: Colors.orangeAccent,
            onPressed: submitChanges,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(
                  Icons.save,
                  size: 32,
                  color: Colors.white,
                ),
                Text(
                  ' Save',
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.white,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
