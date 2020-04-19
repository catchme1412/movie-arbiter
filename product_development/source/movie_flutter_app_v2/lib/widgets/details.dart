import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import 'album.dart';
import 'video_list.dart';

/// Creates [YoutubePlayerDemoApp] widget.
//class GridDetails extends StatelessWidget {
//  @override
//  Widget build(BuildContext context) {
//    return MaterialApp(
//      debugShowCheckedModeBanner: false,
//      title: 'Movie Arbiter',
//      theme: ThemeData(
//        primarySwatch: Colors.blue,
//        appBarTheme: AppBarTheme(
//          color: Colors.blueGrey[900],
//          textTheme: TextTheme(
//            title: TextStyle(
//              color: Colors.white,
//              fontWeight: FontWeight.w300,
//              fontSize: 20.0,
//            ),
//          ),
//        ),
//        iconTheme: IconThemeData(
//          color: Colors.black87,
//        ),
//      ),
//      home: MyHomePage(),
//    );
//  }
//}

/// Homepage
class MyHomePage extends StatefulWidget {
  MyHomePage(this.curAlbum, {Key key}) : super(key: key);

  @required
  final Album curAlbum;

  @override
  _MyHomePageState createState() => _MyHomePageState(curAlbum);
}

class _MyHomePageState extends State<MyHomePage> {
  final Album curAlbum;

  _MyHomePageState(this.curAlbum);

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  YoutubePlayerController _controller;
  TextEditingController _idController;
  TextEditingController _seekToController;

//  PlayerState _playerState;
  YoutubeMetaData _videoMetaData;
  double _volume = 100;
  bool _muted = false;
  bool _isPlayerReady = false;

  final List<String> _ids = [
    'lgkZC_Ss6YE',
    'gQDByCdjUXw',
    'iLnmTe5Q2Qw',
    '_WoCV4c6XOE',
    'KmzdUe0RSJo',
    '6jZDSSZZxjQ',
    'p2lYr3vM_1w',
    '7QUtEmBT_-w',
    '34_PXCzGw1M',
  ];

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId:
          Uri.parse(curAlbum.url).queryParameters.values.elementAt(0),
//      initialVideoId: curAlbum.url,
      flags: YoutubePlayerFlags(
        mute: false,
        autoPlay: true,
        disableDragSeek: false,
        loop: false,
        isLive: false,
        forceHideAnnotation: true,
        forceHD: false,
        enableCaption: true,
      ),
    )..addListener(listener);
    _idController = TextEditingController();
    _seekToController = TextEditingController();
    _videoMetaData = YoutubeMetaData();
//    _playerState = PlayerState.unknown;
  }

  void listener() {
    if (_isPlayerReady && mounted && !_controller.value.isFullScreen) {
      setState(() {
//        _playerState = _controller.value.playerState;
        _videoMetaData = _controller.metadata;
      });
    }
  }

  @override
  void deactivate() {
    // Pauses video while navigating to next page.
    _controller.pause();
    super.deactivate();
  }

  @override
  void dispose() {
    _controller.dispose();
    _idController.dispose();
    _seekToController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.blueGrey[900],
        leading: Padding(
          padding: const EdgeInsets.only(left: 12.0),
          child: Image.asset(
            'assets/ypf.png',
            fit: BoxFit.fitWidth,
          ),
        ),
        title: Text(
          //TODO replace with Movie title
          'Movie Arbiter',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.video_library),
            onPressed: () => Navigator.push(
              context,
              CupertinoPageRoute(
                builder: (context) => VideoList(),
              ),
            ),
          ),
        ],
      ),
      body: Container(
        color: Colors.blueGrey[900],
        child: ListView(
          children: [
            YoutubePlayer(
              controller: _controller,
              showVideoProgressIndicator: true,
              progressIndicatorColor: Colors.blueAccent,
              topActions: <Widget>[
                SizedBox(width: 8.0),
                Expanded(
                  child: Text(
                    _controller.metadata.title,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.0,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                ),
                IconButton(
                  icon: Icon(
                    Icons.settings,
                    color: Colors.white,
                    size: 25.0,
                  ),
                  onPressed: () {
                    _showSnackBar('Settings Tapped!');
                  },
                ),
              ],
              onReady: () {
                _isPlayerReady = true;
              },
              onEnded: (data) {
                _controller
                    .load(_ids[(_ids.indexOf(data.videoId) + 1) % _ids.length]);
                _showSnackBar('Next Video Started!');
              },
            ),
            Container(
              color: Colors.blueGrey[900],
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Container(
                  color: Colors.blueGrey[900],
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      _space,
                      _text('Title', _videoMetaData.title),
                      _space,
//                _text('Channel', _videoMetaData.author),
                      _space,
//                _text('Video Id', _videoMetaData.videoId),
//                _space,
//                Row(
//                  children: [
//                    _text(
//                      'Playback Quality',
//                      _controller.value.playbackQuality,
//                    ),
//                    Spacer(),
//                    _text(
//                      'Playback Rate',
//                      '${_controller.value.playbackRate}x  ',
//                    ),
//                  ],
//                ),
                      _space,
//                TextField(
//                  enabled: _isPlayerReady,
//                  controller: _idController,
//                  decoration: InputDecoration(
//                    border: InputBorder.none,
//                    hintText: 'Enter youtube \<video id\> or \<link\>',
//                    fillColor: Colors.blueAccent.withAlpha(20),
//                    filled: true,
//                    hintStyle: TextStyle(
//                      fontWeight: FontWeight.w300,
//                      color: Colors.blueAccent,
//                    ),
//                    suffixIcon: IconButton(
//                      icon: Icon(Icons.clear),
//                      onPressed: () => _idController.clear(),
//                    ),
//                  ),
//                ),
//                _space,
//                Row(
//                  children: [
//                    _loadCueButton('LOAD'),
//                    SizedBox(width: 10.0),
//                    _loadCueButton('CUE'),
//                  ],
//                ),
                      _space,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          IconButton(
                            icon: Icon(Icons.skip_previous),
                            onPressed: _isPlayerReady
                                ? () => _controller.load(_ids[(_ids.indexOf(
                                            _controller.metadata.videoId) -
                                        1) %
                                    _ids.length])
                                : null,
                          ),
                          IconButton(
                            icon: Icon(
                              _controller.value.isPlaying
                                  ? Icons.pause
                                  : Icons.play_arrow,
                            ),
                            onPressed: _isPlayerReady
                                ? () {
                                    _controller.value.isPlaying
                                        ? _controller.pause()
                                        : _controller.play();
                                    setState(() {});
                                  }
                                : null,
                          ),
                          IconButton(
                            icon: Icon(
                                _muted ? Icons.volume_off : Icons.volume_up),
                            onPressed: _isPlayerReady
                                ? () {
                                    _muted
                                        ? _controller.unMute()
                                        : _controller.mute();
                                    setState(() {
                                      _muted = !_muted;
                                    });
                                  }
                                : null,
                          ),
                          FullScreenButton(
                            controller: _controller,
                            color: Colors.black87,
                          ),
                          IconButton(
                            icon: Icon(Icons.skip_next),
                            onPressed: _isPlayerReady
                                ? () => _controller.load(_ids[(_ids.indexOf(
                                            _controller.metadata.videoId) +
                                        1) %
                                    _ids.length])
                                : null,
                          ),
                        ],
                      ),
                      _space,
                      Row(
                        children: <Widget>[
                          Text(
                            "Volume",
                            style: TextStyle(fontWeight: FontWeight.w300),
                          ),
                          Expanded(
                            child: Slider(
                              inactiveColor: Colors.transparent,
                              value: _volume,
                              min: 0.0,
                              max: 100.0,
                              divisions: 10,
                              label: '${(_volume).round()}',
                              onChanged: _isPlayerReady
                                  ? (value) {
                                      setState(() {
                                        _volume = value;
                                      });
                                      _controller.setVolume(_volume.round());
                                    }
                                  : null,
                            ),
                          ),
                        ],
                      ),
                      _space,
//                AnimatedContainer(
//                  duration: Duration(milliseconds: 800),
//                  decoration: BoxDecoration(
//                    borderRadius: BorderRadius.circular(20.0),
//                    color: _getStateColor(_playerState),
//                  ),
//                  padding: EdgeInsets.all(8.0),
////                  child: Text(
////                    _playerState.toString(),
////                    style: TextStyle(
////                      fontWeight: FontWeight.w300,
////                      color: Colors.white,
////                    ),
////                    textAlign: TextAlign.center,
////                  ),
//                ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _text(String title, String value) {
    return RichText(
      text: TextSpan(
        text: '$title : ',
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
        children: [
          TextSpan(
            text: value ?? '',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w300,
            ),
          ),
        ],
      ),
    );
  }

  Color _getStateColor(PlayerState state) {
    switch (state) {
      case PlayerState.unknown:
        return Colors.grey[700];
      case PlayerState.unStarted:
        return Colors.pink;
      case PlayerState.ended:
        return Colors.red;
      case PlayerState.playing:
        return Colors.blueAccent;
      case PlayerState.paused:
        return Colors.orange;
      case PlayerState.buffering:
        return Colors.yellow;
      case PlayerState.cued:
        return Colors.blue[900];
      default:
        return Colors.blue;
    }
  }

  Widget get _space => SizedBox(height: 10);

  Widget _loadCueButton(String action) {
    return Expanded(
      child: MaterialButton(
        color: Colors.white,
        onPressed: _isPlayerReady
            ? () {
                if (_idController.text.isNotEmpty) {
                  var id = YoutubePlayer.convertUrlToId(
                    _idController.text,
                  );
                  if (action == 'LOAD') _controller.load(id);
                  if (action == 'CUE') _controller.cue(id);
                  FocusScope.of(context).requestFocus(FocusNode());
                } else {
                  _showSnackBar('Source can\'t be empty!');
                }
              }
            : null,
        disabledColor: Colors.grey,
        disabledTextColor: Colors.black,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 14.0),
          child: Text(
            action,
            style: TextStyle(
              fontSize: 18.0,
              color: Colors.white,
              fontWeight: FontWeight.w300,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }

  void _showSnackBar(String message) {
    _scaffoldKey.currentState.showSnackBar(
      SnackBar(
        content: Text(
          message,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontWeight: FontWeight.w300,
            fontSize: 16.0,
          ),
        ),
        backgroundColor: Colors.white,
        behavior: SnackBarBehavior.floating,
        elevation: 1.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50.0),
        ),
      ),
    );
  }
}

//import 'package:flutter/material.dart';
//import 'package:youtube_player_flutter/youtube_player_flutter.dart';
//
//import 'album.dart';
//
//class GridDetails extends StatefulWidget {
//  final Album curAlbum;
//  GridDetails({@required this.curAlbum});
//
//  @override
//  GridDetailsState createState() => GridDetailsState();
//}
//
//class GridDetailsState extends State<GridDetails> {
//  //
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//      body: Container(
//        alignment: Alignment.center,
//        margin: EdgeInsets.all(30.0),
//        child: YoutubePlayer(
//          context: context,
//          source: "ddFvjfvPnqk",
//          playerMode: YoutubePlayerMode.NO_CONTROLS,
//        ),
//      ),
//    );
//  }
//}
