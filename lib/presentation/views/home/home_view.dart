import 'package:aurora_mobile_engineer_assignment/presentation/core/design/app_button.dart';
import 'package:aurora_mobile_engineer_assignment/presentation/views/home/widgets/home_page_background.dart';
import 'package:aurora_mobile_engineer_assignment/presentation/views/home/widgets/home_page_image.dart';
import 'package:aurora_mobile_engineer_assignment/presentation/views/home/widgets/home_page_loading_container.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'home_view_controller.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final HomeViewController controller = Get.find<HomeViewController>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.getRandomImage(context: context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Obx(
              () => HomePageBackground(
                imageUrl: controller.imageUrl.value,
              ),
            ),
          ),
          Positioned.fill(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  AnimatedBuilder(
                    animation: controller.loading,
                    child: Obx(
                      () => HomePageImage(
                        imageUrl: controller.imageUrl.value,
                      ),
                    ),
                    builder: (context, child) {
                      return child!;
                    },
                  ),
                  AnimatedBuilder(
                    animation: controller.loading,
                    child: AppButton(
                      onPressed: () {
                        controller.getRandomImage(context: context);
                      },
                      text: 'Another',
                    ),
                    builder: (context, child) {
                      final t = controller.loading.value;
                      final base = Curves.easeInOutCubic
                          .transform(1.0 - Curves.easeInOutCubic.transform(t));
                      // Button also uses the full timeline for maximum smoothness
                      final btn = _interval(base, 0.0, 1.0);
                      final btnOpacity = btn;
                      final btnOffset = (1.0 - btn) * 24.0;

                      return Opacity(
                        opacity: btnOpacity,
                        child: Transform.translate(
                          offset: Offset(0, btnOffset),
                          child: child,
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
          Positioned.fill(child: HomePageLoadingContainer()),
        ],
      ),
    );
  }
}

double _interval(double value, double start, double end) {
  if (end <= start) return value.clamp(0.0, 1.0);
  double v = (value - start) / (end - start);
  if (v < 0) v = 0;
  if (v > 1) v = 1;
  return Curves.easeInOutCubic.transform(v);
}
