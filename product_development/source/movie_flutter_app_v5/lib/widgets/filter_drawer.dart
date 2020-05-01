import 'package:flutter/material.dart';

class MovieFilterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MovieFilterDrawer();
  }
}

class MovieFilterDrawer extends StatelessWidget {
  const MovieFilterDrawer({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      // Add a ListView to the drawer. This ensures the user can scroll
      // through the options in the drawer if there isn't enough vertical
      // space to fit everything.
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Text(
              'Filter movies',
              style: TextStyle(fontSize: 16),
            ),
            decoration: BoxDecoration(
              color: Colors.orange,
//              image: DecorationImage(
//                  image: AssetImage("assets/images/success.gif")),
            ),
          ),
          ListTile(
//            leading: Container(
//              child: Image.asset("assets/images/success.gif"),
//            ),
            title: Text('Latest releases'),
            onTap: () {
              // Update the state of the app
              // ...
              // Then close the drawer
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: Text("2000's movies"),
            onTap: () {
              // Update the state of the app
              // ...
              // Then close the drawer
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: Text("1990's movies"),
            onTap: () {
              // Update the state of the app
              // ...
              // Then close the drawer
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: Text("1980's movies"),
            onTap: () {
              // Update the state of the app
              // ...
              // Then close the drawer
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
