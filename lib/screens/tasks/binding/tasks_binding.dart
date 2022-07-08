import 'package:get/get.dart';
import 'package:task_manager/screens/tasks/controller/tasks_controller.dart';

class TasksPageBinding extends Bindings {
  final String projectID;
  TasksPageBinding({required this.projectID});

  @override
  void dependencies() {
    Get.put(TasksPageController(projectID: projectID));
  }
}
