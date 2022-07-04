import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';

class DatabaseServiceController extends GetxController {
  static DatabaseServiceController instance = Get.find();
  late User? currentUser;

  DatabaseServiceController({required this.currentUser});

  FirebaseDatabase database = FirebaseDatabase.instance;

  late DatabaseReference userDataRef;

  late DatabaseReference projectsDataRef;

  @override
  void onInit() {
    userDataRef = database.ref("users/${currentUser?.uid}");
    projectsDataRef = database.ref("projects/");
    super.onInit();
  }

  void makeNewGroup(String groupTitle) async {
    var id = database.ref("groups/").push();
    await id.set({'title': groupTitle});

    await userDataRef.push().set(id.key);
  }

  void makeNewProject(String projectTitle, String groupID) async {
    var id = projectsDataRef.push();
    await id.set({'title': projectTitle});

    await database.ref("groups/$groupID/projects").push().set(id.key);
  }

  void removeGroup(String id) async {
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

    userDataRef.child(i).remove();
  }

  void deleteGroup() {}
}

// UNABLE TO ADD DATA FROM DIFFERENT ACCOUNTS. CAN LOGIN IN WITH DIFFERENT ACCOUNT BUT 
// DATA GETS WRITTEN TO THE ORIGINAL ACCOUNT.