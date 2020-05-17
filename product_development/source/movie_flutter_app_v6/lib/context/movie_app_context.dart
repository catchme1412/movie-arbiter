import '../services/connectivity_check.dart';
import '../services/movie_service.dart';
import '../widgets/movie_listing_page.dart';

class MovieAppContext {
  MovieService movieService;
  MovieCardListView movieCardListView;
  ConnectionStatusSingleton connectionStatus;

  int bottomNavigationIndex;
//  StreamSubscription connectionChangeStream;

  MovieAppContext() {
    bottomNavigationIndex = 0;
    movieService = MovieService();
    movieCardListView = MovieCardListView(movieService);
    connectionStatus = ConnectionStatusSingleton.getInstance();
//    connectionChangeStream =
    connectionStatus.connectionChange.listen(connectionChanged);
  }

  void connectionChanged(dynamic hasConnection) {
    print("==================================>Offline :" + hasConnection);
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

  void setBottomNavigationIndex(int index) {
    bottomNavigationIndex = index;
  }

  int getBottomNavigationIndex() {
    return bottomNavigationIndex;
  }
}
