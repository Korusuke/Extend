import 'package:flutter/material.dart';
import 'package:mcan/globals.dart' as globals;

class AlignScreen extends StatefulWidget {
  @override
  _AlignScreenState createState() => _AlignScreenState();
}

class _AlignScreenState extends State<AlignScreen> {
  String masterText = "Align Page";

  @override
  void initState() {
    super.initState();
    if (globals.amIMaster) {
      // handleMaster();
    } else {
      // handleNode();
    }
  }

  @override
  Widget build(BuildContext context) {
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
    ));
  }
}
