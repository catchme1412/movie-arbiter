import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:movie_flutter_app_v6/widgets/movie_listing_page.dart';

import 'landing-page.dart';
import 'movie-share-resume.dart';
import 'movie_share_page.dart';

class LandingPageDecisionMaker extends StatefulWidget {
  LandingPageDecisionMaker({Key key}) : super(key: key);

  @override
  _LandingPageDecisionMakerState createState() =>
      _LandingPageDecisionMakerState();
}

class _LandingPageDecisionMakerState extends State<LandingPageDecisionMaker> {
  static const platform = const MethodChannel('app.channel.shared.data');
  Map<dynamic, dynamic> sharedData = Map();

  @override
  void initState() {
    super.initState();
    _init();
  }

  _init() async {
    await setSharedIntentIfAny();

    // You can use sharedData in your build() method now
  }

  Future setSharedIntentIfAny() async {
    print("Starting....");
    // Case 1: App is already running in background:
    // Listen to lifecycle changes to subsequently call Java MethodHandler to check for shared data
    SystemChannels.lifecycle.setMessageHandler((msg) {
      if (msg.contains('resumed')) {
        _getSharedData().then((d) {
          print('here I am ');
          debugPrint(d.toString());
          if (d.isEmpty) return;
          Navigator.push(
              context,
              new MaterialPageRoute(
                  builder: (context) => MovieShareResume(sharedData: d)));
          // Your logic here
          // E.g. at this place you might want to use Navigator to launch a new page and pass the shared data
        });
      }
      Navigator.push(
          context,
          new MaterialPageRoute(
              builder: (context) => MovieListingPage(
//                    message: "Please try again!",
                  )));
      return null;
    });

    // Case 2: App is started by the intent:
    // Call Java MethodHandler on application start up to check for shared data
    var data = await _getSharedData();
    setState(() {
      sharedData = data;
      debugPrint("Shared data $sharedData");
    });
    setState(() => sharedData = data);
  }

  Future<Map> _getSharedData() async =>
      await platform.invokeMethod('getSharedData');

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return buildLandingPage(context);
  }

  Widget buildLandingPage(BuildContext context) {
    if (sharedData.isEmpty) {
      return LandingPage();
    }
    return MovieSharePage(sharedData: sharedData);
  }
}
