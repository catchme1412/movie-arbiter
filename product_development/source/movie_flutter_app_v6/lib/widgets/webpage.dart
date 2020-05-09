import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../models/album.dart';
import '../theme/dark.dart';
import '../widgets/page_footer.dart';

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
//      DeviceOrientation.landscapeRight,
//      DeviceOrientation.landscapeLeft,
      DeviceOrientation.portraitUp,
//      DeviceOrientation.portraitDown,
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
              initialUrl: 'assets/files/html/loadng.html',
              javascriptMode: JavascriptMode.unrestricted,
              onWebViewCreated: (WebViewController webViewController) {
                _webViewController = webViewController;
                _loadHtmlFromAssets();
              },
              javascriptChannels: Set.from([
                JavascriptChannel(
                    name: 'Print',
                    onMessageReceived: (JavascriptMessage message) {
                      //This is where you receive message from
                      //javascript code and handle in Flutter/Dart
                      //like here, the message is just being printed
                      //in Run/LogCat window of android studio
                      debugPrint(
                          'Message received: ' + message.message.toString());
                      if (message.message.toString() == 'fullscreen') {
                        changeOrientation();
                      } else {
                        _loadHtmlFromAssetsNextPart(message.message.toString());
                      }
                    })
              ]),
              onPageFinished: (value) {
                setState(
                  () {
                    isLoaded = true;
                  },
                );
              },
            ),
            (isLoaded)
                ? Container()
                : Center(
                    child: CircularProgressIndicator(
                      backgroundColor: Colors.blueGrey[900],
                    ),
                  ),
//            Row(
//              mainAxisAlignment: MainAxisAlignment.end,
//              children: <Widget>[
//                FlatButton(
//                  padding: EdgeInsets.fromLTRB(0, 80, 0, 0),
//                  child: buildIcon(),
//                  onPressed: () {
//                    changeOrientation();
//                  },
//                ),
//              ],
//            ),
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
//      return Container();
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

  _loadHtmlFromAssetsNextPart(String url) async {
    String fileHtmlContents = await rootBundle.loadString(filePath);

    fileHtmlContents = fileHtmlContents.replaceAll("videoInjection", url);
    fileHtmlContents = fileHtmlContents.replaceAll(
        "MovieNameToBeReplaced", widget.album.title);

    String movieList = "";

    int i = 1;
    for (String url in widget.album.urlList) {
      movieList +=
          "<span onclick=\"Print.postMessage(\'${url.toString()}\');\">&nbsp;&nbsp;$i&nbsp;&nbsp;&nbsp;&nbsp;</span>";
      i++;
    }
    debugPrint(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>" + movieList);
    fileHtmlContents = fileHtmlContents.replaceAll("MOVIELIST", movieList);

    debugPrint(fileHtmlContents);
    _webViewController.loadUrl(Uri.dataFromString(
      fileHtmlContents,
      mimeType: 'text/html',
      encoding: Encoding.getByName('utf-8'),
    ).toString());
//    _webViewController.evaluateJavascript(
//        "document.getElementById('externalVideo').src= 'https://www.dailymotion.com/embed/video/x2ljpht'"
////        'window.onload = function() {document.getElementById("externalVideo").src= "' +
////            widget.album.url.toString() +
////            '";};',
//        );
  }

  _loadHtmlFromAssets() async {
    String fileHtmlContents = await rootBundle.loadString(filePath);

    fileHtmlContents =
        fileHtmlContents.replaceAll("videoInjection", widget.album.url);
    fileHtmlContents = fileHtmlContents.replaceAll(
        "MovieNameToBeReplaced", widget.album.title);

    String movieList = "";

    int i = 1;
    if (widget.album.urlList != null) {
      for (String url in widget.album.urlList) {
        movieList +=
            "<span onclick=\"Print.postMessage(\'${url.toString()}\');\">&nbsp;&nbsp;$i&nbsp;&nbsp;&nbsp;&nbsp;</span>";
        i++;
      }
      debugPrint(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>" + movieList);
    }

    fileHtmlContents = fileHtmlContents.replaceAll("MOVIELIST", movieList);

    debugPrint(fileHtmlContents);
    _webViewController.loadUrl(Uri.dataFromString(
      fileHtmlContents,
      mimeType: 'text/html',
      encoding: Encoding.getByName('utf-8'),
    ).toString());
//    _webViewController.evaluateJavascript(
//        "document.getElementById('externalVideo').src= 'https://www.dailymotion.com/embed/video/x2ljpht'"
////        'window.onload = function() {document.getElementById("externalVideo").src= "' +
////            widget.album.url.toString() +
////            '";};',
//        );
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
