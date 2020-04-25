import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';

import './services/navigation_observer.dart';
import './widgets/movie_card.dart';
import './widgets/share_intent_receive.dart';
import 'context/movie_app_config.dart';
import 'context/movie_app_context.dart';
import 'theme/dark.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final PreviousRouteObserver observer = PreviousRouteObserver();

  final MovieAppConfig movieAppConfig = MovieAppConfig();

  final MovieAppContext movieAppContext = MovieAppContext();

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
        "/home": (BuildContext context) =>
            MovieListingPage(title: '', movieAppContext: movieAppContext),
        "/error": (BuildContext context) => ErrorPage(),
        "/add": (BuildContext context) => MovieShareReceiver(),
        "/": (context) => LandingPage(movieAppContext: movieAppContext),
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

class LandingPage extends StatelessWidget {
  final MovieAppContext movieAppContext;

  const LandingPage({Key key, this.movieAppContext}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Movie Arbiter'),
      ),
      body: Column(
        children: <Widget>[
          Text(
            "",
            style: TextStyle(fontSize: 60),
          ),
          Text(
            "",
            style: TextStyle(fontSize: 60),
          ),
          Text(
            "Watch Youtube movies",
            style: TextStyle(fontSize: 25),
          ),
          Text(
            "",
            style: TextStyle(fontSize: 60),
          ),
          Text(
            "",
            style: TextStyle(fontSize: 60),
          ),
          Center(
            child: RaisedButton(
              child: Text(
                'Start',
                style: TextStyle(fontSize: 20),
              ),
              onPressed: () {
                // Navigate to the second screen when tapped.

                Navigator.pushNamed(context, '/home');
              },
            ),
          ),
        ],
      ),
    );
  }
}

class MovieListingPage extends StatefulWidget {
  final MovieAppContext movieAppContext;

  MovieListingPage({Key key, this.title, this.movieAppContext})
      : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MovieListingPage> {
  int _counter = 0;

  List<MovieCard> _movies = [];

  bool isError = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkConnectivity();
    getMovies();
  }

  void getMovies() async {
    try {
      List<MovieCard> movies =
          await widget.movieAppContext.getMovieCardListView().getLatestMovies();
      setState(() {
        _movies.addAll(movies);
      });
    } catch (e) {
      isError = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    print("Build UI $_movies");
    if (isError) {
      return SafeArea(
        child: Scaffold(
          backgroundColor: Colors.deepOrange,
          body: Center(
            child: Text('Oops, please check your internet connectivity!'),
          ),
          bottomNavigationBar: PageFooterBar(),
        ),
      );
    }
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
        body: FutureBuilder<List<MovieCard>>(
            future: widget.movieAppContext
                .getMovieCardListView()
                .getLatestMovies(), //returns bool

            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                // YOUR CUSTOM CODE GOES HERE
                return SafeArea(
                  child: Scaffold(
                    body: Center(
                        // Center is a layout widget. It takes a single child and positions it
                        // in the middle of the parent.
                        child: GridView.count(
                      primary: false,
                      padding: const EdgeInsets.all(10),
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      crossAxisCount: 2,
                      children: _movies,
                    )),
                    bottomNavigationBar: PageFooterBar(),
                  ),
                );
              } else {
                return Center(child: CircularProgressIndicator());
              }
            }));
  }

  void checkConnectivity() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      // I am connected to a mobile network.
    } else if (connectivityResult == ConnectivityResult.wifi) {
      // I am connected to a wifi network.
    } else {
      Navigator.pushNamed(context, '/error');
    }
  }
}

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
          switch (index) {
            case 0:
              Navigator.pushNamed(context, "/home");
              break;
            case 2:
              Navigator.pushNamed(context, "/add");
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
              'Add',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
