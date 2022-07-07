import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager/screens/home/view/group.dart';
import 'package:task_manager/utils/firebase_database_service.dart';

class HomeController extends GetxController {
  var notificationsAvailable = false.obs;
  late List<Widget> groups;

  List<Object?> groupsDataFromDatabase = [];
  late Rx<Column> dataCol; //  = Rx<Column>(Column(children: []))
  bool dataRead = false;

  @override
  void onReady() async {
    await updateDataColumn();
    dataRead = true;
    super.onReady();
  }

  Future<void> updateDataColumn() async {
    List<Group> groupList = await getAllUserData();
    dataCol = Rx<Column>(Column(children: groupList));
    update();
  }

  Future<List<Group>> getAllUserData() async {
    List<Group> groupList = [];
    groupsDataFromDatabase.clear();

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

        if (projectList.isNotEmpty) {
          List<String> projectNames = [];

          for (var projectId in projectList) {
            await DatabaseServiceController.instance.database
                .ref("projects/$projectId")
                .child("title")
                .get()
                .then((value) {
              projectNames.add(value.value.toString());
            });
          }

          groupList.add(Group(
            groupTitle: groupTitle,
            cardTitles: projectNames,
            databaseID: id.toString(),
            cardID: projectList,
          ));
        } else {
          groupList.add(Group(
            groupTitle: groupTitle,
            cardTitles: const [],
            databaseID: id.toString(),
            cardID: projectList,
          ));
        }
      });
    }

    return groupList;
  }
}
