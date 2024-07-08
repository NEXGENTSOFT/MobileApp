import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:TopoSmart/domain/models/savedrawingmodel.dart';
import 'package:TopoSmart/presentation/pages/drawingpage.dart';
import 'package:TopoSmart/presentation/components/shapepainter.dart';


class SavedDrawingsPage extends StatelessWidget {
  Color colorpage = Color(0xFF4A4E69);
  Color uno = Color(0xFFF2E9E4);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dibujos Guardados'),
        backgroundColor: uno,
      ),
      body: Consumer<SavedDrawingsModel>(
        builder: (context, savedDrawingsModel, child) {
          return ListView.builder(
            itemCount: savedDrawingsModel.savedDrawings.length,
            itemBuilder: (context, index) {
              List<DrawnShape> drawings = savedDrawingsModel.savedDrawings[index];
              return ListTile(
                title: Text('Dibujo ${index + 1}',style: TextStyle( fontFamily: 'Lato',
                  fontSize: 20,
                  fontWeight: FontWeight.normal,),),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DrawingPageWithSavedDrawing(drawings),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
      bottomNavigationBar: BottomAppBar(
        color: colorpage,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              icon: Icon(Icons.add_circle_outline, color: Colors.white, size: 30),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DrawingPage(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class DrawingPageWithSavedDrawing extends StatelessWidget {
  final List<DrawnShape> savedDrawing;

  DrawingPageWithSavedDrawing(this.savedDrawing);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ver Dibujo Guardado'),
      ),
      body: Center(
        child: CustomPaint(
          size: Size.infinite,
          painter: ShapePainter(shapes: savedDrawing),
        ),
      ),
    );
  }
}
