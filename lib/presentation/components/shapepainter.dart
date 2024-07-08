import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:TopoSmart/domain/models/savedrawingmodel.dart';

class ShapePainter extends CustomPainter {
  final List<DrawnShape> shapes;

  ShapePainter({required this.shapes});

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.black
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 4.0;

    shapes.forEach((shape) {
      if (shape.points != null) {
        for (int i = 0; i < shape.points!.length - 1; i++) {
          if (shape.type == ShapeType.pencil) {
            paint.color = Colors.black;
          } else if (shape.type == ShapeType.eraser) {
            paint.color = Colors.white;
          }
          canvas.drawLine(shape.points![i], shape.points![i + 1], paint);
        }
      } else if (shape.start != null && shape.end != null) {
        Rect rect = Rect.fromPoints(shape.start!, shape.end!);
        if (shape.type == ShapeType.square) {
          canvas.drawRect(rect, paint);
        } else if (shape.type == ShapeType.circle) {
          canvas.drawCircle(rect.center, rect.width / 2, paint);
        }
      } else if (shape.start != null && shape.text != null) {
        TextSpan span = TextSpan(
          style: TextStyle(color: Colors.black, fontSize: shape.size),
          text: shape.text,
        );
        TextPainter tp = TextPainter(
          text: span,
          textAlign: TextAlign.left,
          textDirection: TextDirection.ltr,
        );
        tp.layout();
        tp.paint(canvas, shape.start!);
      } else if (shape.start != null && shape.end != null) {
        if (shape.type == ShapeType.line) {
          canvas.drawLine(shape.start!, shape.end!, paint);
        }
      }
    });
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
