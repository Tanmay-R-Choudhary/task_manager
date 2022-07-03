import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager/screens/home/view/group.dart';

class HomeController extends GetxController {
  var notificationsAvailable = false.obs;

  late List<Widget> groups;

  List<Widget> makeGroups() {
    groups = [
      const Group(
          groupTitle: "Your teams", cardTitles: ["Physics engine", 'scout R']),
      const Group(
          groupTitle: "Personal projects",
          cardTitles: ["Physics engine", 'scout R', 'scout R', 'scout R']),
      const Group(
          groupTitle: "Personal projects for rocketry",
          cardTitles: ["Physics engine", 'scout R', 'scout R', 'scout R']),
    ];

    return groups;
  }
}
