import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:task_manager/screens/start.dart';

class CreateAccountPage extends StatefulWidget {
  const CreateAccountPage({Key? key}) : super(key: key);

  @override
  State<CreateAccountPage> createState() => _CreateAccountPageState();
}

class _CreateAccountPageState extends State<CreateAccountPage>
    with TickerProviderStateMixin {
  late Animation<double> opacity;
  late AnimationController controller;

  @override
  void initState() {
    controller = AnimationController(
        duration: const Duration(milliseconds: 600), vsync: this);

    opacity = Tween<double>(begin: 0.0, end: 1.0)
        .animate(CurvedAnimation(parent: controller, curve: Curves.easeIn))
      ..addListener(() {
        setState(() {});
      });

    controller.forward();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
        ),
        child: Scaffold(
          backgroundColor: Colors.blueGrey,
          body: CustomPaint(
            size: Size(MediaQuery.of(context).size.width,
                MediaQuery.of(context).size.height),
            painter: Painter(),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40.0),
                child: Opacity(
                  opacity: opacity.value,
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
                            "Email",
                            style:
                                TextStyle(color: Colors.black, fontSize: 20.0),
                          ),
                        ),
                        const TextField(),
                        const SizedBox(
                          height: 50,
                        ),
                        const Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Password",
                            style:
                                TextStyle(color: Colors.black, fontSize: 20.0),
                          ),
                        ),
                        const TextField(),
                        const Spacer(),
                        TextButton(
                            onPressed: () {
                              Navigator.pushReplacement(
                                context,
                                PageRouteBuilder(
                                  pageBuilder:
                                      (context, animation1, animation2) =>
                                          const StartPage(),
                                  // transitionDuration: Duration.zero,
                                  // reverseTransitionDuration: Duration.zero,
                                ),
                              );
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

class Painter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint painter0 = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    Path paintPath0 = Path();
    paintPath0.moveTo(0, size.height * 0.3);
    paintPath0.lineTo(0, size.height);
    paintPath0.lineTo(size.width, size.height);
    paintPath0.lineTo(size.width, size.height * 0.2);
    paintPath0.quadraticBezierTo(
        size.width * 0.7, size.height * 0.1, 0, size.height * 0.3);
    paintPath0.close();

    canvas.drawPath(paintPath0, painter0);

    Paint painter1 = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.fill;

    Path painterPath1 = Path();
    painterPath1.moveTo(0, size.height * 0.9);
    painterPath1.lineTo(0, size.height);
    painterPath1.lineTo(size.width, size.height);
    painterPath1.lineTo(size.width, size.height * 0.8);
    painterPath1.quadraticBezierTo(
        size.width * 0.6, size.height * 0.6, 0, size.height * 0.9);
    painterPath1.close();

    canvas.drawPath(painterPath1, painter1);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
