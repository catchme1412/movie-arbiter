import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie_flutter_app_v6/widgets/page_footer.dart';
import 'package:url_launcher/url_launcher.dart';

import 'app_bar.dart';

class MovieContribute extends StatefulWidget {
  @override
  _MovieContributeState createState() => _MovieContributeState();
}

class _MovieContributeState extends State<MovieContribute> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: APP_BAR,
      bottomNavigationBar: PageFooterBar(),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Container(
              padding: EdgeInsets.fromLTRB(40, 40, 40, 40),
              child: Image.asset("assets/images/share-4.png"),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Text("1. Find a good youtube movie"),
                SizedBox(height: 10),
                Text("2. Click on youtube share"),
                SizedBox(height: 10),
                Text("3. Choose Movie Arbiter"),
                SizedBox(height: 10),
                Text("4. Submit the movie"),
              ],
            ),
            Container(
              alignment: Alignment.center,
              child: RaisedButton(
                splashColor: Colors.redAccent,
                onPressed: () {
                  _launchURL();
                },
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Icon(
                      Icons.search,
                      color: Colors.white,
                    ),
                    Text("Open Youtube")
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

_launchURL() async {
  const url =
      'https://www.youtube.com/results?search_query=malayalam+full+movies+HD&sp=CAISBBgCIAE%253D';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}
