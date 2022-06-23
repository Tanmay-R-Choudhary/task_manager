import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:task_manager/screens/create_account.dart';
import 'package:task_manager/utils/screen_backgrounds.dart';

class StartPage extends StatefulWidget {
  const StartPage({Key? key}) : super(key: key);

  @override
  State<StartPage> createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> with TickerProviderStateMixin {
  late AnimationController _animController;
  late Animation<double> controller;

  bool isVisible = true;

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
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: ((context) => const CreateAccountPage())));
        }
      });

    controller = Tween<double>(begin: 1.0, end: 0.0).animate(
        CurvedAnimation(parent: _animController, curve: Curves.easeOut));
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
            painter: GetStartedPagePainter(paintSplashIndicator: controller),
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 100,
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: AnimatedOpacity(
                        opacity: isVisible ? 1.0 : 0.0,
                        duration: const Duration(milliseconds: 500),
                        child: const Text(
                          "Simpl",
                          style: TextStyle(fontSize: 70, color: Colors.white),
                        ),
                      ),
                    ),
                    const Spacer(),
                    const Text(
                      "A new wave",
                      style: TextStyle(
                        fontSize: 50.0,
                        color: Colors.white,
                      ),
                    ),
                    const Text(
                      "of ORGANISATION",
                      style: TextStyle(
                          fontSize: 30.0,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 70,
                    ),
                    AnimatedOpacity(
                      opacity: isVisible ? 1.0 : 0.0,
                      duration: const Duration(milliseconds: 500),
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            isVisible = false;
                          });
                          _animController.forward();
                        },
                        child: Container(
                          height: 70,
                          width: 200,
                          decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(10.0)),
                          child: Row(children: const [
                            SizedBox(
                              width: 20,
                            ),
                            Text(
                              "Get started",
                              style: TextStyle(color: Colors.white),
                            ),
                            Spacer(),
                            Icon(
                              FontAwesomeIcons.arrowRight,
                              color: Colors.white,
                            ),
                            SizedBox(
                              width: 20,
                            ),
                          ]),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                  ],
                ),
              ),
            ),
          )),
    );
  }
}
