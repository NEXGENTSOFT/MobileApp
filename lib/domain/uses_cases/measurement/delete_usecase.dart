import 'package:TopoSmart/domain/repositories/measurement_repository.dart';

class DeleteMeasurementUseCase {
  final MeasurementRepository measurementRepository;

  DeleteMeasurementUseCase(this.measurementRepository);

  Future<void> execute(String measurementUuid, String token) async {
    await measurementRepository.deleteMeasu(measurementUuid, token);
  }
}