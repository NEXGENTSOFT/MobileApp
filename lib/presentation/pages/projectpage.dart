import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert'; // Para manejar JSON
import 'dart:io';
import 'package:TopoSmart/presentation/pages/camaredeletepage.dart';
import 'package:TopoSmart/presentation/pages/savedrawingpage.dart';
import 'package:TopoSmart/presentation/pages/measurementpage.dart';
import 'package:TopoSmart/presentation/pages/camarapage.dart';
import 'package:TopoSmart/presentation/pages/reportpage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert'; // Para manejar JSON
import 'dart:io'; // Asegúrate de importar la página de confirmación

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

  List<Map<String, dynamic>> photos = []; // Lista para almacenar las fotos

  @override
  void initState() {
    super.initState();
    _fetchPhotos(); // Obtener fotos cuando se inicialice la página
  }

  Future<void> _fetchPhotos() async {
    try {
      final response = await http.get(
        Uri.parse('https://servidor-toposmart.zapto.org/projectsmanagement/photos/project/${widget.project['id']}'),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final List<dynamic> photoList = data['data'];
        setState(() {
          photos = photoList.map((item) {
            return {
              'id': item['id'],
              'url': item['url'],
              'name': item['name'],
              'uuid': item['uuid'],
            };
          }).toList();
        });
      } else {
        throw Exception('Error al cargar las fotos');
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al cargar las fotos: $e')),
      );
    }
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
                            decoration: TextDecoration.none,
                            color: letraA,
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
                if (photos.isNotEmpty)
                  Expanded(
                    child: GridView.builder(
                      padding: EdgeInsets.all(10),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                      ),
                      itemCount: photos.length,
                      itemBuilder: (context, index) {
                        final photo = photos[index];
                        return GestureDetector(
                          onTap: () async {
                            final result = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ConfirmDeletePage(
                                  photoUUID: photo['uuid'],
                                  photoUrl: photo['url'],
                                ),
                              ),
                            );
                            if (result == true) {
                              setState(() {
                                photos.removeAt(index);
                              });
                            }
                          },
                          child: Container(
                            margin: EdgeInsets.all(4),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(15.0),
                              child: Image.network(
                                photo['url'],
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
                    builder: (context) => MyMeasurementPage(title: '', id: widget.project['id'] ?? 'id generico'),
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
                    builder: (context) => MyCameraPage(projectId: widget.project['id'] ?? 'id generico'),
                  ),
                );
                if (result != null && result is File) {
                  setState(() {
                    // Deberás subir la foto y actualizar la lista de fotos aquí
                    // Ejemplo:
                    // _uploadPhoto(result); // Implementa este método para subir la foto
                    // _fetchPhotos(); // Actualiza la lista de fotos después de subir
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
