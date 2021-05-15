import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shop/define.dart';
import 'package:shop/models/Product.dart';

final currency = new NumberFormat("#,##0.00", "en_US");

class GalleryItem extends StatelessWidget {
  final Product item;
  final Function onPress;

  const GalleryItem({
    Key? key,
    required this.item,
    required this.onPress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GestureDetector(
        onTap: () => onPress(),
        child: buildView(),
      ),
    );
  }

  Column buildView() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Container(
          margin: const EdgeInsets.only(bottom: 5),
          child: Hero(
            tag: "product-${item.id}",
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(item.image),
            ),
          ),
        ),
        SizedBox(
          child: Container(
            margin: const EdgeInsets.all(3),
            child: Align(
              alignment: Alignment.topLeft,
              child: Text(
                item.name,
                style: TextStyle(color: kTextColor, fontSize: 14),
                textAlign: TextAlign.start,
                maxLines: 2,
                softWrap: true,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ),
        SizedBox(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                RichText(
                  textAlign: TextAlign.start,
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: "\$ ${currency.format(item.price)}\n",
                        style: TextStyle(
                          color: kTextColor,
                          decoration: TextDecoration.lineThrough,
                          fontSize: 12,
                        ),
                      ),
                      TextSpan(
                        text: "\$ ${currency.format(item.price)}",
                        style: TextStyle(
                          fontSize: 15,
                          color: kTextColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(7),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100.0),
                    color: kPrimaryColor,
                  ),
                  child: InkWell(
                    splashColor: kTextLightColor,
                    child: Icon(
                      Icons.shopping_cart_rounded,
                      color: kTextColor,
                    ),
                    onTap: () {},
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
