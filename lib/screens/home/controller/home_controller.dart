import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager/screens/home/view/group.dart';
import 'package:task_manager/utils/firebase_database_service.dart';

class HomeController extends GetxController {
  var notificationsAvailable = false.obs;

  final Map<String, String> groupData = {};
  final Map<String, Map<String, String>> projectsData = {};

  final Map<String, Group> groupList = {};

  late Rx<Column> dataCol; //  = Rx<Column>(Column(children: []))
  bool dataRead = false;

  @override
  void onReady() async {
    await getHomePageData();
    updateDisplay();
    dataRead = true;
    super.onReady();
    update();
  }

  void updateDisplay() {
    dataCol = Rx<Column>(Column(children: groupList.values.toList()));
  }

  void removeProject(String groupID, String projectID) async {
    String id = "";

    await DatabaseServiceController.instance.database.ref("groups/$groupID/projects").get().then((value) {
      value.children.toList().forEach((element) {
        if (element.child("id").value == projectID) {
          id = element.key.toString();
        }
      });
    });

    await DatabaseServiceController.instance.database.ref("groups/$groupID/projects/$id").remove();
    await DatabaseServiceController.instance.database.ref("projects/$projectID").remove();

    projectsData[groupID]?.remove(projectID);
    groupList[groupID] = Group(groupTitle: groupData[groupID] ?? "", databaseID: groupID, cardData: projectsData[groupID] ?? {});

    updateDisplay();
    update();
  }

  void removeGroup(String groupID) async {
    await DatabaseServiceController.instance.database.ref("groups/$groupID/projects").get().then((snapshot) {
      snapshot.children.toList().forEach((element) {
        DatabaseServiceController.instance.database.ref("projects/${element.child('id').value.toString()}").remove();
      });
    });

    await DatabaseServiceController.instance.database.ref("groups/$groupID").remove();
    String key = "";
    await DatabaseServiceController.instance.userDataRef.get().then((value) {
      value.children.toList().forEach((element) {
        if (element.value == groupID) {
          key = element.key.toString();
        }
      });
    });

    print("the key is");
    print(key);

    await DatabaseServiceController.instance.userDataRef.child(key).remove();

    groupData.remove(groupID);
    projectsData.remove(groupID);
    groupList.remove(groupID);

    updateDisplay();
    update();
  }

  void addGroup(String title) async {
    var groupID = DatabaseServiceController.instance.database.ref("groups").push();
    await groupID.set({
      'title': title
    });

    await DatabaseServiceController.instance.userDataRef.push().set(groupID.key);

    groupData[groupID.key.toString()] = title;
    groupList[groupID.key.toString()] = Group(groupTitle: title, databaseID: groupID.key.toString(), cardData: {},);

    updateDisplay();
    update();
  }

  void addProject(String projectTitle, String groupID) async {
    var projectID = DatabaseServiceController.instance.database.ref("projects").push();
    await DatabaseServiceController.instance.database.ref("groups/$groupID/projects").push().set({
      'id': projectID.key.toString(), 'title': projectTitle
    });

    await projectID.set({
      'title': projectTitle
    });

    projectsData[groupID]?[projectID.key.toString()] = projectTitle;
    groupList[groupID] = Group(groupTitle: groupData[groupID] ?? "", databaseID: groupID, cardData: projectsData[groupID] ?? {});
    
    updateDisplay();
    update();
  }

  Future<void> getHomePageData() async {
    groupData.clear();
    projectsData.clear();

    await DatabaseServiceController.instance.userDataRef.get().then((groupKeyData) async {
      for (int i = 0; i < groupKeyData.children.toList().length; i++) {
        String id = groupKeyData.children.toList()[i].value.toString();
        await DatabaseServiceController.instance.database.ref("groups/$id/title").get().then((value) {
          groupData[id] = value.value.toString();
        });

        await DatabaseServiceController.instance.database.ref("groups/$id/projects").get().then((projectsSnapshot) async {
          Map<String, String> projects = {};
          for (var i in projectsSnapshot.children) {
            projects[i.child('id').value.toString()] = i.child("title").value.toString();
          }
          projectsData[id] = projects;
        });
      }
    });

    for(var e in groupData.entries) {
      groupList[e.key] = Group(groupTitle: e.value, databaseID: e.key, cardData: projectsData[e.key] ?? {});
    }

    print(groupData);
    print(projectsData);
  }
}