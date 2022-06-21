import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:task_manager/screens/create_account.dart';

class StartPage extends StatefulWidget {
  const StartPage({Key? key}) : super(key: key);

  @override
  State<StartPage> createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> with TickerProviderStateMixin {
  late AnimationController _animController;
  late Animation<double> controller;

  bool play = false;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this)
      ..addListener(() {
        setState(() {});
      });

    controller = Tween<double>(begin: 1.0, end: 0.0).animate(
        CurvedAnimation(parent: _animController, curve: Curves.easeIn));
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
            painter: Painter(controller),
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
                      child: Opacity(
                        opacity: controller.value,
                        child: TextButton(
                            onPressed: () {
                              print("go to sign in");
                            },
                            child: const Text(
                              "Sign in",
                              style: TextStyle(color: Colors.white),
                            )),
                      ),
                    ),
                    const SizedBox(
                      height: 60,
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Opacity(
                        opacity: controller.value,
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
                      opacity: controller.value,
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
                      opacity: controller.value,
                      child: GestureDetector(
                        onTap: () {
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
  final Animation<double> paintSplashIndicator;
  Painter(this.paintSplashIndicator);

  @override
  void paint(Canvas canvas, Size size) {
    Paint painter0 = Paint()
      ..color = Colors.blueGrey
      ..style = PaintingStyle.fill
      ..strokeWidth = 10.0;

    Path paintPath0 = Path();
    paintPath0.moveTo(0, size.height * 0.6 * paintSplashIndicator.value);
    paintPath0.lineTo(0, size.height);
    paintPath0.lineTo(size.width, size.height);
    paintPath0.lineTo(
        size.width, size.height * 0.5 * paintSplashIndicator.value);
    paintPath0.quadraticBezierTo(
        size.width * 0.75,
        size.height * 0.4 * paintSplashIndicator.value,
        0,
        size.height * 0.6 * paintSplashIndicator.value);
    paintPath0.close();

    canvas.drawPath(paintPath0, painter0);

    Paint painter1 = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill
      ..strokeWidth = 10.0;

    Path paintPath1 = Path();
    paintPath1.moveTo(
        size.width * 0.2 * paintSplashIndicator.value,
        paintSplashIndicator.value * size.height +
            (1 - paintSplashIndicator.value) * 0.3 * size.height);
    paintPath1.lineTo(
        size.width * 0.2 * paintSplashIndicator.value, size.height);
    paintPath1.lineTo(size.width, size.height);
    paintPath1.lineTo(
        size.width,
        size.height * 0.9 * paintSplashIndicator.value +
            size.height * 0.2 * (1 - paintSplashIndicator.value));

    paintPath1.quadraticBezierTo(
        size.width * (0.7 - 0.3 * paintSplashIndicator.value),
        size.height * (0.75 - 0.65 * (1 - paintSplashIndicator.value)),
        size.width * 0.2 * paintSplashIndicator.value,
        paintSplashIndicator.value * size.height +
            (1 - paintSplashIndicator.value) * 0.3 * size.height);
    paintPath1.close();

    canvas.drawPath(paintPath1, painter1);

    Paint painter2 = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.fill;

    Path painterPath2 = Path();
    painterPath2.moveTo(
        0, size.height * (1.0 - 0.1 * (1 - paintSplashIndicator.value))); // 0.9
    painterPath2.lineTo(0, size.height);
    painterPath2.lineTo(size.width, size.height);
    painterPath2.lineTo(size.width,
        size.height * (1.0 - 0.2 * (1 - paintSplashIndicator.value))); // 0.8
    painterPath2.quadraticBezierTo(
        size.width * 0.6 * (1 - paintSplashIndicator.value),
        size.height * (1.0 - 0.4 * (1 - paintSplashIndicator.value)),
        0,
        size.height *
            (1.0 - 0.1 * (1 - paintSplashIndicator.value))); // 0.6, 0.6, 0.9
    painterPath2.close();

    canvas.drawPath(painterPath2, painter2);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
