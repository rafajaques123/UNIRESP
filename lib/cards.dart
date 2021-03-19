import 'package:flutter/material.dart';
import 'pergunta.dart';

class CustomCard extends StatelessWidget {
  CustomCard(
      {@required this.titulo,
      this.descricao,
      this.ramo,
      this.nome,
      this.email});

  final titulo;
  final descricao;
  final ramo;
  final nome;
  final email;
  @override
  Widget build(BuildContext context) {
    return Card(
        child: Container(
            padding: const EdgeInsets.only(top: 5.0),
            child: Column(
              children: <Widget>[
                Text(titulo),
                FlatButton(
                    child: Text("Mostrar mais"),
                    onPressed: () {
                      /** Push a named route to the stcak, which does not require data to be  passed */
                      // Navigator.pushNamed(context, "/task");

                      /** Create a new page and push it to stack each time the button is pressed */
                      // Navigator.push(context, MaterialPageRoute<void>(
                      //   builder: (BuildContext context) {
                      //     return Scaffold(
                      //       appBar: AppBar(title: Text('My Page')),
                      //       body: Center(
                      //         child: FlatButton(
                      //           child: Text('POP'),
                      //           onPressed: () {
                      //             Navigator.pop(context);
                      //           },
                      //         ),
                      //       ),
                      //     );
                      //   },
                      // ));

                      /** Push a new page while passing data to it */
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AskPage(
                                    titulo: titulo,
                                    descricao: descricao,
                                    ramo: ramo,
                                    nome: nome,
                                    email: email,
                                  )));
                    }),
              ],
            )));
  }
}
