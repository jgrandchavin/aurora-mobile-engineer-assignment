import 'dart:async';

import 'package:aurora_mobile_engineer_assignment/initialization.dart';
import 'package:aurora_mobile_engineer_assignment/presentation/views/home/home_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'domain/core/utils/logger.dart';

void main() {
  return runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();

      await SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
      ]);

      log.i('Application started successfully');

      Initialization.injectHTTPManager();

      Initialization.injectRepositoriesAndControllers();

      runApp(
        GetMaterialApp(
          title: 'Aurora Mobile Engineer Assignment',
          defaultTransition: Transition.fadeIn,
          home: const HomeView(),
          builder: (context, child) {
            return MediaQuery(
              data: MediaQuery.of(context)
                  .copyWith(textScaler: const TextScaler.linear(1)),
              child: child ?? Container(),
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
