import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager/screens/log_in/controller/log_in_controller.dart';

import 'package:task_manager/utils/firebase_authentication_service.dart';

class LogInPage extends GetView<LogInPageController> {
  const LogInPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passwordController = TextEditingController();

    return Scaffold(
        backgroundColor: Colors.black,
        body: SlideTransition(
          position: controller.controller,
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextField(
                        controller: emailController,
                        style: const TextStyle(
                            color: Colors.white, fontSize: 20.0),
                        cursorColor: Colors.pink,
                        cursorHeight: 30.0,
                        decoration: const InputDecoration(
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20.0))),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20.0))),
                            label: Text("Email"),
                            labelStyle: TextStyle(
                              color: Colors.blueAccent,
                            )),
                      ),
                      const SizedBox(
                        height: 50.0,
                      ),
                      TextField(
                        controller: passwordController,
                        style: const TextStyle(
                            color: Colors.white, fontSize: 20.0),
                        cursorColor: Colors.pink,
                        cursorHeight: 30.0,
                        decoration: const InputDecoration(
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20.0))),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20.0))),
                            label: Text("Password"),
                            labelStyle: TextStyle(
                              color: Colors.blueAccent,
                            )),
                      ),
                      const SizedBox(
                        height: 50.0,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: GestureDetector(
                          onTap: () {
                            AuthenticationServiceController.instance.signIn(
                                emailController.text.trim(),
                                passwordController.text.trim());
                            if (emailController.text.trim().isEmpty == false &&
                                passwordController.text.trim().isEmpty ==
                                    false) {
                              controller.playAnimationReverse();
                            }
                          },
                          child: Container(
                            height: 50,
                            width: 150,
                            decoration: BoxDecoration(
                                // color: Colors.pink,
                                gradient: LinearGradient(
                                  colors: [Colors.pink.shade100, Colors.pink],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(40.0))),
                            child: const Center(
                                child: Text(
                              "Let's go!",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 20.0,
                              ),
                            )),
                          ),
                        ),
                      ),
                    ]),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Text(
                    "Time to get back to work!",
                    style:
                        TextStyle(color: Colors.grey.shade700, fontSize: 20.0),
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
