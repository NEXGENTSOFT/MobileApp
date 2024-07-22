import 'package:TopoSmart/domain/models/measurementmodel.dart';
import 'package:TopoSmart/domain/repositories/measurement_repository.dart';

class GetAllMeasurementUseCase {
  final MeasurementRepository measurementRepository;

  GetAllMeasurementUseCase(this.measurementRepository);

  Future<List<MeasurementModel>> execute(String token) async {
    return await measurementRepository.getAllMeasu(token);
  }
}