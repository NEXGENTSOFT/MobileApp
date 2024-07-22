import 'dart:io';
import 'package:TopoSmart/domain/models/proyectmodel.dart';

abstract class ProyectRepository {
  Future<List<ProyectModel>> getAllProyect(String token);
  Future<void> deleteProyect(String token, String uuid);
  Future<ProyectModel> getProyectById(String uuid, String token);
  Future<void> createProyect({
    required String name,
    required String description,
    required String token,
  });
  Future<void> updateProyect({
    required String uuid,
    required String name,
    required String description,
    required String token,


  });
}