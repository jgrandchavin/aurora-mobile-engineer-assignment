import 'package:get/get.dart';

import '../core/http_manager.dart';

abstract class IRepository<E> {
  final HttpManager _httpManager;

  HttpManager get httpManager => _httpManager;

  IRepository() : _httpManager = Get.find();
}
