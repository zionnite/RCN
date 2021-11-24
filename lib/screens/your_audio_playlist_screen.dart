import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';
import 'package:rcn/controller/audio_msg_controller.dart';
import 'package:rcn/controller/live_message_controller.dart';
import 'package:rcn/widget/list_message_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class YourAudioPlaylist extends StatefulWidget {
  const YourAudioPlaylist({Key? key}) : super(key: key);

  @override
  _YourAudioPlaylistState createState() => _YourAudioPlaylistState();
}

class _YourAudioPlaylistState extends State<YourAudioPlaylist> {
  final liveMsg = LiveMessageController().getXID;
  final audioMsgListController = AudioMsgController().getXID;
  late ScrollController _controller;

  TextEditingController searchTermController = TextEditingController();
  late String searchTerm;
  bool _showStatus = false;
  late String _statusMsg;
  String? user_id;
  var current_page = 1;
  bool isLoading = false;

  _initUserDetail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var isUserLogin = prefs.getBool('isUserLogin');
    var user_id1 = prefs.getString('user_id');
    var user_name1 = prefs.getString('user_name');
    var user_full_name = prefs.getString('full_name');
    var user_email = prefs.getString('email');
    var user_img1 = prefs.getString('user_img');
    var user_age = prefs.getString('age');
    var phone_no1 = prefs.getString('phone_no');

    setState(() {
      user_id = user_id1!;
    });

    audioMsgListController.getPlaylistDetails(user_id);
  }

  @override
  void initState() {
    super.initState();
    _initUserDetail();
    _controller = ScrollController()..addListener(_scrollListener);
  }

  void _scrollListener() {
    if (_controller.position.pixels == _controller.position.maxScrollExtent) {
      setState(() {
        isLoading = true;
        current_page++;
      });

      //

      audioMsgListController.getMorePlaylistDetail(current_page, user_id);

      Future.delayed(new Duration(seconds: 4), () {
        setState(() {
          isLoading = false;
        });
      });
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
                      'Audio Playlist',
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
                  Card(
                    child: Obx(
                      () => ListView.builder(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount:
                            audioMsgListController.audioMsgPlayList.length,
                        physics: ClampingScrollPhysics(),
                        itemBuilder: (BuildContext context, int index) {
                          if (index ==
                                  audioMsgListController
                                          .audioMsgPlayList.length -
                                      1 &&
                              isLoading == true) {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                          if (audioMsgListController
                                  .audioMsgPlayList[index].id ==
                              null) {
                            audioMsgListController.isMoreDataAvailable.value =
                                false;
                            return Container();
                          }

                          return ListMessageWidget(
                            aud_image: audioMsgListController
                                .audioMsgPlayList[index].image,
                            aud_link: audioMsgListController
                                .audioMsgPlayList[index].link,
                            aud_title: audioMsgListController
                                .audioMsgPlayList[index].title,
                            aud_id: audioMsgListController
                                .audioMsgPlayList[index].id,
                            aud_album: audioMsgListController
                                .audioMsgPlayList[index].album,
                            user_id: user_id.toString(),
                            isPlayListed: audioMsgListController
                                .audioMsgPlayList[index].isPlayListed,
                          );
                        },
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
}
