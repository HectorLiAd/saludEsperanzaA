import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:salud_esperanza/src/pages/login/formLoginWidget.dart';
import 'package:salud_esperanza/src/pages/pages.dart';

class LoginPage extends StatelessWidget {
  static final String routeName = "LoginPage";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
            child: Column(
            children: [
              SizedBox(height: 20),
              LoginFormWidget(),
              SizedBox(height: 20),
              ButtonLoginWidget(),
              ElevatedButton(
                onPressed: ()=>{
                  Navigator.pushNamed(context, RegistrarPage.routeName)
                },
                child: Text('Registrar usuario'),
              )
            ],
          ),
        ),
      ),
    );
  }

}
