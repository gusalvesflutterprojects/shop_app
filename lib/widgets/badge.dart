import 'package:flutter/material.dart';

class Badge extends StatelessWidget {
  const Badge({
    Key key,
    @required this.value,
    @required this.icon,
    this.color,
  }) : super(key: key);

  final int value;
  final Icon icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(
          '/shopping-cart',
        );
      },
      child: Stack(
        alignment: Alignment.center,
        overflow: Overflow.visible,
        children: [
          icon,
          Positioned(
            top: 8,
            right: -8,
                      child: CircleAvatar(
              backgroundColor:
                  color != null ? color : Theme.of(context).accentColor,
              radius: 10,
              child: Text(
                value.toString(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
