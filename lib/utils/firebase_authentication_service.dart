import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager/screens/home/binding/home_binding.dart';
import 'package:task_manager/screens/home/view/home.dart';
import 'package:task_manager/screens/start/binding/start_binding.dart';
import 'package:task_manager/screens/start/view/start.dart';

class AuthenticationServiceController extends GetxController {
  static AuthenticationServiceController instance = Get.find();
  late Rx<User?> _user;

  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  void onReady() {
    super.onReady();
    _user = Rx<User?>(auth.currentUser);
    _user.bindStream(auth.userChanges());
    ever(_user, _initaliseScreen);
  }

  _initaliseScreen(User? user) {
    if (user == null) {
      print("this hit");
      Get.offAll(() => const StartPage(), binding: StartPageBinding());
    } else {
      Get.offAll(() => const HomePage(), binding: HomeBinding());
    }
  }

  void signUp(String displayName, String email, String password) async {
    try {
      await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      await auth.currentUser?.updateDisplayName(displayName);
    } catch (e) {
      Get.snackbar("Error", e.toString(),
          snackPosition: SnackPosition.TOP, backgroundColor: Colors.white);
    }
  }

  void signIn(String email, String password) async {
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
    } catch (e) {
      Get.snackbar("Error", e.toString(),
          snackPosition: SnackPosition.TOP, backgroundColor: Colors.white);
    }
  }

  void signOut() async {
    try {
      await auth.signOut();
    } catch (e) {
      Get.snackbar("Error", e.toString(),
          snackPosition: SnackPosition.TOP, backgroundColor: Colors.white);
    }
  }
}
