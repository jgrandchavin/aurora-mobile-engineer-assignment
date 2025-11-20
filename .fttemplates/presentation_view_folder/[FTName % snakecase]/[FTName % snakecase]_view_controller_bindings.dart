import 'package:get/get.dart';

import '<FTName | snakecase>_view_controller.dart';

class <FTName | capitalize>ViewControllerBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(<FTName | capitalize>ViewController());
  }
}