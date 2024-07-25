import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

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

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> makePostRequest(String text) async {
    var headers = {
      'Content-Type': 'application/json'
    };
    var request = http.Request('POST', Uri.parse('http://literate-accurately-cockatoo.ngrok-free.app/correct'));
    request.body = json.encode({
      "text": text
    });
    request.headers.addAll(headers);

    try {
      http.StreamedResponse response = await request.send();
      print('Conexión establecida. Código de estado: ${response.statusCode}');

      if (response.statusCode == 200) {
        String responseBody = await response.stream.bytesToString();
        setState(() {
          _responseMessage = 'Proyecto guardado exitosamente!';
        });
        print(responseBody);
      } else if (response.statusCode == 307) {
        // Manejo de redirección temporal
        var redirectedUri = Uri.parse(response.headers['location']!);
        print('Redirigiendo a: $redirectedUri');
        var redirectedResponse = await http.post(
          redirectedUri,
          headers: headers,
          body: request.body,
        );

        if (redirectedResponse.statusCode == 200) {
          setState(() {
            _responseMessage = 'Proyecto guardado exitosamente tras redirección!';
          });
          print('Redirección exitosa.');
        } else {
          setState(() {
            _responseMessage = 'Error al guardar el proyecto tras redirección.';
          });
          print('Error tras redirección: ${redirectedResponse.reasonPhrase}');
        }
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
                        var data = {
                          'name': _nameController.text,
                          'description': _descriptionController.text,
                        };

                        String combinedText = '${data['name']}: ${data['description']}';
                        await makePostRequest(combinedText);

                        Navigator.pop(context, data);
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
