import 'package:TopoSmart/domain/models/proyectmodel.dart';
import 'package:TopoSmart/domain/repositories/proyect_repository.dart';

class GetAllProyectUseCase {
  final ProyectRepository proyectRepository;

  GetAllProyectUseCase(this.proyectRepository);

  Future<List<ProyectModel>> execute(String token) async {
    return await proyectRepository.getAllProyect(token);
  }
}