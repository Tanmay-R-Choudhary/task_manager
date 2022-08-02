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
    print(currentUser?.uid);
    projectsDataRef = database.ref("projects/");
    super.onInit();
  }
}
