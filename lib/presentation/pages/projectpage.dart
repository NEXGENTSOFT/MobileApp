import 'package:flutter/material.dart';
import 'package:TopoSmart/presentation/pages/drawingpage.dart';
import 'package:TopoSmart/presentation/pages/measurementpage.dart';
import 'package:TopoSmart/presentation/pages/camarapage.dart';
import 'package:TopoSmart/presentation/pages/reportpage.dart';
import 'package:TopoSmart/presentation/pages/camaredeletepage.dart';
import 'package:TopoSmart/presentation/pages/savedrawingpage.dart';
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

  TextEditingController searchController = TextEditingController();

  String sanitizeInput(String input) {
    return input.replaceAll(RegExp(r'[\";--]'), '');
    }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: uno,
        title: Text(widget.project['name'] ?? 'Detalle del Proyecto'),
      ),
      body: IndexedStack(
        index: _pageproject,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: label,
                  ),
                  height: screenHeight * 0.15,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Text(
                          widget.project['name'] ?? 'Sin nombre',
                          style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.none, color: letraA
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Text(
                          widget.project['description'] ?? 'Sin descripción',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w300,
                            decoration: TextDecoration.none,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                if (imageFiles.isNotEmpty)
                  Expanded(
                    child: GridView.builder(
                      padding: EdgeInsets.all(10),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                      ),
                      itemCount: imageFiles.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () async {
                            final result = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ConfirmDeletePage(imageFile: imageFiles[index]),
                              ),
                            );
                            if (result == true) {
                              setState(() {
                                imageFiles.removeAt(index);
                              });
                            }
                          },
                          child: Container(
                            margin: EdgeInsets.all(4),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(15.0),
                              child: Image.file(
                                imageFiles[index],
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
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
                    builder: (context) => SavedDrawingsPage(),
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
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MyReportPage(title: ''),
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
