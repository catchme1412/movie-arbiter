import 'dart:io';

import 'package:flutter/cupertino.dart';

class ConnectityCheck extends StatefulWidget {
  static bool isConnectivity;
  @override
  _ConnectityCheckState createState() => _ConnectityCheckState();
}

class _ConnectityCheckState extends State<ConnectityCheck> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        print('connected');
      }
    } on SocketException catch (_) {
      print('not connected');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
