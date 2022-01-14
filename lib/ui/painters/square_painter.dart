import 'package:flutter/material.dart';

class SquarePainter extends CustomPainter {

  final Rect squareRect;

  SquarePainter({
    required this.squareRect,
  });

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint();
    paint.style = PaintingStyle.stroke;
    paint.color = Colors.lightGreen;
    paint.strokeWidth = 4.0;
    canvas.drawRect(
      squareRect,
      paint
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // throw UnimplementedError();
    return false;
  }

}