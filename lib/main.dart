import 'package:uniresp/cadastro.dart';
import 'package:uniresp/inicio.dart';
import 'package:uniresp/feedback.dart';
import 'package:flutter/material.dart';
import 'package:uniresp/splashpage.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashPage(),
      routes: <String, WidgetBuilder>{
        '/inicio': (BuildContext context) => PrimeiraRota(),
        '/register': (BuildContext context) => Cad(),
        '/feedback': (BuildContext context) => FeedBack(),
      }
    );
  }
}
