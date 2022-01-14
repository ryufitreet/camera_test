import 'dart:ui';

import 'package:flutter/material.dart';

class FacePointsOvalPainter extends CustomPainter {

  final List<Offset> points;
  
  FacePointsOvalPainter({
    required this.points
  });

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint();
    paint.color = Colors.blueAccent;
    paint.strokeWidth = 4;
    canvas.drawPoints(PointMode.points, points, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // throw UnimplementedError();
    return false;
  }

}