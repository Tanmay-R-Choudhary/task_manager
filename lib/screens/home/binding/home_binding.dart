import 'package:get/get.dart';
import 'package:task_manager/screens/home/controller/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(HomeController());
  }
}
