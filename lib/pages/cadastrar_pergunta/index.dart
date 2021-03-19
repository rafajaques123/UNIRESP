import 'package:flutter/material.dart';
import 'package:uniresp/components/flat_button_ext/index.dart';
import 'package:uniresp/components/text_form_field_ext/index.dart';

class CadastrarPerguntaPage extends StatefulWidget {
  @override
  _CadastrarPerguntaPageState createState() => _CadastrarPerguntaPageState();
}

class _CadastrarPerguntaPageState extends State<CadastrarPerguntaPage> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('ADICIONAR PERGUNTA'),
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
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(50, 20, 50, 0),
                child: TextFormFieldExt(
                  labelText: 'Nome',
                  keyboardType: TextInputType.name,
                  prefixIcon: Icon(Icons.edit),
                  // controller: _controller.nomeController,
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(50, 5, 50, 0),
                child: TextFormFieldExt(
                  labelText: 'Area de conhecimento',
                  keyboardType: TextInputType.text,
                  prefixIcon: Icon(Icons.school),
                  // controller: _controller.areaController,
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(50, 5, 50, 0),
                child: TextFormFieldExt(
                  labelText: 'Email',
                  keyboardType: TextInputType.emailAddress,
                  prefixIcon: Icon(Icons.email),
                  // controller: _controller.emailController,
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(50, 50, 50, 0),
                child: FlatButtonExt(
                  text: 'Salvar',
                  onPressed: () {
                    //   _controller.salvar(context);
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
