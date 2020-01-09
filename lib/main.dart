import 'package:flutter/material.dart';
import 'router/router.dart';

void main() => runApp(MainApp());

class MainApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Zebr',

      home: Index(),
    );
  }
}
