import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

final databaseInstance = FirebaseDatabase.instance;

Future<void> addGroup(
    User user, String groupTitle, String categoryTitle, int newIdx) async {
  var id = databaseInstance.ref().child('groups/').push();
  id.update({'category': categoryTitle, 'title': groupTitle});

  databaseInstance
      .ref('users/${user.uid}')
      .update({newIdx.toString(): id.key.toString()});
}

Future<List<DataSnapshot>> getAllGroups(User user) async {
  DataSnapshot currUserData =
      await databaseInstance.ref('users/' + user.uid).get();

  if (currUserData.value == null) {
    return [];
  } else {
    List<DataSnapshot> groupsInfo = [];

    var data;

    currUserData.exists ? data = currUserData.value : null;

    for (var i in data) {
      groupsInfo.add(await databaseInstance.ref('groups/' + i[0]).get());
    }

    print(groupsInfo);
    return groupsInfo;
  }
}
