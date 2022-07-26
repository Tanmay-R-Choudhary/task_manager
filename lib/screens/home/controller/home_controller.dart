import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager/screens/home/view/group.dart';
import 'package:task_manager/utils/firebase_database_service.dart';

class HomeController extends GetxController {
  var notificationsAvailable = false.obs;

  Map<Map<String, String>, Map<dynamic, dynamic>> homePageData = {};
  // {groupID: groupTitle} : {projectID: projectTitle, projectID: projectTitle...}

  List<Group> groupList = [];

  late Rx<Column> dataCol; //  = Rx<Column>(Column(children: []))
  bool dataRead = false;

  bool firstReadCompleted = false;

  @override
  void onReady() async {
    await getHomePageData();
    for (var e in homePageData.entries) {
      print(e);
    }
    updateDataColumn();
    dataRead = true;
    super.onReady();
  }

  void updateDataColumn() {
    dataCol = Rx<Column>(Column(children: groupList));
    update();
  }

  Future<void> addGroup(String groupTitle) async {
    String groupID = await DatabaseServiceController.instance
        .makeNewGroup(groupTitle: groupTitle);
    var entry = {
      {groupID: groupTitle}: {}
    };
    homePageData.addEntries(entry.entries);
    groupList.add(Group(groupTitle: groupTitle, databaseID: groupID, cardData: const {}));

    updateDataColumn();
  }

  Future<void> addProject(String groupID, String projectName) async {
    String projectID = await DatabaseServiceController.instance.makeNewProject(projectTitle: projectName, groupID: groupID);

    Map<String, String> ele = homePageData.keys.firstWhere(
      (element) => element.keys.first == groupID,
    );
    var project = <String, String>{projectID: projectName};

    homePageData[ele]?.addEntries(project.entries);

    int idx = homePageData.keys.toList().indexWhere((element) => element.keys.first == groupID);

    groupList[idx] = Group(
        groupTitle: ele.values.first,
        databaseID: groupID,
        cardData: homePageData[ele] ?? {});

    updateDataColumn();
  }

  Future<void> getHomePageData() async {
    homePageData.clear();
    groupList.clear();

    await DatabaseServiceController.instance.userDataRef.get().then(
      (snapshot) {
        snapshot.children.toList().forEach(
          (element) async {
            String groupID = element.value.toString();
            await DatabaseServiceController.instance.database.ref("groups/$groupID").get().then(
              (groupSnapshot) {
                String groupTitle = groupSnapshot.child("title").value.toString();
                
                Map<String, String> projects = {};

                var projectsDatasnapshot = groupSnapshot.child('projects').children.toList();

                for (var projectElement in projectsDatasnapshot) {
                  Map<String, String> temp = {projectElement.child('id').value.toString() : projectElement.child('title').value.toString()};
                  projects.addAll(temp);
                  // print("inside loop: $projects for group with name $groupTitle");
                }

                // print("outside loop: $projects for group with name $groupTitle");
                Map<Map<String, String>, Map<String, String>> data = {<String, String>{groupID: groupTitle}: projects};
                homePageData.addAll(data);
              },
            );
          },
        );
      },
    );
  }
}
