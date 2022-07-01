import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LogInPageController extends GetxController
    with GetTickerProviderStateMixin {
  late AnimationController _animController;
  late Animation<Offset> controller;
  late Size scrSize;

  LogInPageController({required this.scrSize});

  @override
  void onInit() {
    super.onInit();
    _animController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1500));

    controller = Tween<Offset>(
            begin: Offset(scrSize.width / 300, 0.0), end: Offset.zero)
        .animate(
            CurvedAnimation(parent: _animController, curve: Curves.elasticOut));

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      playAnimationForward();
    });
  }

  void playAnimationForward() async {
    await _animController.forward();
  }

  void playAnimationReverse() async {
    await _animController.reverse();
  }

  @override
  void onClose() {
    _animController.dispose();
    super.onClose();
  }
}
