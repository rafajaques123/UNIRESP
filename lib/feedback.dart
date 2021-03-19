import 'package:flutter/material.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
// ignore: unused_import
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FeedBack extends StatefulWidget {
  FeedBack({Key key, this.title, this.uid}) : super(key: key);
  final String title;
  final String uid;
  @override
  _FeedBackState createState() => _FeedBackState();
}

class _FeedBackState extends State<FeedBack> {
  var rating2;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              }),
          title: Text('FeedBack'),
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
            SizedBox(
              height: 30.0,
            ),
            Text(
              "Qual sua avaliação em relação ao nosso app ?",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.blue[900],
                fontSize: 22.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 30.0,
            ),
            Container(
              child: Center(
                  child: SmoothStarRating(
                rating: 3,
                isReadOnly: false,
                size: 60,
                filledIconData: Icons.star,
                halfFilledIconData: Icons.star_half,
                defaultIconData: Icons.star_border,
                starCount: 5,
                allowHalfRating: true,
                spacing: 2.0,
                onRated: (rating2) {
                  print("rating value -> $rating2");
                  // print("rating value dd -> ${value.truncate()}");
                },
              )),
            ),
            SizedBox(
              height: 30.0,
            ),
            Container(
              height: 50,
              width: 190,
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
                    'Enviar',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                  onPressed: () {
                    Firestore.instance
                        .collection("avaliacao")
                        .document(widget.uid)
                        .collection('notas')
                        .add({"nome": widget.uid, "nota": rating2}).then(
                            (result) => {Navigator.pop(context)});
                  }),
            ),
          ],
        ));
  }
}
