import 'dart:convert';

import 'package:http/http.dart' as http;

import 'album.dart';

class Services {
  static String youtubeIdSelected;

  static const String url = "http://movie-arbiter.herokuapp.com/search";

  static const String latestMovies =
      "https://raw.githubusercontent.com/catchme1412/movie-arbiter/master/latest-movies.json";

  static Future<List<Album>> getPhotos() async {
    try {
      http.Response response = await http.get(url);
      if (response.statusCode == 200) {
        List<Album> list = parsePhotos(response.body);
        print("Returning the phtos");
        return list;
      } else {
        throw Exception("Error");
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  static Future<List<Album>> getLatest() async {
    try {
      http.Response response = await http.get(latestMovies);
      if (response.statusCode == 200) {
        String json = response.body;
        print(json);
        List<Album> list = parsePhotos(response.body);
        print("Returning the phtos");
        return list;
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
