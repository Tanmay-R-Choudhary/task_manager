import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager/screens/tasks/view/tasks.dart';
import 'package:task_manager/utils/firebase_database_service.dart';

class TasksPageController extends GetxController {
  final String projectID;
  TasksPageController({required this.projectID});

  RxString projectName = RxString("");
  late DatabaseReference projectRef;

  RxDouble taskPriority = RxDouble(2.0);

  RxList<TaskCard> taskCardsList = RxList([]);
  List<String> taskIDList = [];

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

  void addTask(String taskTitle) async {
    var taskID = await DatabaseServiceController.instance.database
        .ref("projects/$projectID/tasks")
        .push();

    await DatabaseServiceController.instance.database
        .ref("projects/$projectID/tasks/${taskID.key}")
        .set({'title': taskTitle, 'priority': taskPriority.value.toInt()});

    taskIDList.add(taskID.key.toString());

    var temp = "";

    if (taskPriority.value == 0.0) {
      temp = "Not so urgent";
    } else if (taskPriority.value == 1.0) {
      temp = "Somewhat urgent";
    } else {
      temp = "VERY urgent";
    }

    taskCardsList.value.add(TaskCard(title: taskTitle, priority: temp));
    update();
  }
}
