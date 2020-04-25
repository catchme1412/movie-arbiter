import 'package:flutter/material.dart';

import 'album.dart';

class MovieCard extends StatelessWidget {
  final Album album;
  MovieCard({this.album});

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      child: Stack(
        children: <Widget>[
          Container(
            alignment: Alignment.center,
            child: FadeInImage.assetNetwork(
              image: album.thumbnailUrl,
//              image:
//                  'https://i.pinimg.com/originals/37/09/13/370913b22a14ae524c199fdbf1f1a9e2.jpg',
              placeholder: "assets/images/no_image.png",
              height: 250,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Container(
              alignment: Alignment.bottomCenter,
              child: Opacity(
                opacity: .9,
                child: Container(
                  width: double.infinity,
                  color: Colors.blueGrey[900],
//
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(8, 4, 8, 2),
                    child: Text(
                      album.title,
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 12.0,
                        backgroundColor: Colors.blueGrey[900],
                      ),
                    ),
                  ),
                ),
              )),
        ],
      ),
      onPressed: () {
        print("Selected: " + album.title);
        if (album.url.contains("youtube")) {
          print("uuuuuuu");
//          Navigator.push(
//            context,
//            MaterialPageRoute(
//              builder: (context) => SecondRoute(
//                youtubeAlbum: album,
//              ),
//            ),
//          );
        }
      },
    );
  }
}

class FirstRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('First Route'),
      ),
      body: Center(
        child: RaisedButton(
          child: Text('Open route'),
          onPressed: () {
            // Navigate to second route when tapped.
          },
        ),
      ),
    );
  }
}

class SecondRoute extends StatelessWidget {
  SecondRoute({this.youtubeAlbum});
  final Album youtubeAlbum;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: RaisedButton(
          onPressed: () {
            // Navigate back to first route when tapped.
          },
          child: Text('Go back!'),
        ),
      ),
    );
  }
}
