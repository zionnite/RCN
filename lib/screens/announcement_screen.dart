import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:rcn/controller/announcement_controller.dart';
import 'package:rcn/widget/announcement_widget.dart';

class AnnouncementScreen extends StatefulWidget {
  const AnnouncementScreen({Key? key}) : super(key: key);

  @override
  _AnnouncementScreenState createState() => _AnnouncementScreenState();
}

class _AnnouncementScreenState extends State<AnnouncementScreen> {
  final anListController = AnnouncementController().getXID;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.deepOrange,
        title: Text('Announcement'),
      ),
      body: SingleChildScrollView(
        controller: anListController.announcementScrollController,
        child: Obx(
          () => ListView.builder(
            shrinkWrap: true,
            physics: ClampingScrollPhysics(),
            scrollDirection: Axis.vertical,
            itemCount: anListController.annList.length,
            itemBuilder: (BuildContext context, int index) {
              if (index == anListController.annList.length - 1 &&
                  anListController.isMoreDataAvailable.value == true) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (anListController.annList[index].id == null) {
                anListController.isMoreDataAvailable.value = false;
                return Container();
              }
              return AnnouncementWidget(
                an_img: anListController.annList[index].image,
                an_body: anListController.annList[index].body,
                an_date: anListController.annList[index].date,
              );
            },
          ),
        ),
      ),
    );
  }
}
