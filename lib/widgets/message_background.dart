import 'package:flutter/material.dart';

class MessageBackground extends CustomPainter {
  final Color background;
  final bool left;
  final double padding;
  MessageBackground(
      {this.background = Colors.white, this.left = true, this.padding = 20});

  @override
  void paint(Canvas canvas, Size size) {
    Paint p = Paint();
    p.color = background;

    canvas.drawRect(
      Rect.fromLTWH(
        0,
        0,
        size.width,
        size.height,
      ),
      p,
    );

    Path path = Path();

    if (left) {
      path.moveTo(-padding, 0);
      path.lineTo(0, padding);
      path.lineTo(0, 0);
    } else {
      path.moveTo(size.width + padding, 0);
      path.lineTo(size.width, 0);
      path.lineTo(size.width, padding);
      path.close();
    }

    canvas.drawPath(path, p);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
