import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';
import 'package:rcn/controller/audio_msg_controller.dart';
import 'package:rcn/controller/live_message_controller.dart';
import 'package:rcn/screens/search_audio_message_screen.dart';
import 'package:rcn/widget/list_message_widget.dart';

class ListMessagesScreen extends StatefulWidget {
  const ListMessagesScreen({Key? key}) : super(key: key);

  @override
  _ListMessagesScreenState createState() => _ListMessagesScreenState();
}

class _ListMessagesScreenState extends State<ListMessagesScreen> {
  final liveMsg = LiveMessageController().getXID;
  final audioMsgListController = AudioMsgController().getXID;
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
    audioMsgListController.getDetails(user_id);
    _controller = ScrollController()..addListener(_scrollListener);
  }

  void _scrollListener() {
    if (_controller.position.pixels == _controller.position.maxScrollExtent) {
      setState(() {
        isLoading = true;
        current_page++;
      });

      //

      audioMsgListController.getMoreDetail(current_page, user_id);

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
                      'Audio Message',
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
                        hintText: 'Search Audio Message',
                        suffixIcon: IconButton(
                          icon: Icon(Icons.search),
                          onPressed: () {
                            if (!searchTermController.text.isEmpty) {
                              setState(() {
                                searchTermController.text = '';
                                _showStatus = false;
                              });

                              Get.to(
                                () => SearchAudioMessageScreen(
                                  search_term: searchTerm,
                                ),
                              );
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
                  Card(
                    child: Obx(
                      () => ListView.builder(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: audioMsgListController.audioMsgList.length,
                        physics: ClampingScrollPhysics(),
                        itemBuilder: (BuildContext context, int index) {
                          if (index ==
                                  audioMsgListController.audioMsgList.length -
                                      1 &&
                              isLoading == true) {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                          if (audioMsgListController.audioMsgList[index].id ==
                              null) {
                            audioMsgListController.isMoreDataAvailable.value =
                                false;
                            return Container();
                          }

                          return ListMessageWidget(
                            aud_image: audioMsgListController
                                .audioMsgList[index].image,
                            aud_link:
                                audioMsgListController.audioMsgList[index].link,
                            aud_title: audioMsgListController
                                .audioMsgList[index].title,
                            aud_id:
                                audioMsgListController.audioMsgList[index].id,
                            aud_album: audioMsgListController
                                .audioMsgList[index].album,
                            user_id: user_id.toString(),
                            isPlayListed: audioMsgListController
                                .audioMsgList[index].isPlayListed,
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
