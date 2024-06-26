import 'package:TopoSmart/presentation/pages/drawingpage.dart';
import 'package:flutter/material.dart';
import 'package:TopoSmart/presentation/pages/measurementpage.dart';
import 'package:TopoSmart/presentation/pages/camarapage.dart';
import 'dart:io';

class MyProjectPage extends StatefulWidget {
  final Map<String, String> project;

  const MyProjectPage({Key? key, required this.project}) : super(key: key);

  @override
  State<MyProjectPage> createState() => _MyProjectPageState();
}

class _MyProjectPageState extends State<MyProjectPage> {
  Color colorpage = Color(0xFF4A4E69);
  Color buttonIN = Color(0xFFD2A351);
  Color letraA = Color(0xFF22223B);
  Color uno = Color(0xFFF2E9E4);
  Color label = Color(0xFFB78471);
  int _pageproject = 0;

  List<File> imageFiles = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: uno,
        title: Text(widget.project['name'] ?? 'Detalle del Proyecto'),
      ),
      body: IndexedStack(
        index: _pageproject,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.project['name'] ?? 'Sin nombre',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                Text(
                  widget.project['description'] ?? 'Sin descripción',
                  style: TextStyle(fontSize: 16),
                ),
                if (imageFiles.isNotEmpty) ...[
                  SizedBox(height: 10),
                  Expanded(
                    child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                      ),
                      itemCount: imageFiles.length,
                      itemBuilder: (context, index) {
                        return ClipRRect(
                          borderRadius: BorderRadius.circular(15.0),
                          child: Image.file(
                            imageFiles[index],
                            fit: BoxFit.cover,
                            width: double.infinity,
                            height: double.infinity,
                          ),
                        );
                      },
                    ),
                  ),
                ],
                // Agrega más detalles
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        color: colorpage,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              icon: Icon(Icons.brush, color: Colors.white, size: 30),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DrawingPage(),
                  ),
                );
              },
            ),
            IconButton(
              icon: Icon(Icons.straighten, color: Colors.white, size: 30),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MyMeasurementPage(title: ''),
                  ),
                );
              },
            ),
            IconButton(
              icon: Icon(Icons.camera_alt_outlined, color: Colors.white, size: 30),
              onPressed: () async {
                final result = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MyCameraPage(),
                  ),
                );
                if (result != null && result is File) {
                  setState(() {
                    imageFiles.add(result);
                  });
                }
              },
            ),
            IconButton(
              icon: Icon(Icons.description, color: Colors.white, size: 30),
              onPressed: () {
                /* Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProfilePage(),
                  ),
                );*/
              },
            ),
          ],
        ),
      ),
    );
  }
}
