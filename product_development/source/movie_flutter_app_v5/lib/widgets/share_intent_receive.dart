import 'dart:async';

import 'package:flutter/material.dart';
import 'package:receive_sharing_intent/receive_sharing_intent.dart';
import 'package:url_launcher/url_launcher.dart';

import '../main.dart';
import '../theme/dark.dart';

class MovieShareReceiver extends StatefulWidget {
  @override
  _MovieShareReceiverState createState() => _MovieShareReceiverState();
}

class _MovieShareReceiverState extends State<MovieShareReceiver> {
  StreamSubscription _intentDataStreamSubscription;
  List<SharedMediaFile> _sharedFiles;
  String _sharedText;

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
        appBar: AppBar(
          title: const Text('Share from Youtube'),
        ),
        body: Center(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 20,
              ),
              Text(_sharedText == null ? 'Share movies from youtube' : "",
                  style: TextStyle(fontSize: 20)),
              Text(_sharedText == null ? "" : "Movie you selected:",
                  style: TextStyle(fontSize: 16)),
              Text(_sharedText ?? ""),

              Container(
                padding: const EdgeInsets.all(16.0),
//                width: 150.0,
                child: TextField(
                  obscureText: false,
                  showCursor: true,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Type the correct movie name here',
                  ),
                ),
              ),
              RaisedButton(
                onPressed: () {
                  if (_sharedText == null) {
                    _launchURL();
                  } else {
                    setState(() {
                      _sharedText = null;
                    });
                    print("Submitted:");
                  }
                },
                child: Text(
                    _sharedText == null ? 'Open youtube' : "Add your movie",
                    style: TextStyle(fontSize: 20)),
              ),
//              Text("Shared files:", style: textStyleBold),
//              Text(_sharedFiles?.map((f) => f.path)?.join(",") ?? ""),
              SizedBox(height: 100),
            ],
          ),
        ),
        bottomNavigationBar: PageFooterBar(),
      ),
    );
  }
}

_launchURL() async {
  const url = 'https://youtube.com';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}
