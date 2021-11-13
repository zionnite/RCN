import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/route_manager.dart';
import 'package:get/state_manager.dart';
import 'package:rcn/controller/video_msg_controller.dart';
import 'package:rcn/widget/video_message_player_widget.dart';

class VideoMessage extends StatefulWidget {
  const VideoMessage({Key? key}) : super(key: key);

  @override
  _VideoMessageState createState() => _VideoMessageState();
}

class _VideoMessageState extends State<VideoMessage> {
  final videoMsgListController = VideoMsgController().getXID;
  late ScrollController _controller;

  TextEditingController searchTermController = TextEditingController();
  late String searchTerm;
  bool _showStatus = false;
  late String _statusMsg;
  var user_id = 1;
  var current_page = 1;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    videoMsgListController.getDetails(user_id);
    _controller = ScrollController()..addListener(_scrollListener);
  }

  void _scrollListener() {
    if (_controller.position.pixels == _controller.position.maxScrollExtent) {
      setState(() {
        isLoading = true;
        current_page++;
      });

      //

      videoMsgListController.getMoreDetail(current_page, user_id);

      // Future.delayed(new Duration(seconds: 4), () {
      //   setState(() {
      //     isLoading = false;
      //   });
      // });
    }
  }

  void searchVideoMessage() {}
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
                      'Video Messages',
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
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 32.0),
                  margin: EdgeInsets.only(top: 180.0),
                  child: Material(
                    elevation: 5.0,
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    child: TextField(
                      controller: searchTermController,
                      onChanged: (text) {
                        setState(() {
                          searchTerm = text;
                          //forumBloc.searchSink.add(searchTerm);
                        });
                      },
                      style: TextStyle(color: Colors.black, fontSize: 16.0),
                      cursorColor: Colors.black,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 32.0,
                          vertical: 14.0,
                        ),
                        border: InputBorder.none,
                        hintText: 'Search Video Message',
                        suffixIcon: IconButton(
                          icon: Icon(Icons.search),
                          onPressed: () {
                            if (!searchTermController.text.isEmpty) {
                              setState(() {
                                searchTermController.text = '';
                                _showStatus = false;
                              });
                              searchVideoMessage();
                            } else {
                              setState(() {
                                setState(() {
                                  _showStatus = true;
                                  _statusMsg =
                                      'Search Term Field can\'t be empty!';
                                });
                              });
                            }
                          },
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            (_showStatus == true)
                ? Padding(
                    padding: const EdgeInsets.symmetric(vertical: 14.0),
                    child: Text(
                      _statusMsg,
                      style: TextStyle(
                        fontSize: 15.0,
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                : Container(),
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
                      itemCount: videoMsgListController.videoMsgList.length,
                      itemBuilder: (BuildContext context, int index) {
                        if (index ==
                                videoMsgListController.videoMsgList.length -
                                    1 &&
                            videoMsgListController.isMoreDataAvailable.value ==
                                true) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        if (videoMsgListController.videoMsgList[index].id ==
                            null) {
                          videoMsgListController.isMoreDataAvailable.value =
                              false;
                          return Container();
                        }
                        return VideoMessagePlayerWidget(
                          vid_image:
                              videoMsgListController.videoMsgList[index].image,
                          vid_link:
                              videoMsgListController.videoMsgList[index].link,
                          vid_title:
                              videoMsgListController.videoMsgList[index].title,
                          vid_id: videoMsgListController.videoMsgList[index].id,
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
