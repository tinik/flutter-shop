import 'package:flutter/material.dart';
import 'package:shop/define.dart';
import 'package:shop/screens/home/components/categories.dart';
import 'package:shop/screens/home/components/promotion.dart';
import 'package:shop/screens/sarch/screen.dart';
import 'package:shop/screens/top-sales/widget.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SearchWidget(),
          Promotion(),
          Container(
            padding: const EdgeInsets.only(
              top: kDefaultPadding,
              right: kDefaultPadding,
              left: kDefaultPadding,
            ),
            child: Text(
              "Categories",
              style: Theme.of(context).textTheme.headline5!.copyWith(fontWeight: FontWeight.bold, fontSize: 18),
            ),
          ),
          Categories(),

          // Show top-sales widget
          Container(
            padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Top Sales",
                  style: Theme.of(context).textTheme.headline5!.copyWith(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                TextButton(
                  child: Text("more"),
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ScreenSearch(query: 'test'),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.only(left: kDefaultPadding),
            child: TopSaleWidget(),
          )
        ],
      ),
    );
  }
}

class SearchWidget extends StatelessWidget {
  const SearchWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(kDefaultPadding),
      child: TextField(
        textInputAction: TextInputAction.send,
        autofocus: false,
        onSubmitted: (value) {
          if (value.length >= 1) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ScreenSearch(query: value),
              ),
            );
          }
        },
        decoration: InputDecoration(
          hintText: 'Enter a search term',
          filled: false,
          fillColor: Color(0xFFEAE9E9),
          focusColor: Colors.white,
          hoverColor: Colors.white,
          prefixIcon: Icon(Icons.search),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }
}
