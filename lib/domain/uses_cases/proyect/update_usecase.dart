import 'package:TopoSmart/domain/repositories/proyect_repository.dart';

class UpdateProyectUseCase {
  final ProyectRepository proyectRepository;

  UpdateProyectUseCase(this.proyectRepository);

  Future<void> execute({ required String measurementUuid,
    required String uuid,
    required String name,
    required String description,required String token}) {
    return proyectRepository.updateProyect(
      uuid: uuid,
       name: name, description: description,
       token: token,
    );
  }
}