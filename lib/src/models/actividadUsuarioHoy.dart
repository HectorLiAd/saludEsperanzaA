// To parse this JSON data, do
//
//     final actividadHoyModel = actividadHoyModelFromMap(jsonString);

import 'dart:convert';

class ActividadHoyModel {

  ActividadHoyModel({
    this.id,
    this.actividadFecha,
    this.actividad,
    this.estadoActividad,
  });

  String? id;
  ActividadFecha? actividadFecha;
  Actividad? actividad;
  String? estadoActividad;

  factory ActividadHoyModel.fromJson(String str) => ActividadHoyModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ActividadHoyModel.fromMap(Map<String, dynamic> json) => ActividadHoyModel(
    id: json["id"],
    actividadFecha: ActividadFecha.fromMap(json["actividadFecha"]),
    actividad: Actividad.fromMap(json["actividad"]),
    estadoActividad: json["estadoActividad"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "actividadFecha": (actividadFecha!=null)?actividadFecha!.toMap():null,
    "actividad": (actividad!=null)? actividad!.toMap():null,
    "estadoActividad": estadoActividad,
  };
}

class Actividad {
  static final String BLANCO = '-1';
  static final String COMPLETADO = '0';
  Actividad({
    this.id,
    this.created,
    this.modified,
    this.titulo,
    this.horaEjecucion,
    this.horaFinalizacion,
    this.tarjetaModificacion,
    this.departamento,
    this.personalDepartamento,
  });

  String? id;
  String? created;
  String? modified;
  String? titulo;
  String? horaEjecucion;
  String? horaFinalizacion;
  String? tarjetaModificacion;
  String? departamento;
  PersonalDepartamento? personalDepartamento;

  factory Actividad.fromJson(String str) => Actividad.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Actividad.fromMap(Map<String, dynamic> json) => Actividad(
    id: json["id"],
    created: json["created"],
    modified: json["modified"],
    titulo: json["titulo"],
    horaEjecucion: json["horaEjecucion"],
    horaFinalizacion: json["horaFinalizacion"],
    tarjetaModificacion: json["tarjetaModificacion"],
    departamento: json["departamento"],
    personalDepartamento: PersonalDepartamento.fromMap(json["personalDepartamento"]),
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "created": created,
    "modified": modified,
    "titulo": titulo,
    "horaEjecucion": horaEjecucion,
    "horaFinalizacion": horaFinalizacion,
    "tarjetaModificacion": tarjetaModificacion,
    "departamento": departamento,
    "personalDepartamento": (personalDepartamento!=null)?personalDepartamento!.toMap():null,
  };
}

class PersonalDepartamento {
  PersonalDepartamento({
    this.id,
    this.created,
    this.modified,
    this.personalDepartamento,
    this.departamento,
  });

  String? id;
  String? created;
  String? modified;
  Departamento? personalDepartamento;
  Departamento? departamento;

  factory PersonalDepartamento.fromJson(String str) => PersonalDepartamento.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory PersonalDepartamento.fromMap(Map<String, dynamic> json) => PersonalDepartamento(
    id: json["id"],
    created: json["created"],
    modified: json["modified"],
    personalDepartamento: Departamento.fromMap(json["personalDepartamento"]),
    departamento: Departamento.fromMap(json["departamento"]),
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "created": created,
    "modified": modified,
    "personalDepartamento": (personalDepartamento!=null)?personalDepartamento!.toMap():null,
    "departamento": (departamento!=null)?departamento!.toMap():null,
  };
}

class Departamento {
  Departamento({
    this.id,
    this.created,
    this.modified,
    this.nombre,
    this.personal,
  });

  String? id;
  String? created;
  String? modified;
  String? nombre;
  Personal? personal;

  factory Departamento.fromJson(String str) => Departamento.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Departamento.fromMap(Map<String, dynamic> json) => Departamento(
    id: json["id"],
    created: json["created"],
    modified: json["modified"],
    nombre: json["nombre"] == null ? null : json["nombre"],
    personal: json["personal"] == null ? null : Personal.fromMap(json["personal"]),
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "created": created,
    "modified": modified,
    "nombre": nombre == null ? null : nombre,
    "personal": personal == null ? null : personal!.toMap(),
  };
}

class Personal {
  Personal({
    this.id,
    this.username,
    this.firstName,
    this.lastName,
    this.isActive,
    this.email,
    this.avatar,
    this.informacion,
    this.genero,
    this.fechaNacimiento,
    this.direccionActual,
    this.latitud,
    this.longitud,
    this.bienvenida,
    this.dni,
    this.created,
    this.modified,
    this.rol,
  });

  String? id;
  String? username;
  String? firstName;
  String? lastName;
  bool? isActive;
  String? email;
  String? avatar;
  String? informacion;
  String? genero;
  String? fechaNacimiento;
  String? direccionActual;
  String? latitud;
  String? longitud;
  bool? bienvenida;
  String? dni;
  String? created;
  String? modified;
  String? rol;

  factory Personal.fromJson(String str) => Personal.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Personal.fromMap(Map<String, dynamic> json) => Personal(
    id: json["id"],
    username: json["username"],
    firstName: json["first_name"],
    lastName: json["last_name"],
    isActive: json["is_active"],
    email: json["email"],
    avatar: json["avatar"],
    informacion: json["informacion"],
    genero: json["genero"],
    fechaNacimiento: json["fechaNacimiento"],
    direccionActual: json["direccionActual"],
    latitud: json["latitud"],
    longitud: json["longitud"],
    bienvenida: json["bienvenida"],
    dni: json["dni"],
    created: json["created"],
    modified: json["modified"],
    rol: json["rol"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "username": username,
    "first_name": firstName,
    "last_name": lastName,
    "is_active": isActive,
    "email": email,
    "avatar": avatar,
    "informacion": informacion,
    "genero": genero,
    "fechaNacimiento": fechaNacimiento,
    "direccionActual": direccionActual,
    "latitud": latitud,
    "longitud": longitud,
    "bienvenida": bienvenida,
    "dni": dni,
    "created": created,
    "modified": modified,
    "rol": rol,
  };
}

class ActividadFecha {
  ActividadFecha({
    this.id,
    this.created,
    this.modified,
    this.actividadFecha,
    this.tarjetaModificacion,
  });

  String? id;
  String? created;
  String? modified;
  String? actividadFecha;
  String? tarjetaModificacion;

  factory ActividadFecha.fromJson(String str) => ActividadFecha.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ActividadFecha.fromMap(Map<String, dynamic> json) => ActividadFecha(
    id: json["id"],
    created: json["created"],
    modified: json["modified"],
    actividadFecha: json["actividadFecha"],
    tarjetaModificacion: json["tarjetaModificacion"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "created": created,
    "modified": modified,
    "actividadFecha": actividadFecha,
    "tarjetaModificacion": tarjetaModificacion,
  };
}
