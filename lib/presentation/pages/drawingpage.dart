import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:math' as math;
import 'package:TopoSmart/domain/models/savedrawingmodel.dart';
import 'package:TopoSmart/presentation/components/shapepainter.dart';

class DrawingPage extends StatefulWidget {
  @override
  _DrawingPageState createState() => _DrawingPageState();
}

class _DrawingPageState extends State<DrawingPage> {
  Color uno = Color(0xFFF2E9E4);
  List<DrawnShape> shapes = [];
  String selectedTool = 'Pencil';
  Offset? startPosition;
  String textToDraw = '';
  double brushSize = 2.0;
  double eraserSize = 20.0;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text('Crear Dibujo'),
        backgroundColor: uno,
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {
              // Guardar el dibujo usando el modelo correspondiente (SavedDrawingsModel)
              Provider.of<SavedDrawingsModel>(context, listen: false).addDrawing(shapes);
              Navigator.pop(context); // Regresar a la página anterior
            },
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              SizedBox(width: screenWidth * 0.1),
              IconButton(
                icon: Icon(Icons.text_fields),
                onPressed: () async {
                  final text = await _showTextInputDialog(context);
                  if (text != null) {
                    setState(() {
                      selectedTool = 'Text';
                      textToDraw = text;
                    });
                  }
                },
              ),
              IconButton(
                icon: Icon(Icons.crop_square),
                onPressed: () => setState(() => selectedTool = 'Square'),
              ),
              IconButton(
                icon: Icon(Icons.radio_button_unchecked),
                onPressed: () => setState(() => selectedTool = 'Circle'),
              ),
              IconButton(
                icon: Icon(Icons.brush),
                onPressed: () => setState(() => selectedTool = 'Pencil'),
              ),
              IconButton(
                icon: Icon(Icons.line_weight),
                onPressed: () => setState(() => selectedTool = 'Line'),
              ),
              IconButton(
                icon: Icon(Icons.undo),
                onPressed: () {
                  if (shapes.isNotEmpty) {
                    setState(() {
                      shapes.removeLast();
                    });
                  }
                },
              ),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(width: screenWidth * 0.05),
              Text('Tamaño:'),
              Expanded(
                child: Slider(
                  value: brushSize,
                  min: 1.0,
                  max: 20.0,
                  onChanged: (value) {
                    setState(() {
                      brushSize = value;
                    });
                  },
                ),
              ),
            ],
          ),
          Expanded(
            child: GestureDetector(
              onPanStart: (details) {
                if (selectedTool == 'Pencil') {
                  setState(() {
                    shapes.add(DrawnShape(
                      points: [details.localPosition],
                      type: ShapeType.pencil,
                      size: brushSize,
                    ));
                  });
                } else if (selectedTool == 'Eraser') {
                  _eraseShapes(details.localPosition);
                } else if (selectedTool == 'Square' ||
                    selectedTool == 'Text' ||
                    selectedTool == 'Line' ||
                    selectedTool == 'Circle') {
                  startPosition = details.localPosition;
                }
              },
              onPanUpdate: (details) {
                if (selectedTool == 'Pencil' && shapes.isNotEmpty) {
                  setState(() {
                    shapes.last.points?.add(details.localPosition);
                  });
                } else if (selectedTool == 'Eraser') {
                  _eraseShapes(details.localPosition);
                }
              },
              onPanEnd: (details) {
                if ((selectedTool == 'Square' || selectedTool == 'Circle') &&
                    startPosition != null) {
                  setState(() {
                    shapes.add(DrawnShape(
                      start: startPosition,
                      end: details.localPosition,
                      type: selectedTool == 'Square'
                          ? ShapeType.square
                          : ShapeType.circle,
                      size: brushSize,
                    ));
                    startPosition = null;
                  });
                } else if (selectedTool == 'Line' && startPosition != null) {
                  setState(() {
                    shapes.add(DrawnShape(
                      start: startPosition,
                      end: details.localPosition,
                      type: ShapeType.line,
                      size: brushSize,
                    ));
                    startPosition = null;
                  });
                } else if (selectedTool == 'Text' && startPosition != null) {
                  setState(() {
                    shapes.add(DrawnShape(
                      start: startPosition,
                      text: textToDraw,
                      type: ShapeType.text,
                      size: brushSize,
                    ));
                    startPosition = null;
                    textToDraw = '';
                  });
                }
              },
              child: CustomPaint(
                size: Size.infinite,
                painter: ShapePainter(shapes: shapes),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<String?> _showTextInputDialog(BuildContext context) async {
    TextEditingController textController = TextEditingController();
    return showDialog<String>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Enter Text'),
          content: TextField(
            controller: textController,
            decoration: InputDecoration(hintText: 'Enter your text here'),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, textController.text),
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void _eraseShapes(Offset position) {
    setState(() {
      shapes.removeWhere((shape) {
        if (shape.type == ShapeType.pencil && shape.points != null) {
          List<Offset> remainingPoints = [];
          bool erased = false;
          for (int i = 0; i < shape.points!.length - 1; i++) {
            Offset p1 = shape.points![i];
            Offset p2 = shape.points![i + 1];
            if (_isSegmentInEraser(position, p1, p2)) {
              erased = true;
            } else {
              remainingPoints.add(p1);
            }
          }
          if (erased) {
            remainingPoints.add(shape.points!.last);
            shape.points = remainingPoints;
            return false; // Shape not fully erased
          }
        } else if ((shape.type == ShapeType.square ||
            shape.type == ShapeType.circle ||
            shape.type == ShapeType.text ||
            shape.type == ShapeType.line) &&
            shape.start != null &&
            shape.end != null) {
          if (_isShapeInEraser(position, shape)) {
            return true; // Shape fully erased
          }
        }
        return false; // Shape not affected
      });
    });
  }

  bool _isSegmentInEraser(Offset eraserCenter, Offset p1, Offset p2) {
    double distance = ((p1.dx - p2.dx) * (eraserCenter.dy - p1.dy) -
        (p1.dy - p2.dy) * (eraserCenter.dx - p1.dx))
        .abs() /
        math.sqrt((p1.distanceSquared - p2.distanceSquared).toDouble());
    return distance < eraserSize / 2;
  }

  bool _isShapeInEraser(Offset eraserCenter, DrawnShape shape) {
    if (shape.type == ShapeType.square) {
      Rect shapeRect = Rect.fromPoints(shape.start!, shape.end!);
      return shapeRect.contains(eraserCenter);
    } else if (shape.type == ShapeType.circle) {
      double radius = (shape.end!.dy - shape.start!.dy) / 2;
      Offset center = Offset(
          (shape.start!.dx + shape.end!.dx) / 2,
          (shape.start!.dy + shape.end!.dy) / 2);
      return (eraserCenter.dx - center.dx) * (eraserCenter.dx - center.dx) +
          (eraserCenter.dy - center.dy) * (eraserCenter.dy - center.dy) <
          radius * radius;
    } else if (shape.type == ShapeType.text) {
      return (eraserCenter.dx - shape.start!.dx) *
          (eraserCenter.dx - shape.start!.dx) +
          (eraserCenter.dy - shape.start!.dy) *
              (eraserCenter.dy - shape.start!.dy) <
          brushSize * brushSize;
    } else if (shape.type == ShapeType.line) {
      double d1 = _distanceFromPointToLine(
          eraserCenter, shape.start!, shape.end!);
      return d1 < eraserSize / 2;
    }
    return false;
  }

  double _distanceFromPointToLine(Offset p, Offset l1, Offset l2) {
    return (((l2.dy - l1.dy) * p.dx -
        (l2.dx - l1.dx) * p.dy +
        l2.dx * l1.dy -
        l2.dy * l1.dx)
        .abs() /
        math.sqrt((l2.dy - l1.dy) * (l2.dy - l1.dy) +
            (l2.dx - l1.dx) * (l2.dx - l1.dx)));
  }
}
