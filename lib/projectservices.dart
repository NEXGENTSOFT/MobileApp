import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Projectservices {

  Future<String> proyectNew(String name, String description) async {
    print("Realizando solicitud HTTP...");

    final response = await http.post(
      Uri.parse('https://servidor-toposmart.zapto.org/projectsmanagement/projects'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'name': name,
        'description': description,
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
      print("Error al agregar el proyecto: ${body['message']}");
      throw Exception(body['message']);
    }
  }
}
