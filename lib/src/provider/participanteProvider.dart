import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:http/http.dart' as http;
import 'package:salud_esperanza/src/models/actividadUsuarioHoy.dart';
import 'package:salud_esperanza/src/models/tarjetaModificacionModel.dart';
import 'package:salud_esperanza/src/models/usuarioApp.dart';
class ParticipanteProvider extends ChangeNotifier{
  final storage = new FlutterSecureStorage();
  List<TarjetaModificacionModel>? misTarjetasModificaion;

  Future<List<TarjetaModificacionModel>?> misTarjetasDeModificaion()async {
    var url = Uri.parse('http://192.168.2.20:8080/api/misTarjetasDeModificacion/');
    var response = await http.get(url, headers: {
      'x-api-key': 'Gxgo0kQa.uTG4PM8Gv9qA8u6qmBRRG3TWG1UjwnlX',
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

  Future<List<ActividadHoyModel>?> misActividadesDeHoy(String idTarejta)async {

    var url = Uri.parse('http://192.168.2.20:8080/api/miActividadeUsuarioHoy/?actividadFecha__tarjetaModificacion__id=$idTarejta');
    var response = await http.get(url, headers: {
      'x-api-key': 'Gxgo0kQa.uTG4PM8Gv9qA8u6qmBRRG3TWG1UjwnlX',
      "Authorization": 'Bearer ${await storage.read(key: 'AccessToken')??''}',
    });
    if (response.statusCode == 200 || response.statusCode == 201) {
      final values = (json.decode(utf8.decode(response.bodyBytes)) as List).map((e) => ActividadHoyModel.fromMap(e)).toList();
      notifyListeners();
      return values;
    }
    return null;
  }


  Future<void> completarActividadHoy(String idActividad)async {
    SmartDialog.showLoading(widget: Center(child: CircularProgressIndicator()));
    var url = Uri.parse('http://192.168.2.20:8080/api/miActividadeUsuarioHoy/$idActividad/');
    var response = await http.put(url,
      headers: {
        'x-api-key': 'Gxgo0kQa.uTG4PM8Gv9qA8u6qmBRRG3TWG1UjwnlX',
        "Authorization": 'Bearer ${await storage.read(key: 'AccessToken')??''}',
      },
      body: {
        "estadoActividad": "0"
      }
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      print("Actividad compeltada");
    }
    SmartDialog.dismiss();
  }


}