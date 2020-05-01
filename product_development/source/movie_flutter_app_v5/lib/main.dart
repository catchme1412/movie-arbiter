import 'package:MovieArbiter/widgets/landing_page.dart';
import 'package:MovieArbiter/widgets/movie_listing.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import './services/navigation_observer.dart';
import './widgets/share_intent_receive.dart';
import 'context/movie_app_config.dart';
import 'context/movie_app_context.dart';
import 'theme/dark.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final PreviousRouteObserver observer = PreviousRouteObserver();

  final MovieAppConfig movieAppConfig = MovieAppConfig();

  final MovieAppContext movieAppContext = MovieAppContext.getInstance();

  MyApp() {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  }
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      initialRoute: initialRoutePlanner(movieAppContext),
//      routes: {
//        // When navigating to the "/" route, build the FirstScreen widget.
//        '/': (context) => LandingPage(),
//        // When navigating to the "/second" route, build the SecondScreen widget.
//        '/second': (context) => MyHomePage(),
//      },
      routes: <String, WidgetBuilder>{
        "/home": (BuildContext context) => MovieListingPage(title: ''),
        "/error": (BuildContext context) => ErrorPage(),
        "/add": (BuildContext context) => MovieShareReceiver(),
        "/": (context) => movieAppContext.isMovieSharedFromYoutube()
            ? MovieShareReceiver()
            : LandingPage(movieAppContext: movieAppContext),
        //add more routes here
      },
      theme: DARK_THEME,
      navigatorObservers: [
        observer,
      ],
    );
  }

  String initialRoutePlanner(MovieAppContext movieAppContext) {
    return "/";
  }
}

class ErrorPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
        child: Center(child: Text("Oops, Please check your connectivity!")));
  }
}
