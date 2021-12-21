import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:provider/provider.dart';
import 'package:salud_esperanza/src/pages/homePage.dart';
import 'package:salud_esperanza/src/pages/login/loginPage.dart';
import 'package:salud_esperanza/src/provider/loginProvider.dart';
import 'package:salud_esperanza/src/provider/participanteProvider.dart';
import 'package:salud_esperanza/src/routes/routes.dart';
import 'package:salud_esperanza/src/utils/colors.dart';


class AppSaludEsperanza extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LoginProvider()),
        ChangeNotifierProvider(create: (_) => ParticipanteProvider()),
      ],
      child: MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  final AppRouter _appRouter= AppRouter();
  MyApp({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _buildMaterialApp();
  }
  Widget _buildMaterialApp() {
    return MaterialApp(
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [Locale('es', 'ES')],
      debugShowCheckedModeBanner: false,
      title: 'Salud y Esperanza V2',
      initialRoute: LoginPage.routeName, //Ruta base ************************************
      navigatorObservers: [FlutterSmartDialog.observer],
      builder: FlutterSmartDialog.init(),
      onGenerateRoute: _appRouter.onGenerateRoute,
      theme: ThemeData.light().copyWith(
          primaryColor: ColorsApp.colorBase
      ),
    );
  }

}