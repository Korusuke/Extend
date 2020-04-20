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

  _handleMaster(BuildContext context) {
    Navigator.pushNamed(context, '/solid');
    // Send message to peer to start their animation
  }

  _handlePeer(BuildContext context) async {
    await sleep3();
    Navigator.pushNamed(context, '/solid');
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
              onPressed: () {
                print('AmIMaster: ' + globals.amIMaster.toString());
                if (globals.amIMaster) {
                  print('Master in!');
                  _handleMaster(context);
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
