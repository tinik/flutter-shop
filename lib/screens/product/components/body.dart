import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';
import 'package:shop/define.dart';
import 'package:shop/screens/product/components/view-description.dart';
import 'package:shop/screens/product/components/view-image.dart';
import 'package:shop/screens/product/components/view-variants.dart';

final currency = new NumberFormat("#,##0.00", "en_US");

class Body extends StatelessWidget {
  final product;

  Body({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // double sample = size.height * 0.3;

    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Container(
            child: ViewImages(
              media: product.media,
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 3),
            padding: EdgeInsets.only(
              top: size.height * 0.01,
              left: kDefaultPadding,
              right: kDefaultPadding,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(15)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.only(bottom: kDefaultPadding / 2),
                  child: Text(
                    product.name,
                    style: Theme.of(context).textTheme.headline4!.copyWith(
                          color: kTextColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(bottom: kDefaultPadding / 2),
                  child: _createHeader(),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    _createPrice(),
                    IconButton(
                      onPressed: () => null,
                      icon: Icon(
                        Icons.favorite_outline,
                      ),
                    ),
                  ],
                ),

                // VariantWidget(product: this._data._value['cache']),
                ExpandableText(product.description ?? ""),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _createHeader() {
    late Map<String, dynamic> status = {"label": "Out of stock", "color": Colors.redAccent};

    final String stockLabel = product.status!.toString().toUpperCase();
    if (stockLabel == 'IN_STOCK') {
      status = {"label": "in stock", "color": Colors.lightGreen};
    } else if (stockLabel == 'OUT_OF_STOCK') {
      status = {"label": "out of stock", "color": Colors.redAccent};
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          child: Chip(
            padding: EdgeInsets.zero,
            backgroundColor: Colors.black38,
            label: Text(
              product.sku,
              style: TextStyle(
                color: kTextLightColor,
                fontWeight: FontWeight.w600,
                fontSize: 12,
              ),
            ),
          ),
        ),
        Container(
          child: Text(
            status['label'],
            style: TextStyle(
              color: status['color'],
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }

  Widget _createPrice() {
    final price = product.price;

    TextSpan regularPrice = TextSpan();
    if (price.isSpecial) {
      final double value = (((price.regular - price.finish) / price.regular) * 100);

      regularPrice = TextSpan(
        children: [
          TextSpan(
            text: "\$ ${currency.format(price.regular)}",
            style: TextStyle(
              color: kTextColor,
              decoration: TextDecoration.lineThrough,
              fontSize: 13,
            ),
          ),
          WidgetSpan(
            child: Container(
              margin: EdgeInsets.only(left: 5),
              padding: EdgeInsets.symmetric(vertical: 1, horizontal: 3),
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(10),
              ),
              child: IntrinsicWidth(
                child: Text("${value.round()}%", style: TextStyle(color: kTextLightColor)),
              ),
            ),
          ),
          TextSpan(text: "\n"),
        ],
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
              fontSize: 21,
              color: kTextColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}