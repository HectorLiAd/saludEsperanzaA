import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';
import 'package:salud_esperanza/src/models/tarjetaModificacionModel.dart';
import 'package:salud_esperanza/src/models/usuarioApp.dart';
import 'package:salud_esperanza/src/pages/cactividadesCompletarHoy.dart';
import 'package:salud_esperanza/src/pages/login/loginPage.dart';
import 'package:salud_esperanza/src/pages/pages.dart';
import 'package:salud_esperanza/src/provider/loginProvider.dart';
import 'package:salud_esperanza/src/provider/participanteProvider.dart';

class HomeParticipantePage extends StatelessWidget {
  static final String routeName = "HomeParticipantePage";
  const HomeParticipantePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Provider.of<ParticipanteProvider>(context, listen: false).misTarjetasDeModificaion();
    final currentUser = Provider.of<LoginProvider>(context, listen: true).currentUserApp;

    if (currentUser!=null && currentUser.rol == UsuarioModel.participante) {
      return Scaffold(
        body: SafeArea(
          child: Container(
            padding: EdgeInsets.all(25),
            width: double.infinity,
            height: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(width: double.infinity),
                Text("Bienvenido ${currentUser.username}"),
                Expanded(child: cargarTarjetas(context)),
                ElevatedButton(
                  onPressed: (){
                    Provider.of<ParticipanteProvider>(context, listen: false).miProgresoSemanal();
                    Navigator.pushNamed(context, ProgresoSemanalScreen.routeName);
                  },
                  child: Text('Actividad de hoy y semanal'),
                ),
                _buildCerrarSesion(context),
              ],
            ),
          ),
        )
      );
    } else {
      return Scaffold (
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Center(child: Text("Usuario no tiene rol participante")),
              _buildCerrarSesion(context)
            ],
          ),
        ),
      );
    }
  }

  ElevatedButton _buildCerrarSesion(BuildContext context) {
    return ElevatedButton(
      onPressed: (){
        final storage = new FlutterSecureStorage();
        storage.deleteAll();
        Navigator.pushNamedAndRemoveUntil(
          context,
          LoginPage.routeName,
          (Route<dynamic> route) => false
        );
      },
      child: Text('Cerrar sesión')
    );
  }


  Widget cargarTarjetas(BuildContext context) {
    return FutureBuilder(
      builder: (context, projectSnap) {
        print(projectSnap.hasData);
        if (projectSnap.hasData) {
          return _buildTrjetasParticipanteListView(projectSnap.data as List<TarjetaModificacionModel>);
        }
        return Container();
      },
      future: Provider.of<ParticipanteProvider>(context, listen: false).misTarjetasDeModificaion(),
    );
  }

  Widget _buildTrjetasParticipanteListView(List<TarjetaModificacionModel> tarjetasModif) {
    return ListView.builder(
      itemCount: tarjetasModif.length,
      itemBuilder: (context, int index) {
        return ElevatedButton(
          onPressed: (){
            Provider.of<ParticipanteProvider>(context, listen: false).misActividadesDeHoy(tarjetasModif[index].id!);
            Navigator.pushNamed(context, ActividadesCompletarHoy.routeName, arguments: tarjetasModif[index]);
          },
          child: Text('${tarjetasModif[index].titulo}')
        );
      }
    );
  }

}
