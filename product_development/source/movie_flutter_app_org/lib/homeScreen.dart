import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => new _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.blueGrey[900],
      appBar: new AppBar(
        title: new Text('Movie Arbiter'),
        backgroundColor: Colors.blueGrey[900],
      ),
      body: new Center(
        child: new Text(''),
      ),
    );
  }
}
