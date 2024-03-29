import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager/screens/home/controller/home_controller.dart';

class GroupCreatorDialog extends StatelessWidget {
  const GroupCreatorDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var nameController = TextEditingController();
    final homeController = Get.put(HomeController());

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
                "New group",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30.0),
              ),
              const SizedBox(
                height: 20.0,
              ),
              TextField(
                controller: nameController,
                cursorColor: Colors.black,
                decoration: const InputDecoration(
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black)),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black)),
                    hintText: "Group title?",
                    hintStyle:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0)),
              ),
              const SizedBox(
                height: 20.0,
              ),
              ElevatedButton(
                onPressed: () {
                  if (nameController.text.trim().isEmpty) {
                    Get.snackbar("Uhh...", "You haven't entered anything 🤔",
                        snackPosition: SnackPosition.BOTTOM,
                        backgroundColor: Colors.white,
                        margin: const EdgeInsets.symmetric(
                            horizontal: 8.0, vertical: 10.0));
                  } else {
                    Get.back();
                    homeController.addGroup(nameController.text.trim());
                  }
                },
                style: ElevatedButton.styleFrom(primary: Colors.black),
                child: const Text(
                  "Create",
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

class CardCreatorDialog extends StatelessWidget {
  final String groupID;
  const CardCreatorDialog({Key? key, required this.groupID}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var titleController = TextEditingController();
    final homeController = Get.put(HomeController());

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
                "New project",
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
                    hintText: "Project title?",
                    hintStyle:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0)),
              ),
              const SizedBox(
                height: 20.0,
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
                    homeController.addProject(titleController.text.trim(), groupID);
                  }
                },
                style: ElevatedButton.styleFrom(primary: Colors.black),
                child: const Text(
                  "Create",
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

class GroupDeleterDialog extends StatelessWidget {
  final String groupID;
  const GroupDeleterDialog({Key? key, required this.groupID}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final homeController = Get.put(HomeController());

    return AlertDialog(
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20.0))),
      elevation: 20.0,
      title: const Text(
        "Are you sure you want to delete this group?",
        style: TextStyle(
          fontSize: 25.0,
          fontWeight: FontWeight.bold,
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Get.back();
            homeController.removeGroup(groupID);
          },
          child: const Text(
            "Do it 👍",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.pink,
                fontSize: 15.0),
          ),
        ),
        TextButton(
          onPressed: () {
            Get.back();
          },
          child: const Text(
            "No, take me back! 😬",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize: 15.0),
          ),
        ),
      ],
    );
  }
}

class CardDeleterDialog extends StatelessWidget {
  final String groupID;
  final String projectID;
  const CardDeleterDialog(
      {Key? key, required this.projectID, required this.groupID})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final homeController = Get.put(HomeController());

    return AlertDialog(
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20.0))),
      elevation: 20.0,
      title: const Text(
        "Are you sure you want to delete this project?",
        style: TextStyle(
          fontSize: 25.0,
          fontWeight: FontWeight.bold,
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Get.back();
            homeController.removeProject(groupID, projectID);
          },
          child: const Text(
            "Do it 👍",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.pink,
                fontSize: 15.0),
          ),
        ),
        TextButton(
          onPressed: () {
            Get.back();
          },
          child: const Text(
            "No, take me back! 😬",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize: 15.0),
          ),
        ),
      ],
    );
  }
}
