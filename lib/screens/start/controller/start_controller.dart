import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager/screens/create_account/binding/create_account_binding.dart';
import 'package:task_manager/screens/create_account/view/create_account.dart';

class StartPageController extends GetxController
    with GetTickerProviderStateMixin {
  late AnimationController _animController;
  late Animation<double> controller;

  var isVisible = true.obs;

  @override
  void onInit() {
    _animController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1000))
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          Get.to(() => const CreateAccountPage(),
              binding: CreateAccountPageBinding());
        }
      });

    controller = Tween<double>(begin: 1.0, end: 0.0).animate(
        CurvedAnimation(parent: _animController, curve: Curves.easeOut))
      ..addListener(() {
        update();
      });

    super.onInit();
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
