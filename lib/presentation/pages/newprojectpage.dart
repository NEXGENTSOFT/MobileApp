import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class MyNewProjectPage extends StatefulWidget {
  const MyNewProjectPage({super.key, required this.title});

  final String title;

  @override
  State<MyNewProjectPage> createState() => _MyNewProjectPageState();
}

class _MyNewProjectPageState extends State<MyNewProjectPage> {
  Color colorpage = Color(0xFF4A4E69);
  Color buttonIN = Color(0xFFD2A351);
  Color letraA = Color(0xFF22223B);
  Color uno = Color(0xFFF2E9E4);
  Color label = Color(0xFFB78471);

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  String _responseMessage = ''; // Variable para el mensaje de respuesta

  // Variables para los datos de respuesta
  int? _projectId;
  String? _projectName;
  String? _projectDescription;

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<int?> getUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userJson = prefs.getString('user');

    if (userJson != null) {
      Map<String, dynamic> user = jsonDecode(userJson);
      return user['id'] != null ? int.tryParse(user['id'].toString()) : null;
    } else {
      print('No se encontraron datos del usuario.');
      return null;
    }
  }

  Future<void> makePostRequest(String name, String description) async {
    int? userId = await getUserId();
    if (userId == null) {
      setState(() {
        _responseMessage = 'No se pudo recuperar el ID del usuario.';
      });
      return;
    }
    var headers = {
      'Content-Type': 'application/json'
    };
    var request = http.Request('POST', Uri.parse('https://servidor-toposmart.zapto.org/projectsmanagement/projects'));
    request.body = json.encode({
      "userId": userId,
      "name": name,
      "description": description
    });
    request.headers.addAll(headers);

    try {
      http.StreamedResponse response = await request.send();
      print('Conexión establecida. Código de estado: ${response.statusCode}');

      if (response.statusCode == 200) {
        String responseBody = await response.stream.bytesToString();
        var responseData = json.decode(responseBody);

        // Guardar los datos de respuesta
        setState(() {
          var data = responseData['data'];
          _projectId = data['id'];
          _projectName = data['name'];
          _projectDescription = data['description'];
          _responseMessage = responseData['message'];
        });
        print('Datos recibidos: $_projectId, $_projectName, $_projectDescription');
      } else {
        setState(() {
          _responseMessage = 'Error al guardar el proyecto.';
        });
        print('Error: ${response.reasonPhrase}');
      }
    } catch (e) {
      setState(() {
        _responseMessage = 'Ocurrió un error inesperado.';
      });
      print('Exception occurred: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeigh = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: uno,
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: screenHeigh * 0.1,
              child: Stack(
                children: [
                  Text(
                    'Nuevo proyecto',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontFamily: 'Lato',
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Nombre del proyecto',
                style: TextStyle(
                  fontFamily: 'Lato-Right',
                  fontSize: 18,
                ),
              ),
            ),
            SizedBox(height: screenHeigh * 0.01),
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: 'Nombre del proyecto',
                filled: true,
                fillColor: label.withOpacity(0.5),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: label),
                  borderRadius: BorderRadius.circular(15),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: label),
                ),
                labelStyle: TextStyle(
                  color: letraA,
                  fontFamily: 'Lato-Light',
                  fontSize: 13,
                ),
              ),
              style: TextStyle(
                color: letraA,
                fontSize: 13,
                fontFamily: "Lato-Light",
              ),
            ),
            SizedBox(height: screenHeigh * 0.04),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Descripción del proyecto',
                style: TextStyle(
                  fontFamily: 'Lato-Right',
                  fontSize: 18,
                ),
              ),
            ),
            SizedBox(height: screenHeigh * 0.01),
            TextField(
              controller: _descriptionController,
              decoration: InputDecoration(
                labelText: 'Descripción del proyecto',
                filled: true,
                fillColor: label.withOpacity(0.5),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: label),
                  borderRadius: BorderRadius.circular(15),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: label),
                ),
                labelStyle: TextStyle(
                  color: letraA,
                  fontFamily: 'Lato-Light',
                  fontSize: 13,
                ),
              ),
              style: TextStyle(
                color: letraA,
                fontSize: 13,
                fontFamily: "Lato-Light",
              ),
            ),
            SizedBox(height: screenHeigh * 0.04),
            Text(
              _responseMessage,
              style: TextStyle(
                color: _responseMessage.startsWith('Error') ? Colors.red : Colors.green,
                fontSize: 16,
                fontFamily: "Lato-Regular",
              ),
            ),
            SizedBox(height: screenHeigh * 0.1),
            Container(
              child: Center(
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () async {
                      if (_nameController.text.isNotEmpty && _descriptionController.text.isNotEmpty) {
                        await makePostRequest(
                          _nameController.text,
                          _descriptionController.text,
                        );

                        Navigator.pop(context, {
                          'id': _projectId,
                          'name': _projectName,
                          'description': _projectDescription,
                        });
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: buttonIN,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 12),
                    ),
                    child: Text(
                      'Guardar',
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: "Lato-Regular",
                        fontSize: 15,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
