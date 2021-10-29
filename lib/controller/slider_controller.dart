import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rcn/model/slider.dart';
import 'package:rcn/services/api_services.dart';

class SliderController extends GetxController {
  SliderController get getXID => Get.find<SliderController>();

  var sliderList = <SliderModel>[].obs;

  @override
  void onInit() {
    getSliders();
    super.onInit();
  }

  getSliders() async {
    var slider = await ApiServices.getApiSlider();
    if (slider != null) {
      // sliderList.clear();
      sliderList.value = slider;
    } else {
      SnackBar(
        content: Text('No Slider available yet!'),
      );
    }
  }
}
