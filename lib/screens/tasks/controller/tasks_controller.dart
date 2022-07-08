import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';
import 'package:task_manager/utils/firebase_database_service.dart';

class TasksPageController extends GetxController {
  final String projectID;
  TasksPageController({required this.projectID});

  RxString projectName = RxString("");
  late DatabaseReference projectRef;

  @override
  void onReady() async {
    projectRef =
        DatabaseServiceController.instance.database.ref("projects/$projectID");

    projectRef.get().then((value) {
      projectName.value = value.child('title').value.toString();
    });

    update();

    super.onReady();
  }
}
