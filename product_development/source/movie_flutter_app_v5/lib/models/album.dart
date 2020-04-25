class Album {
  int albumId;
  int id;
  String title;
  String url;
  String thumbnailUrl;
  String youtubeUrl;

  String imdbRating;

  Album(
      {this.albumId,
      this.id,
      this.title,
      this.url,
      this.thumbnailUrl,
      this.youtubeUrl,
      this.imdbRating});

  // Return object from JSON //
  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
        albumId: json['albumId'] as int,
        id: json['id'] as int,
        title: json['title'] as String,
        url: json['url'] as String,
        thumbnailUrl: json['thumbnailUrl'] as String,
        youtubeUrl: json['youtubeUrl'] as String,
        imdbRating: json['imdbRating'] as String);
  }
}
