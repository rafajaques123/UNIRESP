import 'package:uniresp/login.dart';
import 'package:uniresp/cadastro.dart';
import 'package:flutter/material.dart';


class PrimeiraRota extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: new Container(
        padding: EdgeInsets.only(top: 20, left: 30, right: 30),
        child: ListView(
        children: <Widget>[

///LOGO///
SizedBox(
              width: 180,
              height: 180,
              child: Image.asset("assets/logo.png"),
            ),
///LOGO///

///BOTÃO LOGIN///
SizedBox(
              height: 110,
            ),
            SizedBox(
              height: 10,
            ),
            
        Container(
        height: 50,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  stops: [0.3, 1],
                  colors: [
                    Color(0xFF00CED1),
                    Color(0xFF4682B4),
                  ],
                ),
                borderRadius: BorderRadius.all(
                  Radius.circular(30),
                ),
              ),
        child: FlatButton(
          child: Text('Login',
        style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Login()),
            );
          },
        ),
        ),
///BOTÃO LOGIN///

Container( //Inicio conteiner com texto
padding: EdgeInsets.only(top: 5, bottom: 5),
              height: 30,
              alignment: Alignment.center,
                child: Text(
                  "Não possui uma conta ?",
                  textAlign: TextAlign.center,
                ),
            ),

        Container( //inicio botão cadastrar
              height: 50,
              alignment: Alignment.center,
               decoration: BoxDecoration(
                color: Color(0xFFD3D3D3),
                borderRadius: BorderRadius.all(
                  Radius.circular(30),
                ),
              ),
              
                 child: FlatButton(
                    padding: EdgeInsets.only(left: 94, right: 94), //centraliza o texto
                    child: Text(
                      "Cadastrar",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Cad()),
            );
          },
                  ),
              ),
            ///fim botão cadastrar///



        ],
      ),
      )
    );
  }
}




