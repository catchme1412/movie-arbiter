import 'dart:async';

import 'package:MovieArbiter/context/movie_app_context.dart';
import 'package:MovieArbiter/widgets/page_footer.dart';
import 'package:flutter/material.dart';
import 'package:receive_sharing_intent/receive_sharing_intent.dart';
import 'package:url_launcher/url_launcher.dart';

import '../theme/dark.dart';

class MovieShareReceiver extends StatefulWidget {
  @override
  _MovieShareReceiverState createState() => _MovieShareReceiverState();
}

class _MovieShareReceiverState extends State<MovieShareReceiver> {
  StreamSubscription _intentDataStreamSubscription;
  List<SharedMediaFile> _sharedFiles;
  String _sharedText;

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
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: DARK_THEME,
      home: Scaffold(
//        appBar: AppBar(
//          title: const Text('Share from Youtube'),
//        ),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 20,
                ),
                Container(
                  padding: EdgeInsets.all(30.0),
                  child: Stack(
                    children: <Widget>[
//                      Image.asset(
//                        "assets/images/success.gif",
//                        height: 125.0,
//                        width: 125.0,
//                      ),
                      Text(
                        _shared
                            ? "Thank you for sharing the move!! Your movie will appear after admin's approval."
                            : '',
                        style: TextStyle(color: Colors.green, fontSize: 18),
                      ),
                    ],
                  ),
                ),

                Container(
                  padding: EdgeInsets.all(26.0),
                  child: Center(
                    child: Text(
                        _sharedText == null
                            ? 'Find a good movie in youtube, then share here'
                            : "",
                        style: TextStyle(fontSize: 18)),
                  ),
                ),
                Text(_sharedText == null ? "" : "Movie you selected:",
                    style: TextStyle(fontSize: 14)),
                Text(
                  _sharedText ?? "",
                  style: TextStyle(fontSize: 12, color: Colors.blue),
                ),

                Container(
                  padding: const EdgeInsets.all(16.0),
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

                      print("Submitted:" + emailController.text);
                    }
                  },
                  child: Text(
                      _sharedText == null ? 'Open youtube' : "Add your movie",
                      style: TextStyle(fontSize: 16)),
                ),
//              Text("Shared files:", style: textStyleBold),
//              Text(_sharedFiles?.map((f) => f.path)?.join(",") ?? ""),
              ],
            ),
          ),
        ),
        bottomNavigationBar: PageFooterBar(),
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
