import 'package:flutter/material.dart';
import 'package:salud_esperanza/src/pages/pages.dart';

class AppRouter{
  Route onGenerateRoute(RouteSettings routeSettings){
    if (LoginPage.routeName == routeSettings.name) {
      return MaterialPageRoute(builder: (BuildContext context)=> LoginPage());
    }
    else if (RegistrarPage.routeName == routeSettings.name) {
      return MaterialPageRoute(builder: (BuildContext context)=> RegistrarPage());
    }
    return MaterialPageRoute(builder: (BuildContext context) => Container(child: Center(child: Text('Pagina no encontrada'))));
  }

}