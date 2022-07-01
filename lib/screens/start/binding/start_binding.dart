import 'package:get/get.dart';
import 'package:task_manager/screens/start/controller/start_controller.dart';

class StartPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(StartPageController());
  }
}
