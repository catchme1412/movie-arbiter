import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/album.dart';

class MovieService {
  String youtubeIdSelected;

  List<Album> albums;

  static const String url = "http://movie-arbiter.herokuapp.com/search";

  static const String latestMovies =
      "https://raw.githubusercontent.com/catchme1412/movie-arbiter/master/latest-movies.json";

  Future<List<Album>> getPhotos() async {
    try {
      print("Try to get the latest movies...");
      http.Response response = await http.get(url);
      if (response.statusCode == 200) {
        albums = parsePhotos(response.body);
        print("Returning the phtos");
        return albums;
      } else {
        throw Exception("Error");
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<List<Album>> filter() async {
    try {
      if (albums == null) {
        http.Response response = await http.get(latestMovies);
        if (response.statusCode != 200) {
          throw Exception("Error");
        }
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<List<Album>> getLatestMovies() async {
    try {
      print("Try to get the latest movies...");
      if (albums != null) {
        return albums;
      }
      http.Response response = await http.get(latestMovies);
      if (response.statusCode == 200) {
//        String json = response.body;
//        print(json);
        albums = parsePhotos(response.body);
        print("Returning the phtos");
        return albums;
      } else {
        throw Exception("Error");
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  static List<Album> parsePhotos(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<Album>((json) => Album.fromJson(json)).toList();
  }
}
