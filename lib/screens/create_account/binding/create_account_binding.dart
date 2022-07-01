import 'package:get/get.dart';
import 'package:task_manager/screens/create_account/controller/create_account_controller.dart';

class CreateAccountPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(CreateAccountPageController());
  }
}
