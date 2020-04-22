import 'package:flutter/cupertino.dart';

class PreviousRouteObserver extends NavigatorObserver {
  Route _previousRoute;

  Route get previousRoute => _previousRoute;
  String get previousRouteName => _previousRoute.settings.name;

  @override
  void didPush(Route<dynamic> route, Route<dynamic> previousRoute) {
    _previousRoute = previousRoute;
  }

  @override
  void didReplace({Route<dynamic> newRoute, Route<dynamic> oldRoute}) {
    _previousRoute = oldRoute;
  }
}
