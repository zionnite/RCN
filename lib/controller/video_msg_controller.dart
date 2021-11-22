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
  var searchvideoMsgList = <VideoMsg>[].obs;
  var videoMsgPlayList = <VideoMsg>[].obs;

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

  void fetch_search_page(var page_num, var search_term, var user_id) async {
    var seeker =
        await ApiServices.getSearchVideoMsg(page_num, search_term, user_id);

    if (seeker != null) {
      isMoreDataAvailable(true);
      searchvideoMsgList.clear();
      searchvideoMsgList.addAll(seeker);
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
        await ApiServices.getSearchVideoMsg(page_num, search_term, user_id);

    if (seeker != null) {
      isMoreDataAvailable(true);
      searchvideoMsgList.addAll(seeker);
    } else {
      isMoreDataAvailable(false);
      showSnackBar('Oops!', "No more items", Colors.red);
    }

    if (isMoreDataAvailable == false) {
      showSnackBar('Oops!', "No more items", Colors.red);
    }
  }

  Future<String> toggle_playlist(var user_id, var audio_id) async {
    var seeker = await ApiServices.toggleVideoPlaylist(user_id, audio_id);

    if (seeker == "deleted") {
      showSnackBar("Removed", "Video removed from your playlist", Colors.red);
    } else if (seeker == "un_deleted") {
      showSnackBar("Oops!!", "could not removed Video from your playlist",
          Colors.deepOrange);
    } else if (seeker == "added") {
      showSnackBar("Success", "Video added to your playlist", Colors.green);
    } else if (seeker == "un_added") {
      showSnackBar("Oops!!", "Video could not be added to your playlist",
          Colors.deepOrange);
    } else {
      showSnackBar("Oops!!", "Unidentified error occur", Colors.deepOrange);
    }

    return seeker;
  }

  getPlaylistDetails(var user_id) async {
    var seeker = await ApiServices.getPlaylistVideoMsg(page_num, user_id);
    if (seeker != null) {
      // sliderList.clear();
      videoMsgPlayList.value = seeker;
    } else {
      showSnackBar('Oops!', "No more items", Colors.red);
    }
  }

  void getPlaylistMoreDetail(var page_num, var user_id) async {
    var seeker = await ApiServices.getPlaylistVideoMsg(page_num, user_id);

    if (seeker != null) {
      isMoreDataAvailable(true);
      videoMsgPlayList.addAll(seeker);
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
      snackPosition: SnackPosition.BOTTOM,
    );
  }
}
