import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../models/album.dart';
import '../widgets/webpage.dart';
import '../widgets/youtube_player.dart';

class MovieCard extends StatelessWidget {
  final Album album;
  MovieCard({this.album});
  @override
  Widget build(BuildContext context) {
    return FlatButton(
      child: Stack(
        children: <Widget>[
          MovieCardImageSection(album: album),
          MovieTitleSectionInCard(album: album),
        ],
      ),
      onPressed: () {
        print("Selected: " + album.title);
//        SnackBar snackbar = SnackBar(
//          content: Text("Loading..."),
//        );
//
//        Scaffold.of(context).showSnackBar(snackbar);
        if (album.url.contains("youtube")) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => YoutubeVideoPage(
                album,
              ),
            ),
          );
        } else {
//          print(album.url);

          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => WebViewPage(album),
            ),
          );
        }
      },
    );
  }
}

class MovieCardImageSection extends StatelessWidget {
  const MovieCardImageSection({
    Key key,
    @required this.album,
  }) : super(key: key);

  final Album album;

  @override
  Widget build(BuildContext context) {
    return Stack(
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
          padding: EdgeInsets.all(2),
          child: Opacity(
            opacity: 0.8,
            child: CircleAvatar(
              backgroundImage: AssetImage("assets/images/award-yellow.png"),
//                    backgroundColor: Colors.orange,
              backgroundColor: Colors.transparent,
              radius: 14,
              child: Text(
                album.imdbRating != null ? album.imdbRating : "",
                style: TextStyle(
                    fontSize: 13,
                    color: Colors.black87,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
        )
      ],
    );
  }
}

class MovieTitleSectionInCard extends StatelessWidget {
  const MovieTitleSectionInCard({
    Key key,
    @required this.album,
  }) : super(key: key);

  final Album album;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.bottomCenter,
      child: Opacity(
        opacity: .90,
        child: Container(
          padding: EdgeInsets.fromLTRB(6, 6, 2, 2),
          width: double.infinity,
          color: Colors.black87,
          child: Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
//                Expanded(
//                  child: Text('Deliver features faster',
//                      textAlign: TextAlign.center),
//                ),
//                Expanded(
//                  child:
//                      Text('Craft beautiful UIs', textAlign: TextAlign.center),
//                ),
//                Expanded(
//                  child: FittedBox(
//                    fit: BoxFit.contain, // otherwise the logo will be tiny
//                    child: const FlutterLogo(),
//                  ),
//                ),
//
                Flexible(
                  child: Text(
                    album.title,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontSize: 12,
                      fontFamily: 'Arial Narrow',
                      color: Colors.white,
                      shadows: [
                        Shadow(
                          blurRadius: 1.0,
                          color: Colors.black87,
                          offset: Offset(1.0, 1.0),
                        ),
                      ],
                    ),
                  ),
                ),

//                CircleAvatar(
////                    backgroundImage: AssetImage("assets/images/star.png"),
////                    backgroundColor: Colors.orange,
//                    radius: 14,
//                    child: Text(
//                      album.imdbRating != null ? album.imdbRating : "",
//                      style: TextStyle(
//                          fontSize: 14,
//                          color: Colors.yellowAccent,
//                          fontWeight: FontWeight.bold),
//                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
