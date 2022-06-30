import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:task_manager/custom_widgets/groups.dart';
import 'package:task_manager/screens/home/controller/home_controller.dart';
import 'package:task_manager/screens/log_in/view/log_in.dart';
import 'package:task_manager/screens/notifications.dart';
import 'package:task_manager/utils/firebase_authentication_service.dart';
// import 'package:task_manager/utils/firebase_database_service.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final homeController = Get.find<HomeController>();

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
      ),
      child: Scaffold(
        backgroundColor: Colors.black,
        drawer: Drawer(
          backgroundColor: Colors.blueGrey,
          child: Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                  child: const Text("add to database"),
                  onPressed: () {
                    //TODO: CONFIGURE DATABASE WITH GETX
                  }),
              TextButton(
                  child: const Text("logout"),
                  onPressed: () {
                    AuthenticationServiceController.instance.signOut();
                    Get.to(
                        () => LogInPage(scrSize: MediaQuery.of(context).size));
                  }),
            ],
          )),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Theme(
              data: Theme.of(context).copyWith(
                  colorScheme:
                      ColorScheme.fromSwatch(accentColor: Colors.white)),
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 20.0),
                  child: Column(children: [
                    Row(
                      children: [
                        const Text("Hello, Tanmay!",
                            style:
                                TextStyle(color: Colors.white, fontSize: 30.0)),
                        const Spacer(),
                        GestureDetector(
                          onTap: () {
                            Get.to(() => const NotificationPage());
                          },
                          child: Obx(
                            () => Icon(
                              FontAwesomeIcons.bell,
                              color: homeController.notificationsAvailable.value
                                  ? Colors.pink
                                  : Colors.white,
                              size: 30,
                            ),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    Row(children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        height: 50.0,
                        width: 300.0,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(50.0),
                        ),
                        child: const TextField(
                          cursorColor: Colors.pink,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Search groups",
                              hintStyle: TextStyle(color: Colors.black54)),
                        ),
                      ),
                      const Spacer(),
                      GestureDetector(
                        onTap: () {
                          homeController.notificationsAvailable.value =
                              !homeController.notificationsAvailable.value;
                        },
                        child: Container(
                          height: 50.0,
                          width: 50.0,
                          decoration: BoxDecoration(
                              color: Colors.grey.shade300,
                              borderRadius: BorderRadius.circular(10.0)),
                          child: const Center(
                            child: Icon(
                              FontAwesomeIcons.plus,
                              color: Colors.black,
                              size: 40.0,
                            ),
                          ),
                        ),
                      )
                    ]),
                    const SizedBox(
                      height: 20.0,
                    ),
                    const Groups(groupTitle: "Your teams"),
                    const Groups(groupTitle: "Your teams"),
                    const Groups(groupTitle: "Your teams"),
                    const Groups(groupTitle: "Your teams"),
                    const Groups(groupTitle: "Your teams"),
                  ]),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
