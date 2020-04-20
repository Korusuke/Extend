import 'dart:async';
import 'package:flutter/material.dart';
import 'package:mcan/globals.dart' as globals;

class AlignScreen extends StatefulWidget {
  @override
  _AlignScreenState createState() => _AlignScreenState();
}

class _AlignScreenState extends State<AlignScreen> {
  String masterText = "Continue!";
  // TODO:
  // [ ] Add two arrow marks for alignment
  // [ ] Connect button on master, press connect button message on peer
  // [ ] After pressing connect, animation starts in master
  // [ ] x seconds later animation starts in peer

  Future sleep3() {
    return new Future.delayed(const Duration(seconds: 3), () => "3");
  }

  _handleMaster() {
    // Push to /solid route apparently it gives NoSuchMethodError
    // Send message to peer to start its animation
    Navigator.pushNamed(context, '/solid');
  }

  _handlePeer() {

  }

  @override
  void initState() {
    super.initState();
    if (!globals.amIMaster) {
      setState(() {
        masterText = 'Press continue on master device!';
      });
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
              onPressed: () async {
                print('AmIMaster: ' + globals.amIMaster.toString());
                if (globals.amIMaster) {
                  print('Master in!');
                  // Navigator.pushNamed(context, '/solid');
                  _handleMaster();
                } 
              },
              child: Text(masterText),
            )
          ],
        ),
      )
    );
  }
}
