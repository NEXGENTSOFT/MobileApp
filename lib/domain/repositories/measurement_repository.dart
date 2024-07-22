import 'dart:io';
import 'package:TopoSmart/domain/models/measurementmodel.dart';

abstract class MeasurementRepository {
  Future<List<MeasurementModel>> getAllMeasu(String token);
  Future<void> deleteMeasu(String token, String measurementUuid);
  Future<MeasurementModel> getMeasuById(String measurementUuid, String token);
  Future<void> createMeasu({
    required int station,
    required int minus,
    required int fixedLevel,
    required int plus,
    required int height,
    required String notes,
    required String projectId,
    required String token,
  });
  Future<void> updateMeasu({
    required String measurementUuid,
    required int minus,
    required int fixedLevel,
    required int plus,
    required int height,
    required String notes,
    required String token,
  });
}