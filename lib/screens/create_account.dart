import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:task_manager/screens/home/view/home.dart';
import 'package:task_manager/screens/log_in/binding/log_in_binding.dart';
import 'package:task_manager/screens/log_in/view/log_in.dart';
import 'package:task_manager/utils/firebase_authentication_service.dart';
import 'package:task_manager/utils/screen_backgrounds.dart';

class CreateAccountPage extends StatefulWidget {
  const CreateAccountPage({Key? key}) : super(key: key);

  @override
  State<CreateAccountPage> createState() => _CreateAccountPageState();
}

class _CreateAccountPageState extends State<CreateAccountPage>
    with TickerProviderStateMixin {
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  late AnimationController _animController;
  late Animation<double> controller;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
        duration: const Duration(milliseconds: 1300), vsync: this)
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((AnimationStatus status) {
        if (status == AnimationStatus.completed) {
          Get.to(() => const LogInPage(),
              binding: LogInPageBinding(scrSize: MediaQuery.of(context).size));
        }
      });

    controller = Tween<double>(begin: 1.0, end: 0.0).animate(
        CurvedAnimation(parent: _animController, curve: Curves.easeOut));
  }

  bool isVisible = true;

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
        ),
        child: Scaffold(
          backgroundColor: Colors.blueGrey,
          body: Stack(children: [
            CustomPaint(
              size: Size(MediaQuery.of(context).size.width,
                  MediaQuery.of(context).size.height),
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
                          controller: usernameController,
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
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const HomePage()));
                              AuthenticationServiceController.instance.signUp(
                                  usernameController.text.trim(),
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
                        Align(
                          alignment: Alignment.center,
                          child: TextButton(
                              onPressed: () {
                                _animController.forward();
                                // Get.to(() => const LogInPage(),
                                //     binding: LogInPageBinding(
                                //         scrSize: MediaQuery.of(context).size));
                              },
                              child: const Text(
                                "Already have an account? Log in!",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 10.0),
                              )),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
            ClipPath(
              clipper:
                  CreateAccountPageClipPath(paintSplashIndicator: controller),
              child: Container(
                color: Colors.black,
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
              ),
            ),
          ]),
        ));
  }
}
