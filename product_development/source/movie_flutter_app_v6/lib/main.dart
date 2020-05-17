import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:movie_flutter_app_v6/context/movie_app_context.dart';
import 'package:movie_flutter_app_v6/widgets/error_page.dart';

import './theme/dark.dart';
import './widgets/intent-receiver_and_landing_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  MovieAppContext.getInstance().getMovieService().getLatestMovies();
  runApp(MyApp());
  FlutterError.onError = (FlutterErrorDetails details) {
    print("=================== CAUGHT FLUTTER ERROR");
// Send report
  };
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Movie Arbiter',
        theme: DARK_THEME,
        home: LandingPageDecisionMaker(),
        routes: <String, WidgetBuilder>{
          "error": (BuildContext context) => ErrorPage(),
        }
        //add more routes here
        );
  }
}
