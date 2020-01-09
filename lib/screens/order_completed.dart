import 'package:flutter/material.dart';

class OrderCompleted extends StatelessWidget {
  static const routeName = '/order-completed';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              Icons.done,
              size: 180,
              color: Colors.green,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 72),
              child: Column(
                children: <Widget>[
                  Divider(
                    indent: 24,
                    endIndent: 24,
                    color: Theme.of(context).accentColor,
                  ),
                  Text(
                    'YOUR SHIT\'S ON THE WAY',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  Text(
                    'chill the fuck down now. You\'ll get your jumble soon.',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 24),
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  FlatButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(32),
                    ),
                    color: Colors.lightGreen,
                    onPressed: () => Navigator.of(context).popUntil(ModalRoute.withName('/')),
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Text(
                        'GO HOME',
                        style: TextStyle(
                          fontWeight: FontWeight.w900,
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
