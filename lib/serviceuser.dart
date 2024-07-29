import 'dart:convert';
import 'package:http/http.dart' as http;

class RegisterService {
  Future<void> registerUser({
    required String name,
    required String last_name,
    required String username,
    required String email,
    required String password,
    required String birthdate,
  }) async {
    print('Enviando datos al servidor:');
    print('Nombre: $name');
    print('Apellido: $last_name');
    print('Nombre de usuario: $username');
    print('Correo electrónico: $email');
    print('Contraseña: $password');
    print('Fecha de nacimiento: $birthdate');

    try {
      final response = await http.post(
        Uri.parse('https://servidor-toposmart.zapto.org/usersmanagement/users/'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'name': name,
          'last_name': last_name,
          'username': username,
          'email': email,
          'password': password,
          'birthdate': birthdate,
        }),
      );

      final Map<String, dynamic> body = jsonDecode(response.body);

      if (response.statusCode == 200) {
        print('Usuario registrado exitosamente: ${body['message']}');
      } else {
        print('Error al registrar el usuario: ${body['message']}');
        throw Exception('Error al registrar el usuario: ${body['message']}');
      }
    } catch (e) {
      print('Error al conectar con el servidor: $e');
      throw Exception('Error al conectar con el servidor');
    }
  }
}
