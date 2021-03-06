import 'package:flutter/material.dart';

class GetStartedPagePainter extends CustomPainter {
  final Animation<double> paintSplashIndicator;
  const GetStartedPagePainter({required this.paintSplashIndicator});

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
    painterPath2.moveTo(0,
        size.height * (1.0 - 0.05 * (1 - paintSplashIndicator.value))); // 0.9
    painterPath2.lineTo(0, size.height);
    painterPath2.lineTo(size.width, size.height);
    painterPath2.lineTo(size.width,
        size.height * (1.0 - 0.15 * (1 - paintSplashIndicator.value))); // 0.8
    painterPath2.quadraticBezierTo(
        size.width * 0.6 * (1 - paintSplashIndicator.value),
        size.height * (1.0 - 0.2 * (1 - paintSplashIndicator.value)),
        0,
        size.height *
            (1.0 - 0.05 * (1 - paintSplashIndicator.value))); // 0.6, 0.6, 0.9
    painterPath2.close();

    canvas.drawPath(painterPath2, painter2);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}

class CreateAccountPagePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint painter1 = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill
      ..strokeWidth = 10.0;

    Path paintPath1 = Path();
    paintPath1.moveTo(0, 0.3 * size.height);
    paintPath1.lineTo(0, size.height);
    paintPath1.lineTo(size.width, size.height);
    paintPath1.lineTo(size.width, size.height * 0.2);

    paintPath1.quadraticBezierTo(
        size.width * 0.7, size.height * 0.1, 0, 0.3 * size.height);
    paintPath1.close();

    canvas.drawPath(paintPath1, painter1);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}

class CreateAccountPageClipPath extends CustomClipper<Path> {
  final Animation<double> paintSplashIndicator;

  CreateAccountPageClipPath({required this.paintSplashIndicator});

  @override
  Path getClip(Size size) {
    Path path = Path();
    path.moveTo(0, size.height * 0.95 * paintSplashIndicator.value);
    path.lineTo(0, size.height);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, size.height * 0.85 * paintSplashIndicator.value);
    path.quadraticBezierTo(
        size.width * 0.6 * paintSplashIndicator.value,
        size.height * 0.8 * paintSplashIndicator.value,
        0,
        size.height * 0.95 * paintSplashIndicator.value);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}
