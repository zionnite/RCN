import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:rcn/model/video_msg_model.dart';
import 'package:rcn/services/api_services.dart';

class VideoMsgController extends GetxController {
  VideoMsgController get getXID => Get.find<VideoMsgController>();
  ScrollController videoScrollController = ScrollController();
  var page_num = 1;
  var isDataProcessing = false.obs;
  var isMoreDataAvailable = true.obs;

  var videoMsgList = <VideoMsg>[].obs;

  @override
  void onInit() {
    super.onInit();
  }

  getDetails(var user_id) async {
    var seeker = await ApiServices.getVideoMsg(page_num, user_id);
    if (seeker != null) {
      // sliderList.clear();
      videoMsgList.value = seeker;
    } else {
      showSnackBar('Oops!', "No more items", Colors.red);
    }
  }

  void paginationTask(var user_id) {
    videoScrollController.addListener(() {
      if (videoScrollController.position.pixels ==
          videoScrollController.position.maxScrollExtent) {
        page_num++;
        getMoreDetail(page_num, user_id);
      }
    });
  }

  void getMoreDetail(var page_num, var user_id) async {
    var seeker = await ApiServices.getVideoMsg(page_num, user_id);

    if (seeker != null) {
      isMoreDataAvailable(true);
      videoMsgList.addAll(seeker);
    } else {
      isMoreDataAvailable(false);
      showSnackBar('Oops!', "No more items", Colors.red);
    }

    if (isMoreDataAvailable == false) {
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
