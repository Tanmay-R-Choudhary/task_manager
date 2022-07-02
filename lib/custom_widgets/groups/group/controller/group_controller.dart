import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';
import 'package:task_manager/custom_widgets/groups/group/view/groups.dart';
import 'package:task_manager/custom_widgets/groups/group_card/view/group_card.dart';

class GroupController extends GetxController {
  final List<DataSnapshot> userData;
  GroupController({required this.userData});

  Map<String, List<DataSnapshot>> _groupFilter = {};
  Map<String, List<GroupCard>> groupCards = {};

  void _makeGroups() {
    for (var element in userData) {
      if (_groupFilter
          .containsKey(element.child("category").value.toString())) {
        _groupFilter[element.child("category").value.toString()]?.add(element);
      } else {
        _groupFilter[element.child("category").value.toString()] = [element];
      }
    }
  }

  void _makeCards() {
    _makeGroups();

    for (var e in _groupFilter.entries) {
      List<GroupCard> _cards = [];
      for (var v in e.value) {
        _cards.add(GroupCard(title: v.child("title").value.toString()));
      }

      groupCards[e.key] = _cards;
    }
  }

  List<Groups> returnAllGroups() {
    _makeCards();

    List<Groups> displayGroups = [];

    for (var i in groupCards.entries) {
      displayGroups.add(Groups(groupTitle: i.key, cards: i.value));
    }

    return displayGroups;
  }
}
