import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:random_color/random_color.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../providers/products.dart';

class AddProductScreen extends StatefulWidget {
  static const routeName = 'add-product';

  @override
  _AddProductScreenState createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen>
    with SingleTickerProviderStateMixin {
  final _descriptionFocusNode = FocusNode();
  final _priceFocusNode = FocusNode();
  final _form = GlobalKey<FormState>();
  AnimationController _animationController;

  String _title;
  String _desc;
  double _price;
  LinearGradient _gradient = LinearGradient(
    colors: RandomColor()
        .randomColors(count: 2, colorBrightness: ColorBrightness.veryLight),
    begin: Alignment.bottomLeft,
    end: Alignment.topRight,
  );

  bool _isSubmitting = false;

  Color _randomButtonColor =
      RandomColor().randomColor(colorBrightness: ColorBrightness.veryDark);

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
    _descriptionFocusNode.dispose();
    _priceFocusNode.dispose();
    super.dispose();
  }

  String _titleDescValidator(String value) {
    if (value.length <= 3)
      return 'This field cannot be empty or contain less than 3 characters';
    return null;
  }

  String _priceValidator(String value) {
    if (value.isEmpty)
      return 'Price cannot be null';
    else if (double.parse(value) <= 3)
      return 'Price cannot be less than \$1 or null';
    return null;
  }

  void submitAddProduct(BuildContext ctx) async {
    bool isValid = _form.currentState.validate();

    if (isValid) {
      setState(() => _isSubmitting = true);
      _animationController.forward();
      _form.currentState.save();
      await Provider.of<Products>(context, listen: false).addProduct(
        _title,
        _desc,
        _price,
        _gradient,
      );

      setState(() => _isSubmitting = false);

      Navigator.of(context).pop();
      Scaffold.of(ctx).hideCurrentSnackBar();
      Scaffold.of(ctx).showSnackBar(SnackBar(
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
                  Text(
                    ' Product successfully added.',
                    style: TextStyle(fontSize: 20),
                  ),
                ],
              ),
              Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  gradient: _gradient,
                ),
              )
            ],
          ),
        ),
      ));
      _animationController.stop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final previousCtx =
        ModalRoute.of(context).settings.arguments as BuildContext;
    return Scaffold(
      appBar: AppBar(
        title: Text('Adding new product...'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                gradient: _gradient,
              ),
              height: (MediaQuery.of(context).size.height -
                      MediaQuery.of(context).padding.top) *
                  0.5,
            ),
            FlatButton(
              padding: EdgeInsets.all(12),
              shape: BeveledRectangleBorder(),
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              color: _randomButtonColor,
              onPressed: () => setState(
                () => _gradient = LinearGradient(
                  colors: RandomColor().randomColors(
                      count: 2, colorBrightness: ColorBrightness.veryLight),
                  begin: Alignment.bottomLeft,
                  end: Alignment.topRight,
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    Icons.shuffle,
                    size: 32,
                    color: Colors.white,
                  ),
                  Text(
                    ' Randomize gradient',
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.white,
                    ),
                  )
                ],
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
        builder: (ctx) => AnimatedContainer(
          duration: Duration(milliseconds: 200),
          height: _isSubmitting ? MediaQuery.of(context).size.height : 60,
          child: FlatButton(
            padding: EdgeInsets.zero,
            shape: BeveledRectangleBorder(),
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            color: Colors.orangeAccent,
            onPressed: () => submitAddProduct(previousCtx),
            child: _isSubmitting
                ? SpinKitDoubleBounce(
                    color: Colors.white,
                    size: 32.0,
                    controller: _animationController,
                  )
                : Row(
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
