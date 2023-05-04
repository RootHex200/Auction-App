import 'package:get/state_manager.dart';

class ObscureTextController extends GetxController {
  var loginObscureText = true.obs;
  var signupObscureText = true.obs;

  void loginObscureTextChange() {
    loginObscureText.value = !loginObscureText.value;
  }

  void signupObscureTextChange() {
    signupObscureText.value = !signupObscureText.value;
  }
}
