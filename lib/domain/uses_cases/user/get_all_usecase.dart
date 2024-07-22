import 'package:TopoSmart/domain/models/usermodel.dart';
import 'package:TopoSmart/domain/repositories/user_repository.dart';

class GetAllUsersUseCase {
  final UserRepository userRepository;

  GetAllUsersUseCase(this.userRepository);

  Future<List<UserModel>> execute(String token) async {
    return await userRepository.getAllUser(token);
  }
}