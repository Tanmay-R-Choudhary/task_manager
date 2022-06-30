import 'package:get/get.dart';
import 'package:task_manager/screens/home/controller/home_controller.dart';

class HomeBindinds extends Bindings {
  @override
  void dependencies() {
    Get.put(HomeController());
  }
}
