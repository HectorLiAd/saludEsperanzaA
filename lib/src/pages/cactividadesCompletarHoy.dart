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
    final listaActividades = Provider.of<ParticipanteProvider>(context, listen: true).listaActividades;
    if (listaActividades!=null ) {
      return _buildActividadesListView(listaActividades);
    } else {
      return Center(child: CircularProgressIndicator());
    }
  }

  Widget _buildActividadesListView(List<ActividadHoyModel> actividades) {
    return ListView.builder(
      itemCount: actividades.length,
      itemBuilder: (context, int index) {
        final actividad = actividades[index];
        return ListTile(
          trailing: (actividad.estadoActividad==Actividad.BLANCO)?
          GestureDetector(
            child: Icon(Icons.close, color: Colors.red,),
            onTap: () => Provider.of<ParticipanteProvider>(context, listen: false).completarActividadHoy(actividad.id!, Actividad.COMPLETADO),
          ):
          GestureDetector(
            child: Icon(Icons.task_alt_outlined, color: Colors.green,),
            onTap: () => Provider.of<ParticipanteProvider>(context, listen: false).completarActividadHoy(actividad.id!, Actividad.BLANCO),
          ),
          title: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('${actividad.actividad!.titulo}'),
              Text('${actividad.actividad!.horaEjecucion}-${actividad.actividad!.horaFinalizacion}'),
              Text('Estado: ${actividad.estadoActividad}'),
            ],
          ),
        );
      }
    );
  }
}
