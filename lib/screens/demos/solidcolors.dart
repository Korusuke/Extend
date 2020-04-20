import 'package:flutter/material.dart';
import 'package:extend/globals.dart' as globals;

class Animate extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return AnimateState();
  }
}

class AnimateState extends State<Animate> with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<double> animation;
  double height, width;

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(duration: Duration(seconds: 3), vsync: this)
          ..addListener(() => setState(() {}));
    animation = Tween(begin: -width, end: width).animate(controller);
    controller.forward();

    width = globals.width;
    height = globals.height;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Transform.translate(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Flexible(
              child: Container(
                height: height,
                width: width,
                decoration: BoxDecoration(
                  color: Colors.blueAccent,
                ),
              ),
            ),
          ],
        ),
        offset: Offset(animation.value, 0.0),
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
