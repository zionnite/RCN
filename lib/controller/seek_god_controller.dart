import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:rcn/model/seek_god.dart';
import 'package:rcn/services/api_services.dart';

class SeekGodController extends GetxController {
  SeekGodController get getXID => Get.find<SeekGodController>();
  ScrollController scrollController = ScrollController();
  var page_num = 1;
  var isDataProcessing = false.obs;
  var isMoreDataAvailable = true.obs;

  var seekGodList = <SeeKGod>[].obs;

  @override
  void onInit() {
    getSeekGod();
    super.onInit();
    paginationTask();
  }

  getSeekGod() async {
    var seeker = await ApiServices.getSeekGod(page_num);
    if (seeker != null) {
      isDataProcessing(true);
      seekGodList.value = seeker;
    }
  }

  void paginationTask() {
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        page_num++;
        getSeekGodMore(page_num);
      }
    });
  }

  void getSeekGodMore(var page_num) async {
    var seeker = await ApiServices.getSeekGod(page_num);
    if (seeker != null) {
      isDataProcessing(true);
      seekGodList.addAll(seeker);
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

  // @override
  // void dispose() {
  //   super.dispose();
  //   scrollController.dispose();
  // }
}
