import 'package:aurora_mobile_engineer_assignment/presentation/core/design/app_colors.dart';
import 'package:aurora_mobile_engineer_assignment/presentation/views/home/home_view_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simple_animations/simple_animations.dart';

class HomePageLoadingContainer extends GetView<HomeViewController> {
  const HomePageLoadingContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller.loading,
      child: _AmbientAuroraBackdrop(isDarkMode: controller.isDarkMode),
      builder: (context, child) {
        final t = Curves.easeInOut.transform(controller.loading.value);
        final isReversing =
            controller.loading.status == AnimationStatus.reverse;
        if (t <= 0.001) {
          return const SizedBox.shrink();
        }
        // Even smoother, slower fade for the opaque background (gentler on exit)
        final overlayOpacity =
            isReversing ? (t * t) : Curves.easeInOutCubic.transform(t);
        return Opacity(
          opacity: overlayOpacity,
          child: Container(
            color: controller.isDarkMode
                ? AppColors.auroraBlack
                : AppColors.auroraWhite,
            child: Stack(
              fit: StackFit.expand,
              children: [
                Opacity(opacity: 0.85, child: child),
                Center(
                  child: _AuroraLoader(
                    progress: t,
                    isReversing: isReversing,
                    isDarkMode: controller.isDarkMode,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _AuroraLoader extends StatelessWidget {
  final bool isDarkMode;
  final double progress;
  final bool isReversing;

  const _AuroraLoader(
      {required this.progress,
      required this.isReversing,
      required this.isDarkMode});

  @override
  Widget build(BuildContext context) {
    // Slower, smoother enter/exit — reduced overshoot and softer opacity ramp
    final appear = Curves.easeInOutCubic.transform(progress);
    // On exit, use a quadratic fade (t^2) to slow down near the end
    final contentOpacity = isReversing
        ? (progress * progress)
        : Curves.easeInOutCubic.transform(progress);
    return Opacity(
      opacity: contentOpacity,
      child: Transform.scale(
        scale: 0.90 + 0.12 * appear, // max ~1.02 for very gentle overshoot
        child: SizedBox(
          width: 160,
          height: 160,
          child: Stack(
            alignment: Alignment.center,
            children: [
              _SweepHalo(isDarkMode: isDarkMode),
              _RippleRing(delay: 0.0, isDarkMode: isDarkMode),
              _RippleRing(delay: 0.33, isDarkMode: isDarkMode),
              _RippleRing(delay: 0.66, isDarkMode: isDarkMode),
              _CoreOrb(isDarkMode: isDarkMode),
            ],
          ),
        ),
      ),
    );
  }
}

class _SweepHalo extends StatelessWidget {
  final bool isDarkMode;
  const _SweepHalo({required this.isDarkMode});

  @override
  Widget build(BuildContext context) {
    return CustomAnimationBuilder<double>(
      control: Control.loop,
      tween: Tween(begin: 0.0, end: 1.0),
      duration: const Duration(milliseconds: 2400),
      curve: Curves.easeInOut,
      builder: (context, v, _) {
        return Transform.rotate(
          angle: v * 6.283185307179586, // 2 * pi
          child: Container(
            width: 124,
            height: 124,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: SweepGradient(
                colors: [
                  isDarkMode
                      ? AppColors.auroraBlack
                      : AppColors.auroraOrange.withValues(alpha: 0.08),
                  AppColors.auroraOrange.withValues(alpha: 0.9),
                  isDarkMode
                      ? AppColors.auroraBlack
                      : AppColors.auroraOrangeDark.withValues(alpha: 0.06),
                ],
                stops: const [0.0, 0.1, 1.0],
              ),
              // Soften the halo edges via blur style shadow
              boxShadow: [
                BoxShadow(
                  color: AppColors.auroraOrange
                      .withValues(alpha: isDarkMode ? 0.20 : 0.14),
                  blurRadius: 20,
                  spreadRadius: 2,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _RippleRing extends StatelessWidget {
  final double delay;
  final bool isDarkMode;
  const _RippleRing({required this.delay, required this.isDarkMode});

  @override
  Widget build(BuildContext context) {
    return CustomAnimationBuilder<double>(
      control: Control.loop,
      tween: Tween(begin: 0.0, end: 1.0),
      duration: const Duration(milliseconds: 2200),
      curve: Curves.easeInOut,
      startPosition: delay,
      builder: (context, v, _) {
        final scale = 1.0 + v * 1.8;
        final opacity = (1.0 - v) * 0.42;
        return Transform.scale(
          scale: scale,
          child: Opacity(
            opacity: opacity,
            child: Container(
              width: 96,
              height: 96,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isDarkMode
                      ? AppColors.auroraWhite.withValues(alpha: 0.60)
                      : AppColors.auroraOrange.withValues(alpha: 0.18),
                  width: isDarkMode ? 1.0 : 1.0,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class _CoreOrb extends StatelessWidget {
  final bool isDarkMode;

  const _CoreOrb({required this.isDarkMode});

  @override
  Widget build(BuildContext context) {
    return CustomAnimationBuilder<double>(
      control: Control.mirror,
      tween: Tween(begin: 0.0, end: 1.0),
      duration: const Duration(milliseconds: 1500),
      curve: Curves.easeInOutCubic,
      builder: (context, value, child) {
        final glow = 0.35 + 0.40 * value;
        final innerOpacity = 0.65 + 0.35 * (1 - (value - 0.5).abs() * 2);
        return Container(
          width: 84,
          height: 84,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: RadialGradient(
              colors: [
                AppColors.auroraOrange.withValues(alpha: 0.95),
                // Slightly lighter outer edge in light mode to avoid a dark ring
                isDarkMode
                    ? AppColors.auroraOrangeDark.withValues(alpha: 0.85)
                    : AppColors.auroraOrangeDark.withValues(alpha: 0.65),
              ],
              stops: const [0.3, 1.0],
            ),
            boxShadow: [
              BoxShadow(
                color: AppColors.auroraOrange.withValues(alpha: glow),
                blurRadius: isDarkMode ? (44 + 28 * value) : (36 + 22 * value),
                spreadRadius: isDarkMode ? (5 + 2 * value) : (3 + 1 * value),
              ),
              if (!isDarkMode)
                const BoxShadow(
                  color: Color(0x26FFFFFF),
                  blurRadius: 12,
                  spreadRadius: -2,
                  offset: Offset(-2, -2),
                ),
            ],
          ),
          child: Center(
            child: SizedBox(
              width: 28,
              height: 28,
              child: _ProgressArc(
                isDarkMode: isDarkMode,
                opacity: innerOpacity,
              ),
            ),
          ),
        );
      },
    );
  }
}

class _ProgressArc extends StatelessWidget {
  final bool isDarkMode;
  final double opacity;
  const _ProgressArc({required this.isDarkMode, required this.opacity});

  @override
  Widget build(BuildContext context) {
    return CustomAnimationBuilder<double>(
      control: Control.loop,
      tween: Tween(begin: 0.0, end: 1.0),
      duration: const Duration(milliseconds: 1400),
      curve: Curves.easeInOutCubic,
      builder: (context, t, _) {
        return CustomPaint(
          painter: _ArcPainter(
            angle: t * 6.283185307179586, // 2*pi
            isDarkMode: isDarkMode,
            opacity: opacity,
          ),
        );
      },
    );
  }
}

class _ArcPainter extends CustomPainter {
  final double angle;
  final bool isDarkMode;
  final double opacity;

  _ArcPainter({
    required this.angle,
    required this.isDarkMode,
    required this.opacity,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    final sweep = 1.7; // ~97 degrees
    final start = -1.2 + angle; // animate rotation

    final colors = isDarkMode
        ? [
            AppColors.auroraOrange.withValues(alpha: 0.95 * opacity),
            AppColors.auroraOrangeDark.withValues(alpha: 0.85 * opacity),
            const Color(0x00FFFFFF),
          ]
        : [
            AppColors.auroraOrangeDark.withValues(alpha: 0.75 * opacity),
            AppColors.auroraOrange.withValues(alpha: 0.55 * opacity),
            const Color(0x00FFFFFF),
          ];

    final shader = SweepGradient(
      colors: colors,
      stops: const [0.0, 0.7, 1.0],
      transform: GradientRotation(start),
    ).createShader(rect.inflate(6));

    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3
      ..strokeCap = StrokeCap.round
      ..shader = shader;

    final inset = 1.5;
    final arcRect = Rect.fromLTWH(
        inset, inset, size.width - inset * 2, size.height - inset * 2);
    canvas.drawArc(arcRect, start, sweep, false, paint);
  }

  @override
  bool shouldRepaint(covariant _ArcPainter oldDelegate) {
    return oldDelegate.angle != angle ||
        oldDelegate.isDarkMode != isDarkMode ||
        oldDelegate.opacity != opacity;
  }
}

class _AmbientAuroraBackdrop extends StatelessWidget {
  final bool isDarkMode;

  const _AmbientAuroraBackdrop({required this.isDarkMode});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final maxSide = constraints.maxWidth > constraints.maxHeight
            ? constraints.maxWidth
            : constraints.maxHeight;
        final blobSize = maxSide * 0.9;
        return Stack(
          children: [
            _MovingBlob(
              size: blobSize,
              startAlignment: const Alignment(-1.0, -0.6),
              endAlignment: const Alignment(0.8, 0.6),
              color: AppColors.auroraOrange.withValues(alpha: 0.18),
              duration: const Duration(milliseconds: 6500),
            ),
            _MovingBlob(
              size: blobSize * 0.8,
              startAlignment: const Alignment(0.9, -0.8),
              endAlignment: const Alignment(-0.8, 0.5),
              color: isDarkMode
                  ? AppColors.auroraOrangeDark.withValues(alpha: 0.16)
                  : AppColors.auroraOrange.withValues(alpha: 0.12),
              duration: const Duration(milliseconds: 8000),
            ),
          ],
        );
      },
    );
  }
}

class _MovingBlob extends StatelessWidget {
  final double size;
  final Alignment startAlignment;
  final Alignment endAlignment;
  final Color color;
  final Duration duration;

  const _MovingBlob({
    required this.size,
    required this.startAlignment,
    required this.endAlignment,
    required this.color,
    required this.duration,
  });

  @override
  Widget build(BuildContext context) {
    return CustomAnimationBuilder<double>(
      control: Control.mirror,
      tween: Tween(begin: 0.0, end: 1.0),
      duration: duration,
      curve: Curves.easeInOut,
      builder: (context, v, _) {
        final alignment =
            Alignment.lerp(startAlignment, endAlignment, v) ?? startAlignment;
        return Align(
          alignment: alignment,
          child: Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: [
                  color,
                  Colors.transparent,
                ],
                stops: const [0.0, 1.0],
              ),
            ),
          ),
        );
      },
    );
  }
}
