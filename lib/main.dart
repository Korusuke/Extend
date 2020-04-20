import 'package:flutter/material.dart';
import 'package:mcan/screens/scan.dart';
import 'package:mcan/screens/align.dart';
import 'package:mcan/screens/demos/solidcolors.dart';
import 'package:mcan/globals.dart' as globals;

void main() {
  runApp(MaterialApp(
    title: 'Extended Displays?',
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      primarySwatch: Colors.blue,
    ),
    initialRoute: '/',
    routes: {
      '/': (context) => Home(),
      '/scan': (context) => Scan(),
      '/align': (context) => AlignScreen(),
      '/solid': (context) => Animate(),
    },
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  String masterText = "Connect";
  TextEditingController _textController = TextEditingController();

  AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 10),
      vsync: this,
    )..repeat();

    _textController.addListener((){
      print("value: ${_textController.text}");
      globals.username = _textController.text;
      setState(() {});
    });
  }

  Animatable<Color> background = TweenSequence<Color>([
    TweenSequenceItem(
      weight: 1.0,
      tween: ColorTween(
        begin: Colors.red,
        end: Colors.green,
      ),
    ),
    TweenSequenceItem(
      weight: 1.0,
      tween: ColorTween(
        begin: Colors.green,
        end: Colors.blue,
      ),
    ),
    TweenSequenceItem(
      weight: 1.0,
      tween: ColorTween(
        begin: Colors.blue,
        end: Colors.pink,
      ),
    ),
  ]);

  @override
  void dispose() {
    // Clean up the controller when the Widget is disposed
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    globals.width = MediaQuery.of(context).size.width;
    globals.height = MediaQuery.of(context).size.height;
    return AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Scaffold(
            body: Container(
              color: background
                  .evaluate(AlwaysStoppedAnimation(_controller.value)),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.all(20.0),
                      child: Form(
                        child: TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Enter Name',
                            enabledBorder: const OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Colors.white, width: 1.5),
                            ),
                          ),
                          controller: _textController,
                        ),
                      ),
                    ),
                    RaisedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/scan');
                      },
                      color: Colors.blue,
                      textColor: Colors.white,
                      child: Text(masterText),
                      padding: EdgeInsets.all(48),
                      shape: CircleBorder(),
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }
}
