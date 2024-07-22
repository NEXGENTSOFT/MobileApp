import 'package:TopoSmart/domain/repositories/user_repository.dart';

class DeleteUserUseCase {
  final UserRepository userRepository;

  DeleteUserUseCase(this.userRepository);

  Future<void> execute(String uuid, String password, String token) async {
    await userRepository.deleteUser(uuid, password, token);
  }
}