import 'package:flutter/material.dart';

// ignore: must_be_immutable
class FlatButtonExt extends StatelessWidget {
  String _text;
  Function _onPressed;
  FlatButtonExt({
    String text,
    Function onPressed,
  }) {
    this._text = text;
    this._onPressed = onPressed;
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(10, 5, 10, 0),
      child: Container(
        height: 60,
        width: MediaQuery.of(context).size.width,
        child: SizedBox.expand(
          child: FlatButton(
              onPressed: _onPressed,
              child: Text(_text,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ))),
        ),
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
      ),
    );
  }
}
