import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:movie_flutter_app_v6/context/movie_app_context.dart';
import 'package:movie_flutter_app_v6/theme/dark.dart';
import 'package:movie_flutter_app_v6/widgets/movie_listing_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../navigation.dart';

class LandingPage extends StatefulWidget {
  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  static const ROUTE = "landing-page";

  SharedPreferences sharedPreferences;
  bool isLoggedIn = false;
  String userName;

//  final MovieAppContext movieAppContext;

//  const LandingPage({Key key, this.movieAppContext}) : super(key: key);

  GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: ['email'],
  );

  _login() async {
    try {
      GoogleSignInAccount googleSignInAccount = await _googleSignIn.signIn();
      setState(() {
        isLoggedIn = true;
        print("LOGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGG");
        sharedPreferences.setBool(MovieAppContext.IS_LOGGED_IN, true);
        sharedPreferences.setString(
            MovieAppContext.USER_NAME, googleSignInAccount.displayName);
        print(googleSignInAccount.displayName);
        MovieNavigator.navigate(context, MovieListingPage.ROUTE);
      });
    } catch (err) {
      print(err);
    }
  }

  _logout() async {
    try {
      await _googleSignIn.signOut();
      print("LOGGED OUT");
      isLoggedIn = false;
      sharedPreferences.setBool(MovieAppContext.IS_LOGGED_IN, false);
    } catch (err) {
      print(err);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
//    _logout();
    init();
  }

  void init() async {
    sharedPreferences = await SharedPreferences.getInstance();
    isLoggedIn =
        sharedPreferences.getBool(MovieAppContext.IS_LOGGED_IN) ?? false;
    userName = sharedPreferences.getString(MovieAppContext.USER_NAME) ?? "";
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: DARK_THEME,
      home: Scaffold(
        body: Center(
          child: Container(
            constraints: BoxConstraints.expand(),
            decoration: BoxDecoration(
              color: Colors.black,
              image: DecorationImage(
//                  colorFilter: ColorFilter.srgbToLinearGamma(),

                  colorFilter: new ColorFilter.mode(
                      Colors.black.withOpacity(0.5), BlendMode.dstATop),
                  image: AssetImage("assets/images/loading.gif"),
                  fit: BoxFit.cover),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Text(
                    'Best Youtube Movies',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.normal),
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Text(
                    'Watch, share and contribute',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.lightGreen,
                        fontSize: 14,
                        fontWeight: FontWeight.normal),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  buildLoginOrWelcomeSection(),
                  RaisedButton(
                    padding: EdgeInsets.all(8),
                    color: Colors.orange,
                    child: Text(
                      'Start',
                      style: TextStyle(fontSize: 16),
                    ),
                    onPressed: () {
                      // Navigate to the second screen when tapped.

                      MovieNavigator.navigate(context, MovieListingPage.ROUTE);
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildLoginOrWelcomeSection() {
    //If not logged in show login or skip
    // else show welcome message
    // and start button
    userName = sharedPreferences == null
        ? ""
        : sharedPreferences.getString(MovieAppContext.USER_NAME) ?? "";
    if (isLoggedIn) {
      return Column(
        children: <Widget>[
          Text(
            "Welcome back $userName!!",
            style: TextStyle(color: Colors.cyan),
          ),
          SizedBox(
            height: 20,
          ),
//          RaisedButton(
//            padding: EdgeInsets.all(8),
//            child: Text(
//              'Start',
//              style: TextStyle(fontSize: 16),
//            ),
//            onPressed: () {
//              // Navigate to the second screen when tapped.
//
//              MovieNavigator.navigate(context, MovieListingPage.ROUTE);
//            },
//          ),
        ],
      );
    } else {
      return Container();
//      return Column(
//        children: <Widget>[
//          RaisedButton(
//            padding: EdgeInsets.only(top: 3.0, bottom: 3.0, left: 3.0),
//            color: const Color(0xFF4285F4),
//            onPressed: () {
//              _login();
//            },
//            child: new Row(
//              mainAxisSize: MainAxisSize.min,
//              children: <Widget>[
//                new Image.asset(
//                  'assets/images/google.png',
//                  height: 48.0,
//                ),
//                new Container(
//                    padding: EdgeInsets.only(left: 10.0, right: 10.0),
//                    child: new Text(
//                      "Sign in with Google",
//                      style: TextStyle(
//                          color: Colors.white, fontWeight: FontWeight.bold),
//                    )),
//              ],
//            ),
//          ),
//          SizedBox(
//            height: 10,
//          ),
//          Text("Get notified about new movies by signin using Google"),
//          SizedBox(
//            height: 10,
//          ),
//          RaisedButton(
//            padding: EdgeInsets.only(top: 3.0, bottom: 3.0, left: 3.0),
//            color: const Color(0x2a2a2a),
//            onPressed: () {
//              MovieNavigator.navigate(context, MovieListingPage.ROUTE);
//            },
//            child: new Row(
//              mainAxisSize: MainAxisSize.min,
//              children: <Widget>[
//                new Container(
//                    padding: EdgeInsets.only(left: 10.0, right: 10.0),
//                    child: new Text(
//                      "Skip Sign-In for now",
//                      style: TextStyle(
//                          color: Colors.blueGrey[700],
//                          fontWeight: FontWeight.normal),
//                    )),
//              ],
//            ),
//          ),
//          SizedBox(
//            height: 50,
//          )
//        ],
//      );
    }
  }

//class LandingPage extends StatelessWidget {
//  static const ROUTE = "landing-page";
//
//  final MovieAppContext movieAppContext;
//
//  const LandingPage({Key key, this.movieAppContext}) : super(key: key);
//
//  @override
//  Widget build(BuildContext context) {
//    return MaterialApp(
//      debugShowCheckedModeBanner: false,
//      theme: DARK_THEME,
//      home: Scaffold(
//        body: Center(
//          child: Container(
//            constraints: BoxConstraints.expand(),
//            decoration: BoxDecoration(
//              color: Colors.black,
//              image: DecorationImage(
////                  colorFilter: ColorFilter.srgbToLinearGamma(),
//
//                  colorFilter: new ColorFilter.mode(
//                      Colors.black.withOpacity(0.5), BlendMode.dstATop),
//                  image: AssetImage("assets/images/loading.gif"),
//                  fit: BoxFit.cover),
//            ),
//            child: Center(
//              child: Column(
//                mainAxisAlignment: MainAxisAlignment.end,
//                children: <Widget>[
//                  Text(
//                    'Best Youtube Movies',
//                    textAlign: TextAlign.center,
//                    style: TextStyle(
//                        color: Colors.white,
//                        fontSize: 20,
//                        fontWeight: FontWeight.normal),
//                  ),
//                  SizedBox(
//                    height: 20,
//                  ),
//                  buildLoginOrWelcomeSection(),
//                  RaisedButton(
//                    padding: EdgeInsets.all(8),
//                    color: Colors.orange,
//                    child: Text(
//                      'Start',
//                      style: TextStyle(fontSize: 16),
//                    ),
//                    onPressed: () {
//                      // Navigate to the second screen when tapped.
//
//                      MovieNavigator.navigate(context, MovieListingPage.ROUTE);
//                    },
//                  ),
//                  SizedBox(
//                    height: 20,
//                  ),
//                ],
//              ),
//            ),
//          ),
//        ),
//      ),
//    );
//  }
//
//  Widget buildLoginOrWelcomeSection() {
//    //If not logged in show login or skip
//    // else show welcome message
//    // and start button
//    return Text('ff');
//  }
}
