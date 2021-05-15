import 'package:flutter/material.dart';
import 'package:shop/define.dart';
import 'package:shop/screens/cart/screen.dart';

class WidgetCart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    int counter = 99;

    return Stack(
      children: <Widget>[
        IconButton(
          icon: Icon(Icons.shopping_cart),
          color: kTextColor,
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ScreenCart(),
            ),
          ),
        ),
        counter != 0 ? buildCounter(counter) : Container()
      ],
    );
  }

  Positioned buildCounter(int counter) {
    return Positioned(
      right: 11,
      top: 11,
      child: Container(
        padding: const EdgeInsets.all(2),
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.circular(10),
        ),
        constraints: BoxConstraints(
          minWidth: 14,
          minHeight: 14,
        ),
        child: Text(
          '$counter',
          style: TextStyle(
            color: Colors.white,
            fontSize: 8,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
