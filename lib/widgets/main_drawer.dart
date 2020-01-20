import 'package:flutter/material.dart';

class MainDrawer extends StatelessWidget {
  Widget _buildDrawerTile(
    String title,
    String subtitle,
    IconData icon,
    Function navigation,
  ) =>
      Column(
        children: <Widget>[
          ListTile(
            contentPadding: EdgeInsets.all(12),
            leading: Icon(
              icon,
              size: 32,
            ),
            title: Text(
              title,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w400,
              ),
            ),
            subtitle: Text(subtitle),
            onTap: navigation,
          ),
          Divider(
            height: 0,
          ),
        ],
      );

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          DrawerHeader(
            margin: EdgeInsets.zero,
            decoration: BoxDecoration(color: Theme.of(context).accentColor),
            child: Container(
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  ListTile(
                    leading: Icon(
                      Icons.tag_faces,
                      size: 48,
                    ),
                    title: Text(
                      'Go buy yourself some shit',
                      style: TextStyle(
                        fontSize: 24,
                        fontFamily: 'OpenSans',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    subtitle: Text(
                      'I mean it. I kidnapped your mom.',
                      style: TextStyle(
                        fontSize: 14,
                        fontFamily: 'Nunito',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          _buildDrawerTile(
            'Shop',
            'Go buy yourself some stuff',
            Icons.shopping_cart,
            () => Navigator.of(context).pushReplacementNamed('/'),
          ),
          _buildDrawerTile(
            'Orders',
            'Your shit\'s here',
            Icons.shopping_basket,
            () => Navigator.of(context).pushReplacementNamed('/my-orders'),
          ),
          _buildDrawerTile(
            'Manage products',
            'Manage your crap',
            Icons.more,
            () => Navigator.of(context).pushReplacementNamed('/user-products'),
          ),
        ],
      ),
    );
  }
}
