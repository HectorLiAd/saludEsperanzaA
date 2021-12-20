import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:salud_esperanza/src/controller/forms/loginForm.dart';
import 'package:salud_esperanza/src/controller/forms/registroUsuario.dart';
import 'package:salud_esperanza/src/models/usuarioApp.dart';
import 'package:salud_esperanza/src/provider/loginProvider.dart';

class RegistroFormWidget extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return ReactiveForm(
      formGroup: registroUsuarioController.registerForm,
      child: Column(
        children: <Widget>[
          _buildNombre(),
          SizedBox(height: 20),
          _buildApellidos(),
          SizedBox(height: 20),
          _buildDNI(),
          SizedBox(height: 20),
          _buildNombreUsuario(),
          SizedBox(height: 20),
          _buildEmail(),
          SizedBox(height: 20),
          _buildPassword(),
          SizedBox(height: 20),
          _buildConfirmarPassword(),
        ],
      ),
    );
  }

  Widget _buildNombre (){
    return ReactiveTextField(
      decoration: InputDecoration(
          hintText: 'Nombres'
      ),
      formControlName: 'nombres',
      validationMessages: (control)=> {
        ValidationMessage.required:'Este campo es requerido',
        ValidationMessage.maxLength: 'Este campo debe tener como maximo 50 caracteres'
      },
    );
  }

  Widget _buildApellidos (){
    return ReactiveTextField(
      decoration: InputDecoration(
          hintText: 'Apellidos'
      ),
      formControlName: 'apellidos',
      validationMessages: (control)=> {
        ValidationMessage.required:'Este campo es requerido',
        ValidationMessage.maxLength: 'Este campo debe tener como maximo 50 caracteres'
      },
    );
  }

  Widget _buildDNI (){
    return ReactiveTextField(
      decoration: InputDecoration(
          hintText: 'DNI'
      ),
      keyboardType: TextInputType.number,
      formControlName: 'dni',
      validationMessages: (control)=> {
        ValidationMessage.required: 'Este campo es requerido',
        ValidationMessage.maxLength: 'DNI incorrecto',
        ValidationMessage.minLength: 'DNI incorrecto',
        ValidationMessage.number: 'Campo de tipo numerico'
      },
    );
  }

  Widget _buildNombreUsuario(){
    return ReactiveTextField(
      decoration: InputDecoration(
          hintText: 'Nombre de usuario del app'
      ),
      formControlName: 'user',
      validationMessages: (control)=> {
        ValidationMessage.required: 'Este campo es requerido',
        ValidationMessage.maxLength: 'Este campo debe tener como max 20',
        ValidationMessage.minLength: 'Este campo debe tener como min 5'
      },
    );
  }

  Widget _buildEmail(){
    return ReactiveTextField(
      decoration: InputDecoration(
          hintText: 'E-mail'
      ),
      keyboardType: TextInputType.emailAddress,
      formControlName: 'email',
      validationMessages: (control)=> {
        ValidationMessage.required: 'Este campo es requerido',
        ValidationMessage.maxLength: 'Este campo debe tener como max 20',
        ValidationMessage.minLength: 'Este campo debe tener como min 5'
      },
    );
  }

  Widget _buildPassword() {
    return ReactiveTextField(
      decoration: InputDecoration(
          hintText: 'Password'
      ),
      formControlName: 'password',
      validationMessages: (control)=> {
        ValidationMessage.required:'Este campo es requerido',
        ValidationMessage.pattern: 'La contraseña debe contener 3Aa·*-',
        ValidationMessage.maxLength: 'Este campo debe tener como max 25',
        ValidationMessage.minLength: 'Este campo debe tener como min 8'
      },
    );
  }

  Widget _buildConfirmarPassword() {
    return ReactiveTextField(
      decoration: InputDecoration(
          hintText: 'Confirmar password'
      ),
      formControlName: 'passwordConfirmation',
      validationMessages: (control)=> {
        ValidationMessage.mustMatch: 'El password es diferente'
      },
    );
  }


}


class ButtonRegistroWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(onPressed: ()=>_onPressed(context), child: Text("Registrar usuario"));
  }

  void _onPressed(BuildContext context) {
    registroUsuarioController.registerForm.markAllAsTouched();
    FocusScope.of(context).unfocus();
    if (registroUsuarioController.registerForm.invalid) return;

    final usuario = UsuarioModel(
      dni: registroUsuarioController.getDni,
      email: registroUsuarioController.getEmail,
      password: registroUsuarioController.getPassword,
      username: registroUsuarioController.getUser,
      firstName: registroUsuarioController.getNombres,
      lastName: registroUsuarioController.getApellidos
    );
    Provider.of<LoginProvider>(context, listen: false).registroUsuario(usuario: usuario);
  }
}
