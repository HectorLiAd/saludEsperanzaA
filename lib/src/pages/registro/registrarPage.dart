import 'package:flutter/material.dart';
import 'package:salud_esperanza/src/pages/registro/formRegistroWidget.dart';

class RegistrarPage extends StatelessWidget {
  static final String routeName = "RegistrarPage";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 20),
              RegistroFormWidget(),
              SizedBox(height: 20),
              ButtonRegistroWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
