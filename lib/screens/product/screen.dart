import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shop/define.dart';
import 'package:shop/models/Product.dart';
import 'package:shop/screens/product/components/body.dart';
import 'package:shop/ui/back.dart';
import 'package:shop/ui/cart.dart';

class ScreenProduct extends StatelessWidget {
  final Product product;

  ScreenProduct({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      appBar: buildAppBar(context),
      body: Body(product: product),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: BackWidget(),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.search),
          color: kTextLightColor,
          onPressed: () {},
        ),
        WidgetCart(),
      ],
    );
  }
}
