import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../widgets/order_sub_item.dart';
import '../models/product_with_quantity.dart';

class OrderItem extends StatefulWidget {
  final int id;
  final List<ProductWithQuantity> orderProducts;
  final DateTime orderDate;
  final double orderTotalPrice;

  OrderItem({
    this.id,
    this.orderProducts,
    this.orderDate,
    this.orderTotalPrice,
  });

  @override
  _OrderItemState createState() => _OrderItemState();
}

class _OrderItemState extends State<OrderItem> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        GestureDetector(
          onTap: () => setState(() => _isExpanded = !_isExpanded),
          child: AnimatedContainer(
            duration: Duration(milliseconds: 200),
            color: _isExpanded ? Colors.grey[300] : Colors.transparent,
            padding: _isExpanded
                ? EdgeInsets.all(18)
                : EdgeInsets.symmetric(vertical: 12),
            child: ListTile(
              contentPadding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * 0.065),
              leading: Container(
                color: Colors.black26,
                width: MediaQuery.of(context).size.width * 0.15,
                child: GridView.builder(
                  itemCount: widget.orderProducts.length <= 4
                      ? widget.orderProducts.length
                      : 4,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 1.1,
                    crossAxisSpacing: 0,
                    mainAxisSpacing: 0,
                  ),
                  itemBuilder: (_, i) {
                    return Container(
                      decoration: BoxDecoration(
                        gradient: widget.orderProducts[i].product.gradient,
                      ),
                    );
                  },
                ),
              ),
              title: Text(
                '${widget.id}',
                style: TextStyle(fontSize: 24),
              ),
              subtitle:
                  Text('${DateFormat('MMM dd yyyy').format(widget.orderDate)}'),
              trailing: Column(
                children: <Widget>[
                  Text(
                    '${widget.orderProducts.fold(0, (val, item) => val + item.qty)} items',
                    style: TextStyle(fontSize: 16),
                  ),
                  Text(
                    '\$${widget.orderTotalPrice.toStringAsFixed(2)}',
                    style: TextStyle(fontSize: 24),
                  ),
                ],
              ),
            ),
          ),
        ),
        AnimatedContainer(
          duration: Duration(milliseconds: 500),
          height: _isExpanded ? widget.orderProducts.length * 72.0 : 0,
          curve: Curves.fastOutSlowIn,
          child: ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            itemCount: widget.orderProducts.length,
            itemBuilder: (_, i) => OrderSubItem(
              widget.orderProducts[i].product,
              widget.orderProducts[i].qty,
            ),
          ),
        ),
        Divider(
          height: 0,
        ),
      ],
    );
  }
}
