import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:rcn/services/api_services.dart';

class SendMessageController extends GetxController {
  SendMessageController get getXID => Get.find<SendMessageController>();
  var isSubmitting = false.obs;
  Future<bool> send(var email, var name, var message) async {
    isSubmitting.value = true;
    var seeker = await ApiServices.submitMessage(email, name, message);

    if (seeker == true) {
      isSubmitting.value = false;
      showSnackBar("Success", "Message sent successfully!", Colors.green);
    } else if (seeker == false) {
      isSubmitting.value = false;
      showSnackBar(
          "Oops!!", "Database busy, please try again later", Colors.black);
    } else {
      isSubmitting.value = false;
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
