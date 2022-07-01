import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:task_manager/screens/home/binding/home_binding.dart';
import 'package:task_manager/screens/home/view/home.dart';
import 'package:task_manager/screens/start.dart';

// class AuthenticationService {
//   final FirebaseAuth _firebaseAuth;

//   AuthenticationService(this._firebaseAuth);

//   Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

//   Future<String?> logIn(
//       {required String email, required String password}) async {
//     try {
//       await _firebaseAuth.signInWithEmailAndPassword(
//           email: email, password: password);
//       return "logged in";
//     } on FirebaseAuthException catch (e) {
//       return e.message;
//     }
//   }

//   Future<String?> logOut() async {
//     try {
//       await _firebaseAuth.signOut();
//       return "logged out";
//     } on FirebaseAuthException catch (e) {
//       return e.message;
//     }
//   }

//   Future<String?> signUp(
//       {required String email, required String password}) async {
//     try {
//       await _firebaseAuth.createUserWithEmailAndPassword(
//           email: email, password: password);
//       return "Signed in";
//     } on FirebaseAuthException catch (e) {
//       return e.message;
//     }
//   }
// }

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
      Get.offAll(() => const StartPage());
    } else {
      Get.offAll(() => const HomePage(), binding: HomeBindinds());
    }
  }

  void signUp(String displayName, String email, String password) async {
    try {
      await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      await auth.currentUser?.updateDisplayName(displayName);
    } catch (e) {
      Get.snackbar("Error", e.toString());
    }
  }

  void signIn(String email, String password) async {
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
    } catch (e) {
      Get.snackbar("Error", e.toString());
    }
  }

  void signOut() async {
    try {
      await auth.signOut();
    } catch (e) {
      Get.snackbar("Error", e.toString());
    }
  }
}
