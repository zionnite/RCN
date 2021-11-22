import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rcn/controller/video_msg_controller.dart';
import 'package:rcn/widget/video_message_player_widget.dart';

class YourVideoPlaylist extends StatefulWidget {
  const YourVideoPlaylist({Key? key}) : super(key: key);

  @override
  _YourVideoPlaylistState createState() => _YourVideoPlaylistState();
}

class _YourVideoPlaylistState extends State<YourVideoPlaylist> {
  final videoMsgListController = VideoMsgController().getXID;
  late ScrollController _controller;

  TextEditingController searchTermController = TextEditingController();
  late String searchTerm;
  bool _showStatus = false;
  late String _statusMsg;
  var user_id = 2;
  var current_page = 1;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    videoMsgListController.getPlaylistDetails(user_id);
    _controller = ScrollController()..addListener(_scrollListener);
  }

  void _scrollListener() {
    if (_controller.position.pixels == _controller.position.maxScrollExtent) {
      setState(() {
        isLoading = true;
        current_page++;
      });

      //

      videoMsgListController.getPlaylistMoreDetail(current_page, user_id);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        controller: _controller,
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  height: 200,
                  width: double.infinity,
                  color: Colors.deepOrange,
                  child: Padding(
                    padding: EdgeInsets.only(top: 100.0),
                    child: Text(
                      'Video Playlist',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 35.0,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                Positioned(
                  top: 40,
                  left: 10,
                  child: IconButton(
                    icon: Icon(
                      Icons.arrow_back_ios,
                      color: Colors.white,
                    ),
                    onPressed: () => Get.back(),
                  ),
                ),
              ],
            ),
            Container(
              margin: EdgeInsets.only(
                top: 0,
              ),
              child: Column(
                children: [
                  Obx(
                    () => ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      physics: ClampingScrollPhysics(),
                      itemCount: videoMsgListController.videoMsgPlayList.length,
                      itemBuilder: (BuildContext context, int index) {
                        if (videoMsgListController.videoMsgPlayList[index].id ==
                            null) {
                          return Center(
                            child: Text(
                              'Your Playlist is empty',
                              style: TextStyle(
                                fontSize: 20.0,
                              ),
                            ),
                          );
                        }
                        if (index > 0 &&
                            index ==
                                videoMsgListController.videoMsgPlayList.length -
                                    1 &&
                            videoMsgListController.isMoreDataAvailable.value ==
                                true) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        if (videoMsgListController.videoMsgPlayList[index].id ==
                            null) {
                          videoMsgListController.isMoreDataAvailable.value =
                              false;
                          return Container();
                        }
                        return VideoMessagePlayerWidget(
                          vid_image: videoMsgListController
                              .videoMsgPlayList[index].image,
                          vid_link: videoMsgListController
                              .videoMsgPlayList[index].link,
                          vid_title: videoMsgListController
                              .videoMsgPlayList[index].title,
                          vid_id:
                              videoMsgListController.videoMsgPlayList[index].id,
                          user_id: user_id.toString(),
                          isPlayListed: videoMsgListController
                              .videoMsgPlayList[index].isPlayListed,
                          // vid_album: 'Ministration',
                        );
                      },
                    ),
                  ),
                  //SelectedOptions(item_selected: _selectedChoices),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
