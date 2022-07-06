import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:task_manager/screens/home/controller/home_controller.dart';
import 'package:task_manager/screens/home/view/dialogs.dart';
import 'package:task_manager/screens/notifications/binding/notifications_binding.dart';
import 'package:task_manager/screens/notifications/view/notifications.dart';
import 'package:task_manager/utils/firebase_authentication_service.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                  child: const Text("logout"),
                  onPressed: () {
                    AuthenticationServiceController.instance.signOut();
                  }),
            ],
          )),
        ),
        body: SafeArea(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
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
                          Text(
                              "👋 Hello, ${AuthenticationServiceController.instance.auth.currentUser?.displayName ?? "err..."}!",
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 30.0)),
                          const Spacer(),
                          GestureDetector(
                            onTap: () {
                              Get.to(() => const NotificationsPage(),
                                  binding: NotificationsBinding());
                            },
                            child: Icon(
                              FontAwesomeIcons.bell,
                              color: controller.notificationsAvailable.value
                                  ? Colors.pink
                                  : Colors.white,
                              size: 30,
                            ),
                          ),
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
                            Get.dialog(const GroupCreatorDialog());
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
                      GetBuilder<HomeController>(
                        builder: (_) {
                          if (!(_.dataRead)) {
                            return Column(
                              children: const [],
                            );
                          } else {
                            return _.dataCol.value;
                          }
                        },
                      )
                    ])),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
