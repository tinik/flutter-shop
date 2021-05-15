import 'package:flutter/material.dart';
import 'package:shop/define.dart';
import 'package:shop/models/Product.dart';
import 'package:shop/screens/category/components/categories.dart';
import 'package:shop/screens/category/components/gallery-item.dart';
import 'package:shop/screens/product/screen.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: kDefaultPadding,
          ),
          child: Text(
            "Women",
            style: Theme.of(context).textTheme.headline5!.copyWith(fontWeight: FontWeight.bold),
          ),
        ),
        Categories(),

        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
            child: GridView.builder(
              itemCount: products.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: kDefaultPadding / 2,
                crossAxisSpacing: kDefaultPadding / 2,
                childAspectRatio: 0.68,
              ),
              itemBuilder: (context, index) => GalleryItem(
                item: products[index],
                onPress: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ScreenProduct(
                      product: products[index],
                    ),
                  ),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
