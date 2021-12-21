import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:salud_esperanza/src/models/tarjetaModificacionModel.dart';
import 'package:salud_esperanza/src/pages/pages.dart';

class AppRouter{


  Route onGenerateRoute(RouteSettings routeSettings){

    if (LoginPage.routeName == routeSettings.name) {
      return MaterialPageRoute(builder: (BuildContext context)=> LoginPage());
    }
    else if (RegistrarPage.routeName == routeSettings.name) {
      return MaterialPageRoute(builder: (BuildContext context)=> RegistrarPage());
    }

    else if (HomeParticipantePage.routeName == routeSettings.name) {
      return MaterialPageRoute(builder: (BuildContext context)=> HomeParticipantePage());
    }

    else if (ActividadesCompletarHoy.routeName == routeSettings.name) {
      final tajrtaModif = routeSettings.arguments as TarjetaModificacionModel;
      return MaterialPageRoute(builder: (BuildContext context)=> ActividadesCompletarHoy( tarjetamodifiacion: tajrtaModif,));
    }

    else if (ProgresoSemanalScreen.routeName == routeSettings.name) {
      return MaterialPageRoute(builder: (BuildContext context)=> ProgresoSemanalScreen());
    }


    return MaterialPageRoute(builder: (BuildContext context) => Container(child: Center(child: Text('Pagina no encontrada'))));
  }

}