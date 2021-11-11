import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:rcn/model/audio_msg_model.dart';
import 'package:rcn/services/api_services.dart';

class AudioMsgController extends GetxController {
  AudioMsgController get getXID => Get.find<AudioMsgController>();
  ScrollController audioScrollController = ScrollController();
  var page_num = 1;
  var isDataProcessing = false.obs;
  var isMoreDataAvailable = true.obs;

  var audioMsgList = <AudioMsg>[].obs;

  @override
  void onInit() {
    super.onInit();
  }

  getDetails(var user_id) async {
    var seeker = await ApiServices.getAudioMsg(page_num, user_id);
    if (seeker != null) {
      // sliderList.clear();
      audioMsgList.value = seeker;
    } else {
      showSnackBar('Oops!', "No more items", Colors.red);
    }
  }

  void paginationTask(var user_id) {
    audioScrollController.addListener(() {
      if (audioScrollController.position.pixels ==
          audioScrollController.position.maxScrollExtent) {
        page_num++;
        getMoreDetail(page_num, user_id);
      }
    });
  }

  void getMoreDetail(var page_num, var user_id) async {
    print('userid ${user_id}');
    var seeker = await ApiServices.getAudioMsg(page_num, user_id);
    print('Scroll fire+++++');

    if (seeker != null) {
      isMoreDataAvailable(true);
      audioMsgList.addAll(seeker);
    } else {
      print('Scroll fire');
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
