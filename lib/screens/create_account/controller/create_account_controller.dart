import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager/screens/log_in/binding/log_in_binding.dart';
import 'package:task_manager/screens/log_in/view/log_in.dart';

class CreateAccountPageController extends GetxController
    with GetTickerProviderStateMixin {
  late AnimationController _animController;
  late Animation<double> controller;

  @override
  void onInit() {
    super.onInit();
    _animController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1300))
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          Get.off(() => const LogInPage(),
              binding: LogInPageBinding(scrSize: Get.mediaQuery.size));
        }
      });

    controller = Tween<double>(begin: 1.0, end: 0.0).animate(
        CurvedAnimation(parent: _animController, curve: Curves.easeOut))
      ..addListener(() {
        update();
      });
  }

  @override
  void onClose() {
    _animController.dispose();
    super.onClose();
  }

  void playAnimationForward() async {
    await _animController.forward();
  }

  void playAnimationReverse() async {
    await _animController.reverse();
  }
}
