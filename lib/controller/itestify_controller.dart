import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:rcn/model/itestify_model.dart';
import 'package:rcn/services/api_services.dart';

class ItestifyController extends GetxController {
  ItestifyController get getXID => Get.find<ItestifyController>();
  ScrollController itestifyScrollController = ScrollController();
  var page_num = 1;
  var isDataProcessing = false.obs;
  var isMoreDataAvailable = true.obs;

  var itestList = <ItestifyModel>[].obs;
  var searchitestList = <ItestifyModel>[].obs;

  @override
  void onInit() {
    super.onInit();
  }

  getDetails(var page_num, var user_id) async {
    var seeker = await ApiServices.getItestify(page_num, user_id);
    if (seeker != null) {
      itestList.value = seeker;
    } else {
      showSnackBar('Oops!', "No more items", Colors.red);
    }
  }

  void paginationTask(var page_num, var user_id) {
    itestifyScrollController.addListener(() {
      if (itestifyScrollController.position.pixels ==
          itestifyScrollController.position.maxScrollExtent) {
        page_num++;
        getMoreDetail(page_num, user_id);
      }
    });
  }

  void getMoreDetail(var page_num, var user_id) async {
    var seeker = await ApiServices.getItestify(page_num, user_id);

    if (seeker != null) {
      isMoreDataAvailable(true);
      itestList.addAll(seeker);
    } else {
      isMoreDataAvailable(false);
      showSnackBar('Oops!', "No more items", Colors.red);
    }

    if (isMoreDataAvailable == false) {
      showSnackBar('Oops!', "No more items", Colors.red);
    }
  }

  Future<String> toggle_testify(var user_id, var audio_id) async {
    var seeker = await ApiServices.toggleTestimonylist(user_id, audio_id);

    if (seeker == "deleted") {
      showSnackBar("Removed", "Testimony Unlike", Colors.red);
    } else if (seeker == "un_deleted") {
      showSnackBar(
          "Oops!!", "could not unlike this testimony", Colors.deepOrange);
    } else if (seeker == "added") {
      showSnackBar("Success", "Testimony Like by you", Colors.green);
    } else if (seeker == "un_added") {
      showSnackBar("Oops!!", "could not like testimony", Colors.deepOrange);
    } else {
      showSnackBar("Oops!!", "Unidentified error occur", Colors.deepOrange);
    }

    return seeker;
    //return seeker;
  }

  showSnackBar(String title, String msg, Color backgroundColor) {
    Get.snackbar(
      title,
      msg,
      backgroundColor: backgroundColor,
      colorText: Colors.white,
      snackPosition: SnackPosition.BOTTOM,
    );
  }
}
