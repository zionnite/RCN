import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/route_manager.dart';
import 'package:rcn/component/video_message_player_widget.dart';

class VideoMessage extends StatefulWidget {
  const VideoMessage({Key? key}) : super(key: key);

  @override
  _VideoMessageState createState() => _VideoMessageState();
}

class _VideoMessageState extends State<VideoMessage> {
  TextEditingController searchTermController = TextEditingController();
  late String searchTerm;
  bool _showStatus = false;
  late String _statusMsg;
  var _value;

  void searchVideoMessage() {}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
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
                  ListView(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    physics: ClampingScrollPhysics(),
                    children: [
                      VideoMessagePlayerWidget(
                        vid_image:
                            'https://rcnsermons.org/wp-content/uploads/2020/05/Apostle-Arome-Osayi-365x365.png',
                        vid_link:
                            'https://rcnsermons.org/2021%20updload/01%20January%202021%20-%20Prayer%20And%20Fasting/08%20Inner%20Knowledge%20Of%20Reckoning%20-%20%28Apst.%20Arome%20Osayi%29%20-%20Wed.%2014th%202021.mp3',
                        vid_title: 'January 2021 - Prayer and Fasting',
                        //vid_id: '1',
                        // vid_album: 'Ministration',
                      ),
                      VideoMessagePlayerWidget(
                        vid_image:
                            'https://rcnsermons.org/wp-content/uploads/2020/05/Apostle-Arome-Osayi-365x365.png',
                        vid_link:
                            'https://rcnsermons.org/2021%20updload/01%20January%202021%20-%20Prayer%20And%20Fasting/08%20Inner%20Knowledge%20Of%20Reckoning%20-%20%28Apst.%20Arome%20Osayi%29%20-%20Wed.%2014th%202021.mp3',
                        vid_title: 'Feburar 2021 - Prayer and Fasting',
                        // vid_id: '2',
                        // vid_album: 'Ministration',
                      ),
                    ],
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
