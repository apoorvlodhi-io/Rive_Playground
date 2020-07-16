import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'package:riveplayground/AnimationOne.dart';
import 'package:riveplayground/AnimationThree.dart';
import 'package:riveplayground/AnimationTwo.dart';
import 'package:riveplayground/FlipCard.dart';
import 'package:riveplayground/TransformAnimation.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Animation Basics',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      routes: {
        AnimationOne.id: (context) => AnimationOne(),
        AnimationTwo.id: (context) => AnimationTwo(),
        Ticket.id: (context) => Ticket(),
        TransformDemo.id: (context) => TransformDemo(),
        MatrixThreeD.id: (context) => MatrixThreeD(),
      },
      home: MainPage(),
    );
  }
}

class MainPage extends StatelessWidget {
//  static const String id = 'splash_screen';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        drawer: Drawer(),
        appBar: AppBar(
          title: Text('Animation Basics'),
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Expanded(
                      child: FlatButton(
                        child: Text(
                          'Animation1',
                          style: TextStyle(color: Colors.white),
                        ),
                        color: UniqueColor.getColor(),
                        onPressed: () {
                          Navigator.pushNamed(context, AnimationOne.id);
                        },
                      ),
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: FlatButton(
                        child: Text(
                          'Animation2',
                          style: TextStyle(color: Colors.white),
                        ),
                        color: UniqueColor.getColor(),
                        onPressed: () {
                          Navigator.pushNamed(context, AnimationTwo.id);
                        },
                      ),
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: FlatButton(
                        child: Text(
                          'Animation3',
                          style: TextStyle(color: Colors.white),
                        ),
                        color: UniqueColor.getColor(),
                        onPressed: () {
                          Navigator.pushNamed(context, Ticket.id);
                        },
                      ),
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: FlatButton(
                        child: Text(
                          'Animation4',
                          style: TextStyle(color: Colors.white),
                        ),
                        color: UniqueColor.getColor(),
                        onPressed: () {
                          Navigator.pushNamed(context, TransformDemo.id);
                        },
                      ),
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: FlatButton(
                        child: Text(
                          'Animation5',
                          style: TextStyle(color: Colors.white),
                        ),
                        color: UniqueColor.getColor(),
                        onPressed: () {
                          Navigator.pushNamed(context, MatrixThreeD.id);
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class UniqueColor {
  static Random random = Random();
  static Color getColor() {
    return Color.fromRGBO(
        random.nextInt(256), random.nextInt(256), random.nextInt(256), 1);
  }
}
