import 'package:TopoSmart/domain/repositories/proyect_repository.dart';

class DeleteProyectUseCase {
  final ProyectRepository proyectRepository;

  DeleteProyectUseCase(this.proyectRepository);

  Future<void> execute(String uuid, String token) async {
    await proyectRepository.deleteProyect(uuid, token);
  }
}