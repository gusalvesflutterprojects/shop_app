import 'package:flutter/material.dart';

class NothingToDisplay extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;

  NothingToDisplay({this.icon, this.title, this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    icon,
                    size: 180,
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
                          title.toUpperCase(),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        Text(
                          subtitle,
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 24),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
  }
}