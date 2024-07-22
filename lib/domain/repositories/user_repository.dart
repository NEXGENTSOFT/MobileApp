import 'dart:io';
import 'package:TopoSmart/domain/models/usermodel.dart';

abstract class UserRepository {
  Future<List<UserModel>> getAllUser(String token);
  Future<void> deleteUser(String token, String uuid, String password);
  Future<UserModel> getUserById(String uuid, String token);
  Future<void> createUser({
    required String name,
    required String last_name,
    required String email,
    required String password,
    required String username,
    required String birthdate,
    required String token,
  });
  Future<void> updateUser({
    required String uuid,
    required String name,
    required String password,
    required String newPassword,
    required String token,

  });
}