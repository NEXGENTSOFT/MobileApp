
class UserModel {
  final String name;
  final String last_name;
  final String email;
  final String password;
  final String username;
  final String birthdate;

  const UserModel({
    required this.name,
    required this.last_name,
    required this.email,
    required this.password,
    required this.username,
    required this.birthdate,

  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
      "name": String name,
      "last_name": String last_name,
      "email": String email,
      "password": String password,
      "username": String username,
      "birthdate": String birthdate


      } => UserModel(
          name: name,
          last_name: last_name,
          email: email,
          password: password,
          username: username,
          birthdate: birthdate,
      ),
      _ => throw const FormatException('Failed'),
    };
  }
}
