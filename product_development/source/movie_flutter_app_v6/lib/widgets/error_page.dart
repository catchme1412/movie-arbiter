import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie_flutter_app_v6/widgets/page_footer.dart';

class ErrorPage extends StatefulWidget {
  static const ROUTE = "error";

  final String message;

  const ErrorPage({Key key, this.message}) : super(key: key);
  @override
  _ErrorPageState createState() => _ErrorPageState();
}

class _ErrorPageState extends State<ErrorPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Movie Arbiter"),
      ),
      bottomNavigationBar: PageFooterBar(),
      body: SafeArea(
        child: Center(
          child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.fromLTRB(40, 40, 40, 40),
                child: Image.asset("assets/images/error.png"),
              ),
              Padding(
                padding: EdgeInsets.all(20),
                child: Text(
                  widget.message,
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
