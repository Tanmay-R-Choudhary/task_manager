import 'package:get/get.dart';
import 'package:task_manager/screens/notifications/controller/notifications_controller.dart';

class NotificationsBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(NotificationsController());
  }
}
