import 'dart:ui';

import 'package:aurora_mobile_engineer_assignment/presentation/core/design/app_colors.dart';
import 'package:aurora_mobile_engineer_assignment/presentation/views/home/home_view_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePageBackground extends GetView<HomeViewController> {
  final String imageUrl;

  const HomePageBackground({
    super.key,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: Stack(
        fit: StackFit.expand,
        children: [
          imageUrl.isNotEmpty
              ? Image.network(
                  imageUrl,
                  fit: BoxFit.cover,
                )
              : Container(
                  color: controller.isDarkMode
                      ? AppColors.auroraBlack
                      : AppColors.auroraWhite),
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
              child: Container(
                color: controller.isDarkMode
                    ? AppColors.auroraBlack.withValues(alpha: 0.5)
                    : AppColors.auroraWhite.withValues(alpha: 0.5),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
