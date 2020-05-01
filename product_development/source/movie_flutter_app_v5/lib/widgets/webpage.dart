import 'dart:convert';

import 'package:MovieArbiter/models/album.dart';
import 'package:MovieArbiter/theme/dark.dart';
import 'package:MovieArbiter/widgets/page_footer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class WebViewPage extends StatefulWidget {
  Album album;

  WebViewPage(this.album);

  @override
  State<StatefulWidget> createState() {
    return _WebViewPageState();
  }
}

class _WebViewPageState extends State<WebViewPage> {
  //
  WebViewController _webViewController;
  String filePath = 'assets/files/html/video.html';

  bool isLoaded;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isLoaded = false;
  }

  @override
  dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: DARK_THEME,
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.blueGrey[900],
        appBar: buildAppBar(),
        bottomNavigationBar: buildPageFooterBar(),
        body: Stack(
          children: <Widget>[
            WebView(
              initialMediaPlaybackPolicy: AutoMediaPlaybackPolicy.always_allow,
              initialUrl: '',
              javascriptMode: JavascriptMode.unrestricted,
              onWebViewCreated: (WebViewController webViewController) {
                _webViewController = webViewController;
                _loadHtmlFromAssets();
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                FlatButton(
                  padding: EdgeInsets.fromLTRB(0, 80, 0, 0),
                  child: buildIcon(),
                  onPressed: () {
                    changeOrientation();
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  PageFooterBar buildPageFooterBar() {
    if (MediaQuery.of(context).orientation == Orientation.portrait) {
      // is portrait
      return PageFooterBar();
    } else {
// is landscape
    }
  }

  AppBar buildAppBar() {
    if (MediaQuery.of(context).orientation == Orientation.portrait) {
      // is portrait
      return AppBar(title: Text('Movie Arbiter'));
    } else {
// is landscape
    }
  }

  _loadHtmlFromAssets() async {
    String fileHtmlContents = await rootBundle.loadString(filePath);
    _webViewController.loadUrl(Uri.dataFromString(
      fileHtmlContents + "?url=" + widget.album.url,
      mimeType: 'text/html',
      encoding: Encoding.getByName('utf-8'),
    ).toString());
    _webViewController.evaluateJavascript(
        'window.onload = function() {document.getElementById("externalVideo").src= "' +
            widget.album.url.toString() +
            '";};');
  }

  void changeOrientation() {
    if (MediaQuery.of(context).orientation == Orientation.portrait) {
      // is portrait
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.landscapeRight,
        DeviceOrientation.landscapeLeft,
      ]);
    } else {
// is landscape
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ]);
    }
  }

  Icon buildIcon() {
    if (MediaQuery.of(context).orientation == Orientation.portrait) {
      // is portrait
      return Icon(
        Icons.fullscreen,
        color: Colors.white,
      );
    } else {
// is landscape
      return Icon(
        Icons.fullscreen_exit,
        color: Colors.white,
      );
    }
  }
}
