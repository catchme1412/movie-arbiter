import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../models/album.dart';
import 'app_bar.dart';
import 'page_footer.dart';

/// Homepage
class YoutubeVideoPage extends StatefulWidget {
  YoutubeVideoPage(this.curAlbum, {Key key}) : super(key: key);

  @required
  final Album curAlbum;

  @override
  _YoutubePlayerPageState createState() => _YoutubePlayerPageState(curAlbum);
}

class _YoutubePlayerPageState extends State<YoutubeVideoPage> {
  final Album curAlbum;

  _YoutubePlayerPageState(this.curAlbum);

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
//    'lgkZC_Ss6YE',
  ];

  @override
  void initState() {
    super.initState();
    String videoId =
        Uri.parse(curAlbum.url).queryParameters.values.elementAt(0);
    _controller = YoutubePlayerController(
      initialVideoId: videoId,
//          Uri.parse(curAlbum.url).queryParameters.values.elementAt(0),
//      initialVideoId: curAlbum.url,
      flags: YoutubePlayerFlags(
        mute: false,
        autoPlay: false,
        disableDragSeek: false,
        loop: false,
        isLive: false,
        hideControls: false,

//        forceHideAnnotation: false,
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
      SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
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
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    _controller.pause();
    super.deactivate();
  }

  @override
  void dispose() {
    _controller.pause();
    _controller.dispose();
    _idController.dispose();
    _seekToController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: APP_BAR,
      body: Scaffold(
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
                  _controller.load(
                      _ids[(_ids.indexOf(data.videoId) + 1) % _ids.length],
                      startAt: 0);
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
//                        _space,
                        _text('Title', curAlbum.title),
//                _text('Channel', _videoMetaData.author),
//                        _space,

//                        _space,

                        _space,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
//                            IconButton(
//                              icon: Icon(Icons.skip_previous),
//                              onPressed: _isPlayerReady
//                                  ? () => _controller.load(
//                                      _ids[(_ids.indexOf(_controller
//                                                  .metadata.videoId) -
//                                              1) %
//                                          _ids.length],
//                                      startAt: 0)
//                                  : null,
//                            ),
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
                              color: Colors.white,
                            ),
//                            IconButton(
//                              icon: Icon(Icons.skip_next),
//                              onPressed: _isPlayerReady
//                                  ? () => _controller.load(
//                                      _ids[(_ids.indexOf(_controller
//                                                  .metadata.videoId) +
//                                              1) %
//                                          _ids.length],
//                                      startAt: 0)
//                                  : null,
//                            ),
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
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: PageFooterBar(),
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
                  if (action == 'LOAD') _controller.load(id, startAt: 0);
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
