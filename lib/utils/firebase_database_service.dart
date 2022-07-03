import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';

class DatabaseServiceController extends GetxController {
  static DatabaseServiceController instance = Get.find();
  late User? currentUser;

  DatabaseServiceController({required this.currentUser});

  FirebaseDatabase database = FirebaseDatabase.instance;

  late DatabaseReference userDataRef;

  late DatabaseReference groupsDataRef;

  late DatabaseReference projectsDataRef;

  @override
  void onInit() {
    userDataRef = database.ref("users/${currentUser?.uid}");
    groupsDataRef = database.ref("groups/");
    projectsDataRef = database.ref("projects/");
    super.onInit();
  }

  void makeNewGroup(String groupTitle) async {
    var id = groupsDataRef.push();
    await id.set({'title': groupTitle});

    await userDataRef.push().set(id.key);
  }

  void makeNewProject(String projectTitle) async {
    var id = projectsDataRef.push();
    await id.set({'title': projectTitle});

    // groupsDataRef; TODO: get the group to which new project must be added
  }

  void deleteGroup() {}
}
