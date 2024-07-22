import 'package:TopoSmart/domain/repositories/measurement_repository.dart';

class UpdateMeasurementUseCase {
  final MeasurementRepository measurementRepository;

  UpdateMeasurementUseCase(this.measurementRepository);

  Future<void> execute({ required String measurementUuid,
    required int minus,
    required int fixedLevel,
    required int plus,
    required int height,
    required String notes, required String token}) {
    return measurementRepository.updateMeasu(
      measurementUuid: measurementUuid,
      minus: minus,
      fixedLevel: fixedLevel,
      plus: plus,
      height: height,
      notes: notes, token: token,
    );
  }
}