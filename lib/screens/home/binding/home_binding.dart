import 'package:get/get.dart';
import 'package:task_manager/screens/home/controller/home_controller.dart';
import 'package:task_manager/utils/firebase_database_service.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(HomeController());
    Get.put(DatabaseServiceController());
  }
}
