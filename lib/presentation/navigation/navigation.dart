import 'package:aurora_mobile_engineer_assignment/presentation/views/home/home_view.dart';
import 'package:aurora_mobile_engineer_assignment/presentation/views/home/home_view_controller_bindings.dart';
import 'package:get/get.dart';

import 'routes.dart';

class Navigation {
  static List<GetPage> get routes => [
        GetPage(
          name: Routes.home,
          page: HomeView.new,
          binding: HomeViewControllerBindings(),
        ),
      ];
}
