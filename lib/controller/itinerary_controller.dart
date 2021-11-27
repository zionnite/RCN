import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:rcn/model/itinerary_model.dart';
import 'package:rcn/services/api_services.dart';

class ItineraryController extends GetxController {
  ItineraryController get getXID => Get.find<ItineraryController>();
  ScrollController itineraryScrollController = ScrollController();
  var page_num = 1;
  var isDataProcessing = false.obs;
  var isMoreDataAvailable = true.obs;

  var itinearyList = <Itinerary>[].obs;

  @override
  void onInit() {
    getItineray();
    super.onInit();
    paginationTask();
  }

  getItineray() async {
    var seeker = await ApiServices.getItinerary(page_num);
    if (seeker != null) {
      isDataProcessing(true);
      itinearyList.value = seeker;
    }
  }

  void paginationTask() {
    itineraryScrollController.addListener(() {
      if (itineraryScrollController.position.pixels ==
          itineraryScrollController.position.maxScrollExtent) {
        page_num++;
        getItinerarMore(page_num);
      }
    });
  }

  void getItinerarMore(var page_num) async {
    var seeker = await ApiServices.getItinerary(page_num);

    if (seeker != null) {
      isMoreDataAvailable(true);
      itinearyList.addAll(seeker);
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
