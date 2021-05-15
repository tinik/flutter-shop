import 'package:flutter/material.dart';
import 'package:shop/define.dart';
import 'package:shop/screens/category/components/body.dart';
import 'package:shop/ui/back.dart';
import 'package:shop/ui/cart.dart';

class ScreenCategory extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: Body(),
    );
  }

  buildAppBar(context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: BackWidget(),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.search),
          color: kTextColor,
          onPressed: () {},
        ),
        WidgetCart(),
        SizedBox(width: kDefaultPadding / 2)
      ],
    );
  }
}
