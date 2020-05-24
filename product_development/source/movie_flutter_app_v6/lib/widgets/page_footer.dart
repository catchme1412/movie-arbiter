import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie_flutter_app_v6/context/movie_app_context.dart';

import 'movie_contribute.dart';
import 'movie_listing_page.dart';
import 'movie_search_page.dart';

class PageFooterBar extends StatefulWidget {
  @override
  _BottomNaviationState createState() => _BottomNaviationState();
}

class _BottomNaviationState extends State<PageFooterBar> {
  int pushCount = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: BottomNavigationBar(
        showSelectedLabels: true,
        currentIndex: MovieAppContext.getInstance().getBottomNavigationIndex(),
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey,
        onTap: (int index) {
          print("Set state..............................................");
          MovieAppContext.getInstance().setBottomNavigationIndex(index);

          print("Selected $index");

//          final snackBar =
//              SnackBar(content: Image.asset("assets/images/small.png"));
//
//// Find the Scaffold in the widget tree and use it to show a SnackBar.
//          Scaffold.of(context).showSnackBar(snackBar);
//          while (pushCount >= 0) {
//            Navigator.of(context).pop();
//            print("LOOOOOP $pushCount");
//            pushCount--;
//          }
//          pushCount++;
          switch (index) {
            case 0:
              Navigator.pushNamedAndRemoveUntil(
                  context, MovieListingPage.ROUTE, (r) => false);
//              Navigator.push(
//                  context,
//                  new MaterialPageRoute(
//                      builder: (context) => new MovieListingPage()));
              break;
            case 1:
              Navigator.pushNamedAndRemoveUntil(
                  context, SearchList.ROUTE, (r) => false);
//              Navigator.push(
//                  context,
//                  new MaterialPageRoute(
//                      builder: (context) => new SearchList()));
//              Scaffold.of(context).openEndDrawer();
              break;
            case 2:
              Navigator.pushNamedAndRemoveUntil(
                  context, MovieContribute.ROUTE, (r) => false);
//              Navigator.push(
//                  context,
//                  new MaterialPageRoute(
//                      builder: (context) => new MovieContribute()));
              break;
          }
        },
        backgroundColor: Colors.black87,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('Home'),
          ),

          BottomNavigationBarItem(
            icon: Icon(
              Icons.search,
//              color: Colors.white,
            ),
            title: Text('Search'),
          ),
//          BottomNavigationBarItem(
//            icon: Icon(
//              Icons.dehaze,
//              color: Colors.white,
//            ),
//            title: Text(
//              'Filter',
//              style: TextStyle(color: Colors.white),
//            ),
//          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.add_to_photos,
//              color: Colors.white,
            ),
            title: Text(
              'Contribute',
//              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}

//class PageFooterBar extends StatelessWidget {
//  @override
//  Widget build(BuildContext context) {
//    return Container(
//      child: BottomNavigationBar(
//        showSelectedLabels: true,
//        selectedItemColor: Colors.white,
//        unselectedItemColor: Colors.amber,
//        onTap: (int index) {
//          print("Selected $index");
//
////          final snackBar =
////              SnackBar(content: Image.asset("assets/images/small.png"));
////
////// Find the Scaffold in the widget tree and use it to show a SnackBar.
////          Scaffold.of(context).showSnackBar(snackBar);
//          switch (index) {
//            case 0:
//              Navigator.push(
//                  context,
//                  new MaterialPageRoute(
//                      builder: (context) => new MovieListingPage()));
//              break;
//            case 1:
//              Navigator.push(
//                  context,
//                  new MaterialPageRoute(
//                      builder: (context) => new SearchList()));
////              Scaffold.of(context).openEndDrawer();
//              break;
//            case 2:
//              Navigator.push(
//                  context,
//                  new MaterialPageRoute(
//                      builder: (context) => new MovieContribute()));
//              break;
//          }
//        },
//        backgroundColor: Colors.black87,
//        items: const <BottomNavigationBarItem>[
//          BottomNavigationBarItem(
//            icon: Icon(Icons.home),
//            title: Text('Home'),
//          ),
//
//          BottomNavigationBarItem(
//            icon: Icon(
//              Icons.search,
////              color: Colors.white,
//            ),
//            title: Text('Search'),
//          ),
////          BottomNavigationBarItem(
////            icon: Icon(
////              Icons.dehaze,
////              color: Colors.white,
////            ),
////            title: Text(
////              'Filter',
////              style: TextStyle(color: Colors.white),
////            ),
////          ),
//          BottomNavigationBarItem(
//            icon: Icon(
//              Icons.add_to_photos,
////              color: Colors.white,
//            ),
//            title: Text(
//              'Contribute',
////              style: TextStyle(color: Colors.white),
//            ),
//          ),
//        ],
//      ),
//    );
//  }
//}
