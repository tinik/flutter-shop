import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shop/define.dart';
import 'package:shop/screens/search/components/body.dart';
import 'package:shop/ui/back.dart';
import 'package:shop/ui/cart.dart';

class SearchInput extends StatelessWidget {
  final String input;

  const SearchInput({
    Key? key,
    required this.input,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      textInputAction: TextInputAction.send,
      autofocus: false,
      decoration: InputDecoration(
        hintText: 'Enter a search term',
        prefixIcon: Icon(Icons.search),
        contentPadding: EdgeInsets.zero,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.white70),
        ),
      ),
      controller: TextEditingController(
        text: this.input.toString(),
      ),
      onSubmitted: (value) {
        // if (value.length >= 1 && this.input != value) {
        Navigator.pushReplacement(
          context,
          PageRouteBuilder(
            transitionDuration: const Duration(seconds: 0),
            pageBuilder: (context, animation, secondary) => ScreenSearch(
              query: value,
            ),
          ),
        );
      },
    );
  }
}

class ScreenSearch extends StatelessWidget {
  final String query;

  const ScreenSearch({
    Key? key,
    required this.query,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: buildAppBar(context),
      body: Container(
        padding: EdgeInsets.symmetric(
          horizontal: kDefaultPadding,
        ),
        child: Column(
          children: <Widget>[
            SearchInput(
              input: query,
            ),
            SearchBody(
              input: query,
            ),
          ],
        ),
      ),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: BackWidget(),
      actions: <Widget>[
        WidgetCart(),
      ],
    );
  }
}
