import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:TopoSmart/presentation/providers/services.dart';
import 'package:TopoSmart/domain/models/usermodel.dart';
import 'package:TopoSmart/domain/repositories/user_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserRepositoryImpl implements UserRepository {
  late final ConnectivityService _connectivityService;

  //ProductRepositoryImpl(this._connectivityService);

  @override
  Future<List<UserModel>> getAllUser(String token) async {
    if (await _connectivityService.hasConnection()) {
      final response = await http.get(
        Uri.parse('http'),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final dynamic jsonResponse = json.decode(response.body);
        if (jsonResponse.containsKey('saucers')) {
          List<dynamic> saucersJson = jsonResponse['saucers'];
          List<UserModel> products = saucersJson.map((saucer) => UserModel.fromJson(saucer)).toList();

          final prefs = await SharedPreferences.getInstance();
          prefs.setString('user', json.encode(products));

          return products;
        } else {
          throw Exception('Response does not contain "saucers"');
        }
      } else {
        throw Exception('Failed to load users');
      }
    } else {
      final prefs = await SharedPreferences.getInstance();
      final productsString = prefs.getString('user');
      if (productsString != null) {
        final List<dynamic> productsJson = json.decode(productsString);
        return productsJson.map((product) => UserModel.fromJson(product)).toList();
      } else {
        throw Exception('No internet connection and no cached data available');
      }
    }
  }

  @override
  Future<UserModel> getUserById(String uuid, String token) async {
    try {
      final response = await http.get(
        Uri.parse('http://$uuid'),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );
      if (response.statusCode == 200) {
        final productData = json.decode(response.body);
        return UserModel.fromJson(productData);
      } else {
        throw Exception('Error al obtener los datos del usuario');
      }
    } catch (error) {
      throw Exception('Error al obtener los datos del usuario: $error');
    }
  }

  @override
  Future<void> deleteUser(String password, String uuid, String token) async {
    final url = 'http:$uuid';
    final response = await http.delete(Uri.parse(url), headers: {
      'Authorization': 'Bearer $token',
    });

    if (response.statusCode == 200) {
      if (kDebugMode) {
        print('Usuario eliminado exitosamente');
      }
    } else {
      throw Exception(
          'Error al eliminar el usuario: ${response.reasonPhrase}');
    }
  }

  @override
  Future<void> createUser(
      { required String name,
        required String last_name,
        required String email,
        required String password,
        required String username,
        required String birthdate,
        required String token}) async {
    const url = 'http';
    var request = http.MultipartRequest('POST', Uri.parse(url));
    request.headers.addAll({'Authorization': 'Bearer $token'});
    request.fields.addAll({
      'name': name,
      'last_name': last_name,
      'email': email,
      'username': username,
      'birthdate': birthdate,
      'password': password,
    });
    final response = await request.send();
    if (response.statusCode == 200) {
      if (kDebugMode) {
        print('Usuario creado exitosamente');
      }
    } else {
      throw Exception('Error al crear el usuario: ${response.reasonPhrase}');
    }
  }

  @override
  Future<void> updateUser(
      {
        required String uuid,
        required String name,
        required String password,
        required String newPassword,
        required String token}) async {
    final url = 'http:///$uuid';
    var request = http.MultipartRequest('PUT', Uri.parse(url));
    request.headers.addAll({'Authorization': 'Bearer $token'});
    request.fields.addAll({
      'uuid': uuid,
      'name': name,
      'password': password,
      'newPassword': newPassword,
    });
    final response = await request.send();
    if (response.statusCode == 200) {
      if (kDebugMode) {
        print('Usuario editado exitosamente');
      }
    } else {
      throw Exception('Error al editar el usuario: ${response.reasonPhrase}');
    }
  }
}