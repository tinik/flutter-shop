import 'package:flutter/material.dart';
import 'package:shop/define.dart';
import 'package:shop/screens/sarch/screen.dart';

class WidgetSearch extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.search),
      color: kTextColor,
      onPressed: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ScreenSearch(query: ''),
        ),
      ),
    );
  }
}
