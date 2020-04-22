import '../models/album.dart';
import '../services/movie_service.dart';
import 'movie_card.dart';

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
