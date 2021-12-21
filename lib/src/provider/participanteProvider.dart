import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:http/http.dart' as http;
import 'package:salud_esperanza/src/models/actividadUsuarioHoy.dart';
import 'package:salud_esperanza/src/models/promogresoModel.dart';
import 'package:salud_esperanza/src/models/tarjetaModificacionModel.dart';
import 'package:salud_esperanza/src/models/usuarioApp.dart';
import 'package:salud_esperanza/src/provider/credenciales.dart';
class ParticipanteProvider extends ChangeNotifier{

  final storage = new FlutterSecureStorage();
  List<TarjetaModificacionModel>? misTarjetasModificaion;
  List<ActividadHoyModel>? listaActividades;
  List<ProgresoSemanalModel>? listaProgresoSemanal;

  Future<List<TarjetaModificacionModel>?> misTarjetasDeModificaion()async {
    var url = Uri.parse('${CredencialesApi.url}/api/misTarjetasDeModificacion/');
    var response = await http.get(url, headers: {
      'x-api-key': '${CredencialesApi.apiKey}',
      "Authorization": 'Bearer ${await storage.read(key: 'AccessToken')??''}',
    });
    if (response.statusCode == 200 || response.statusCode == 201) {
      final values = (json.decode(utf8.decode(response.bodyBytes)) as List).map((e) => TarjetaModificacionModel.fromMap(e)).toList();
      misTarjetasModificaion = values;
      notifyListeners();
      return misTarjetasModificaion;
    }
    notifyListeners();
    return null;
  }

  Future<List<ActividadHoyModel>?> misActividadesDeHoy(String idTarejta) async {
    this.listaActividades = null;
    var url = Uri.parse('${CredencialesApi.url}/api/miActividadeUsuarioHoy/?actividadFecha__tarjetaModificacion__id=$idTarejta');
    var response = await http.get(url, headers: {
      'x-api-key': '${CredencialesApi.apiKey}',
      "Authorization": 'Bearer ${await storage.read(key: 'AccessToken')??''}',
    });
    if (response.statusCode == 200 || response.statusCode == 201) {
      final values = (json.decode(utf8.decode(response.bodyBytes)) as List).map((e) => ActividadHoyModel.fromMap(e)).toList();
      listaActividades = values;
      notifyListeners();
      return values;
    }
    listaActividades=List.empty(growable: true);
    notifyListeners();
    return null;
  }


  Future<void> completarActividadHoy(String idActividad, String estado)async {
    SmartDialog.showLoading(widget: Center(child: CircularProgressIndicator()));
    var url = Uri.parse('${CredencialesApi.url}/api/miActividadeUsuarioHoy/$idActividad/');
    var response = await http.put(url,
      headers: {
        'x-api-key': '${CredencialesApi.apiKey}',
        "Authorization": 'Bearer ${await storage.read(key: 'AccessToken')??''}',
      },
      body: {
        "estadoActividad": estado
      }
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      if (this.listaActividades!=null) {
        this.listaActividades = this.listaActividades!.map((e) {
          if (e.id == idActividad) e.estadoActividad = estado;
          return e;
        }).toList();
      }
    }
    SmartDialog.dismiss();
    notifyListeners();

  }

  Future<List<ProgresoSemanalModel>?> miProgresoSemanal()async {
    var url = Uri.parse('${CredencialesApi.url}/api/miProgresoSemanal/');
    var response = await http.get(url,
      headers: {
        'x-api-key': '${CredencialesApi.apiKey}',
        "Authorization": 'Bearer ${await storage.read(key: 'AccessToken')??''}',
      },
    );
    if (response.statusCode < 400) {
      final values = (json.decode(utf8.decode(response.bodyBytes)) as List).map((e) => ProgresoSemanalModel.fromMap(e)).toList();
      listaProgresoSemanal = values;
    }
    notifyListeners();
    return listaProgresoSemanal;
  }

}