import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/state_manager.dart';
import 'package:loading/indicator/ball_pulse_indicator.dart';
import 'package:loading/loading.dart';
import 'package:rcn/controller/video_msg_controller.dart';
import 'package:rcn/widget/video_message_player_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class searchVideoMessageScreen extends StatefulWidget {
  searchVideoMessageScreen({Key? key, required this.search_term})
      : super(key: key);
  String search_term;

  @override
  _searchVideoMessageScreenState createState() =>
      _searchVideoMessageScreenState();
}

class _searchVideoMessageScreenState extends State<searchVideoMessageScreen> {
  final videoMsgListController = VideoMsgController().getXID;
  late ScrollController _controller;

  TextEditingController searchTermController = TextEditingController();
  late String searchTerm;
  bool _showStatus = false;
  late String _statusMsg;
  var user_id;
  var current_page = 1;
  bool isLoading = false;
  bool widgetLoading = true;

  getIfVideoLoaded() {
    var loading = videoMsgListController.isDataSearchProcessing.value;
    if (loading) {
      setState(() {
        widgetLoading = false;
      });
    }
  }

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

    videoMsgListController.fetch_search_page(
        current_page, widget.search_term, user_id);
  }

  @override
  void initState() {
    super.initState();
    _initUserDetail();

    _controller = ScrollController()..addListener(_scrollListener);

    Future.delayed(new Duration(seconds: 4), () {
      if (mounted) {
        setState(() {
          getIfVideoLoaded();
        });
      }
    });
  }

  void _scrollListener() {
    if (_controller.position.pixels == _controller.position.maxScrollExtent) {
      setState(() {
        isLoading = true;
        current_page++;
      });

      //

      videoMsgListController.fetch_search_page_by_pagination(
        current_page,
        widget.search_term,
        user_id,
      );

      Future.delayed(new Duration(seconds: 1), () {
        if (mounted) {
          setState(() {
            isLoading = false;
          });
        }
      });
    }
  }

  void searchVideo() {
    videoMsgListController.fetch_search_page(1, searchTerm, user_id);
    _controller = ScrollController()..addListener(_scrollListener);
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
                      'Search Video',
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
                              searchVideo();
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
              child: (widgetLoading)
                  ? Center(
                      child: Loading(
                        indicator: BallPulseIndicator(),
                        size: 50.0,
                        color: Colors.redAccent,
                      ),
                    )
                  : Column(
                      children: [
                        Obx(
                          () => ListView.builder(
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            physics: ClampingScrollPhysics(),
                            itemCount: videoMsgListController
                                .searchvideoMsgList.length,
                            itemBuilder: (BuildContext context, int index) {
                              if (index ==
                                      videoMsgListController
                                              .searchvideoMsgList.length -
                                          1 &&
                                  isLoading == true) {
                                return Center(
                                  child: CircularProgressIndicator(),
                                );
                              }
                              if (videoMsgListController
                                      .searchvideoMsgList[index].id ==
                                  null) {
                                videoMsgListController
                                    .isMoreDataAvailable.value = false;
                                return Container();
                              }
                              return VideoMessagePlayerWidget(
                                vid_image: videoMsgListController
                                    .searchvideoMsgList[index].image,
                                vid_link: videoMsgListController
                                    .searchvideoMsgList[index].link,
                                vid_title: videoMsgListController
                                    .searchvideoMsgList[index].title,
                                vid_id: videoMsgListController
                                    .searchvideoMsgList[index].id,
                                user_id: user_id.toString(),
                                isPlayListed: videoMsgListController
                                    .videoMsgList[index].isPlayListed,
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
