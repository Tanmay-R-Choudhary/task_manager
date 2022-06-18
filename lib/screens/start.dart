import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:task_manager/screens/create_account.dart';
import 'package:task_manager/screens/test.dart';

class StartPage extends StatefulWidget {
  const StartPage({Key? key}) : super(key: key);

  @override
  State<StartPage> createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> with TickerProviderStateMixin {
  late Animation<double> greyPaintHeightLeft;
  late Animation<double> greyPaintHeightRight;
  late Animation<double> greyPaintBezier;

  late Animation<double> whiteParam1;
  late Animation<double> whiteParam2;
  late Animation<double> whiteParam3;
  late Animation<double> whiteParam4;

  late Animation<double> whiteParam5;
  late Animation<double> whiteParam6;
  late Animation<double> whiteParam7;
  late Animation<double> whiteParam8;

  late Animation<double> blackParam1;
  late Animation<double> blackParam2;
  late Animation<double> blackParam3;
  late Animation<double> blackParam4;

  late Animation<double> opacity;

  late AnimationController controller;

  bool play = false;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
        duration: const Duration(milliseconds: 1500), vsync: this);

    greyPaintHeightLeft = Tween<double>(begin: 0.6, end: 0.0)
        .animate(CurvedAnimation(parent: controller, curve: Curves.easeIn))
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          Navigator.pushReplacement(
            context,
            PageRouteBuilder(
              pageBuilder: (context, animation1, animation2) =>
                  const CreateAccountPage(),
              transitionDuration: const Duration(milliseconds: 1),
              reverseTransitionDuration: Duration.zero,
            ),
          );
        }
      });

    greyPaintHeightRight = Tween<double>(
      begin: 0.5,
      end: 0.0,
    ).animate(CurvedAnimation(parent: controller, curve: Curves.easeIn))
      ..addListener(() {
        setState(() {});
      });

    greyPaintBezier = Tween<double>(begin: 0.4, end: 0.0)
        .animate(CurvedAnimation(parent: controller, curve: Curves.easeIn))
      ..addListener(() {
        setState(() {});
      });

    whiteParam1 = Tween<double>(begin: 0.2, end: 0.0)
        .animate(CurvedAnimation(parent: controller, curve: Curves.easeIn))
      ..addListener(() {
        setState(() {});
      });

    whiteParam2 = Tween<double>(begin: 1.0, end: 0.3)
        .animate(CurvedAnimation(parent: controller, curve: Curves.easeIn))
      ..addListener(() {
        setState(() {});
      });

    whiteParam3 = Tween<double>(begin: 0.2, end: 0.0)
        .animate(CurvedAnimation(parent: controller, curve: Curves.easeIn))
      ..addListener(() {
        setState(() {});
      });

    whiteParam4 = Tween<double>(begin: 0.9, end: 0.2)
        .animate(CurvedAnimation(parent: controller, curve: Curves.easeIn))
      ..addListener(() {
        setState(() {});
      });

    whiteParam5 = Tween<double>(begin: 0.3, end: 0.7)
        .animate(CurvedAnimation(parent: controller, curve: Curves.easeIn))
      ..addListener(() {
        setState(() {});
      });

    whiteParam6 = Tween<double>(begin: 0.75, end: 0.1)
        .animate(CurvedAnimation(parent: controller, curve: Curves.easeIn))
      ..addListener(() {
        setState(() {});
      });

    whiteParam7 = Tween<double>(begin: 0.2, end: 0.0)
        .animate(CurvedAnimation(parent: controller, curve: Curves.easeIn))
      ..addListener(() {
        setState(() {});
      });

    whiteParam8 = Tween<double>(begin: 1.0, end: 0.3)
        .animate(CurvedAnimation(parent: controller, curve: Curves.easeIn))
      ..addListener(() {
        setState(() {});
      });

    blackParam1 = Tween<double>(begin: 1.0, end: 1.0)
        .animate(CurvedAnimation(parent: controller, curve: Curves.easeIn))
      ..addListener(() {
        setState(() {});
      });

    blackParam2 = Tween<double>(begin: 1.0, end: 0.9)
        .animate(CurvedAnimation(parent: controller, curve: Curves.easeIn))
      ..addListener(() {
        setState(() {});
      });

    blackParam3 = Tween<double>(begin: 1.0, end: 0.8)
        .animate(CurvedAnimation(parent: controller, curve: Curves.easeIn))
      ..addListener(() {
        setState(() {});
      });

    blackParam4 = Tween<double>(begin: 1.0, end: 0.6)
        .animate(CurvedAnimation(parent: controller, curve: Curves.easeIn))
      ..addListener(() {
        setState(() {});
      });

    opacity = Tween<double>(begin: 1.0, end: 0.0)
        .animate(CurvedAnimation(parent: controller, curve: Curves.easeIn))
      ..addListener(() {
        setState(() {});
      });
  }

  @override
  void dispose() {
    controller.dispose();
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
            painter: Painter(
                greyPaintHeightLeft.value,
                greyPaintHeightRight.value,
                greyPaintBezier.value,
                whiteParam1.value,
                whiteParam2.value,
                whiteParam3.value,
                whiteParam4.value,
                whiteParam5.value,
                whiteParam6.value,
                whiteParam7.value,
                whiteParam8.value,
                blackParam1.value,
                blackParam2.value,
                blackParam3.value,
                blackParam4.value),
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 40.0,
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                          onPressed: () {
                            print("go to sign in");
                          },
                          child: const Text(
                            "Sign in",
                            style: TextStyle(color: Colors.white),
                          )),
                    ),
                    const SizedBox(
                      height: 60,
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Opacity(
                        opacity: opacity.value,
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
                    Opacity(
                      opacity: opacity.value,
                      child: const Text(
                        "of ORGANISATION",
                        style: TextStyle(
                            fontSize: 30.0,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(
                      height: 70,
                    ),
                    Opacity(
                      opacity: opacity.value,
                      child: InkWell(
                        splashColor: Colors.white,
                        onTap: () {
                          controller.forward();
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
                              Icons.forward,
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

class Painter extends CustomPainter {
  final double greyHeightLeft;
  final double greyHeightRight;
  final double greyBezier;

  final double whitep1;
  final double whitep2;
  final double whitep3;
  final double whitep4;
  final double whitep5;
  final double whitep6;
  final double whitep7;
  final double whitep8;

  final double blackp1;
  final double blackp2;
  final double blackp3;
  final double blackp4;
  Painter(
      this.greyHeightLeft,
      this.greyHeightRight,
      this.greyBezier,
      this.whitep1,
      this.whitep2,
      this.whitep3,
      this.whitep4,
      this.whitep5,
      this.whitep6,
      this.whitep7,
      this.whitep8,
      this.blackp1,
      this.blackp2,
      this.blackp3,
      this.blackp4);

  @override
  void paint(Canvas canvas, Size size) {
    Paint painter0 = Paint()
      ..color = Colors.blueGrey
      ..style = PaintingStyle.fill
      ..strokeWidth = 10.0;

    Path paintPath0 = Path();
    paintPath0.moveTo(0, size.height * greyHeightLeft);
    paintPath0.lineTo(0, size.height);
    paintPath0.lineTo(size.width, size.height);
    paintPath0.lineTo(size.width, size.height * greyHeightRight);
    paintPath0.quadraticBezierTo(size.width * 0.75, size.height * greyBezier, 0,
        size.height * greyHeightLeft);
    paintPath0.close();

    canvas.drawPath(paintPath0, painter0);

    Paint painter1 = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill
      ..strokeWidth = 10.0;

    Path paintPath1 = Path();
    paintPath1.moveTo(size.width * whitep1, size.height * whitep2);
    paintPath1.lineTo(size.width * whitep3, size.height);
    paintPath1.lineTo(size.width, size.height);
    paintPath1.lineTo(size.width, size.height * whitep4);
    paintPath1.quadraticBezierTo(size.width * whitep5, size.height * whitep6,
        size.width * whitep7, size.height * whitep8);
    paintPath1.close();

    canvas.drawPath(paintPath1, painter1);

    Paint painter2 = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.fill;

    Path painterPath2 = Path();
    painterPath2.moveTo(0, size.height * blackp2);
    painterPath2.lineTo(0, size.height * blackp1);
    painterPath2.lineTo(size.width * blackp1, size.height * blackp1);
    painterPath2.lineTo(size.width * blackp1, size.height * blackp3);
    painterPath2.quadraticBezierTo(
        size.width * blackp4, size.height * blackp4, 0, size.height * blackp2);
    painterPath2.close();

    canvas.drawPath(painterPath2, painter2);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
