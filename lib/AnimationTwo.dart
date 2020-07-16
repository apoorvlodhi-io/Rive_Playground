import 'package:flutter/material.dart';

class AnimationTwo extends StatelessWidget {
  static const String id = 'AnimationTwo';
  Tween<double> _scaleTween = Tween<double>(begin: 1, end: 2);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Tween Animation'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TweenAnimationBuilder(
                tween: _scaleTween,
                duration: Duration(milliseconds: 600),
                builder: (context, scale, child) {
                  return Transform.scale(
                    scale: scale,
                    child: child,
                  );
                },
                child: Container(
                  child: Center(
                    child: Text('Apoorv'),
                  ),
                  height: 100,
                  width: 100,
                  color: Colors.lightBlueAccent,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
