import 'package:app_sqlite/home.dart';
import 'package:app_sqlite/tela_cadastro_contato.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      initialRoute: "/",
      routes: {
        "/": (context) => HomePage(),
        "/cadastro": (context) => CadastroContatoWidget(),
      },


    );
  }
}
