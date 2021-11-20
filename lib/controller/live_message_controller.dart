import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class LiveMessageController extends GetxController {
  LiveMessageController get getXID => Get.find<LiveMessageController>();
  var isLive = false.obs;

  setIsLive(value) {
    isLive.value = value;
  }
}
