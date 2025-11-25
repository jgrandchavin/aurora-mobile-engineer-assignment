import 'dart:async';

import 'package:aurora_mobile_engineer_assignment/initialization.dart';
import 'package:aurora_mobile_engineer_assignment/presentation/navigation/navigation.dart';
import 'package:aurora_mobile_engineer_assignment/presentation/navigation/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'domain/core/utils/logger.dart';

void main() {
  return runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();

      Initialization.initializeLogger();

      await SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
      ]);

      log.i('Application started successfully');

      Initialization.injectHTTPManager();

      Initialization.injectRepositoriesAndControllers();

      runApp(
        GetMaterialApp(
          title: 'Aurora Mobile Engineer Assignment',
          getPages: Navigation.routes,
          initialRoute: Routes.home,
          builder: (context, child) {
            return Overlay(
              initialEntries: [
                OverlayEntry(
                  builder: (context) => child ?? Container(),
                ),
              ],
            );
          },
        ),
      );
    },
    (error, stack) async {
      log.e('Error: $error', error: error, stackTrace: stack);
    },
  );
}
