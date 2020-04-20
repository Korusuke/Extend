import 'dart:convert';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:wifi/wifi.dart';
import 'package:ping_discover_network/ping_discover_network.dart';
import 'package:mcan/globals.dart' as globals;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

class Scan extends StatefulWidget {
  @override
  _ScanState createState() => _ScanState();
}

class _ScanState extends State<Scan> {
  startServer() async {
    globals.server =
        await HttpServer.bind(InternetAddress.anyIPv4, globals.port);
    print("Server running on IP : " +
        globals.server.address.toString() +
        " On Port : " +
        globals.server.port.toString());
  }

  scanPeers() async {
    final String ip = await Wifi.ip;
    globals.myip = ip;
    final String subnet = ip.substring(0, ip.lastIndexOf('.'));
    final int port = globals.port;
    final stream = NetworkAnalyzer.discover2(subnet, port);
    print('listening...');
    stream.listen((NetworkAddress addr) async {
      if (addr.exists) {
        print('Found device: ${addr.ip}');
        if (addr.ip != ip) {
          globals.peer = await whoyou(addr.ip, port);
          print(globals.peer.name);
          if (await connect(addr.ip, port) == 'ok') {
            Fluttertoast.showToast(
                msg: "Connected to ${globals.peer.name}",
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 2,
                backgroundColor: Colors.green,
                textColor: Colors.white,
                fontSize: 16.0);
            sleep2();
            globals.amIMaster = true;
            Navigator.pushNamed(context, '/align');
          }
        }
      }
    });
  }

  Future whoyou(String ip, int port) async {
    final http.Response response = await http.post(
      'http://$ip:$port/whoareyou',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'name': globals.username,
        'ip': globals.myip,
        'width': globals.width.toString(),
        'height': globals.height.toString()
      }),
    );

    if (response.statusCode == 200) {
      return Peer.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load peer');
    }
  }

  Future connect(String ip, int port) async {
    final http.Response response = await http.post(
      'http://$ip:$port/connect',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'name': globals.username,
        'ip': globals.myip,
        'width': globals.width.toString(),
        'height': globals.height.toString()
      }),
    );

    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Failed to load peer');
    }
  }

  replyPeers() async {
    await for (HttpRequest request in globals.server) {
      String content = await utf8.decoder.bind(request).join(); /*2*/
      var data = jsonDecode(content) as Map;
      globals.peer = Peer.fromJson(data);
      print(request.uri);
      if (request.uri.toString() == '/whoareyou') {
        request.response
          ..headers.contentType =
              new ContentType("application", "json", charset: "utf-8")
          ..write(jsonEncode(<String, String>{
            'name': globals.username,
            'ip': globals.myip,
            'width': globals.width.toString(),
            'height': globals.height.toString()
          }))
          ..close();
      } else if (request.uri.toString() == '/connect') {
        request.response
          ..headers.contentType =
              new ContentType("text", "plain", charset: "utf-8")
          ..write('ok')
          ..close();
        globals.amIMaster = false;
        Fluttertoast.showToast(
            msg: "Connected to ${globals.peer.name}",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 2,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0);
        await sleep2();
        Navigator.pushNamed(context, '/align');
      } else {
        request.response
          ..headers.contentType =
              new ContentType("text", "plain", charset: "utf-8")
          ..write('The World is a mysterious place')
          ..close();
      }
    }
  }

  Future sleep2() {
    return new Future.delayed(const Duration(seconds: 2), () => "2");
  }

  handler() async {
    await startServer();
    scanPeers();
    replyPeers();
  }

  @override
  void initState() {
    super.initState();
    handler();
  }

  @override
  void dispose() {
    super.dispose();
    globals.server.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
        child: ClipOval(
          child: Container(
            color: Colors.blue,
            height: 120.0, // height of the button
            width: 120.0, // width of the button
            child: Center(
                child: Text(
              'Scanning',
              style:
                  TextStyle(color: Colors.white.withOpacity(0.8), fontSize: 20),
            )),
          ),
        ),
      )
    );
  }
}

class Peer {
  final String name;
  final String ip;
  final String width;
  final String height;

  Peer({this.name, this.ip, this.width, this.height});

  factory Peer.fromJson(Map<String, dynamic> json) {
    return Peer(
        name: json['name'],
        ip: json['ip'],
        width: json['width'],
        height: json['height']);
  }
}
