import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:rcn/services/api_services.dart';

class LoginSignupController extends GetxController {
  LoginSignupController get getXID => Get.find<LoginSignupController>();
  var isDataProcessing = false.obs;

  Future<String> signup(
      var user_name, var email, var password, var gender) async {
    var seeker =
        await ApiServices.userAuthSignup(email, password, user_name, gender);
    return seeker;
  }

  Future<String> login(email, var password) async {
    var seeker = await ApiServices.userAuthLogin(email, password);
    return seeker;
  }

  Future<String> reset(email) async {
    var seeker = await ApiServices.userAuthRest(email);
    return seeker;
  }
}
