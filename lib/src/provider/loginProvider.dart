import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:http/http.dart' as http;
import 'package:salud_esperanza/src/models/usuarioApp.dart';
class LoginProvider extends ChangeNotifier{
  final storage = new FlutterSecureStorage();
  UsuarioModel? currentUserApp;


  Future<String> loginUsuario({required String email, required String password})async {
    SmartDialog.showLoading(widget: Center(child: CircularProgressIndicator()));
    var url = Uri.parse('http://192.168.2.20:8080/api/auth/login/');
    var response = await http.post(url, body: {
      "email": email,
      "password": password
    });
    SmartDialog.dismiss();
    final res = jsonDecode(utf8.decode(response.bodyBytes));
    if (response.statusCode<400) {
      await storage.write(key: 'AccessToken', value: res['access']);
      return res['access'];
    } else {
      print("usuario no encontrado");
    }
    notifyListeners();
    return '';
  }

  Future<UsuarioModel?> registroUsuario({required UsuarioModel usuario})async {
    SmartDialog.showLoading(widget: Center(child: CircularProgressIndicator()));
    var url = Uri.parse('http://192.168.2.20:8080/api/auth/register/');
    var response = await http.post(url, body: usuario.toMap(), headers: {
      'x-api-key': 'Gxgo0kQa.uTG4PM8Gv9qA8u6qmBRRG3TWG1UjwnlX'
    });
    print(response.body);
    SmartDialog.dismiss();
    if (response.statusCode == 200 || response.statusCode == 201) return UsuarioModel.fromJson(utf8.decode(response.bodyBytes));
    else return null;
  }


  Future<UsuarioModel?> miPerfilUsuario()async {
    var url = Uri.parse('http://192.168.2.20:8080/api/auth/me/');
    var response = await http.get(url, headers: {
      'x-api-key': 'Gxgo0kQa.uTG4PM8Gv9qA8u6qmBRRG3TWG1UjwnlX',
      "Authorization": 'Bearer ${await storage.read(key: 'AccessToken')??''}',
    });
    print(response.body);
    notifyListeners();
    if (response.statusCode == 200 || response.statusCode == 201) {
      currentUserApp = UsuarioModel.fromJson(utf8.decode(response.bodyBytes));
      return currentUserApp;
    }

    return null;
  }

}