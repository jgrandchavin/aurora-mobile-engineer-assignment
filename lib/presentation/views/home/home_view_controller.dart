import 'dart:async';

import 'package:aurora_mobile_engineer_assignment/presentation/core/view_controller/i_view_controller.dart';
import 'package:get/get.dart';
import 'package:rxdart/rxdart.dart' as rxdart;

class HomeViewController extends IViewController {
  HomeViewController();

  // ANCHOR Internals
  final _subs = rxdart.CompositeSubscription();

  // ANCHOR State

  // ANCHOR Getters
  final currentPage = RxInt(0);
  final isUserLoggedIn = RxBool(false);

  // ANCHOR Lifecycle
  @override
  Future<void> onInit() async {
    super.onInit();
  }

  @override
  void onClose() {
    _subs.clear();

    super.onClose();
  }
}
