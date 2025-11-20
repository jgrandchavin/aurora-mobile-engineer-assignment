import 'package:aurora_mobile_engineer_assignment/configs/consts.dart';
import 'package:aurora_mobile_engineer_assignment/domain/features/images/images_controller.dart';
import 'package:aurora_mobile_engineer_assignment/infrastructure/core/http_manager.dart';
import 'package:aurora_mobile_engineer_assignment/infrastructure/repositories/images_repository.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import 'domain/core/utils/logger.dart';

class Initialization {
  /// Inject all controllers and repositories
  static void injectRepositoriesAndControllers() {
    Get.put<ImagesRepository>(ImagesRepository(), permanent: true);

    Get.put<ImagesController>(ImagesController(), permanent: true);

    log.i('Repositories and controllers has been injected');
  }

  /// Initialize and inject HTTP service from [environement]
  static void injectHTTPManager() {
    Get.put<HttpManager>(
      HttpManager(
        httpClient: http.Client(),
        serverUrl: kServerUrl,
      ),
      permanent: true,
    );
    log.i('HTTP service has been injected');
  }
}
