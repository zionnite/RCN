import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:rcn/controller/itestify_controller.dart';
import 'package:rcn/widget/itestify_widget.dart';
import 'package:speed_dial_fab/speed_dial_fab.dart';

class ItestifyScreen extends StatefulWidget {
  const ItestifyScreen({Key? key}) : super(key: key);

  @override
  _ItestifyScreenState createState() => _ItestifyScreenState();
}

class _ItestifyScreenState extends State<ItestifyScreen> {
  final itestListController = ItestifyController().getXID;
  late ScrollController _controller;
  var user_id = 2;
  var current_page = 1;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    itestListController.getDetails(current_page, user_id);
    _controller = ScrollController()..addListener(_scrollListener);
  }

  void _scrollListener() {
    if (_controller.position.pixels == _controller.position.maxScrollExtent) {
      setState(() {
        isLoading = true;
        current_page++;
      });

      //

      itestListController.getMoreDetail(current_page, user_id);

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
      appBar: AppBar(
        backgroundColor: Colors.deepOrange,
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'iTestify',
              style: TextStyle(),
            ),
          ],
        ),
      ),
      floatingActionButton: SpeedDialFabWidget(
        secondaryIconsList: [
          Icons.add,
        ],
        secondaryIconsText: [
          "Share Testimony",
        ],
        secondaryIconsOnPress: [
          () => {callBottomSheet()},
        ],
        secondaryBackgroundColor: Colors.grey[900],
        secondaryForegroundColor: Colors.grey[100],
        primaryBackgroundColor: Colors.deepOrange,
        primaryForegroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        controller: _controller,
        child: Obx(
          () => ListView.builder(
            shrinkWrap: true,
            physics: ClampingScrollPhysics(),
            scrollDirection: Axis.vertical,
            itemCount: itestListController.itestList.length,
            itemBuilder: (BuildContext context, int index) {
              if (index == itestListController.itestList.length - 1 &&
                  itestListController.isMoreDataAvailable.value == true) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (itestListController.itestList[index].id == null) {
                itestListController.isMoreDataAvailable.value = false;
                return Container();
              }
              return ItestifyWidget(
                test_img: itestListController.itestList[index].userImage,
                test_full_name: itestListController.itestList[index].fullName,
                test_user_name: itestListController.itestList[index].userName,
                test_counter: itestListController.itestList[index].counter,
                test_body: itestListController.itestList[index].body,
                isTestLike: itestListController.itestList[index].isTeskLike,
                test_id: itestListController.itestList[index].id,
                user_id: user_id.toString(),
              );
            },
          ),
        ),
      ),
    );
  }

  callBottomSheet() {
    print('Sheet Called');
  }
}
