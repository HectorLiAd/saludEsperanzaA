import 'dart:convert';

class ProgresoSemanalModel {
  ProgresoSemanalModel({
    this.tarjetaUsuario,
    this.actividadHoy,
    this.cantidadDias,
    this.numDiaHoy,
    this.actividadesDiarias,
  });

  TarjetaUsuario? tarjetaUsuario;
  Actividad? actividadHoy;
  int? cantidadDias;
  int? numDiaHoy;
  List<Actividad>? actividadesDiarias;

  factory ProgresoSemanalModel.fromJson(String str) => ProgresoSemanalModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ProgresoSemanalModel.fromMap(Map<String, dynamic> json) => ProgresoSemanalModel(
    tarjetaUsuario: TarjetaUsuario.fromMap(json["tarjetaUsuario"]),
    actividadHoy: Actividad.fromMap(json["actividadHoy"]),
    cantidadDias: json["cantidadDias"],
    numDiaHoy: json["numDiaHoy"],
    actividadesDiarias: List<Actividad>.from(json["actividadesDiarias"].map((x) => Actividad.fromMap(x))),
  );

  Map<String, dynamic> toMap() => {
    "tarjetaUsuario": (tarjetaUsuario!=null)?tarjetaUsuario!.toMap():null,
    "actividadHoy": (actividadHoy!=null)?actividadHoy!.toMap():null,
    "cantidadDias": cantidadDias,
    "numDiaHoy": numDiaHoy,
    "actividadesDiarias": (actividadesDiarias!=null)?List<dynamic>.from(actividadesDiarias!.map((x) => x.toMap())):null,
  };
}

class Actividad {
  Actividad({
    this.created,
    this.modified,
    this.id,
    this.tarjetaModificacionId,
    this.actividadFecha,
    this.totalActividades,
    this.actividadesEnBlanco,
    this.actividadesMarcadas,
    this.actividadesCompletadas,
    this.actividadesNoCompletadas,
    this.actividadesEnProceso,
  });

  String? created;
  String? modified;
  String? id;
  String? tarjetaModificacionId;
  String? actividadFecha;
  int? totalActividades;
  int? actividadesEnBlanco;
  int? actividadesMarcadas;
  int? actividadesCompletadas;
  int? actividadesNoCompletadas;
  int? actividadesEnProceso;

  String get porcentajeAvanzado{
    try {
      int porcentaje = (this.actividadesMarcadas!*100)~/this.totalActividades!;
      return '${porcentaje}% del progreso';
    } on IntegerDivisionByZeroException catch (e) {
      return 'Sin actividades';
    }
  }

  factory Actividad.fromJson(String str) => Actividad.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Actividad.fromMap(Map<String, dynamic> json) => Actividad(
    created: json["created"],
    modified: json["modified"],
    id: json["id"],
    tarjetaModificacionId: json["tarjetaModificacion_id"],
    actividadFecha: json["actividadFecha"],
    totalActividades: json["totalActividades"],
    actividadesEnBlanco: json["actividadesEnBlanco"],
    actividadesMarcadas: json["actividadesMarcadas"],
    actividadesCompletadas: json["actividadesCompletadas"],
    actividadesNoCompletadas: json["actividadesNoCompletadas"],
    actividadesEnProceso: json["actividadesEnProceso"],
  );

  Map<String, dynamic> toMap() => {
    "created": created,
    "modified": modified,
    "id": id,
    "tarjetaModificacion_id": tarjetaModificacionId,
    "actividadFecha": actividadFecha,
    "totalActividades": totalActividades,
    "actividadesEnBlanco": actividadesEnBlanco,
    "actividadesMarcadas": actividadesMarcadas,
    "actividadesCompletadas": actividadesCompletadas,
    "actividadesNoCompletadas": actividadesNoCompletadas,
    "actividadesEnProceso": actividadesEnProceso,
  };
}

class TarjetaUsuario {
  TarjetaUsuario({
    this.id,
    this.created,
    this.modified,
    this.titulo,
    this.fechaInicio,
    this.fechaFin,
    this.horaActividadEntrega,
    this.horaActividadEntregaFin,
    this.participante,
  });

  String? id;
  String? created;
  String? modified;
  String? titulo;
  String? fechaInicio;
  String? fechaFin;
  String? horaActividadEntrega;
  String? horaActividadEntregaFin;
  String? participante;

  factory TarjetaUsuario.fromJson(String str) => TarjetaUsuario.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory TarjetaUsuario.fromMap(Map<String, dynamic> json) => TarjetaUsuario(
    id: json["id"],
    created: json["created"],
    modified: json["modified"],
    titulo: json["titulo"],
    fechaInicio: json["fechaInicio"],
    fechaFin: json["fechaFin"],
    horaActividadEntrega: json["horaActividadEntrega"],
    horaActividadEntregaFin: json["horaActividadEntregaFin"],
    participante: json["participante"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "created": created,
    "modified": modified,
    "titulo": titulo,
    "fechaInicio": fechaInicio,
    "fechaFin":  fechaFin,
    "horaActividadEntrega": horaActividadEntrega,
    "horaActividadEntregaFin": horaActividadEntregaFin,
    "participante": participante,
  };
}
