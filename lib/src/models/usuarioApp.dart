import 'dart:convert';

class UsuarioModel {

  static final String participante  = '0';
  static final String asistente     = '1';
  static final String personal      = '2';
  static final String admin_app     = '3';


  UsuarioModel({
    this.id,
    this.email,
    this.firstName,
    this.lastName,
    this.username,
    this.password,
    this.dni,
    this.rol
  });

  String? id;
  String? email;
  String? firstName;
  String? lastName;
  String? username;
  String? password;
  String? dni;
  String? rol;

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
    rol: json["rol"],
  );

  Map<String, dynamic> toMap() => {
    "email": email,
    "first_name": firstName,
    "last_name": lastName,
    "username": username,
    "password": password,
    "dni": dni,
    "rol": rol,
  };
}
