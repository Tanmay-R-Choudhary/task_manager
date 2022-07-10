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

    await projectRef.get().then((value) {
      projectName.value = value.child('title').value.toString();
    });

    await getTask();
    update();

    super.onReady();
  }

  Future<void> getTask() async {
    taskIDList.clear();
    taskCardsList.value.clear();

    var title = "";
    var description = "";
    var priority = "";
    var temp = "";
    bool completed = false;

    await DatabaseServiceController.instance.database
        .ref("projects/$projectID/tasks")
        .get()
        .then((value) {
      value.children.toList().forEach((element) {
        taskIDList.add(element.key.toString());

        title = element.child("title").value.toString();
        description = element.child("description").value.toString();
        priority = element.child("priority").value.toString();
        temp = element.child("completed").value.toString();

        if (temp == 'true') {
          completed = true;
        } else {
          completed = false;
        }

        if (priority == "0") {
          priority = "Not so urgent";
        } else if (priority == "1") {
          priority = "Somewhat urgent";
        } else {
          priority = "VERY urgent";
        }

        taskCardsList.add(TaskCard(
          id: element.key.toString(),
          title: title,
          description: description,
          priority: priority,
          completed: completed,
        ));
      });
    });
  }

  void addTask(String taskTitle, String taskDescription) async {
    var taskID = await DatabaseServiceController.instance.database
        .ref("projects/$projectID/tasks")
        .push();

    await DatabaseServiceController.instance.database
        .ref("projects/$projectID/tasks/${taskID.key}")
        .set({
      'title': taskTitle,
      'description': taskDescription,
      'priority': taskPriority.value.toInt(),
      'completed': false
    });

    taskIDList.add(taskID.key.toString());

    var temp = "";

    if (taskPriority.value == 0.0) {
      temp = "NOT URGENT";
    } else if (taskPriority.value == 1.0) {
      temp = "SOMEWHAT URGENT";
    } else {
      temp = "VERY URGENT";
    }

    taskCardsList.value.add(TaskCard(
      id: taskID.key.toString(),
      title: taskTitle,
      description: taskDescription,
      priority: temp,
      completed: false,
    ));
    update();
  }

  void deleteTask(String taskID) async {
    await DatabaseServiceController.instance.database
        .ref("projects/$projectID/tasks/$taskID")
        .remove();

    int idx = taskIDList.indexOf(taskID);

    taskIDList.removeAt(idx);
    taskCardsList.value.removeAt(idx);

    Get.snackbar(
        "Task deleted 👍", "Task with id $taskID was removed from the database",
        snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.white);

    update();
  }

  void updateTaskCompletion(String id, bool status, String title,
      String description, String priority) async {
    await DatabaseServiceController.instance.database
        .ref("projects/$projectID/tasks/$id")
        .update({'completed': status});

    int idx = taskIDList.indexOf(id);
    taskCardsList.value[idx] = TaskCard(
        id: id,
        completed: status,
        title: title,
        description: description,
        priority: priority);

    update();
  }
}
