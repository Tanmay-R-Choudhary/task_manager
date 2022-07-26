import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:task_manager/screens/home/view/dialogs.dart';
import 'package:task_manager/screens/tasks/binding/tasks_binding.dart';
import 'package:task_manager/screens/tasks/view/tasks.dart';

class Group extends StatelessWidget {
  final String groupTitle;
  final String databaseID;
  final Map<dynamic, dynamic> cardData;
  const Group(
      {Key? key,
      required this.groupTitle,
      required this.databaseID,
      required this.cardData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<GroupCard> makeChildren() {
      List<GroupCard> cards = [];

      for (var e in cardData.entries) {
        cards.add(GroupCard(
            cardTitle: e.value.toString(),
            id: e.key.toString(),
            groupID: databaseID));
      }

      return cards;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            children: [
              SizedBox(
                width: 200.0,
                child: Text(
                  groupTitle,
                  style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0),
                ),
              ),
              const Spacer(),
              IconButton(
                  onPressed: () {
                    Get.dialog(CardCreatorDialog(
                      groupID: databaseID,
                    ));
                  },
                  icon: const Icon(FontAwesomeIcons.plus,
                      color: Colors.white, size: 20.0)),
              IconButton(
                  onPressed: () {
                    Get.dialog(GroupDeleterDialog(
                      groupID: databaseID,
                    ));
                  },
                  icon: const Icon(FontAwesomeIcons.trash,
                      color: Colors.pink, size: 20.0)),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 10.0),
          child: SizedBox(
            height: 150.0,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.only(left: 10.0),
              children: makeChildren(),
            ),
          ),
        ),
      ],
    );
  }
}

class GroupCard extends StatelessWidget {
  final String cardTitle;
  final String id;
  final String groupID;
  const GroupCard(
      {Key? key,
      required this.cardTitle,
      required this.id,
      required this.groupID})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () {
        Get.dialog(CardDeleterDialog(
          projectID: id,
          groupID: groupID,
        ));
      },
      onTap: () {
        Get.off(() => const TasksPage(),
            binding: TasksPageBinding(projectID: id));
      },
      child: Container(
        margin: const EdgeInsets.only(right: 10.0),
        height: 150,
        width: 150,
        decoration: BoxDecoration(
            color: Colors.blueGrey, borderRadius: BorderRadius.circular(20.0)),
        child: Center(
          child: Text(
            cardTitle,
            style: const TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
