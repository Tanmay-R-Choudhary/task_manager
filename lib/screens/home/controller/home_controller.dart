import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager/screens/home/view/group.dart';
import 'package:task_manager/utils/firebase_database_service.dart';

class HomeController extends GetxController {
  var notificationsAvailable = false.obs;
  late List<Widget> groups;

  List<Object?> groupsDataFromDatabase = [];

  RxList<Widget> groupList = RxList<Widget>();

  @override
  void onReady() {
    getAllUserData();
    super.onReady();
  }

  void getAllUserData() async {
    await DatabaseServiceController.instance.userDataRef.get().then((snapshot) {
      snapshot.children.toList().forEach((element) {
        groupsDataFromDatabase.add(element.value);
      });
    });

    for (var id in groupsDataFromDatabase) {
      await DatabaseServiceController.instance.database
          .ref("groups/$id")
          .get()
          .then((snapshot) async {
        String groupTitle = snapshot.child("title").value.toString();
        List<String>? projectList = [];
        await DatabaseServiceController.instance.database
            .ref('groups/$id/projects')
            .get()
            .then((value) {
          value.children.toList().forEach((element) {
            projectList.add(element.value.toString());
          });
        });

        if (projectList != null) {
          List<String> projectNames = [];

          for (var project_id in projectList) {
            await DatabaseServiceController.instance.database
                .ref("projects/$project_id")
                .child("title")
                .get()
                .then((value) {
              projectNames.add(value.value.toString());
            });
          }

          groupList.value.add(Group(
            groupTitle: groupTitle,
            cardTitles: projectNames,
            databaseID: id.toString(),
          ));
        } else {
          groupList.value.add(Group(
            groupTitle: groupTitle,
            cardTitles: [],
            databaseID: id.toString(),
          ));
        }

        print(groupTitle);
        print(projectList);
      });
    }
  }
}
