import 'dart:async';
import 'package:flutter/material.dart';
import 'package:mcan/globals.dart' as globals;
import 'dart:math';

class AlignScreen extends StatefulWidget {
  @override
  _AlignScreenState createState() => _AlignScreenState();
}

class _AlignScreenState extends State<AlignScreen> {
  String masterText = "Continue!";
  double tot_width;
  double tot_height;
  // TODO:
  // [ ] Add two arrow marks for alignment
  // [ ] Connect button on master, press connect button message on peer
  // [ ] After pressing connect, animation starts in master
  // [ ] x seconds later animation starts in peer

  Future sleep3() {
    return new Future.delayed(const Duration(seconds: 3), () => "3");
  }

  _handleMaster(BuildContext context) {
    // Navigator.pushNamed(context, '/solid');
    // Send message to peer to start their animation
  }

  _handlePeer(BuildContext context) async {
    // await sleep3();
    // Navigator.pushNamed(context, '/solid');
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      tot_height = globals.height;
      print(tot_height);
      tot_width = globals.width + double.parse(globals.peer.width);
      print(tot_width);
    });
    if (!globals.amIMaster) {
      setState(() {
        masterText = 'Press continue on master device!';
      });
      _handlePeer(context);
    } else {
      _handleMaster(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    // return Container(
    //     color: Colors.red,
    //     child: OverflowBox(
    //         minWidth: tot_width,
    //         maxWidth: tot_width,
    //         minHeight: tot_height,
    //         maxHeight: tot_height,
    //         alignment: (globals.amIMaster
    //             ? Alignment.centerRight
    //             : Alignment.centerLeft),
    //         child: Image.network(
    //           'https://picsum.photos/800?image=1',
    //           height: tot_height,
    //           width: tot_width,
    //           fit: BoxFit.fitWidth,
    //           alignment: Alignment.center,
    //         )));
    return Scaffold(
        body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Align(
            alignment: globals.amIMaster ? Alignment.centerRight : Alignment.centerLeft,
            child: Icon(
              globals.amIMaster ? Icons.arrow_forward : Icons.arrow_back,
              size: 60
            ),
          ),
          RaisedButton(
            onPressed: () async {
              print('AmIMaster: ' + globals.amIMaster.toString());
              if (globals.amIMaster) {
                print('Master in!');
                // Navigator.pushNamed(context, '/solid');
                // _handleMaster();
              }
            },
            child: Text(masterText),
          ),
          Align(
            alignment: globals.amIMaster ? Alignment.centerRight : Alignment.centerLeft,
            child: Icon(
              globals.amIMaster ? Icons.arrow_forward : Icons.arrow_back,
              size: 60
            ),
          ),
        ],
      ),
    ));
  }
}
// return Scaffold(
//         body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: <Widget>[
//             RaisedButton(
//               onPressed: () {
//                 print('AmIMaster: ' + globals.amIMaster.toString());
//                 if (globals.amIMaster) {
//                   print('Master in!');
//                   _handleMaster(context);
//                 }
//               },
//               child: Text(masterText),
//             )
//           ],
//         ),
//       )
//     );
//   }
