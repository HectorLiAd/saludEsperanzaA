import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:salud_esperanza/src/controller/forms/loginForm.dart';
import 'package:salud_esperanza/src/pages/HomePage.dart';
import 'package:salud_esperanza/src/provider/loginProvider.dart';
import 'package:salud_esperanza/src/provider/participanteProvider.dart';

class LoginFormWidget extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return ReactiveForm(
      formGroup: loginController.loginForm,
      child: Column(
        children: <Widget>[
          _buildEmail(),
          SizedBox(height: 20),
          _buildPassword(),
        ],
      ),
    );
  }

  Widget _buildEmail() {
    return ReactiveTextField(
      decoration: InputDecoration(
        hintText: 'Email'
      ),
      keyboardType: TextInputType.emailAddress,
      formControlName: 'email',
      validationMessages: (control)=> {
        ValidationMessage.required:'Este campo es requerido',
        ValidationMessage.email:'Debe ser un email valido',
      },
    );
  }

  Widget _buildPassword() {
    return ReactiveTextField(
      decoration: InputDecoration(
          hintText: 'Password'
      ),
      keyboardType: TextInputType.text,
      formControlName: 'password',
      validationMessages: (control)=> {
        ValidationMessage.required:'Este campo es requerido',
      },
    );
  }


}


class ButtonLoginWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(onPressed: ()=>_onPressed(context), child: Text("Iniciar sesiòn"));
  }

  void _onPressed(BuildContext context) async {
    loginController.loginForm.markAllAsTouched();
    FocusScope.of(context).unfocus();
    if (!loginController.loginForm.valid) return;
    print(loginController.getEmail);
    print(loginController.getPassword);
    final token = await Provider.of<LoginProvider>(context, listen: false).loginUsuario(
      email: loginController.getEmail,
      password: loginController.getPassword
    );
    if (token.isNotEmpty) {
      await Provider.of<LoginProvider>(context, listen: false).miPerfilUsuario();
      Navigator.pushNamed(context, HomeParticipantePage.routeName);

    }
  }
}
