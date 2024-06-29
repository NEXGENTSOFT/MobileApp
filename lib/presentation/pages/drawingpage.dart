import 'package:flutter/material.dart';
import 'dart:math' as math;



class DrawingPage extends StatefulWidget {
  @override
  _DrawingPageState createState() => _DrawingPageState();
}

class _DrawingPageState extends State<DrawingPage> {
  List<DrawnShape> shapes = [];
  String selectedTool = 'Pencil';
  Offset? startPosition;
  String textToDraw = '';
  double brushSize = 2.0;
  double eraserSize = 20.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Drawing App'),
        actions: [
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
            onPressed: () => setState(() => shapes.clear()),
          ),
          IconButton(
            icon: Icon(Icons.remove_circle_outline),
            onPressed: () => setState(() => selectedTool = 'Eraser'),
          ),
        ],
      ),
      body: Column(
        children: [
          Row(
            children: [
              Text('Brush Size:'),
              Slider(
                value: brushSize,
                min: 1.0,
                max: 20.0,
                onChanged: (value) {
                  setState(() {
                    brushSize = value;
                  });
                },
              ),
              Text('Eraser Size:'),
              Slider(
                value: eraserSize,
                min: 10.0,
                max: 50.0,
                onChanged: (value) {
                  setState(() {
                    eraserSize = value;
                  });
                },
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
                } else if (selectedTool == 'Square' || selectedTool == 'Text' || selectedTool == 'Line' || selectedTool == 'Circle') {
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
                if ((selectedTool == 'Square' || selectedTool == 'Circle') && startPosition != null) {
                  setState(() {
                    shapes.add(DrawnShape(
                      start: startPosition,
                      end: details.localPosition,
                      type: selectedTool == 'Square' ? ShapeType.square : ShapeType.circle,
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
      shapes.forEach((shape) {
        if (shape.type == ShapeType.pencil && shape.points != null) {
          // Modificar los puntos del lápiz para borrar donde pase
          List<Offset> remainingPoints = [];
          for (int i = 0; i < shape.points!.length - 1; i++) {
            Offset p1 = shape.points![i];
            Offset p2 = shape.points![i + 1];
            if (!_isSegmentInEraser(position, p1, p2)) {
              remainingPoints.add(p1);
            }
          }
          remainingPoints.add(shape.points!.last); // Añadir el último punto
          shape.points = remainingPoints;
        } else if ((shape.type == ShapeType.square || shape.type == ShapeType.circle || shape.type == ShapeType.text || shape.type == ShapeType.line) &&
            shape.start != null && shape.end != null) {
          // Modificar las formas para borrar donde pase el borrador
          if (_isShapeInEraser(position, shape)) {
            // Si la forma está completamente dentro del borrador, no hacer nada
            return;
          }
          // Para cada tipo de forma, ajustar cómo se maneja el borrado
          if (shape.type == ShapeType.square) {
            // Borrar partes del cuadrado según el borrador
            Rect shapeRect = Rect.fromPoints(shape.start!, shape.end!);
            if (shapeRect.contains(position)) {
              // Calcular la intersección y actualizar el cuadrado
              Offset delta = Offset(shapeRect.center.dx - position.dx, shapeRect.center.dy - position.dy);
              Offset newStart = shape.start! - delta;
              Offset newEnd = shape.end! - delta;
              shape.start = newStart;
              shape.end = newEnd;
            }
          } else if (shape.type == ShapeType.circle) {
            // Borrar partes del círculo según el borrador
            double radius = (shape.start! - shape.end!).distance / 2;
            Offset center = Offset(
              (shape.start!.dx + shape.end!.dx) / 2,
              (shape.start!.dy + shape.end!.dy) / 2,
            );
            if ((center - position).distance <= radius) {
              // Calcular la intersección y actualizar el círculo
              Offset delta = center - position;
              Offset newStart = shape.start! - delta;
              Offset newEnd = shape.end! - delta;
              shape.start = newStart;
              shape.end = newEnd;
            }
          } else if (shape.type == ShapeType.text) {
            // Borrar el texto según el borrador
            // Aquí puedes implementar una lógica específica para el borrado de texto si es necesario
          } else if (shape.type == ShapeType.line) {
            // Borrar partes de la línea según el borrador
            if (_isLineInEraser(position, shape.start!, shape.end!)) {
              // Calcular la intersección y actualizar la línea
              Offset delta = Offset(shape.start!.dx - shape.end!.dx, shape.start!.dy - shape.end!.dy);
              Offset newStart = shape.start! - delta;
              Offset newEnd = shape.end! - delta;
              shape.start = newStart;
              shape.end = newEnd;
            }
          }
        }
      });

      // Eliminar las formas vacías (líneas del lápiz sin puntos)
      shapes.removeWhere((shape) => shape.type == ShapeType.pencil && shape.points!.isEmpty);
    });
  }

  bool _isSegmentInEraser(Offset eraserCenter, Offset p1, Offset p2) {
    double distance = ((p1.dx - p2.dx) * (eraserCenter.dy - p1.dy) - (p1.dy - p2.dy) * (eraserCenter.dx - p1.dx)).abs() /
        math.sqrt((p1.distanceSquared - p2.distanceSquared).toDouble());
    return distance < eraserSize / 2;
  }

  bool _isShapeInEraser(Offset eraserCenter, DrawnShape shape) {
    if (shape.type == ShapeType.square) {
      Rect shapeRect = Rect.fromPoints(shape.start!, shape.end!);
      return shapeRect.contains(eraserCenter);
    } else if (shape.type == ShapeType.circle) {
      double radius = (shape.start! - shape.end!).distance / 2;
      Offset center = Offset(
        (shape.start!.dx + shape.end!.dx) / 2,
        (shape.start!.dy + shape.end!.dy) / 2,
      );
      return (center - eraserCenter).distance <= radius;
    } else if (shape.type == ShapeType.text) {
      // Implementa la lógica para el borrado de texto si es necesario
      return false;
    } else if (shape.type == ShapeType.line) {
      return _isLineInEraser(eraserCenter, shape.start!, shape.end!);
    }
    return false;
  }


  bool _isLineInEraser(Offset eraserCenter, Offset p1, Offset p2) {
    double distance1 = math.sqrt(math.pow(eraserCenter.dx - p1.dx, 2) + math.pow(eraserCenter.dy - p1.dy, 2));
    double distance2 = math.sqrt(math.pow(eraserCenter.dx - p2.dx, 2) + math.pow(eraserCenter.dy - p2.dy, 2));
    double lineLength = math.sqrt(math.pow(p1.dx - p2.dx, 2) + math.pow(p1.dy - p2.dy, 2));
    return distance1 + distance2 <= lineLength + eraserSize;
  }



}

class DrawnShape {
  List<Offset>? points;
  Offset? start;
  Offset? end;
  String? text;
  ShapeType type;
  double size;

  DrawnShape({this.points, this.start, this.end, this.text, required this.type, this.size = 2.0});
}

enum ShapeType { pencil, square, text, line, circle }

class ShapePainter extends CustomPainter {
  final List<DrawnShape> shapes;

  ShapePainter({required this.shapes});

  @override
  void paint(Canvas canvas, Size size) {
    for (var shape in shapes) {
      final paint = Paint()
        ..color = Colors.black
        ..strokeWidth = shape.size
        ..style = PaintingStyle.stroke;

      if (shape.type == ShapeType.pencil && shape.points != null) {
        for (int i = 0; i < shape.points!.length - 1; i++) {
          canvas.drawLine(shape.points![i], shape.points![i + 1], paint);
        }
      } else if (shape.type == ShapeType.square && shape.start != null && shape.end != null) {
        canvas.drawRect(
          Rect.fromPoints(shape.start!, shape.end!),
          paint..style = PaintingStyle.stroke,
        );
      } else if (shape.type == ShapeType.circle && shape.start != null && shape.end != null) {
        double radius = (shape.start! - shape.end!).distance / 2;
        Offset center = Offset(
          (shape.start!.dx + shape.end!.dx) / 2,
          (shape.start!.dy + shape.end!.dy) / 2,
        );
        canvas.drawCircle(center, radius, paint..style = PaintingStyle.stroke);
      } else if (shape.type == ShapeType.line && shape.start != null && shape.end != null) {
        canvas.drawLine(shape.start!, shape.end!, paint..style = PaintingStyle.stroke);
      } else if (shape.type == ShapeType.text && shape.start != null && shape.text != null) {
        final textSpan = TextSpan(
          text: shape.text,
          style: TextStyle(color: Colors.black, fontSize: shape.size),
        );
        final textPainter = TextPainter(
          text: textSpan,
          textDirection: TextDirection.ltr,
        );
        textPainter.layout();
        textPainter.paint(canvas, shape.start!);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}