class MeasurementModel {
  final int station;
  final int minus;
  final int fixedLevel;
  final int plus;
  final int height;
  final String notes;
  final String projectId;

  const MeasurementModel({
    required this.station,
    required this.minus,
    required this.fixedLevel,
    required this.plus,
    required this.height,
    required this.notes,
    required this.projectId

  });

  factory MeasurementModel.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
      "station": int station,
      "minus": int minus,
      "fixedLevel": int fixedLevel,
      "plus": int plus,
      "height": int height,
      "notes": String notes,
      "projectId": String projectId




      } => MeasurementModel(
        station: station,
        minus: minus,
        fixedLevel: fixedLevel,
        plus: plus,
        height: height,
        notes: notes,
          projectId: projectId
      ),
      _ => throw const FormatException('Failed'),
    };
  }
}
