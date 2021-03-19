import 'package:uniresp/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';

class Cad extends StatefulWidget {
  Cad({Key key, this.title, this.uid}) : super(key: key);
  final String title;
  final String uid;
  @override
  _CadState createState() => _CadState();
}

class _CadState extends State<Cad> {
  FirebaseUser currentUser;
  initState() {
    this.getCurrentUser();
    super.initState();
  }

  void getCurrentUser() async {
    currentUser = await FirebaseAuth.instance.currentUser();
  }

  final FirebaseAuth auth = FirebaseAuth.instance;
  final db = Firestore.instance;
  String errorMessage = '';
  String successMessage = 'Cadastro realizado!';
  final GlobalKey<FormState> _formStateKey = GlobalKey<FormState>();
  String _emailId;
  String _password;
  String _nome;
  String _emp;
  String _atv;
  final _nomeController = TextEditingController(text: '');
  final _empController = TextEditingController(text: '');
  final _atvController = TextEditingController(text: '');
  final _emailIdController = TextEditingController(text: '');
  final _passwordController = TextEditingController(text: '');
  final _confirmPasswordController = TextEditingController(text: '');
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
      String fileName = 'perfil_images/$_emailId.png';
      _uploadTask = _storage.ref().child(fileName).putFile(_image);
      // ignore: unused_local_variable
      StorageTaskSnapshot taskSnapshot = await _uploadTask.onComplete;
    }

    return Scaffold(
        body: Container(
            padding: EdgeInsets.only(top: 0, left: 30, right: 30),
            child: ListView(children: <Widget>[
              Form(
                key: _formStateKey,
                autovalidate: true,
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Align(
                          alignment: Alignment.center,
                          child: CircleAvatar(
                            radius: 80,
                            backgroundColor: Color(0xff476cfb),
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
                                        "https://upload.wikimedia.org/wikipedia/commons/thumb/7/7e/Circle-icons-profile.svg/1200px-Circle-icons-profile.svg.png",
                                        fit: BoxFit.fill,
                                      ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 30.0),
                          child: IconButton(
                              icon: Icon(
                                (Icons.photo_camera),
                              ),
                              onPressed: () => _pickImage(ImageSource.gallery)),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 2,
                    ),
                    TextFormField(
                      validator: validatename,
                      onSaved: (value) {
                        _nome = value;
                      },
                      keyboardType: TextInputType.text,
                      controller: _nomeController,
                      decoration: InputDecoration(
                        labelText: "Nome Completo",
                        labelStyle: TextStyle(
                          color: Colors.black38,
                          fontWeight: FontWeight.w400,
                          fontSize: 16,
                        ),
                      ),
                      style: TextStyle(fontSize: 20),
                    ),
                    TextFormField(
                      validator: validateemp,
                      onSaved: (value) {
                        _emp = value;
                      },
                      keyboardType: TextInputType.text,
                      controller: _empController,
                      decoration: InputDecoration(
                        labelText: "Empresa",
                        labelStyle: TextStyle(
                          color: Colors.black38,
                          fontWeight: FontWeight.w400,
                          fontSize: 16,
                        ),
                      ),
                      style: TextStyle(fontSize: 20),
                    ),
                    TextFormField(
                      validator: validateatv,
                      onSaved: (value) {
                        _atv = value;
                      },
                      keyboardType: TextInputType.text,
                      controller: _atvController,
                      decoration: InputDecoration(
                        labelText: "Ramo de Atividade",
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
                      height: 2,
                    ),
                    TextFormField(
                      // autofocus: true,
                      validator: validateConfirmPassword,
                      controller: _confirmPasswordController,
                      keyboardType: TextInputType.text,
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: "Confirmar Senha",
                        labelStyle: TextStyle(
                          color: Colors.black38,
                          fontWeight: FontWeight.w400,
                          fontSize: 16,
                        ),
                      ),
                      style: TextStyle(fontSize: 20),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 15,
              ),
              (errorMessage != ''
                  ? Text(
                      errorMessage,
                      style: TextStyle(color: Colors.red, fontSize: 15),
                    )
                  : Container(alignment: Alignment.center)),
              SizedBox(
                height: 25,
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
                  child: Text(
                    'Cadastrar',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                  onPressed: () {
                    if (_formStateKey.currentState.validate()) {
                      _formStateKey.currentState.save();
                      signUp(_emailId, _password).then((user) {
                        if (user != null) {
                          uploadPic(context);
                          print('Registered Successfully.');
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Login()),
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
              Text(
                'Já possui uma conta ?',
                textAlign: TextAlign.center,
              ),
              Container(
                //Inicio conteiner com texto
                height: 20,
                alignment: Alignment.center,
                child: FlatButton(
                  child: Text(
                    'Login',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Login()),
                    );
                  },
                ),
              ),
              SizedBox(
                height: 5,
              ),
            ])));
  }

  Future<FirebaseUser> signUp(email, password) async {
    try {
      FirebaseUser user = (await FirebaseAuth.instance
              .createUserWithEmailAndPassword(email: email, password: password))
          .user;
      db.collection("usuarios").document(user.uid).setData({
        "nome": _nome,
        "empresa": _emp,
        "ramo de atividade": _atv,
        "email": _emailId,
      });
      assert(user != null);
      assert(await user.getIdToken() != null);
      return user;
    } catch (e) {
      handleError(e);
      return null;
    }
  }

  handleError(PlatformException error) {
    print(error);
    switch (error.code) {
      case 'ERROR_EMAIL_ALREADY_IN_USE':
        setState(() {
          errorMessage = 'Este email já esta cadastrado!';
        });
        break;
      default:
    }
  }

  String validateemp(String value) {
    if (value.trim().isEmpty || value.length < 3) {
      return 'Este campo não pode ser vazio';
    }
    return null;
  }

  String validateatv(String value) {
    if (value.trim().isEmpty || value.length < 3) {
      return 'Este campo não pode ser vazio';
    }
    return null;
  }

  String validatename(String value) {
    if (value.trim().isEmpty || value.length < 3) {
      return 'Digite um nome válido';
    }
    return null;
  }

  String validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (value.isEmpty || !regex.hasMatch(value))
      return 'Digite um email válido';
    else
      return null;
  }

  String validatePassword(String value) {
    if (value.trim().isEmpty || value.length < 6 || value.length > 14) {
      return 'A senha deve contem no mínimo 6 caracteres e maximo 14 caracteres';
    }
    return null;
  }

  String validateConfirmPassword(String value) {
    if (value.trim() != _passwordController.text.trim()) {
      return 'As senhas não combinam';
    }
    return null;
  }
}
