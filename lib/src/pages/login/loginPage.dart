import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';
import 'package:salud_esperanza/src/pages/login/formLoginWidget.dart';
import 'package:salud_esperanza/src/pages/pages.dart';
import 'package:salud_esperanza/src/provider/loginProvider.dart';

class LoginPage extends StatelessWidget {
  static final String routeName = "LoginPage";

  void currentUser(BuildContext context) async {
    final storage = new FlutterSecureStorage();
    String tkn = '${await storage.read(key: 'AccessToken')??''}';
    if (tkn.isNotEmpty) {
      final usuario = await Provider.of<LoginProvider>(context, listen: false).miPerfilUsuario();
      if (usuario!=null) {
        Navigator.pushNamedAndRemoveUntil(
          context,
          HomeParticipantePage.routeName,
          (Route<dynamic> route) => false
        );
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    currentUser(context);
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
            child: Column(
            children: [
              SizedBox(height: 20),
              LoginFormWidget(),
              SizedBox(height: 20),
              ButtonLoginWidget(),
            ],
          ),
        ),
      ),
    );
  }

}
