import '../services/connectivity_check.dart';
import '../services/movie_service.dart';
import '../widgets/movie_listing.dart';

class MovieAppContext {
  MovieService movieService;
  MovieCardListView movieCardListView;
  ConnectionStatusSingleton connectionStatus;
  bool isMovieShared = false;
  MovieAppContext() {
    movieService = MovieService();
    movieCardListView = MovieCardListView(movieService);
    connectionStatus = ConnectionStatusSingleton.getInstance();
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
    return isMovieShared;
  }

  void setMovieShared(bool flag) {
    isMovieShared = flag;
  }
}
