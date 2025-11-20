import 'package:aurora_mobile_engineer_assignment/infrastructure/repositories/i_repository.dart';

class ImagesRepository extends IRepository {
  ImagesRepository();

  Future<String> getRandomImageUrl() async {
    final response = await httpManager.getRequest(endpoint: 'images');
    return response['url'];
  }
}
