/*import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class trailerwatch extends StatefulWidget {
  var trailerytid;
  trailerwatch({this.trailerytid});

  @override
  State<trailerwatch> createState() => _trailerwatchState();
}

class _trailerwatchState extends State<trailerwatch> {
  late YoutubePlayerController controller;

  @override
  void initState() {
    final videoid = YoutubePlayer.convertUrlToId(widget.trailerytid);
    controller = YoutubePlayerController(
      initialVideoId: videoid.toString(),
      flags: YoutubePlayerFlags(
        enableCaption: true,
        autoPlay: false,
        mute: false,
        // controlsVisibleAtStart: true,
        forceHD: true,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(0.0),
      child: YoutubePlayer(
        thumbnail: Image.network(
          "https://img.youtube.com/vi/" + widget.trailerytid + "/hqdefault.jpg",
          fit: BoxFit.cover,
        ),
        controlsTimeOut: Duration(milliseconds: 1500),
        aspectRatio: 16 / 9,
        controller: controller,
        showVideoProgressIndicator: true,
        bufferIndicator: const Center(
          child: Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.amber),
              )),
        ),
        progressIndicatorColor: Colors.amber,
        bottomActions: [
          CurrentPosition(),
          ProgressBar(
              isExpanded: true,
              colors: ProgressBarColors(
                playedColor: Colors.white,
                handleColor: Colors.amber,
              )),
          RemainingDuration(),
          FullScreenButton(),
        ],
      ),
    );
  }
}



 */
