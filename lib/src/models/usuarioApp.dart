import 'dart:convert';

class UsuarioModel {
  UsuarioModel({
    this.id,
    this.email,
    this.firstName,
    this.lastName,
    this.username,
    this.password,
    this.dni,
  });

  String? id;
  String? email;
  String? firstName;
  String? lastName;
  String? username;
  String? password;
  String? dni;

  factory UsuarioModel.fromJson(String str) => UsuarioModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory UsuarioModel.fromMap(Map<String, dynamic> json) => UsuarioModel(
    id: json["id"],
    email: json["email"],
    firstName: json["first_name"],
    lastName: json["last_name"],
    username: json["username"],
    password: json["password"],
    dni: json["dni"],
  );

  Map<String, dynamic> toMap() => {
    "email": email,
    "first_name": firstName,
    "last_name": lastName,
    "username": username,
    "password": password,
    "dni": dni,
  };
}
