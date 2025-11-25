import 'dart:async';

import 'package:aurora_mobile_engineer_assignment/domain/core/utils/haptic_feedbacks_utils.dart';
import 'package:aurora_mobile_engineer_assignment/domain/core/utils/logger.dart';
import 'package:aurora_mobile_engineer_assignment/domain/features/images/images_controller.dart';
import 'package:aurora_mobile_engineer_assignment/presentation/core/view_controller/i_view_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class HomeViewController extends IViewController
    with GetSingleTickerProviderStateMixin {
  HomeViewController();

  // ANCHOR Internals
  final ImagesController _imagesController = Get.find();
  late bool isDarkMode;

  // ANCHOR State
  late AnimationController loading;
  final imageUrl = RxString('');

  // ANCHOR Lifecycle
  @override
  Future<void> onInit() async {
    setIsDarkMode();

    loading = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 750),
      reverseDuration: Duration(milliseconds: 750),
      value: 0.0,
    );

    super.onInit();
  }

  @override
  void onClose() {
    loading.dispose();
    super.onClose();
  }

  /// ANCHOR Methods
  Future<void> getRandomImage({required BuildContext context}) async {
    try {
      loading.forward();
      final reachableUrl = await _getReachableImageUrlWithRetry(maxAttempts: 2);
      if (reachableUrl == null) {
        throw Exception('Image URL is not reachable');
      }

      // Pre-cache the image so that when we display it, it appears instantly.
      if (context.mounted) {
        await precacheImage(NetworkImage(reachableUrl), context);
      }
      imageUrl.value = reachableUrl;

      playHapticFeedback();
    } catch (e, stack) {
      log.e('Error getting random image', error: e, stackTrace: stack);
      Get.snackbar(
        'Error',
        'Something went wrong',
        backgroundColor: Colors.red,
        colorText: Colors.white,
        duration: Duration(seconds: 2),
        animationDuration: Duration(milliseconds: 500),
      );
    } finally {
      loading.reverse();
    }
  }

  // Tries to fetch a reachable image URL, retrying up to [maxAttempts] times.
  // Returns the first reachable URL found, or null if none are reachable.
  Future<String?> _getReachableImageUrlWithRetry({int maxAttempts = 2}) async {
    for (var attemptIndex = 0; attemptIndex < maxAttempts; attemptIndex++) {
      final candidateUrl = await _imagesController.getRandomImageUrl();
      final isReachable = await _isUrlReachable(url: candidateUrl);

      if (isReachable) {
        return candidateUrl;
      } else {
        log.w('Image URL is not reachable: $candidateUrl');
      }
    }
    return null;
  }

  // Returns true if the URL responds successfully.
  // Uses HEAD first (lightweight), then falls back to a minimal GET if needed.
  Future<bool> _isUrlReachable({required String url}) async {
    try {
      final uri = Uri.parse(url);
      final head = await http.head(uri);

      if (head.statusCode == 200) return true;

      if (head.statusCode == 403 || head.statusCode == 405) {
        final get = await http.get(uri);
        return get.statusCode == 200 || get.statusCode == 206;
      }
      return false;
    } catch (_) {
      return false;
    }
  }

  void setIsDarkMode() {
    try {
      isDarkMode =
          MediaQuery.of(Get.context!).platformBrightness == Brightness.dark;
    } catch (error, stack) {
      isDarkMode = false;
      log.e('Error setting isDarkMode', error: error, stackTrace: stack);
    }
  }

  void playHapticFeedback() {
    HapticFeedbackUtils.bubbleAppear();
    HapticFeedbackUtils.selection();
  }
}
