import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:salud_esperanza/src/controller/forms/loginForm.dart';
import 'package:salud_esperanza/src/models/usuarioApp.dart';
import 'package:salud_esperanza/src/pages/homePage.dart';
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

    // si los inputs text son corretoss
    final token = await Provider.of<LoginProvider>(context, listen: false).loginUsuario(email: loginController.getEmail, password: loginController.getPassword);
    if (token.isNotEmpty) {
      final usuario = await Provider.of<LoginProvider>(context, listen: false).miPerfilUsuario();
      if (usuario!=null && usuario.rol==UsuarioModel.participante) {
        await Alert(context: context, title: "Bienvenido querido participante", desc: "${usuario.username}").show();
        Navigator.pushNamed(context, HomeParticipantePage.routeName);
      } else {
        final storage = new FlutterSecureStorage();
        storage.deleteAll();
        Alert(context: context, title: "Usuario no tienes el rol de participante", desc: "No tienes los permisos necesarios para poder acceder al sistema").show();
      }
    } else {
      Alert(context: context, title: "Usuario no encontrado", desc: "La contraseña o email son incorrectos").show();

    }
  }
}
