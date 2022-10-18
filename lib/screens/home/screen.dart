import 'package:flutter/material.dart';
import 'package:shop/define.dart';
import 'package:shop/screens/home/components/body.dart';
import 'package:shop/screens/profile/screen.dart';
import 'package:shop/screens/search/screen.dart';
import 'package:shop/ui/cart.dart';

class ScreenHome extends StatelessWidget {
  AppBar _createBar(context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      actions: <Widget>[
        WidgetCart(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: this._createBar(context),
      body: Body(),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: kPrimaryColor,
        type: BottomNavigationBarType.fixed,
        currentIndex: 0,
        items: [
          BottomNavigationBarItem(
            label: "Home",
            icon: Icon(Icons.home),
            backgroundColor: kPrimaryColor,
          ),
          BottomNavigationBarItem(
            label: "Search",
            icon: Icon(Icons.search),
          ),
          BottomNavigationBarItem(
            label: "Account",
            icon: Icon(Icons.account_circle_rounded),
          ),
        ],
        onTap: (int index) {
          // Search index
          if (index == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ScreenSearch(query: ""),
              ),
            );
          }

          // Search index
          if (index == 2) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ScreenProfile(),
              ),
            );
          }
        },
      ),
    );
  }
}
