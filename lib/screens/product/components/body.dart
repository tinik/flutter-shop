import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';
import 'package:shop/define.dart';
import 'package:shop/models/Product.dart';
import 'package:shop/screens/product/components/counter.dart';

final currency = new NumberFormat("#,##0.00", "en_US");

class Body extends StatelessWidget {
  final Product product;

  const Body({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double sample = size.height * 0.3;

    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          SizedBox(
            height: size.height,
            child: Stack(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(top: sample),
                  padding: EdgeInsets.only(
                    top: size.height * 0.05,
                    left: kDefaultPadding,
                    right: kDefaultPadding,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.only(bottom: kDefaultPadding),
                        child: Text(
                          "SKU: ${product.sku}",
                          style: TextStyle(color: kTextColor),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.only(bottom: kDefaultPadding),
                        child: Text(
                          product.name,
                          style: Theme.of(context).textTheme.headline4!.copyWith(
                                color: kTextColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                        ),
                      ),
                      VariantWidget(product: this.product),
                      SizedBox(height: kDefaultPadding / 2),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: kDefaultPadding),
                        child: Text(
                          product.description,
                          textAlign: TextAlign.start,
                          style: TextStyle(height: 1.5),
                        ),
                      ),
                      SizedBox(height: kDefaultPadding / 2),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CounterWidget(),
                          Container(
                            child: RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(text: "Price:"),
                                  TextSpan(
                                    text: "\$ ${currency.format(product.price)}",
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline4!
                                        .copyWith(color: kTextColor, fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: kDefaultPadding / 2),
                      CartWidget(product: this.product),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: kDefaultPadding),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 289,
                            child: Hero(
                              tag: "product-${product.id}",
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Image.network(
                                  product.image,
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CartWidget extends StatelessWidget {
  final Product product;

  const CartWidget({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: kDefaultPadding),
      child: Row(
        children: [
          Container(
            margin: EdgeInsets.only(right: kDefaultPadding),
            height: 50,
            width: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: kPrimaryColor),
            ),
            child: IconButton(
              icon: Icon(Icons.shopping_cart),
              color: kPrimaryColor,
              onPressed: () => null,
            ),
          ),
          Expanded(
            child: SizedBox(
              height: 50,
              child: TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: kPrimaryColor,
                ),
                child: Text(
                  "Checkout".toUpperCase(),
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: kTextLightColor,
                  ),
                ),
                onPressed: () => null,
              ),
            ),
          )
        ],
      ),
    );
  }
}

class VariantWidget extends StatelessWidget {
  final Product product;

  const VariantWidget({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Color"),
            Row(children: [
              ColorCase(color: Colors.black),
              ColorCase(color: Colors.blue),
              ColorCase(color: Colors.red),
            ])
          ],
        )),
        Expanded(
          child: RichText(
            text: TextSpan(
              style: TextStyle(color: kTextColor),
              children: [
                TextSpan(text: "Size\n"),
                TextSpan(
                    text: "${product.size.toString()} cm",
                    style: Theme.of(context).textTheme.headline5!.copyWith(fontWeight: FontWeight.bold))
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class ColorCase extends StatelessWidget {
  final Color color;
  final bool isSelected;

  const ColorCase({
    Key? key,
    required this.color,
    this.isSelected = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 24,
      width: 24,
      margin: EdgeInsets.only(top: kDefaultPadding / 4, right: kDefaultPadding / 2),
      padding: EdgeInsets.all(2),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: isSelected ? this.color : Colors.transparent,
        ),
      ),
      child: DecoratedBox(
        decoration: BoxDecoration(color: this.color, shape: BoxShape.circle),
      ),
    );
  }
}
