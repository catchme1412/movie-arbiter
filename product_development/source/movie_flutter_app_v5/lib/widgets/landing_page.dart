import 'package:MovieArbiter/context/movie_app_context.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LandingPage extends StatelessWidget {
  final MovieAppContext movieAppContext;

  const LandingPage({Key key, this.movieAppContext}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
          child: Container(
            constraints: BoxConstraints.expand(),
            decoration: BoxDecoration(
              color: Colors.black,
              image: DecorationImage(
//                  colorFilter: ColorFilter.srgbToLinearGamma(),

                  colorFilter: new ColorFilter.mode(
                      Colors.black.withOpacity(0.5), BlendMode.dstATop),
                  image: AssetImage("assets/images/loading.gif"),
                  fit: BoxFit.cover),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Text(
                    'Best Youtube Movies',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.normal),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  RaisedButton(
                    padding: EdgeInsets.all(8),
                    color: Colors.orange,
                    child: Text(
                      'Start',
                      style: TextStyle(fontSize: 16),
                    ),
                    onPressed: () {
                      // Navigate to the second screen when tapped.

                      Navigator.pushNamed(context, '/home');
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
