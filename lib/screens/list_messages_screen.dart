import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:rcn/widget/list_message_widget.dart';

class ListMessagesScreen extends StatefulWidget {
  const ListMessagesScreen({Key? key}) : super(key: key);

  @override
  _ListMessagesScreenState createState() => _ListMessagesScreenState();
}

// class PopupItem {
//   int value;
//   String name;
//   PopupItem({required this.value, required this.name});
// }

class _ListMessagesScreenState extends State<ListMessagesScreen> {
  TextEditingController searchTermController = TextEditingController();
  late String searchTerm;
  bool _showStatus = false;
  late String _statusMsg;
  var _value;
  // late PopupItem _popupItem;
  //
  // List<PopupItem> _list = [
  //   PopupItem(value: 1, name: "First Value"),
  //   PopupItem(value: 2, name: "Second Item"),
  //   PopupItem(value: 3, name: "Third Item"),
  //   PopupItem(value: 4, name: "Fourth Item")
  // ];
  //
  // late PopupItem _selectedChoices;
  // void _select(PopupItem choice) {
  //   setState(() {
  //     _selectedChoices = choice;
  //   });
  // }

  void searchAudioMessage() {}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Colors.deepOrange,
      // ),
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
                              searchAudioMessage();
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
                  // PopupMenuButton(
                  //   color: Colors.yellowAccent,
                  //   elevation: 20,
                  //   enabled: true,
                  //   onSelected: _select,
                  //   itemBuilder: (context) {
                  //     return _list.map((PopupItem item) {
                  //       return PopupMenuItem(
                  //         value: item,
                  //         child: Text(item.name),
                  //       );
                  //     }).toList();
                  //   },
                  // ),

                  Card(
                    child: ListView(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      physics: ClampingScrollPhysics(),
                      children: [
                        ListMessageWidget(
                          aud_image:
                              'https://rcnsermons.org/wp-content/uploads/2020/05/Apostle-Arome-Osayi-365x365.png',
                          aud_link:
                              'https://rcnsermons.org/2021%20updload/01%20January%202021%20-%20Prayer%20And%20Fasting/08%20Inner%20Knowledge%20Of%20Reckoning%20-%20%28Apst.%20Arome%20Osayi%29%20-%20Wed.%2014th%202021.mp3',
                          aud_title: 'January 2021 - Prayer and Fasting',
                          aud_id: '1',
                          aud_album: 'Ministration',
                        ),
                        ListMessageWidget(
                          aud_image:
                              'https://rcnsermons.org/wp-content/uploads/2020/05/Apostle-Arome-Osayi-365x365.png',
                          aud_link:
                              'https://rcnsermons.org/2021%20updload/01%20January%202021%20-%20Prayer%20And%20Fasting/08%20Inner%20Knowledge%20Of%20Reckoning%20-%20%28Apst.%20Arome%20Osayi%29%20-%20Wed.%2014th%202021.mp3',
                          aud_title: 'January 2021 - Prayer and Fasting',
                          aud_id: '2',
                          aud_album: 'Ministration',
                        ),
                        ListMessageWidget(
                          aud_image:
                              'https://rcnsermons.org/wp-content/uploads/2020/05/Apostle-Arome-Osayi-365x365.png',
                          aud_link:
                              'https://rcnsermons.org/2021%20updload/01%20January%202021%20-%20Prayer%20And%20Fasting/08%20Inner%20Knowledge%20Of%20Reckoning%20-%20%28Apst.%20Arome%20Osayi%29%20-%20Wed.%2014th%202021.mp3',
                          aud_title: 'January 2021 - Prayer and Fasting',
                          aud_id: '3',
                          aud_album: 'Ministration',
                        ),
                      ],
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

// class SelectedOptions extends StatelessWidget {
//   const SelectedOptions({Key? key, required this.item_selected})
//       : super(key: key);
//   final PopupItem item_selected;
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: Column(
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text("Item Selected Name"),
//               Text(item_selected.name),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }
