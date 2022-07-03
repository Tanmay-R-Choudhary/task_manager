import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:task_manager/screens/create_account/controller/create_account_controller.dart';
import 'package:task_manager/utils/firebase_authentication_service.dart';
import 'package:task_manager/utils/screen_backgrounds.dart';

class CreateAccountPage extends GetView<CreateAccountPageController> {
  const CreateAccountPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var displayNameController = TextEditingController();
    var emailController = TextEditingController();
    var passwordController = TextEditingController();

    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
        ),
        child: Scaffold(
          backgroundColor: Colors.blueGrey,
          body: Stack(children: [
            CustomPaint(
              size: Size(Get.mediaQuery.size.width, Get.mediaQuery.size.height),
              painter: CreateAccountPagePainter(),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40.0),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    height: 350,
                    width: double.infinity,
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(30.0)),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black,
                              blurRadius: 20.0,
                              offset: Offset(0, 15))
                        ]),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 50,
                        ),
                        TextField(
                          controller: displayNameController,
                          cursorColor: Colors.black,
                          decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: "What should we call you?"),
                        ),
                        const Divider(
                          height: 0.0,
                          color: Colors.black,
                          thickness: 1.0,
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        TextField(
                          controller: emailController,
                          cursorColor: Colors.black,
                          decoration: const InputDecoration(
                              border: InputBorder.none, hintText: "Email"),
                        ),
                        const Divider(
                          height: 0.0,
                          color: Colors.black,
                          thickness: 1.0,
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Row(children: [
                          Expanded(
                              child: TextField(
                            controller: passwordController,
                            cursorColor: Colors.black,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: "Password",
                            ),
                          )),
                          const SizedBox(
                            width: 20.0,
                          ),
                          GestureDetector(
                            onTap: () {
                              AuthenticationServiceController.instance.signUp(
                                  displayNameController.text.trim(),
                                  emailController.text.trim(),
                                  passwordController.text.trim());
                            },
                            child: Container(
                                height: 35,
                                width: 30,
                                decoration: const BoxDecoration(
                                    color: Colors.pink,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10))),
                                child: const Center(
                                  child: Icon(
                                    FontAwesomeIcons.angleRight,
                                    color: Colors.white,
                                  ),
                                )),
                          )
                        ]),
                        const Divider(
                          height: 0.0,
                          color: Colors.black,
                          thickness: 1.0,
                        ),
                        const Spacer(),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: Align(
                            alignment: Alignment.center,
                            child: GestureDetector(
                                onTap: () {
                                  controller.playAnimationForward();
                                },
                                child: const Text(
                                  "Already have an account? Log in!",
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 10.0),
                                )),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
            GetBuilder<CreateAccountPageController>(
              builder: (controller) => ClipPath(
                clipper: CreateAccountPageClipPath(
                    paintSplashIndicator: controller.controller),
                child: Container(
                  color: Colors.black,
                  height: Get.mediaQuery.size.height,
                  width: Get.mediaQuery.size.width,
                ),
              ),
            ),
          ]),
        ));
  }
}
