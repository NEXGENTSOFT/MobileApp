import 'package:flutter/material.dart';

class SavedDrawingsModel extends ChangeNotifier {
  List<List<DrawnShape>> _savedDrawings = [];

  List<List<DrawnShape>> get savedDrawings => _savedDrawings;

  void addDrawing(List<DrawnShape> drawing) {
    _savedDrawings.add(drawing);
    notifyListeners();
  }

  void removeDrawing(int index) {
    _savedDrawings.removeAt(index);
    notifyListeners();
  }
}

enum ShapeType { pencil, eraser, square, circle, text, line }

class DrawnShape {
  List<Offset>? points;
  Offset? start;
  Offset? end;
  String? text;
  ShapeType? type;
  double? size;

  DrawnShape({this.points, this.start, this.end, this.text, this.type, this.size});
}
