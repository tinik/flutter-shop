import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shop/define.dart';
import 'package:shop/repository/category/products.dart';
import 'package:shop/screens/product/screen.dart';

final currency = new NumberFormat("#,##0.00", "en_US");

class GalleryItem extends StatelessWidget {
  final Product item;

  const GalleryItem({
    Key? key,
    required this.item,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(3),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(15)),
      ),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ScreenProduct(id: this.item.id, urlKey: this.item.urlKey),
            ),
          );
        },
        child: buildView(),
      ),
    );
  }

  Widget buildView() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Container(
          alignment: Alignment.center,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image(
              image: CachedNetworkImageProvider(item.thumbnail),
              height: 192.0,
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
                createPrice(),
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
                      color: kTextLightColor,
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

  RichText createPrice() {
    final price = item.price;

    TextSpan regularPrice = TextSpan();
    if (price.isSpecial) {
      regularPrice = TextSpan(
        text: "\$ ${currency.format(price.regular)}\n",
        style: TextStyle(
          color: kTextColor,
          decoration: TextDecoration.lineThrough,
          fontSize: 12,
        ),
      );
    }

    return RichText(
      textAlign: TextAlign.start,
      text: TextSpan(
        children: [
          regularPrice,
          TextSpan(
            text: "\$ ${currency.format(price.finish)}",
            style: TextStyle(
              fontSize: 15,
              color: kTextColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
