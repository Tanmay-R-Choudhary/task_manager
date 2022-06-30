import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager/screens/home/binding/home_binding.dart';
import 'package:task_manager/screens/home/view/home.dart';
import 'dart:math';

import 'package:task_manager/utils/firebase_authentication_service.dart';

class LogInPage extends StatefulWidget {
  final Size scrSize;
  const LogInPage({Key? key, required this.scrSize}) : super(key: key);

  @override
  State<LogInPage> createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> with TickerProviderStateMixin {
  late AnimationController _animController;
  late Animation<Offset> controller;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    _animController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1500));

    controller = Tween<Offset>(
            begin: Offset(widget.scrSize.width / 300, 0.0), end: Offset.zero)
        .animate(
            CurvedAnimation(parent: _animController, curve: Curves.elasticOut))
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.dismissed) {
          Get.to(() => const HomePage(), binding: HomeBindinds());
        }
      });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _animController.forward();
    });

    super.initState();
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: SlideTransition(
          position: controller,
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
                            _animController.reverse();
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
