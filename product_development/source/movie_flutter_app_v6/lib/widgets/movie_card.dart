import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../models/album.dart';
import '../widgets/page_footer.dart';
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

class WeblinkPage extends StatelessWidget {
  final Album album;

  WeblinkPage({Key key, this.album}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      bottomNavigationBar: PageFooterBar(),
      body: WebView(
        javascriptMode: JavascriptMode.unrestricted,
        initialUrl:
            'https://www.dailymotion.com/embed/video/x2ljpht&amp;controls=1',
      ),
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
    return Container(
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
          opacity: .9,
          child: Container(
            width: double.infinity,
            color: Colors.black87,
//
            child: Padding(
              padding: EdgeInsets.fromLTRB(8, 4, 8, 2),
              child: RichText(
                text: new TextSpan(
                  // Note: Styles for TextSpans must be explicitly defined.
                  // Child text spans will inherit styles from parent
                  style: new TextStyle(
                    fontSize: 14.0,
                    color: Colors.white,
                  ),
                  children: <TextSpan>[
                    new TextSpan(
                        text: album.imdbRating,
                        style: new TextStyle(
                            color: Colors.yellowAccent,
                            fontSize: 12,
                            backgroundColor: Colors.black87)),
                    new TextSpan(text: '  ' + album.title),
                  ],
                ),
              ),
//                    child: Text(
//                      album.title + '  ' + album.imdbRating,
//                      textAlign: TextAlign.center,
//                      maxLines: 2,
//                      overflow: TextOverflow.ellipsis,
//                      style: TextStyle(
//                        fontWeight: FontWeight.normal,
//                        fontSize: 12.0,
////                        backgroundColor: Colors.blueGrey[900],
//                      ),
//                    ),
            ),
          ),
        ));
  }
}
