import 'dart:async';

import 'package:flutter/material.dart';

import '../../../domain/core/utils/haptic_feedbacks_utils.dart';

class CustomGestureDetector extends StatefulWidget {
  final Widget child;
  final void Function()? onTap;
  final bool disableGesture;
  final bool desactivateHaptic;

  const CustomGestureDetector({
    super.key,
    required this.child,
    this.onTap,
    this.disableGesture = false,
    this.desactivateHaptic = false,
  });

  @override
  State<CustomGestureDetector> createState() => _CustomGestureDetectorState();
}

class _CustomGestureDetectorState extends State<CustomGestureDetector>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation _animation;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
    _animation = Tween<double>(begin: 0, end: 0.03).animate(
        CurvedAnimation(parent: _controller, curve: Curves.bounceInOut));
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    _animation.removeListener(() {});
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.disableGesture) return widget.child;

    return AnimatedBuilder(
      animation: _animation,
      builder: (_, child) {
        return Transform.scale(
          scale: 1.0 - _animation.value,
          child: child,
        );
      },
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTapDown: (_) {
          HapticFeedbackUtils.light();

          _controller.forward();
        },
        onTapUp: (_) => _controller.reverse(),
        onTapCancel: () => _controller.reverse(),
        onTap: () async {
          unawaited(_controller.forward());
          if (widget.onTap != null) {
            if (!widget.desactivateHaptic) {
              unawaited(HapticFeedbackUtils.light());
            }
            await _controller.forward();
            widget.onTap!();
            unawaited(_controller.reverse());
          }
        },
        child: widget.child,
      ),
    );
  }
}
