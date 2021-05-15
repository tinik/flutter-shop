import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shop/ui/back.dart';
import 'package:shop/ui/cart.dart';

class ScreenSearch extends StatelessWidget {
  final String query;

  const ScreenSearch({Key? key, required this.query}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: buildAppBar(context),
      body: Center(
        child: Text("Search: " + query),
      ),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: BackWidget(),
      actions: <Widget>[
        WidgetCart(),
      ],
    );
  }
}
