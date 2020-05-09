import 'dart:async';

import 'package:receive_sharing_intent/receive_sharing_intent.dart';

import '../services/connectivity_check.dart';
import '../services/movie_service.dart';
import '../widgets/movie_listing.dart';

class MovieAppContext {
  MovieService movieService;
  MovieCardListView movieCardListView;
  ConnectionStatusSingleton connectionStatus;
  bool _isMovieShared = false;

  StreamSubscription _intentDataStreamSubscription;
  List<SharedMediaFile> _sharedFiles;

  MovieAppContext() {
    movieService = MovieService();
    movieCardListView = MovieCardListView(movieService);
    connectionStatus = ConnectionStatusSingleton.getInstance();
    connectionStatus.connectionChange.listen(connectionChanged);
  }

  void connectionChanged(dynamic hasConnection) {
    print("Internet:" + hasConnection);
  }

  //This creates the single instance by calling the `_internal` constructor specified below
  static final MovieAppContext _singleton = new MovieAppContext();
//  MovieAppContext._internal();

  static MovieAppContext getInstance() => _singleton;
  MovieService getMovieService() {
    return movieService;
  }

  MovieCardListView getMovieCardListView() {
    return movieCardListView;
  }

  ConnectionStatusSingleton getConnectionStatus() {
    return connectionStatus;
  }

  bool isMovieSharedFromYoutube() {
    // For sharing images coming from outside the app while the app is in the memory
    _intentDataStreamSubscription = ReceiveSharingIntent.getMediaStream()
        .listen((List<SharedMediaFile> value) {
//      setState(() {
      print("Shared:" + (_sharedFiles?.map((f) => f.path)?.join(",") ?? ""));
      _sharedFiles = value;
    });

    // For sharing images coming from outside the app while the app is closed
    ReceiveSharingIntent.getInitialMedia().then((List<SharedMediaFile> value) {
//      setState(() {
      _sharedFiles = value;
    });
//    }
//    );

    return _isMovieShared ? _sharedFiles != null : false;
  }

  void setMovieShared(bool flag) {
    _isMovieShared = flag;
  }
}
