import 'dart:async';

import 'package:MovieArbiter/context/movie_app_context.dart';
import 'package:MovieArbiter/widgets/page_footer.dart';
import 'package:flutter/material.dart';
import 'package:receive_sharing_intent/receive_sharing_intent.dart';
import 'package:url_launcher/url_launcher.dart';

class MovieShareReceiver extends StatefulWidget {
  @override
  _MovieShareReceiverState createState() => _MovieShareReceiverState();
}

class _MovieShareReceiverState extends State<MovieShareReceiver> {
  StreamSubscription _intentDataStreamSubscription;
  List<SharedMediaFile> _sharedFiles;
  String _sharedText;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  bool _shared = false;
  TextEditingController emailController = new TextEditingController();

  @override
  void initState() {
    super.initState();

    // For sharing images coming from outside the app while the app is in the memory
    _intentDataStreamSubscription = ReceiveSharingIntent.getMediaStream()
        .listen((List<SharedMediaFile> value) {
      setState(() {
        print("Shared:" + (_sharedFiles?.map((f) => f.path)?.join(",") ?? ""));
        _sharedFiles = value;
      });
    }, onError: (err) {
      print("getIntentDataStream error: $err");
    });

    // For sharing images coming from outside the app while the app is closed
    ReceiveSharingIntent.getInitialMedia().then((List<SharedMediaFile> value) {
      setState(() {
        _sharedFiles = value;
      });
    });

    // For sharing or opening urls/text coming from outside the app while the app is in the memory
    _intentDataStreamSubscription =
        ReceiveSharingIntent.getTextStream().listen((String value) {
      setState(() {
        _sharedText = value;
      });
    }, onError: (err) {
      print("getLinkStream error: $err");
    });

    // For sharing or opening urls/text coming from outside the app while the app is closed
    ReceiveSharingIntent.getInitialText().then((String value) {
      setState(() {
        _sharedText = value;
      });
    });
  }

  @override
  void dispose() {
    _intentDataStreamSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const textStyleBold = const TextStyle(fontWeight: FontWeight.bold);
//    return MaterialApp(
//      debugShowCheckedModeBanner: false,
//      theme: DARK_THEME,
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: const Text('Movie Arbiter'),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              padding: EdgeInsets.fromLTRB(40, 40, 40, 40),
              child: Image.asset("assets/images/share-4.png"),
            ),
            SizedBox(
              height: _sharedText == null ? 0 : 20,
            ),
            Text(
              _sharedText == null ? '1. Find a good youtube movie' : "",
              style: TextStyle(fontSize: 14),
              textAlign: TextAlign.left,
            ),
            SizedBox(
              height: _sharedText == null ? 10 : 0,
            ),
            Text(
              _sharedText == null ? '2. Click the share option' : "",
              style: TextStyle(fontSize: 14),
              textAlign: TextAlign.left,
            ),
            SizedBox(
              height: _sharedText == null ? 10 : 0,
            ),
            Text(
              _sharedText == null ? '3. Choose Movie Arbiter' : "",
              style: TextStyle(fontSize: 14),
              textAlign: TextAlign.left,
            ),
            SizedBox(
              height: _sharedText == null ? 10 : 0,
            ),
            Text(
              _sharedText == null ? '4. Submit for review' : "",
              style: TextStyle(fontSize: 14),
              textAlign: TextAlign.left,
            ),
            Text(_sharedText == null ? "" : "Movie you selected:",
                style: TextStyle(fontSize: 14)),
            Text(
              _sharedText ?? "",
              style: TextStyle(fontSize: 12, color: Colors.blue),
            ),

            Container(
              padding: const EdgeInsets.all(20.0),
//                width: 150.0,
              child: _sharedText != null
                  ? TextField(
                      controller: emailController,
                      obscureText: false,
                      showCursor: true,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Name of this movie?',
                      ),
                    )
                  : Container(),
            ),
            RaisedButton(
              onPressed: () {
                if (_sharedText == null) {
                  _launchURL();
                } else {
                  setState(() {
                    _sharedText = null;
                    _shared = true;
                    MovieAppContext.getInstance().setMovieShared(_shared);
                  });
// Find the Scaffold in the widget tree and use it to show a SnackBar.
                  SnackBar snackbar = buildSnackbar();
                  _scaffoldKey.currentState.showSnackBar(snackbar);
                  print("Submitted:" + emailController.text);
                }
              },
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  _sharedText == null
                      ? Icon(
                          Icons.search,
                          color: Colors.white,
                        )
                      : Icon(
                          Icons.add_to_home_screen,
                          color: Colors.white,
                        ),
                  Text(
                    _sharedText == null ? 'Open youtube' : "Submit for review",
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
//              Text("Shared files:", style: textStyleBold),
//              Text(_sharedFiles?.map((f) => f.path)?.join(",") ?? ""),
          ],
        ),
      ),
      bottomNavigationBar: PageFooterBar(),
//      ),
    );
  }

  SnackBar buildSnackbar() {
    SnackBar snackbar = SnackBar(
      backgroundColor: Colors.orange,
      duration: Duration(seconds: 7),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Image.asset(
            "assets/images/success.gif",
            height: 100,
          ),
          SizedBox(
            height: 10,
          ),
          Flexible(
            child: Text(
              "Congratulations! You have shared your movie.",
              style: TextStyle(fontSize: 20),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(
            height: 8,
          ),
          Flexible(
            child: Text(
              "Your contribution will appear after admin's approval",
              style: TextStyle(fontSize: 14),
              textAlign: TextAlign.center,
            ),
          ),
          //
        ],
      ),
    );
    return snackbar;
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
