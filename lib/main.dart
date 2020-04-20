import 'package:flutter/material.dart';
import 'package:mcan/screens/scan.dart';
import 'package:mcan/screens/align.dart';
import 'package:mcan/screens/demos/solidcolors.dart';
import 'package:mcan/globals.dart' as globals;

void main() {
  runApp(MaterialApp(
    title: 'Extended Displays?',
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

class _HomeState extends State<Home> {
  String masterText = "Connect Devices";

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    globals.width = MediaQuery.of(context).size.width;
    globals.height = MediaQuery.of(context).size.width;
    return Scaffold(
        body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            RaisedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/scan');
              },
              child: Text(masterText),
            )
          ],
        ),
      )
    );
  }
}
