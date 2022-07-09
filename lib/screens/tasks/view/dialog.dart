import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager/screens/tasks/controller/tasks_controller.dart';

class TaskCreatorDialog extends GetView<TasksPageController> {
  const TaskCreatorDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var titleController = TextEditingController();

    return Dialog(
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20.0))),
      elevation: 20.0,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                "New task",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30.0),
              ),
              const SizedBox(
                height: 20.0,
              ),
              TextField(
                controller: titleController,
                cursorColor: Colors.black,
                decoration: const InputDecoration(
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black)),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black)),
                    hintText: "Task title?",
                    hintStyle:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0)),
              ),
              const SizedBox(
                height: 20.0,
              ),
              const Text(
                "How about setting a priority?",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 17.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Obx(
                () => Slider(
                  min: 0,
                  max: 2,
                  divisions: 2,
                  inactiveColor: Colors.blueGrey,
                  thumbColor: Colors.black,
                  activeColor: Colors.pink,
                  value: controller.taskPriority.value,
                  onChanged: (value) {
                    controller.taskPriority.value = value;
                  },
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  if (titleController.text.trim().isEmpty) {
                    Get.snackbar("Uhh...", "You haven't entered anything 🤔",
                        snackPosition: SnackPosition.BOTTOM,
                        backgroundColor: Colors.white,
                        margin: const EdgeInsets.symmetric(
                            horizontal: 8.0, vertical: 10.0));
                  } else {
                    Get.back();
                    controller.addTask(titleController.text.trim());
                  }
                },
                style: ElevatedButton.styleFrom(primary: Colors.black),
                child: const Text(
                  "Add",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
