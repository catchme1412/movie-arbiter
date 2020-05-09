import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie_flutter_app_v6/widgets/movie_listing_page.dart';

class MovieNavigator {
  static void navigate(BuildContext context, String route) {
    Widget widget;

    switch (route) {
      case MovieListingPage.ROUTE:
        widget = MovieListingPage();
        break;
    }

    Navigator.push(
        context, new MaterialPageRoute(builder: (context) => widget));
  }
}
