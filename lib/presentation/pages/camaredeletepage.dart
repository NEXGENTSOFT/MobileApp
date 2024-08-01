import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert'; // Para manejar JSON

class ConfirmDeletePage extends StatelessWidget {
  final String photoUUID;
  final String photoUrl; // Añadido para recibir la URL de la imagen

  const ConfirmDeletePage({
    Key? key,
    required this.photoUUID,
    required this.photoUrl,
  }) : super(key: key);

  Future<void> _deletePhoto(BuildContext context) async {
    var headers = {
      'Content-Type': 'application/json',
    };

    var request = http.Request('DELETE', Uri.parse('https://servidor-toposmart.zapto.org/projectsmanagement/photos'));
    request.body = json.encode({
      "fileUuid": photoUUID,
      "fileUrl": photoUrl,
    });
    request.headers.addAll(headers);

    try {
      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        final responseBody = await response.stream.bytesToString();
        print(responseBody);
        Navigator.of(context).pop(true); // Retorna true si la eliminación fue exitosa
      } else {
        throw Exception('Error al eliminar la foto');
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al eliminar la foto: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Eliminar imagen'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.network(photoUrl), // Usar URL para mostrar la imagen
          SizedBox(height: 20),
          Text(
            '¿Desea eliminar esta imagen?',
            style: TextStyle(fontSize: 18),
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () {
                  _deletePhoto(context); // Llamar a la función para eliminar la foto
                },
                child: Text('Sí'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context, false); // Cancelar eliminación
                },
                child: Text('No'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
