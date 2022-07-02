import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';

class DatabaseServiceController extends GetxController {
  static DatabaseServiceController instance = Get.find();
  late User? currentUser;

  DatabaseServiceController({required this.currentUser});

  // late Rx<Future<DataSnapshot?>> _userData;
  final List<DataSnapshot> _userData = [];

  FirebaseDatabase database = FirebaseDatabase.instance;

  late Rx<DatabaseReference> dbUserRef;

  Future<void> _initialiseData() async {
    await dbUserRef.value.once().then((value) {
      value.snapshot.child('${currentUser?.uid}').children.forEach((element) {
        database.ref('groups/${element.value}').once().then((value) {
          _userData.add(value.snapshot);
        });
      });
    });
  }

  List<DataSnapshot> get getUserData {
    return _userData;
  }

  void addData(String category, String title) async {
    var id_group = database.ref('groups/').push();
    await id_group.set({'category': category, 'title': title});

    print(currentUser?.uid);

    database.ref('users/${currentUser?.uid}').push().set(id_group.key);
  }

  void printData() {
    for (var e in _userData) {
      print(e);
    }
  }

  void updateData() {
    _initialiseData();
  }

  @override
  void onReady() {
    super.onReady();
    _initialiseData();
    dbUserRef = Rx<DatabaseReference>(database.ref('users/'));
    // dbUserRef.bindStream(dbUserRef.value.onChildChanged);
  }
}
