import 'package:flutter/material.dart';
import 'package:shop/define.dart';

class BackWidget extends StatelessWidget {
  final color = kTextColor;

  const BackWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        Icons.arrow_back,
        color: color,
      ),
      onPressed: () => Navigator.pop(context),
    );
  }
}
