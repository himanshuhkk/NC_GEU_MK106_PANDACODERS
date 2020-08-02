
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class Yt extends StatefulWidget {
  final String id;

  Yt({this.id});

  @override
  _YtState createState() => _YtState();
}

class _YtState extends State<Yt> {
  YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: widget.id,
      flags: YoutubePlayerFlags(
        autoPlay: true,
        mute: false,
      ),
    );
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);
    return Center(
      child: YoutubePlayer(
          controller: _controller,
          showVideoProgressIndicator: true,
          bottomActions: <Widget>[
            CurrentPosition(),
            ProgressBar(isExpanded: true),
          ]
      ),
    );
  }
}