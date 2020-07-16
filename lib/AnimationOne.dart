import 'package:flutter/material.dart';
import 'dart:math';

class AnimationOne extends StatefulWidget {
  static const String id = 'AnimationOne';

  @override
  _AnimationOneState createState() => _AnimationOneState();
}

class _AnimationOneState extends State<AnimationOne> {
  double _width = 100;
  double _height = 100;
  Color _color = Colors.lightBlueAccent;

  double _updateState() {
    setState(() {
      if (_color == Colors.lightBlueAccent) {
        _width = 350;
        _height = 350;
        _color = Colors.deepOrangeAccent;
      } else {
        _width = 100;
        _height = 100;
        _color = Colors.lightBlueAccent;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Animated Container'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              AnimatedContainer(
                duration: Duration(milliseconds: 500),
                curve: Curves.bounceOut,
                child: Center(
                  child: Text('Apoorv'),
                ),
                height: _height,
                width: _width,
                color: _color,
              ),
              RaisedButton(
                  child: Text('Animate'),
                  onPressed: () {
                    _updateState();
                  })
            ],
          ),
        ),
      ),
    );
  }
}
//
//class SineCurve extends Curve {
//  final double count;
//  SineCurve({this.count = 3});
//  @override
//  double transformInterval(double t) {
//    var val = sin(count * 2 * pi * t) * 0.5 + 0.5;
//    return val;
//  }
//}
