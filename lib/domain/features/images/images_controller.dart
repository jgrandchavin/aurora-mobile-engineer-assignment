import 'package:aurora_mobile_engineer_assignment/domain/core/controllers/i_controller.dart';
import 'package:aurora_mobile_engineer_assignment/infrastructure/repositories/images_repository.dart';

class ImagesController extends IController {
  ImagesController();

  final ImagesRepository _imagesRepository = ImagesRepository();

  Future<String> getRandomImageUrl() async {
    return await _imagesRepository.getRandomImageUrl();
  }
}
