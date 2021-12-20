import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:salud_esperanza/src/models/actividadUsuarioHoy.dart';
import 'package:salud_esperanza/src/models/tarjetaModificacionModel.dart';
import 'package:salud_esperanza/src/provider/participanteProvider.dart';

class ActividadesCompletarHoy extends StatelessWidget {
  static final String routeName = "ActividadesCompletarHoy";

  final TarjetaModificacionModel tarjetamodifiacion;
  const ActividadesCompletarHoy({Key? key, required this.tarjetamodifiacion}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(child: cargarActividades(context))
        ],
      ),
    );
  }

  Widget cargarActividades(BuildContext context) {
    return FutureBuilder(
      builder: (context, projectSnap) {
        print(projectSnap.hasData);
        if (projectSnap.hasData) {
          return _buildActividadesListView(projectSnap.data as List<ActividadHoyModel>);
        }
        return Container();
      },
      future: Provider.of<ParticipanteProvider>(context, listen: false).misActividadesDeHoy(tarjetamodifiacion.id!)
    );
  }

  Widget _buildActividadesListView(List<ActividadHoyModel> actividades) {
    return ListView.builder(
        itemCount: actividades.length,
        itemBuilder: (context, int index) {
          return ListTile(
            trailing: GestureDetector(
              child: Icon(Icons.add),
              onTap: ()=> {
                Provider.of<ParticipanteProvider>(context, listen: false).completarActividadHoy(actividades[index].id!)
              },
            ),
            title: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('${actividades[index].actividad!.titulo}'),
                Text('Estado: ${actividades[index].estadoActividad}'),
              ],
            ),
          );
        }
    );
  }
}
