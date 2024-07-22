import 'package:TopoSmart/domain/models/proyectmodel.dart';
import 'package:TopoSmart/domain/repositories/proyect_repository.dart';

class GetProyectByIdUseCase {
  final ProyectRepository proyectRepository;

  GetProyectByIdUseCase(this.proyectRepository);

  Future<ProyectModel> execute(String measurementUuid, String token) async {
    try {
      final proyect = await proyectRepository.getProyectById(measurementUuid, token);
      return proyect;
    } catch (error) {
      throw Exception('Error al obtener los datos del proyect: $error');
    }
  }
}