import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:shop/define.dart';
import 'package:shop/screens/cart/screen.dart';

class WidgetCart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    int counter = 99;

    return TextButton(
      onPressed: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ScreenCart(),
        ),
      ),
      child: Badge(
        badgeContent: Text(
          counter.toString(),
          style: TextStyle(
            color: Colors.white,
            fontSize: 10,
          ),
          textAlign: TextAlign.center,
        ),
        child: Icon(
          Icons.shopping_cart,
          color: kTextColor,
        ),
      ),
    );
  }
}
