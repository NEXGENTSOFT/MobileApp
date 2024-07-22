import 'package:TopoSmart/domain/models/subscriptionmodel.dart';

abstract class UserSubsRepository {
  Future<SubscriptionModel> subsUser(String user_id, String token);
}