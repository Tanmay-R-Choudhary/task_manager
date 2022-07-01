import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager/screens/notifications/controller/notifications_controller.dart';

class NotificationsPage extends GetView<NotificationsController> {
  const NotificationsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Text(
          "Hi",
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
