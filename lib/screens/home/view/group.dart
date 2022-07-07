import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:task_manager/screens/home/view/dialogs.dart';

class Group extends StatelessWidget {
  final String groupTitle;
  final List<String> cardTitles;
  final String databaseID;
  final List<String> cardID;
  const Group(
      {Key? key,
      required this.groupTitle,
      required this.cardTitles,
      required this.databaseID,
      required this.cardID})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<GroupCard> makeChildren() {
      List<GroupCard> cards = [];

      for (int i = 0; i < cardTitles.length; i++) {
        cards.add(GroupCard(
          cardTitle: cardTitles[i],
          ID: cardID[i],
          groupID: databaseID,
        ));
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
  final String ID;
  final String groupID;
  const GroupCard(
      {Key? key,
      required this.cardTitle,
      required this.ID,
      required this.groupID})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () {
        Get.dialog(CardDeleterDialog(
          projectID: ID,
          groupID: groupID,
        ));
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
