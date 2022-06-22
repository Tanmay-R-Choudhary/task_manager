import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:task_manager/screens/start.dart';
import 'package:task_manager/utils/animators.dart';

class CreateAccountPage extends StatefulWidget {
  const CreateAccountPage({Key? key}) : super(key: key);

  @override
  State<CreateAccountPage> createState() => _CreateAccountPageState();
}

class _CreateAccountPageState extends State<CreateAccountPage>
    with TickerProviderStateMixin {
  late AnimationController _animController;
  late Animation<double> controller;

  bool isVisible = false;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this)
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((AnimationStatus status) {
        if (status == AnimationStatus.completed) {
          Navigator.push(context,
              MaterialPageRoute(builder: ((context) => const StartPage())));
        }
      });

    controller = Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(parent: _animController, curve: Curves.easeOut));

    setState(() {
      isVisible = true;
    });
  }

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
          backgroundColor: Colors.black,
          body: CustomPaint(
            size: Size(MediaQuery.of(context).size.width,
                MediaQuery.of(context).size.height),
            painter: GetStartedPagePainter(controller),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40.0),
                child: AnimatedOpacity(
                  opacity: isVisible ? 1.0 : 0.0,
                  duration: const Duration(milliseconds: 500),
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
                      children: [
                        const SizedBox(
                          height: 50,
                        ),
                        const Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "What should we call you??",
                            style:
                                TextStyle(color: Colors.black, fontSize: 25.0),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        const SizedBox(
                          height: 70,
                        ),
                        const TextField(),
                        const Spacer(),
                        TextButton(
                            onPressed: () {
                              setState(() {
                                isVisible = false;
                              });
                              _animController.forward();
                            },
                            child: const Text(
                              "Already have an account? Log in!",
                              style: TextStyle(
                                  color: Colors.black, fontSize: 13.0),
                            ))
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ));
  }
}
