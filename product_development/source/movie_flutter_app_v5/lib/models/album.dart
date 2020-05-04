class Album {
  int albumId;
  int id;
  String title;
  String url;
  String thumbnailUrl;
  String youtubeUrl;
  String releaseDate;
  String imdbRating;
  List<dynamic> urlList;

  Album(
      {this.albumId,
      this.id,
      this.title,
      this.url,
      this.thumbnailUrl,
      this.youtubeUrl,
      this.imdbRating,
      this.releaseDate,
      this.urlList});

  // Return object from JSON //
  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
        albumId: json['albumId'] as int,
        id: json['id'] as int,
        title: json['title'] as String,
        url: json['url'] as String,
        thumbnailUrl: json['thumbnailUrl'] as String,
        youtubeUrl: json['youtubeUrl'] as String,
        imdbRating: json['imdbRating'] as String,
        releaseDate: json['releaseDate'] as String,
        urlList: json['urlList'] as List<dynamic>);
  }
}
