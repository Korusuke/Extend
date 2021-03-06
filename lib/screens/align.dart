import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:extend/globals.dart' as globals;

class AlignScreen extends StatefulWidget {
  @override
  _AlignScreenState createState() => _AlignScreenState();
}

class _AlignScreenState extends State<AlignScreen> {
  String masterText = "Continue!";
  double totalWidth;
  double totalHeight;
  int id = 1;

  Future sleep6() {
    return new Future.delayed(const Duration(seconds: 6), () => "6");
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      totalHeight = min(globals.height, double.parse(globals.peer.height));
      print(totalHeight);
      totalWidth = globals.width + double.parse(globals.peer.width);
      print(globals.width);
      print(totalWidth);
    });
    if (!globals.amIMaster) {
      setState(() {
        masterText = 'Press continue on master device!';
      });
    }
    updateImage();
  }

  updateImage() async {
    setState(() {
      if (id < 5) {
        id = id + 1;
      } else {
        id = 1;
      }
    });
    await sleep6();
    updateImage();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: totalHeight,
      color: Colors.black26,
      child: OverflowBox(
        minWidth: totalWidth,
        maxWidth: totalWidth,
        minHeight: totalHeight,
        maxHeight: totalHeight,
        alignment:
            (globals.amIMaster ? Alignment.centerRight : Alignment.centerLeft),
        child: Image.asset('assets/images/slides/$id.jpg'),
      ),
    );

    // return Scaffold(
    //     body: Center(
    //   child: Column(
    //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //     crossAxisAlignment: CrossAxisAlignment.center,
    //     children: <Widget>[
    //       Align(
    //         alignment: globals.amIMaster ? Alignment.centerRight : Alignment.centerLeft,
    //         child: Icon(
    //           globals.amIMaster ? Icons.arrow_forward : Icons.arrow_back,
    //           size: 60
    //         ),
    //       ),
    //       RaisedButton(
    //         onPressed: () async {
    //           print('AmIMaster: ' + globals.amIMaster.toString());
    //           if (globals.amIMaster) {
    //             print('Master in!');
    //             // Navigator.pushNamed(context, '/solid');
    //             // _handleMaster();
    //           }
    //         },
    //         child: Text(masterText),
    //       ),
    //       Align(
    //         alignment: globals.amIMaster ? Alignment.centerRight : Alignment.centerLeft,
    //         child: Icon(
    //           globals.amIMaster ? Icons.arrow_forward : Icons.arrow_back,
    //           size: 60
    //         ),
    //       ),
    //     ],
    //   ),
    // ));
  }
}
