import 'dart:io';
import 'package:TopoSmart/domain/repositories/user_repository.dart';

class CreateUserUseCase {
  final UserRepository userRepository;

  CreateUserUseCase(this.userRepository);

  Future<void> execute({required String name, required String last_name, required String email, required String password, required String username,required String birthdate, required String token}) {
    return userRepository.createUser(name: name, last_name: last_name, email: email, password: password, username:username, birthdate:birthdate, token: token);
  }
}