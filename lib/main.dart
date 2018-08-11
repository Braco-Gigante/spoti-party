import 'dart:async';

import 'package:flutter/material.dart';
import 'dart:io';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SpotiParty',
      theme: ThemeData(
        brightness: Brightness.dark,
        buttonColor: Colors.green,
        buttonTheme: ButtonThemeData(
          padding: const EdgeInsets.all(12.0),
          shape: OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(32.0),
            ),
          ),
        ),
        textTheme: TextTheme(
          display4: const TextStyle(
              debugLabel: 'whiteMountainView display4',
              fontFamily: 'Roboto',
              inherit: true,
              color: Colors.white70,
              decoration: TextDecoration.none),
          display3: const TextStyle(
              debugLabel: 'whiteMountainView display3',
              fontFamily: 'Roboto',
              inherit: true,
              color: Colors.white70,
              decoration: TextDecoration.none),
          display2: const TextStyle(
              debugLabel: 'whiteMountainView display2',
              fontFamily: 'Roboto',
              inherit: true,
              color: Colors.white70,
              decoration: TextDecoration.none),
          display1: const TextStyle(
              debugLabel: 'whiteMountainView display1',
              fontFamily: 'Roboto',
              inherit: true,
              color: Colors.white70,
              decoration: TextDecoration.none),
          headline: const TextStyle(
              debugLabel: 'whiteMountainView headline',
              fontFamily: 'Roboto',
              inherit: true,
              color: Colors.white,
              decoration: TextDecoration.none),
          title: const TextStyle(
              debugLabel: 'whiteMountainView title',
              fontFamily: 'Roboto',
              inherit: true,
              color: Colors.white,
              decoration: TextDecoration.none),
          subhead: const TextStyle(
              debugLabel: 'whiteMountainView subhead',
              fontFamily: 'Roboto',
              inherit: true,
              color: Colors.white,
              decoration: TextDecoration.none),
          body2: const TextStyle(
              debugLabel: 'whiteMountainView body2',
              fontFamily: 'Roboto',
              inherit: true,
              color: Colors.white,
              decoration: TextDecoration.none),
          body1: const TextStyle(
              debugLabel: 'whiteMountainView body1',
              fontFamily: 'Roboto',
              inherit: true,
              color: Colors.white,
              decoration: TextDecoration.none),
          caption: const TextStyle(
              debugLabel: 'whiteMountainView caption',
              fontFamily: 'Roboto',
              inherit: true,
              color: Colors.white70,
              decoration: TextDecoration.none),
          button: const TextStyle(
              debugLabel: 'whiteMountainView button',
              fontFamily: 'Roboto',
              fontSize: 16.0,
              // inherit: true,
              color: Colors.white,
              decoration: TextDecoration.none),
        ),
      ),
      home: MyHomePage(
        title: 'SpotiParty',
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String title;

  MyHomePage({Key key, @required this.title}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  void _create_server() {
    int port = 1234;

    HttpServer.bind(InternetAddress.loopbackIPv4, port).
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RaisedButton(
              child: Center(child: Text('Host Party')),
              onPressed: () {
                _create_server();
              },
            ),
            const SizedBox(height: 16.0),
            RaisedButton(
              child: Center(child: Text('Join Party')),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
