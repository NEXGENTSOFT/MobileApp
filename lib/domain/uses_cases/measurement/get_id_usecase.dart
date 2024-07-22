import 'package:TopoSmart/domain/models/measurementmodel.dart';
import 'package:TopoSmart/domain/repositories/measurement_repository.dart';

class GetMeasurementByIdUseCase {
  final MeasurementRepository measurementRepository;

  GetMeasurementByIdUseCase(this.measurementRepository);

  Future<MeasurementModel> execute(String measurementUuid, String token) async {
    try {
      final measu = await measurementRepository.getMeasuById(measurementUuid, token);
      return measu;
    } catch (error) {
      throw Exception('Error al obtener los datos de la medición: $error');
    }
  }
}