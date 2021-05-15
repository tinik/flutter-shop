import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shop/define.dart';
import 'package:shop/screens/cart/components/body.dart';
import 'package:shop/ui/back.dart';

class ScreenCart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: buildAppBar(context),
      body: Body(),
      bottomNavigationBar: buildAppFooter(),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      leading: BackWidget(),
      actions: <Widget>[
        SizedBox(width: kDefaultPadding / 2),
      ],
    );
  }

  Widget buildAppFooter() {
    return Stack(
      children: [
        Container(
          height: 100,
          decoration: BoxDecoration(
            color: kPrimaryColor,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              RawMaterialButton(
                padding: const EdgeInsets.all(kDefaultPadding),
                textStyle: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w500),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Text("GO TO CHECKOUT"),
                    Container(
                      padding: const EdgeInsets.only(
                        left: kDefaultPadding / 2,
                      ),
                      child: Icon(Icons.shopping_cart_rounded),
                    ),
                  ],
                ),
                onPressed: () {},
              ),
            ],
          ),
        ),
      ],
    );
  }
}
