import 'package:TopoSmart/domain/repositories/proyect_repository.dart';

class CreateProyectUseCase {
  final ProyectRepository proyectRepository;

  CreateProyectUseCase(this.proyectRepository);

  Future<void> execute({required String name, required String description, required String token}) {
    return proyectRepository.createProyect(name: name, description:description, token: token);
  }
}