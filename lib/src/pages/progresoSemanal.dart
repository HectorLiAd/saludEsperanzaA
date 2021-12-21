import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:salud_esperanza/src/models/promogresoModel.dart';
import 'package:salud_esperanza/src/provider/participanteProvider.dart';


class ProgresoSemanalScreen extends StatelessWidget {
  static final String routeName = "ProgresoSemanalScreen";
  const ProgresoSemanalScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final listaActividadSemanal = Provider.of<ParticipanteProvider>(context).listaProgresoSemanal;
    if (listaActividadSemanal!=null) {
      return Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              Expanded(child: _buildListadoTarjetas(listaActividadSemanal))
            ],
          )
        ),
      );
    } else {
      return Scaffold(body: Center(child: CircularProgressIndicator()));
    }
  }

  Widget _buildListadoTarjetas(List<ProgresoSemanalModel> listado) {
    return ListView.separated(
      separatorBuilder: (context, index) {
        return Divider();
      },
      itemCount: listado.length,
      itemBuilder: (context, index) {
        final actividadTarjeta = listado[index];
        return Container(
          padding: EdgeInsets.all(25),
          
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(width: double.infinity),
              Text(
                'Tarjeta de cambio: ${actividadTarjeta.tarjetaUsuario!.titulo}',
                textAlign: TextAlign.center,
              ),
              Text('Fecha de inicio: ${actividadTarjeta.tarjetaUsuario!.fechaInicio}', textAlign: TextAlign.start),
              Text('Fecha de finalización: ${actividadTarjeta.tarjetaUsuario!.fechaFin}', textAlign: TextAlign.start),
              Text('Cambio por ${actividadTarjeta.cantidadDias} días', textAlign: TextAlign.start),
              if(actividadTarjeta.actividadHoy==null) Text('Dia ${actividadTarjeta.numDiaHoy}', textAlign: TextAlign.start),
              if(actividadTarjeta.actividadHoy!=null)Text(
                  'Dia ${actividadTarjeta.numDiaHoy}, ${actividadTarjeta.actividadHoy!.porcentajeAvanzado}',
                  textAlign: TextAlign.start
              ),
              Expanded(child: _buildListadoActividadSemanal(actividadTarjeta.actividadesDiarias!)),
            ],
          ),
          height: 350,
        );
      },
    );
  }


  Widget _buildListadoActividadSemanal(List<Actividad> actividades) {
    return Container(
      color: Colors.grey.withOpacity(0.6),
      child: ListView.builder(
        itemCount: actividades.length,
        itemBuilder: (context, index) {
          final actividad = actividades[index];
          return ListTile(
            title: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('${actividad.actividadFecha}'),
                Text('${actividad.porcentajeAvanzado}'),
              ],
            ),
          );
        },
      ),
    );
  }

}
