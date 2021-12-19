import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:http/http.dart' as http;
import 'package:salud_esperanza/src/models/usuarioApp.dart';
class LoginProvider extends ChangeNotifier{
  final storage = new FlutterSecureStorage();

  Future<void> loginUsuario({required String email, required String password})async {
    SmartDialog.showLoading(widget: Center(child: CircularProgressIndicator()));
    var url = Uri.parse('http://192.168.2.20:8080/api/auth/login/');
    var response = await http.post(url, body: {
      "email": email,
      "password": password
    });
    SmartDialog.dismiss();
    final res = jsonDecode(utf8.decode(response.bodyBytes));
    print( res['access']);
    await storage.write(key: 'AccessToken', value: res['access']);
    notifyListeners();
  }

  Future<RegistroUsuarioModel?> registroUsuario({required RegistroUsuarioModel usuario})async {
    SmartDialog.showLoading(widget: Center(child: CircularProgressIndicator()));
    var url = Uri.parse('http://192.168.2.20:8080/api/auth/register/');
    var response = await http.post(url, body: usuario.toMap());
    print(response.body);
    SmartDialog.dismiss();
    if (response.statusCode == 200 || response.statusCode == 201) return RegistroUsuarioModel.fromJson(utf8.decode(response.bodyBytes));
    else return null;
  }

}