import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';
import 'package:task_manager/utils/firebase_authentication_service.dart';

class DatabaseServiceController extends GetxController {
  static DatabaseServiceController instance = Get.find();

  FirebaseDatabase database = FirebaseDatabase.instance;
  User? currentUser = AuthenticationServiceController.instance.auth.currentUser;
  late DatabaseReference userDataRef;
  late DatabaseReference projectsDataRef;

  @override
  void onInit() {
    userDataRef = database.ref("users/${currentUser?.uid}");
    print(currentUser
        ?.uid); // ADD A METHOD TO REREAD USER UID BEFORE GETTING TO HOME PAGE
    projectsDataRef = database.ref("projects/");
    super.onInit();
  }

  void makeNewGroup(
      {required String groupTitle, required Function updateUI}) async {
    var id = database.ref("groups/").push();
    await id.set({'title': groupTitle});

    await userDataRef.push().set(id.key);

    await updateUI();
  }

  void makeNewProject(
      {required String projectTitle,
      required String groupID,
      required Function updateUI}) async {
    var id = projectsDataRef.push();
    await id.set({'title': projectTitle});

    await database.ref("groups/$groupID/projects").push().set(id.key);

    await updateUI();
  }

  void removeGroup({required String id, required Function updateUI}) async {
    // remove projects
    await database.ref('groups/$id').child('projects').get().then((value) {
      value.children.toList().forEach((element) async {
        await database.ref("projects/${element.value}").remove();
      });
    });

    // remove group
    await database.ref('groups/$id').remove();

    // remove group from user
    String i = "";
    await database.ref("users/${currentUser?.uid}").get().then((value) {
      value.children.toList().forEach((element) {
        if (element.value.toString() == id) {
          // print(element.key);
          i = element.key.toString();
        }
      });
    });

    await userDataRef.child(i).remove();

    await updateUI();
  }
}
