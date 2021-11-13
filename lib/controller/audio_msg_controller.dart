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
  var searchaudioMsgList = <AudioMsg>[].obs;

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
    var seeker = await ApiServices.getAudioMsg(page_num, user_id);

    if (seeker != null) {
      isMoreDataAvailable(true);
      audioMsgList.addAll(seeker);
    } else {
      isMoreDataAvailable(false);
      showSnackBar('Oops!', "No more items", Colors.red);
    }

    if (isMoreDataAvailable == false) {
      showSnackBar('Oops!', "No more items", Colors.red);
    }
  }

  void fetch_search_page(var page_num, var search_term, var user_id) async {
    var seeker =
        await ApiServices.getSearchAudioMsg(page_num, search_term, user_id);

    if (seeker != null) {
      isMoreDataAvailable(true);
      searchaudioMsgList.clear();
      searchaudioMsgList.addAll(seeker);
    } else {
      isMoreDataAvailable(false);
      showSnackBar('Oops!', "No more items", Colors.red);
    }

    if (isMoreDataAvailable == false) {
      showSnackBar('Oops!', "No more items", Colors.red);
    }
  }

  void fetch_search_page_by_pagination(
      var page_num, var search_term, var user_id) async {
    var seeker =
        await ApiServices.getSearchAudioMsg(page_num, search_term, user_id);

    if (seeker != null) {
      isMoreDataAvailable(true);
      searchaudioMsgList.addAll(seeker);
    } else {
      isMoreDataAvailable(false);
      showSnackBar('Oops!', "No more items", Colors.red);
    }

    if (isMoreDataAvailable == false) {
      showSnackBar('Oops!', "No more items", Colors.red);
    }
  }

  Future<String> toggle_playlist(var user_id, var audio_id) async {
    var seeker = await ApiServices.toggleAudioPlaylist(user_id, audio_id);

    if (seeker == "deleted") {
      showSnackBar("Removed", "Audio removed from your playlist", Colors.red);
    } else if (seeker == "un_deleted") {
      showSnackBar("Oops!!", "could not removed Audio from your playlist",
          Colors.deepOrange);
    } else if (seeker == "added") {
      showSnackBar("Success", "Audio added to your playlist", Colors.green);
    } else if (seeker == "un_added") {
      showSnackBar("Oops!!", "Audio could not be added to your playlist",
          Colors.deepOrange);
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
