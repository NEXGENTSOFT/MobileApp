import 'package:TopoSmart/domain/models/subscriptionmodel.dart';
import 'package:TopoSmart/domain/repositories/subscription_repository.dart';

class GetSubscriptionByIdUseCase {
  final UserSubsRepository userSubsRepository;

  GetSubscriptionByIdUseCase(this.userSubsRepository);

  Future<SubscriptionModel> execute(String user_id, String token) async {
    try {
      final subs = await userSubsRepository.subsUser(user_id, token);
      return subs;
    } catch (error) {
      throw Exception('Error al obtener los datos de la medición: $error');
    }
  }
}