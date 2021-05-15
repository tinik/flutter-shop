import 'package:flutter/material.dart';
import 'package:shop/define.dart';

class BackWidget extends StatelessWidget {
  const BackWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        Icons.arrow_back,
        color: kTextColor,
      ),
      onPressed: () => Navigator.pop(context),
    );
  }
}
