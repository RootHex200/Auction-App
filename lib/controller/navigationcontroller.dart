

import 'package:get/get.dart';

class NavigationController extends GetxController {
    var currentvalue = 0.obs;
    currentindex(value) {
    currentvalue.value = value;
  }
}