import 'package:flutter/material.dart';

class AskPage extends StatelessWidget {
  final titulo;
  final descricao;
  final ramo;
  final nome;
  final email;
  AskPage(
      {@required this.titulo,
      this.descricao,
      this.ramo,
      this.nome,
      this.email});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(titulo),
          flexibleSpace: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: <Color>[
                  Color(0xFF00CED1),
                  Color(0xFF4682B4),
                ])),
          ),
        ),
        body: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Descrição',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(descricao),
                Text(
                  'Ramo',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(ramo),
                Text(
                  'Nome',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(nome),
                Text(
                  'Email',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(email)
              ]),
        ));
  }
}
