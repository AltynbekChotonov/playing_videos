import 'package:flutter/material.dart';

import 'package:video_player/video_player.dart';

import 'widgets/video_player_widget.dart';

void main() => runApp(VideoPlayerApp());

class VideoPlayerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Playing Two Videos',
      home: VideoPlayerScreen(),
    );
  }
}

class VideoPlayerScreen extends StatefulWidget {
  VideoPlayerScreen({Key? key}) : super(key: key);

  @override
  _VideoPlayerScreenState createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  late VideoPlayerController _controller;
  late VideoPlayerController _controller2;

  @override
  void initState() {
    // Set videoPlayerOptions: VideoPlayerOptions(mixWithOthers: true) to let videos to play together,
    // otherwise it won't work
    _controller = VideoPlayerController.network(
        'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4',
        videoPlayerOptions: VideoPlayerOptions(mixWithOthers: true));

    _controller2 = VideoPlayerController.network(
        'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4',
        videoPlayerOptions: VideoPlayerOptions(mixWithOthers: true));

    initPlay();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    _controller2.dispose();

    super.dispose();
  }

  initPlay() {
    _controller2.play();

    _controller.play();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Playing Two Videos'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            VideoPlayerWidget(
              controller: _controller,
              url: '',
            ),
            SizedBox(height: 30.0),
            VideoPlayerWidget(
              controller: _controller2,
              url: '',
            ),
            SizedBox(height: 30.0),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            if (_controller.value.isPlaying && _controller2.value.isPlaying) {
              _controller.pause();
              _controller2.pause();
            } else {
              _controller.play();
              _controller2.play();
            }
          });
        },
        child: Icon(
          _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
        ),
      ),
    );
  }
}
