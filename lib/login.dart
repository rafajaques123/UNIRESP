import 'package:firebase_auth/firebase_auth.dart';
import 'package:uniresp/cadastro.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:uniresp/splashpage.dart';



class Login extends StatefulWidget {
  Login ({Key key}) : super(key: key);
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {

final FirebaseAuth auth = FirebaseAuth.instance;
  String errorMessage = '';
  String successMessage = '';
  final GlobalKey<FormState> _formStateKey = GlobalKey<FormState>();
  String _emailId;
  String _password;
  final _emailIdController = TextEditingController(text: '');
  final _passwordController = TextEditingController(text: '');


  @override
      Widget build(BuildContext context) {
    return Scaffold(

      body: Container(
        padding: EdgeInsets.only(top: 0, left: 40, right: 40),
        child: ListView(
          children: <Widget>[
SizedBox(
              width: 180,
              height: 180,
              child: Image.asset("assets/logo.png"),
            ),

            SizedBox(
              height: 2,
            ),

 Form(
                    key: _formStateKey,
                    autovalidate: true,
                    child: Column(
                      children: <Widget>[
            TextFormField(
              // autofocus: true,
              validator: validateEmail,
                            onSaved: (value) {
                              _emailId = value;
                            },
                            keyboardType: TextInputType.emailAddress,
                            controller: _emailIdController,
              decoration: InputDecoration(
                labelText: "E-mail",
                labelStyle: TextStyle(
                  color: Colors.black38,
                  fontWeight: FontWeight.w400,
                  fontSize: 16,
                ),
              ),
              style: TextStyle(fontSize: 20),
            ),


            SizedBox(
              height: 2,
            ),


            TextFormField(
              // autofocus: true,
              validator: validatePassword,
                            onSaved: (value) {
                              _password = value;
                            },
                            controller: _passwordController,
              keyboardType: TextInputType.text,
              obscureText: true,
              decoration: InputDecoration(
                labelText: "Senha",
                labelStyle: TextStyle(
                  color: Colors.black38,
                  fontWeight: FontWeight.w400,
                  fontSize: 16,
                ),
              ),
              style: TextStyle(fontSize: 20),
            ),

            SizedBox(
              height: 15,
            ),
],
                    ),
 ),
 (errorMessage != ''
                      ? Text(
                          errorMessage,
                          style: TextStyle(color: Colors.red, fontSize: 15),
                        )
                      : Container(
              alignment: Alignment.center)),

           SizedBox(
              height: 30,
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
          child: Text('Entrar',
        style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),),
          onPressed: () {
                            if (_formStateKey.currentState.validate()) {
                              _formStateKey.currentState.save();
                              signIn(_emailId, _password).then((user) {
                                if (user != null) {
                                  print('Logged in successfully.');
Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SplashPage()),
            );
                                } else {
                                  print('Error while Login.');
                                }
                              });
                            }
                          },
        ),
        ),


SizedBox(
              height: 10,
            ),


Text('Não possui uma conta ?',
 textAlign: TextAlign.center,
                ),
Container( //Inicio conteiner com texto
              height: 20,
              alignment: Alignment.center,
              child: FlatButton(
          child: Text('Cadastrar',
        style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                      ),),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Cad()),
            );
          },
            ),
        ),
          ]
      )
      )
    );
  }
  Future<FirebaseUser> signIn(String email, String password) async {
    try {
      FirebaseUser user = (await FirebaseAuth.instance.
signInWithEmailAndPassword(email: email, password: password))
.user;

      assert(user != null);
      assert(await user.getIdToken() != null);

      final FirebaseUser currentUser = await auth.currentUser();
      assert(user.uid == currentUser.uid);
      return user;
    } catch (e) {
      handleError(e);
      return null;
    }
  }

  handleError(PlatformException error) {
    print(error);
    switch (error.code) {
      case 'ERROR_USER_NOT_FOUND':
        setState(() {
          errorMessage = 'Usuario não encontrado !';
        });
        break;
      case 'ERROR_WRONG_PASSWORD':
        setState(() {
          errorMessage = 'Senha Incorreta !';
        });
        break;
    }
  }
  

  String validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (value.isEmpty || !regex.hasMatch(value))
      return 'Insira um email válido!';
    else
      return null;
  }

  String validatePassword(String value) {
    if (value.trim().isEmpty) {
      return 'A senha não pode ser vazia!';
    }
    return null;
  }
}
