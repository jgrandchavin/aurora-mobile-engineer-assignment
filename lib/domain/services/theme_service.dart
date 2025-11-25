import 'dart:ui';

import 'package:aurora_mobile_engineer_assignment/domain/core/services/i_service.dart';
import 'package:flutter/material.dart' show MediaQuery;
import 'package:get/get.dart';

class ThemeService extends IService {
  late bool isDarkMode;

  @override
  Future<void> initialize() async {
    isDarkMode =
        MediaQuery.of(Get.context!).platformBrightness == Brightness.dark;
  }
}
