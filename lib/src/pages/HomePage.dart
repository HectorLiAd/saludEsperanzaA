import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:salud_esperanza/src/models/tarjetaModificacionModel.dart';
import 'package:salud_esperanza/src/pages/cactividadesCompletarHoy.dart';
import 'package:salud_esperanza/src/provider/loginProvider.dart';
import 'package:salud_esperanza/src/provider/participanteProvider.dart';

class HomeParticipantePage extends StatelessWidget {
  static final String routeName = "HomeParticipantePage";
  const HomeParticipantePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Provider.of<ParticipanteProvider>(context, listen: false).misTarjetasDeModificaion();
    final currentUser = Provider.of<LoginProvider>(context).currentUserApp;
    if (currentUser!=null) {
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
              ],
            ),
          ),
        )
      );
    } else {
      return Scaffold(
        body: Center(child: Text("Home participatns"),),
      );
    }

  }


  Widget cargarTarjetas(BuildContext context) {
    return FutureBuilder(
      builder: (context, projectSnap) {
        print(projectSnap.hasData);
        if (projectSnap.hasData) {
          final tarjetas = projectSnap.data as List<TarjetaModificacionModel>;
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
            onPressed: ()=>Navigator.pushNamed(context, ActividadesCompletarHoy.routeName, arguments:tarjetasModif[index] ),
            child: Text('${tarjetasModif[index].titulo}')
        );
      }
    );
  }
}
