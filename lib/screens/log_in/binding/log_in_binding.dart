import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager/screens/log_in/controller/log_in_controller.dart';

class LogInPageBinding extends Bindings {
  late Size scrSize;
  LogInPageBinding({required this.scrSize});

  @override
  void dependencies() {
    Get.put(LogInPageController(scrSize: scrSize));
  }
}
