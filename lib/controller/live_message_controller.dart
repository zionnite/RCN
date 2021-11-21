import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:rcn/services/api_services.dart';

class LiveMessageController extends GetxController {
  LiveMessageController get getXID => Get.find<LiveMessageController>();
  var isLive = ''.obs;

  @override
  void onInit() {
    super.onInit();
    getLiveStatus();
  }

  getLiveStatus() async {
    var seeker = await ApiServices.get_live_status();
    if (seeker != null) {
      isLive.value = seeker;
    }
  }

  setIsLive(value) {
    isLive.value = value;
  }
}
