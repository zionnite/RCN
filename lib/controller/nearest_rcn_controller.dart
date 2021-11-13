import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:rcn/model/nearest_rcn_model.dart';
import 'package:rcn/services/api_services.dart';

class NearestRcnController extends GetxController {
  NearestRcnController get getXID => Get.find<NearestRcnController>();
  ScrollController nearestScrollController = ScrollController();
  var page_num = 1;
  var isDataProcessing = false.obs;
  var isMoreDataAvailable = true.obs;

  var nearList = <NearestRcnModel>[].obs;

  @override
  void onInit() {
    getData();
    super.onInit();
    paginationTask();
  }

  getData() async {
    var seeker = await ApiServices.getNearestRCN(page_num);
    if (seeker != null) {
      nearList.value = seeker;
    } else {
      showSnackBar('Oops!', "No more items", Colors.red);
    }
  }

  void paginationTask() {
    // isMoreDataAvailable(true);
    nearestScrollController.addListener(() {
      if (nearestScrollController.position.pixels ==
          nearestScrollController.position.maxScrollExtent) {
        page_num++;
        getDataMore(page_num);
      }
    });
  }

  void getDataMore(var page_num) async {
    var seeker = await ApiServices.getNearestRCN(page_num);

    if (seeker != null) {
      isMoreDataAvailable(true);
      nearList.addAll(seeker);
      Future.delayed(new Duration(seconds: 4), () {
        isMoreDataAvailable(false);
      });
    } else {
      // isMoreDataAvailable(false);
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
