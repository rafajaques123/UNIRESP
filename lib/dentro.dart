import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uniresp/perfil.dart';
import 'cards.dart';

class Dentro extends StatefulWidget {
  Dentro({Key key, this.title, this.uid}) : super(key: key);
  final String title;
  final String uid;
  @override
  _DentroState createState() => _DentroState();
}

class _DentroState extends State<Dentro> {
  TextEditingController taskTitleInputController;
  TextEditingController taskDescripInputController;
  TextEditingController taskRamoInputController;
  TextEditingController taskNomeInputController;
  TextEditingController taskEmailInputController;
  TextEditingController taskArquivoInputController;
  FirebaseUser currentUser;
  initState() {
    taskTitleInputController = new TextEditingController();
    taskDescripInputController = new TextEditingController();
    taskRamoInputController = new TextEditingController();
    taskNomeInputController = new TextEditingController();
    taskEmailInputController = new TextEditingController();
    taskArquivoInputController = new TextEditingController();

    this.getCurrentUser();
    super.initState();
  }

  void getCurrentUser() async {
    currentUser = await FirebaseAuth.instance.currentUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('UniResp'),
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
      drawer: Drawer(
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the drawer if there isn't enough vertical
        // space to fit everything.
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: StreamBuilder(
                  stream: Firestore.instance
                      .collection('usuarios')
                      .document(widget.uid)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return new Text("Loading");
                    }
                    var userDocument = snapshot.data;
                    return new Text(
                      'Bem Vindo, ' + userDocument["nome"] + ' !',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    );
                  }),
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
              ),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Home'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.person_outline),
              title: Text('Perfil'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Perfil(
                            uid: currentUser.uid,
                          )),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.border_color),
              title: Text('Feedback'),
              onTap: () {
                Navigator.pushNamed(context, "/feedback");
              },
            ),
            ListTile(
              leading: Icon(Icons.exit_to_app),
              title: Text('Sair'),
              onTap: () {
                FirebaseAuth.instance
                    .signOut()
                    .then((result) =>
                        Navigator.pushReplacementNamed(context, "/inicio"))
                    .catchError((err) => print(err));
              },
            ),
          ],
        ),
      ),
      body: Center(
        child: Container(
            padding: const EdgeInsets.all(20.0),
            child: StreamBuilder<QuerySnapshot>(
              stream: Firestore.instance
                  .collection("usuarios")
                  .document(widget.uid)
                  .collection('perguntas')
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError)
                  return new Text('Error: ${snapshot.error}');
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                    return new Text('Loading...');
                  default:
                    return new ListView(
                      children: snapshot.data.documents
                          .map((DocumentSnapshot document) {
                        return new CustomCard(
                          titulo: document['titulo'],
                          descricao: document['descricao'],
                          ramo: document['ramo'],
                          nome: document['nome'],
                          email: document['email'],
                        );
                      }).toList(),
                    );
                }
              },
            )),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xFF00CED1),
        onPressed: _showDialog,
        tooltip: 'Add',
        child: Icon(Icons.add),
      ),
    );
  }

  _showDialog() async {
    await showDialog<String>(
      context: context,
      child: AlertDialog(
        contentPadding: const EdgeInsets.all(16.0),
        content: Column(
          children: <Widget>[
            Text(
                "Por favor preencha todos os campos para cadastrar uma nova pergunta"),
            Expanded(
              child: TextField(
                autofocus: true,
                decoration: InputDecoration(labelText: 'Título*'),
                controller: taskTitleInputController,
              ),
            ),
            Expanded(
              child: TextField(
                autofocus: true,
                decoration: InputDecoration(labelText: 'Ramo*'),
                controller: taskRamoInputController,
              ),
            ),
            Expanded(
              child: TextField(
                autofocus: true,
                decoration: InputDecoration(labelText: 'Descrição*'),
                controller: taskDescripInputController,
              ),
            ),
            Expanded(
              child: TextField(
                autofocus: true,
                decoration: InputDecoration(labelText: 'Nome*'),
                controller: taskNomeInputController,
              ),
            ),
            Expanded(
              child: TextField(
                autofocus: true,
                decoration: InputDecoration(labelText: 'Email*'),
                controller: taskEmailInputController,
              ),
            ),
          ],
        ),
        actions: <Widget>[
          FlatButton(
              child: Text('Cancelar'),
              onPressed: () {
                taskTitleInputController.clear();
                taskDescripInputController.clear();
                taskRamoInputController.clear();
                taskNomeInputController.clear();
                taskEmailInputController.clear();
                Navigator.pop(context);
              }),
          FlatButton(
              child: Text('Enviar'),
              onPressed: () {
                if (taskDescripInputController.text.isNotEmpty &&
                    taskTitleInputController.text.isNotEmpty &&
                    taskRamoInputController.text.isNotEmpty) {
                  Firestore.instance
                      .collection("usuarios")
                      .document(widget.uid)
                      .collection('perguntas')
                      .add({
                        "titulo": taskTitleInputController.text,
                        "descricao": taskDescripInputController.text,
                        "ramo": taskRamoInputController.text,
                        "nome": taskNomeInputController.text,
                        "email": taskEmailInputController.text,
                      })
                      .then((result) => {})
                      .catchError((err) => print(err));
                }
                if (taskDescripInputController.text.isNotEmpty &&
                    taskTitleInputController.text.isNotEmpty &&
                    taskRamoInputController.text.isNotEmpty) {
                  Firestore.instance
                      .collection("solicitacoes")
                      .add({
                        "titulo": taskTitleInputController.text,
                        "descricao": taskDescripInputController.text,
                        "ramo": taskRamoInputController.text,
                        "nome": taskNomeInputController.text,
                        "email": taskEmailInputController.text,
                      })
                      .then((result) => {
                            Navigator.pop(context),
                            taskTitleInputController.clear(),
                            taskDescripInputController.clear(),
                            taskRamoInputController.clear(),
                            taskNomeInputController.clear(),
                            taskEmailInputController.clear(),
                          })
                      .catchError((err) => print(err));
                }
              })
        ],
      ),
    );
  }
}
