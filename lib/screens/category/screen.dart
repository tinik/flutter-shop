import 'package:flutter/material.dart';
import 'package:shop/define.dart';
import 'package:shop/screens/category/components/body.dart';
import 'package:shop/ui/back.dart';
import 'package:shop/ui/cart.dart';

class ScreenCategory extends StatelessWidget {
  final int id;

  ScreenCategory({
    Key? key,
    required this.id,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: Key("category-${this.id}"),
      appBar: buildAppBar(context),
      body: Body(
        id: this.id,
      ),
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
      ],
    );
  }
}

// ---------------------------------------------------------------------------------------------------------------------
