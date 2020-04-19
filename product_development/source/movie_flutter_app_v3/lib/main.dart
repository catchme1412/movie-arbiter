import 'package:flutter/material.dart';
import 'package:movie_flutter_app_v3/widgets/movie_card.dart';
import 'package:movie_flutter_app_v3/widgets/movie_listing.dart';

import 'theme/dark.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: DARK_THEME,
      home: MovieListingPage(
//        movieCards: null,
          ),
    );
  }
}

class MovieListingPage extends StatefulWidget {
  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  @override
  _MovieListingPageState createState() => _MovieListingPageState();
}

class _MovieListingPageState extends State<MovieListingPage> {
  List<MovieCard> movieCards = MovieCards().getLatestMoviesSync();

  @override
  void initState() {
    super.initState();

    setState(() {
      initLoadMovies();
    });
  }

  Future<void> initLoadMovies() async {
    movieCards = await MovieCards().getLatestMovies();
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.

    return SafeArea(
      child: Scaffold(
//      appBar: AppBar(
//        // Here we take the value from the MyHomePage object that was created by
//        // the App.build method, and use it to set our appbar title.
//        title: Text(widget.title),
//      ),
        body: Center(
            // Center is a layout widget. It takes a single child and positions it
            // in the middle of the parent.
            child: GridView.count(
          primary: false,
          padding: const EdgeInsets.all(10),
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          crossAxisCount: 2,
          children: movieCards,
        )),
        bottomNavigationBar: BottomNavigationBar(
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
          ],
        ),
      ),
    );
  }
}
