import 'package:flutter/material.dart';

import 'package:proyecto_cine/Sharepreference/Sharepreference.dart';
import 'package:proyecto_cine/screens/LoginPage.dart';
import 'package:proyecto_cine/screens/map_screen.dart';



void main() async {
  
  final prefs = PrefernciaUsuario();
  await prefs.initPrefs();
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true, brightness: Brightness.dark),
      initialRoute: LoginPage.nombre,
      routes: {
        LoginPage.nombre:(context) => LoginPage(),
        MapScreen.nombre:(context) =>   MapScreen(), 
      },
    );
  }
}