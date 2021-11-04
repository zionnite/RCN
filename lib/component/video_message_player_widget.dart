import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:rcn/screens/view_video_screen.dart';

class VideoMessagePlayerWidget extends StatefulWidget {
  VideoMessagePlayerWidget({
    Key? key,
    required this.vid_image,
    required this.vid_link,
    required this.vid_title,
    // required this.vid_id,
    //required this.vid_album,
  }) : super(key: key);

  String vid_image;
  String vid_link;
  String vid_title;
  //String vid_id;
  //String vid_album;

  @override
  _VideoMessagePlayerWidgetState createState() =>
      _VideoMessagePlayerWidgetState();
}

class _VideoMessagePlayerWidgetState extends State<VideoMessagePlayerWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 0.0),
      child: Card(
        child: Column(
          children: [
            Container(
              height: 200,
              width: double.infinity,
              padding: const EdgeInsets.symmetric(
                horizontal: 8.0,
              ),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(
                    '${widget.vid_image}',
                  ),
                  fit: BoxFit.cover,
                ),
              ),
              child: ClipRRect(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                  child: Container(
                    alignment: Alignment.center,
                    color: Colors.grey.withOpacity(0.1),
                    child: IconButton(
                      icon: Icon(
                        Icons.play_circle_filled_sharp,
                        color: Colors.redAccent,
                        size: 45.0,
                      ),
                      onPressed: () {
                        Get.to(
                          () => ViewVideoScreen(
                            youTubeLink:
                                'https://www.youtube.com/watch?v=fyLtzh0zv9A',
                            youTubeTitle:
                                'Final Day Of Fasting and Prayer Conquest',
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text(
                      '${widget.vid_title}',
                      maxLines: 2,
                    ),
                  ),
                ),
                Container(
                  child: PopupMenuButton(
                    icon: Icon(
                      Icons.more_vert_sharp,
                    ),
                    enabled: true,
                    onSelected: (value) {
                      if (value == 'play') {
                        Get.to(
                          () => ViewVideoScreen(
                            youTubeLink:
                                'https://www.youtube.com/watch?v=fyLtzh0zv9A',
                            youTubeTitle:
                                'Final Day Of Fasting and Prayer Conquest',
                          ),
                        );
                      }
                      setState(() {
                        //_value = value;
                        //print(_value);
                      });
                    },
                    itemBuilder: (context) => [
                      PopupMenuItem(
                        child: Text("Play"),
                        value: "play",
                      ),
                      PopupMenuItem(
                        child: Text("Download"),
                        value: "Download",
                      ),
                      PopupMenuItem(
                        child: Text("Add to Playlist"),
                        value: "Add to Playlist",
                      ),
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
