import 'package:TopoSmart/domain/repositories/measurement_repository.dart';

class CreateMeasurementUseCase {
  final MeasurementRepository measurementRepository;

  CreateMeasurementUseCase(this.measurementRepository);

  Future<void> execute({required int station, required int minus, required int fixedLevel, required int plus, required int height, required String notes, required String projectId, required String token}) {
    return measurementRepository.createMeasu(station: station, minus: minus, fixedLevel:fixedLevel, plus: plus, height:height, notes:notes, projectId:projectId, token: token);
  }
}