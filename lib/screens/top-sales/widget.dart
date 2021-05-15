import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shop/define.dart';
import 'package:shop/models/Product.dart';
import 'package:shop/screens/category/components/gallery-item.dart';

class TopSaleWidget extends StatelessWidget {
  const TopSaleWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 282,
      child: SizedBox(
        height: 282,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: products.length,
          itemBuilder: (context, index) {
            final item = products[index];
            return createItem(item);
          },
        ),
      ),
    );
  }

  Container createItem(Product item) {
    const double innerPadding = (kDefaultPadding / 3);
    return Container(
      key: Key("sales-${item.sku}"),
      width: 178,
      height: 178,
      margin: const EdgeInsets.only(right: kDefaultPadding / 2),
      padding: const EdgeInsets.all(innerPadding),
      decoration: BoxDecoration(
        color: kPrimaryColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: Image.network(
                item.image,
                height: 175,
                width: 175,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            height: 31,
            child: Align(
              alignment: Alignment.topLeft,
              child: Text(
                item.name,
                style: TextStyle(color: kTextLightColor, fontSize: 13),
                textAlign: TextAlign.start,
                maxLines: 2,
                softWrap: true,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(
              vertical: kDefaultPadding / 3,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                RichText(
                  textAlign: TextAlign.start,
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: "\$ ${currency.format(item.price)} \n",
                        style: TextStyle(
                          color: Colors.white70,
                          decoration: TextDecoration.lineThrough,
                          fontSize: 14,
                        ),
                      ),
                      TextSpan(
                        text: "\$ ${currency.format(item.price)}",
                        style: TextStyle(
                          fontSize: 16,
                          color: kTextLightColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                InkWell(
                  //This keeps the splash effect within the circle
                  borderRadius: BorderRadius.circular(1000.0), //Something large to ensure a circle
                  child: Icon(
                    Icons.shopping_cart_rounded,
                    color: Colors.white,
                  ),
                  onTap: () {},
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
