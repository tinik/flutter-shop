import 'package:flutter/material.dart';
import 'package:shop/screens/category/components/body.dart';
import 'package:shop/ui/back.dart';
import 'package:shop/ui/cart.dart';
import 'package:shop/ui/search.dart';

class ScreenCategory extends StatelessWidget {
  final int id;

  ScreenCategory({
    Key? key,
    required this.id,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      key: Key("category-${id}"),
      backgroundColor: Color(0xFFF6F6F6),
      body: Body(
        id: id,
      ),
    );
  }

  buildAppBar(context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: BackWidget(),
      actions: <Widget>[
        WidgetSearch(),
        WidgetCart(),
      ],
    );
  }
}

// ---------------------------------------------------------------------------------------------------------------------
