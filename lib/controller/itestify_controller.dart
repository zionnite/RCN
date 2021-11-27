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
      isDataProcessing(true);
      itestList.value = seeker;
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

  Future<String> add_testimony(var user_id, var msg) async {
    var seeker = await ApiServices.submitTestimony(user_id, msg);

    if (seeker == "success") {
      showSnackBar("Success", "Submitted successfully, awaiting staff approval",
          Colors.green);
    } else if (seeker == "error_1" || seeker == "error_2") {
      showSnackBar(
          "Oops!!", "Database busy, please try again later!", Colors.red);
    } else {
      showSnackBar("Oops!!", "Unidentified error occur", Colors.deepOrange);
    }

    return seeker;
    //return seeker;
  }

  Future<String> report(var user_id, var test_id, var reason) async {
    var seeker = await ApiServices.report_testimony(user_id, test_id, reason);

    if (seeker == "success") {
      showSnackBar(
          "Success",
          "Report Submitted, our staff will act on it accordingly",
          Colors.green);
    } else if (seeker == "fail_01") {
      showSnackBar(
          "Oops!!", "Database busy, please try again later!", Colors.red);
    } else if (seeker == "fail_02") {
      showSnackBar(
          "Oops!!",
          "You have already, submitted this post for review, please hold while we looked into it!",
          Colors.red);
    } else {
      showSnackBar("Oops!!", "Unidentified error occur", Colors.deepOrange);
    }

    return seeker;
    //return seeker;
  }

  Future<String> block_user(var user_id, var test_id) async {
    var seeker = await ApiServices.block_test_user(user_id, test_id);

    if (seeker == "success") {
      showSnackBar("Success",
          "You will no longer see any write-up from this user!", Colors.green);
    } else if (seeker == "fail_01") {
      showSnackBar("Oops!!", "You Can'\t block yourself", Colors.red);
    } else if (seeker == "fail") {
      showSnackBar(
          "Oops!!",
          "Database busy, please try again later OR you have already block user!",
          Colors.deepOrange);
    } else if (seeker == "already") {
      showSnackBar("Oops!!", "You have already block this user!", Colors.red);
    } else {
      showSnackBar("Oops!!", "Unidentified error occur", Colors.deepOrange);
    }

    return seeker;
  }

  Future<String> delete(var user_id, var test_id) async {
    var seeker = await ApiServices.delete_test(user_id, test_id);

    if (seeker == "true") {
      showSnackBar("Success", "Post Deleted for you!", Colors.green);
    } else if (seeker == "false") {
      showSnackBar(
          "Oops!!", "Database busy, please try again later", Colors.black);
    } else if (seeker == "already") {
      showSnackBar("Oops!!", "This Post has already be deleted for you!",
          Colors.deepOrange);
    } else {
      showSnackBar("Oops!!", "Unidentified error occur", Colors.deepOrange);
    }

    return seeker;
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
