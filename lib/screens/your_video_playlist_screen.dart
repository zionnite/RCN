import 'package:flutter/material.dart';

class YourVideoPlaylist extends StatefulWidget {
  const YourVideoPlaylist({Key? key}) : super(key: key);

  @override
  _YourVideoPlaylistState createState() => _YourVideoPlaylistState();
}

class _YourVideoPlaylistState extends State<YourVideoPlaylist> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepOrangeAccent,
        title: Text(
          'Video Playlist',
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [],
          ),
        ),
      ),
    );
  }
}
