class ProyectModel {
  final String name;
  final String description;

  const ProyectModel({
    required this.name,
    required this.description,


  });

  factory ProyectModel.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
      'name': String name,
      'description': String description,

      } => ProyectModel(
          name: name,
          description: description,

      ),
      _ => throw const FormatException('Failed to load product.'),
    };
  }

}
