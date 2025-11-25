import 'package:aurora_mobile_engineer_assignment/presentation/core/design/app_colors.dart';
import 'package:aurora_mobile_engineer_assignment/presentation/core/widgets/custom_gesture_detector.dart';
import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  final void Function() onPressed;
  final String text;
  const AppButton({super.key, required this.onPressed, required this.text});

  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.circular(12.0);
    return CustomGestureDetector(
      onTap: onPressed,
      child: ClipRRect(
        borderRadius: borderRadius,
        child: DecoratedBox(
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [
                AppColors.auroraOrange,
                AppColors.auroraOrangeDark,
                AppColors.auroraBlack,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: borderRadius,
          ),
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
            child: Center(
              child: Text(
                text,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
