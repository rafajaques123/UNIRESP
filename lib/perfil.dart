import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:io';

// ignore: must_be_immutable
class Perfil extends StatefulWidget {
  Perfil({Key key, this.title, this.uid}) : super(key: key);
  final String title;
  final String uid;
  var email;
  @override
  _PerfilState createState() => _PerfilState();
}

class _PerfilState extends State<Perfil> {
  FirebaseUser currentUser;
  initState() {
    this.getCurrentUser();
    super.initState();
  }

  void getCurrentUser() async {
    currentUser = await FirebaseAuth.instance.currentUser();
  }

  File _image;
  final FirebaseStorage _storage =
      FirebaseStorage(storageBucket: 'gs://uniresp-338ed.appspot.com');

  StorageUploadTask _uploadTask;
  @override
  Widget build(BuildContext context) {
    Future<void> _pickImage(ImageSource source) async {
      File selected = await ImagePicker.pickImage(source: source);

      setState(() {
        _image = selected;
      });
    }

    Future uploadPic(BuildContext context) async {
      String fileName = 'perfil_images/${widget.uid}.png';
      _uploadTask = _storage.ref().child(fileName).putFile(_image);
      // ignore: unused_local_variable
      StorageTaskSnapshot taskSnapshot = await _uploadTask.onComplete;
      setState(() {
        print("Profile Picture uploaded");
        Scaffold.of(context)
            .showSnackBar(SnackBar(content: Text('Foto de Perfil Atualizada')));
      });
    }

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            }),
        title: Text('Perfil'),
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
      body: Column(
        children: <Widget>[
          Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                    Color(0xFF00CED1),
                    Color(0xFF4682B4),
                  ])),
              child: Container(
                width: double.infinity,
                height: 350.0,
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      CircleAvatar(
                        radius: 60,
                        backgroundColor: Color(00000),
                        child: ClipOval(
                          child: new SizedBox(
                            width: 180.0,
                            height: 180.0,
                            child: (_image != null)
                                ? Image.file(
                                    _image,
                                    fit: BoxFit.fill,
                                  )
                                : Image.network(
                                    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcThv-Y1z6rZ8R1wbJY4L7p0dzdhuIoN6U9mzA&usqp=CAU",
                                    fit: BoxFit.fill,
                                  ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 0, left: 0),
                        child: IconButton(
                            icon: Icon(
                              (Icons.photo_camera),
                            ),
                            onPressed: () => _pickImage(ImageSource.gallery)),
                      ),
                      Align(
                        alignment: Alignment.center,
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
                                userDocument["nome"],
                                style: TextStyle(
                                  fontSize: 25.0,
                                  fontStyle: FontStyle.italic,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              );
                            }),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Card(
                        margin: EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 5.0),
                        clipBehavior: Clip.antiAlias,
                        color: Colors.white,
                        elevation: 5.0,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8.0, vertical: 22.0),
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                child: Column(
                                  children: <Widget>[
                                    Text(
                                      "Empresa",
                                      style: TextStyle(
                                        color: Colors.blue[900],
                                        fontSize: 22.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5.0,
                                    ),
                                    Align(
                                      alignment: Alignment.center,
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
                                              userDocument["empresa"],
                                              style: TextStyle(
                                                fontSize: 20.0,
                                                color: Colors.blue[900],
                                              ),
                                            );
                                          }),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  children: <Widget>[
                                    Text(
                                      "Ramo",
                                      style: TextStyle(
                                        color: Colors.blue[900],
                                        fontSize: 22.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5.0,
                                    ),
                                    Align(
                                      alignment: Alignment.center,
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
                                              userDocument["ramo de atividade"],
                                              style: TextStyle(
                                                fontSize: 20.0,
                                                color: Colors.blue[900],
                                              ),
                                            );
                                          }),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              )),
          Container(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 30.0, horizontal: 16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Informações adicionais:",
                    style: TextStyle(
                        color: Colors.blue[900],
                        fontStyle: FontStyle.normal,
                        fontSize: 28.0),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
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
                            userDocument["email"],
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold),
                          );
                        }),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
          RaisedButton(
            color: Color(0xff476cfb),
            onPressed: () {
              uploadPic(context);
            },
            elevation: 4.0,
            splashColor: Color(0xFF00CED1),
            child: Text(
              'Salvar',
              style: TextStyle(color: Colors.white, fontSize: 16.0),
            ),
          ),
        ],
      ),
    );
  }
}
