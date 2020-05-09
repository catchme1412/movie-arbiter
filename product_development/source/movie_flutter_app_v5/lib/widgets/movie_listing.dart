import 'package:MovieArbiter/context/movie_app_context.dart';
import 'package:MovieArbiter/widgets/page_footer.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';

import '../models/album.dart';
import '../services/movie_service.dart';
import 'filter_drawer.dart';
import 'movie_card.dart';

class MovieListingPage extends StatefulWidget {
  final MovieAppContext movieAppContext = MovieAppContext.getInstance();

  MovieListingPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MovieListingPage> {
  List<MovieCard> _movies = [];

  String errorMessage = "";
  bool isError = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkConnectivity();
    getMovies();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.deactivate();
    super.dispose();
  }

  void getMovies() async {
    try {
      List<MovieCard> movies =
          await widget.movieAppContext.getMovieCardListView().getLatestMovies();
      setState(() {
        _movies.addAll(movies);
      });
    } catch (e) {
      errorMessage = e.toString();
      print(e);

      isError = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    print("Build UI $_movies");

    if (isError) {
      return Scaffold(
        backgroundColor: Colors.deepOrange,
        endDrawer: MovieFilterDrawer(),
        body: Center(
          child: Text('Oops, please check your internet connectivity!'),
        ),
        bottomNavigationBar: PageFooterBar(),
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
                    endDrawer: MovieFilterDrawer(),
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
//                return FittedBox(
//                  child: Image.asset(
//                    "assets/images/loader-4.gif",
//                  ),
//                  fit: BoxFit.fill,
//                );
//                return Container(
//                  color: Colors.blueGrey[900],
//                  child: Column(
//                    children: <Widget>[
//                      Image.asset(
//                        "assets/images/loading-2.gif",
//                      ),
//                      Text(""),
//                      Text("Loading..."),
//                    ],
//                  ),
//                );
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

class MovieCardListView {
  final MovieService movieService;

  MovieCardListView(this.movieService);

  Future<List<MovieCard>> getLatestMovies() async {
    List<Album> albums = await movieService.getLatestMovies();

    List<MovieCard> movies = <MovieCard>[];
    for (Album a in albums) {
      movies.add(
        MovieCard(
          album: a,
        ),
      );
    }

    return movies;
  }

  List<MovieCard> getLatestMoviesSync() {
    Album album = Album();
    album.title = "...";
    album.url = "";
    album.thumbnailUrl = 'https://placehold.it/200x250/606060/606060&text=%20';
    List<MovieCard> movies = <MovieCard>[];
    for (int i = 0; i < 6; i++) {
      movies.add(MovieCard(
        album: album,
      ));
    }

    return movies;
  }
}
