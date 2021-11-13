import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rcn/controller/video_msg_controller.dart';
import 'package:rcn/util.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class ViewVideoScreen extends StatefulWidget {
  ViewVideoScreen({
    Key? key,
    required this.youTubeLink,
    required this.youTubeTitle,
    required this.user_id,
    required this.youtube_vid_id,
    required this.isPlayListed,
  }) : super(key: key);

  String youTubeLink;
  String youTubeTitle;
  String youtube_vid_id;
  String user_id;
  bool isPlayListed;

  @override
  _ViewVideoScreenState createState() => _ViewVideoScreenState();
}

class _ViewVideoScreenState extends State<ViewVideoScreen> {
  final videoMsgListController = VideoMsgController().getXID;

  late String videoId;
  late YoutubePlayerController _controller;
  late TextEditingController _idController;
  late TextEditingController _seekToController;
  late PlayerState _playerState;
  late YoutubeMetaData _videoMetaData;

  double _volume = 100;
  bool _muted = false;
  bool _isPlayerReady = false;

  @override
  void initState() {
    // getYoutubeId();
    super.initState();
    // videoId = YoutubePlayer.convertUrlToId(
    //   "https://www.youtube.com/watch?v=fyLtzh0zv9A",
    // )!;
    videoId = YoutubePlayer.convertUrlToId(
      "${widget.youTubeLink}",
    )!;
    // print(videoId);

    _controller = YoutubePlayerController(
      initialVideoId: videoId,
      flags: YoutubePlayerFlags(
        //isLive: true,
        enableCaption: true,
        forceHD: true,
      ),
    )..addListener(listener);
    _idController = TextEditingController();
    _seekToController = TextEditingController();
    _videoMetaData = const YoutubeMetaData();
    _playerState = PlayerState.unknown;
  }

  @override
  Widget build(BuildContext context) {
    return getYoutubeId();
  }

  void listener() {
    if (_isPlayerReady && mounted && !_controller.value.isFullScreen) {
      setState(() {
        _playerState = _controller.value.playerState;
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

  getYoutubeId() {
    return YoutubePlayerBuilder(
      player: YoutubePlayer(
        controller: _controller,
        liveUIColor: Colors.red,
        showVideoProgressIndicator: true,
        topActions: <Widget>[
          const SizedBox(width: 8.0),
          Expanded(
            child: Text(
              _controller.metadata.title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18.0,
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ),
          // IconButton(
          //   icon: const Icon(
          //     Icons.settings,
          //     color: Colors.white,
          //     size: 25.0,
          //   ),
          //   onPressed: () {
          //     print('Settings Tapped!');
          //   },
          // ),
        ],
        onReady: () {
          _isPlayerReady = true;
        },
        onEnded: (data) {
          _showSnackBar('Live Broadcast Ended');
        },
      ),
      builder: (context, player) => Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.deepOrangeAccent,
          title: Text(
            '${widget.youTubeTitle}',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
              overflow: TextOverflow.ellipsis,
            ),
            maxLines: 1,
          ),
        ),
        body: ListView(
          children: [
            player,
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _space,
                  SizedBox(
                    height: 10,
                  ),
                  InkWell(
                    onTap: () {
                      showSnackBar("Video Download", "Features Coming Soon!...",
                          Colors.red);
                    },
                    child: Card(
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                          color: primaryColorLight,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      color: Colors.red,
                      elevation: 3,
                      child: Container(
                        width: double.infinity,
                        child: Padding(
                          padding: const EdgeInsets.all(14.0),
                          child: Text(
                            'Download',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20.0,
                              fontWeight: FontWeight.w500,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () async {
                      var toggle = await videoMsgListController.toggle_playlist(
                          widget.user_id, widget.youtube_vid_id);

                      if (toggle == 'added') {
                        setState(() {
                          widget.isPlayListed = true;
                        });
                      } else if (toggle == 'deleted') {
                        setState(() {
                          widget.isPlayListed = false;
                        });
                      }
                    },
                    child: Card(
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                          color: primaryColorLight,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      color: (widget.isPlayListed)
                          ? Colors.redAccent
                          : Colors.green,
                      elevation: 3,
                      child: Container(
                        width: double.infinity,
                        child: Padding(
                          padding: const EdgeInsets.all(14.0),
                          child: (widget.isPlayListed)
                              ? Text(
                                  'Remove From Playlist',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  textAlign: TextAlign.center,
                                )
                              : Text(
                                  'Add To Playlist',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                        ),
                      ),
                    ),
                  ),
                ],
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
        style: const TextStyle(
          color: Colors.blueAccent,
          fontWeight: FontWeight.bold,
        ),
        children: [
          TextSpan(
            text: value,
            style: const TextStyle(
              color: Colors.blueAccent,
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
        return Colors.grey[700]!;
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
        return Colors.blue[900]!;
      default:
        return Colors.blue;
    }
  }

  Widget get _space => const SizedBox(height: 10);

  Widget _loadCueButton(String action) {
    return Expanded(
      child: MaterialButton(
        color: Colors.blueAccent,
        onPressed: _isPlayerReady
            ? () {
                if (_idController.text.isNotEmpty) {
                  var id = YoutubePlayer.convertUrlToId(
                        _idController.text,
                      ) ??
                      '';
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
            style: const TextStyle(
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
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontWeight: FontWeight.w300,
            fontSize: 16.0,
          ),
        ),
        backgroundColor: Colors.blueAccent,
        behavior: SnackBarBehavior.floating,
        elevation: 1.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50.0),
        ),
      ),
    );
  }

  showSnackBar(String title, String msg, Color backgroundColor) {
    Get.snackbar(
      title,
      msg,
      backgroundColor: backgroundColor,
      colorText: Colors.white,
      snackPosition: SnackPosition.BOTTOM,
    );
  }
}
