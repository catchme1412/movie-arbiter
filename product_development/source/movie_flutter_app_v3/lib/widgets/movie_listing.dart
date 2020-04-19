import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'album.dart';
import 'movie_card.dart';
import 'movie_service.dart';

class MovieCards {
  Future<List<Widget>> getLatestMovies() async {
    List<Album> albums = await MovieService.getLatestMovies();

    List<MovieCard> movies = <MovieCard>[];
    for (Album a in albums) {
      movies.add(MovieCard(a));
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
      movies.add(MovieCard(album));
    }

    return movies;
  }
}
