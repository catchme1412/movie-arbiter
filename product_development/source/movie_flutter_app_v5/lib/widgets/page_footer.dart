import 'package:MovieArbiter/widgets/share_intent_receive.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'filter_drawer.dart';
import 'movie_listing.dart';

class PageFooterBar extends StatelessWidget {
  const PageFooterBar({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: BottomNavigationBar(
        onTap: (int index) {
          print("Selected $index");
//          final snackBar =
//              SnackBar(content: Image.asset("assets/images/small.png"));
//
//// Find the Scaffold in the widget tree and use it to show a SnackBar.
//          Scaffold.of(context).showSnackBar(snackBar);
          switch (index) {
            case 0:
              Navigator.push(
                  context,
                  new MaterialPageRoute(
                      builder: (context) => new MovieListingPage()));
              break;
            case 1:
              Navigator.push(
                  context,
                  new MaterialPageRoute(
                      builder: (context) => new MovieFilterPage()));
//              Scaffold.of(context).openEndDrawer();
              break;
            case 2:
              Navigator.push(
                  context,
                  new MaterialPageRoute(
                      builder: (context) => new MovieShareReceiver()));
              break;
          }
        },
        backgroundColor: Colors.black87,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('Home'),
          ),

//          BottomNavigationBarItem(
//            icon: Icon(
//              Icons.search,
//              color: Colors.white,
//            ),
//            title: Text('Search'),
//          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.dehaze,
              color: Colors.white,
            ),
            title: Text(
              'Filter',
              style: TextStyle(color: Colors.white),
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.add_to_photos,
              color: Colors.white,
            ),
            title: Text(
              'Contribute',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
