import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:rcn/model/announcement_model.dart';
import 'package:rcn/services/api_services.dart';

class AnnouncementController extends GetxController {
  AnnouncementController get getXID => Get.find<AnnouncementController>();
  ScrollController announcementScrollController = ScrollController();
  var page_num = 1;
  var isDataProcessing = false.obs;
  var isMoreDataAvailable = true.obs;

  var annList = <AnnouncementModel>[].obs;

  @override
  void onInit() {
    getData();
    super.onInit();
    paginationTask();
  }

  getData() async {
    var seeker = await ApiServices.getAnnouncement(page_num);
    if (seeker != null) {
      annList.value = seeker;
    } else {
      showSnackBar('Oops!', "No more items", Colors.red);
    }
  }

  void paginationTask() {
    announcementScrollController.addListener(() {
      if (announcementScrollController.position.pixels ==
          announcementScrollController.position.maxScrollExtent) {
        page_num++;
        getDataMore(page_num);
      }
    });
  }

  void getDataMore(var page_num) async {
    var seeker = await ApiServices.getAnnouncement(page_num);

    if (seeker != null) {
      isMoreDataAvailable(true);
      annList.addAll(seeker);
    } else {
      isMoreDataAvailable(false);
      showSnackBar('Oops!', "No more items", Colors.red);
    }
  }

  showSnackBar(String title, String msg, Color backgroundColor) {
    Get.snackbar(
      title,
      msg,
      backgroundColor: backgroundColor,
      colorText: Colors.white,
    );
  }
}
