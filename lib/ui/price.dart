import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shop/define.dart';
import 'package:shop/models/entity/Product/Price.dart';

final currency = new NumberFormat("#,##0.00", "en_US");

class WidgetPrice extends StatelessWidget {
  final ProductPrice price;

  const WidgetPrice({
    Key? key,
    required this.price,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => _createPrice(price);

  RichText _createPrice(price) {
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
