import 'package:aurora_mobile_engineer_assignment/domain/services/theme_service.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

abstract class IViewController<T> extends GetxController with StateMixin<T> {
  @protected
  ThemeService get themeService => Get.find<ThemeService>();
}
