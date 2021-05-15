import 'package:flutter/material.dart';
import 'package:shop/define.dart';
import 'package:shop/screens/home/screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        textTheme: Theme.of(context).textTheme.apply(bodyColor: kTextColor),
        primarySwatch: Colors.blueGrey,
      ),
      home: ScreenHome(),
    );
  }
}
