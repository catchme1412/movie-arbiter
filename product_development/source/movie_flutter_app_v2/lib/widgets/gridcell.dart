import 'package:flutter/material.dart';

import 'album.dart';

class AlbumCell extends StatelessWidget {
  const AlbumCell(this.album);
  @required
  final Album album;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(0.0),
      ),
      color: Colors.blueGrey[900],
      child: Padding(
        padding: EdgeInsets.all(2.0),
        child: Container(
          alignment: Alignment.center,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Flexible(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(0.0),
                  child: Hero(
                    tag: "image${album.id}",
                    child: FadeInImage.assetNetwork(
                      placeholder: "assets/images/no_image.png",
                      image: album.thumbnailUrl,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(0.0),
                child: Text(
                  album.title,
                  maxLines: 1,
                  softWrap: true,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w300,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
