import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Measurementservices {
  final String apiUrl = 'https://servidor-toposmart.zapto.org/projectsmanagement/measurements';

  Future<String> newMeasu(
      int station,
      int minus,
      int fixedLevel,
      int plus,
      int height,
      String notes,
      String projectId,
      ) async {
    print("Realizando solicitud HTTP...");

    final response = await http.post(
      Uri.parse(apiUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'station': station,
        'minus': minus,
        'fixedLevel': fixedLevel,
        'plus': plus,
        'height': height,
        'notes': notes,
        'projectId': projectId
      }),
    );
    print("Respuesta recibida: ${response.body}");

    final Map<String, dynamic> body = jsonDecode(response.body);

    if (response.statusCode == 200) {
      final String token = body['token'];

      final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      sharedPreferences.setString('token', token);
      print('Token guardado en SharedPreferences.');

      return token;
    } else {
      print("Error al agregar la medición: ${body['message']}");
      throw Exception(body['message']);
    }
  }

  // Método para obtener las mediciones
  Future<List<Map<String, dynamic>>> getMeasurements() async {
    print("Realizando solicitud GET...");

    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      // Convertir la lista dinámica en una lista de mapas de tipo Map<String, dynamic>
      return data.map((item) => Map<String, dynamic>.from(item)).toList();
    } else {
      print("Error al obtener las mediciones: ${response.body}");
      throw Exception('Error al obtener las mediciones');
    }
  }
}
