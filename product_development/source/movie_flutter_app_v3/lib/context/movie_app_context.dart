import '../services/movie_service.dart';
import '../widgets/movie_listing.dart';

class MovieAppContext {
  MovieService movieService;
  MovieCardListView movieCardListView;

  MovieAppContext() {
    movieService = MovieService();
    movieCardListView = MovieCardListView(movieService);
  }
  MovieService getMovieService() {
    return movieService;
  }

  MovieCardListView getMovieCardListView() {
    return movieCardListView;
  }
}
