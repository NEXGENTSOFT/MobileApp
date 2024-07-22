import 'package:TopoSmart/domain/models/usermodel.dart';
import 'package:TopoSmart/domain/repositories/user_repository.dart';

class GetUserByIdUseCase {
  final UserRepository userRepository;

  GetUserByIdUseCase(this.userRepository);

  Future<UserModel> execute(String uuid, String token) async {
    try {
      final user = await userRepository.getUserById(uuid, token);
      return user;
    } catch (error) {
      throw Exception('Error al obtener los datos del usuario: $error');
    }
  }
}