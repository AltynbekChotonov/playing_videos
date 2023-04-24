import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerWidget extends StatefulWidget {
  VideoPlayerWidget({Key? key, required this.url, required this.controller})
      : super(key: key);

  final String url;
  final VideoPlayerController controller;

  @override
  _VideoPlayerWidgetState createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  late Future<void> _initializeVideoPlayerFuture;

  @override
  void initState() {
    _initializeVideoPlayerFuture =
        widget.controller.initialize().then((_) => setState(() {}));

    super.initState();
  }

  @override
  void dispose() {
    widget.controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return // Use a FutureBuilder to display a loading spinner while waiting for the
// VideoPlayerController to finish initializing.
        FutureBuilder(
      future: _initializeVideoPlayerFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          // If the VideoPlayerController has finished initialization, use
          // the data it provides to limit the aspect ratio of the VideoPlayer.
          return AspectRatio(
            aspectRatio: widget.controller.value.aspectRatio,
            // Use the VideoPlayer widget to display the video.
            child: VideoPlayer(widget.controller),
          );
        } else {
          // If the VideoPlayerController is still initializing, show a
          // loading spinner.
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
