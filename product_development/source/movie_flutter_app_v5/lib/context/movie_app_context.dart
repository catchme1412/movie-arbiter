import '../services/connectivity_check.dart';
import '../services/movie_service.dart';
import '../widgets/movie_listing.dart';

class MovieAppContext {
  MovieService movieService;
  MovieCardListView movieCardListView;
  ConnectionStatusSingleton connectionStatus;
  MovieAppContext() {
    movieService = MovieService();
    movieCardListView = MovieCardListView(movieService);
    connectionStatus = ConnectionStatusSingleton.getInstance();
  }
  MovieService getMovieService() {
    return movieService;
  }

  MovieCardListView getMovieCardListView() {
    return movieCardListView;
  }

  ConnectionStatusSingleton getConnectionStatus() {
    return connectionStatus;
  }
}
