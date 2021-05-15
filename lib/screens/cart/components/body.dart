import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';
import 'package:shop/define.dart';
import 'package:shop/models/Product.dart';
import 'package:shop/screens/product/components/counter.dart';
import 'package:shop/screens/product/screen.dart';

final currency = new NumberFormat("#,##0.00", "en_US");

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Cart",
                style: Theme.of(context).textTheme.headline5!.copyWith(fontWeight: FontWeight.bold),
              ),
              Text(
                "\$ ${currency.format(9999.9999)}",
                style: Theme.of(context).textTheme.headline5!.copyWith(fontWeight: FontWeight.bold),
              )
            ],
          ),
        ),
        Expanded(
          child: Container(
            padding: const EdgeInsets.only(top: kDefaultPadding * 1.5),
            child: CartPage(),
          ),
        ),
      ],
    );
  }
}

class CartPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _CartPageState();
  }
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: products.length,
      itemBuilder: (BuildContext context, int index) {
        final item = products[index];

        return Dismissible(
          key: UniqueKey(),
          direction: DismissDirection.endToStart,
          onDismissed: (DismissDirection direction) {
            print('- Action - apple delete handle -');
          },
          secondaryBackground: Container(
            color: Colors.red,
            child: Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: const EdgeInsets.all(kDefaultPadding),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      'Delete',
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                    Icon(
                      Icons.delete,
                      color: Colors.white,
                      size: 32,
                    ),
                  ],
                ),
              ),
            ),
          ),
          background: Container(),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ScreenProduct(product: item),
                  ),
                ),
                child: Container(
                  height: 128,
                  width: 128,
                  margin: const EdgeInsets.only(
                    left: kDefaultPadding,
                    right: kDefaultPadding,
                    bottom: kDefaultPadding,
                  ),
                  child: Hero(
                    tag: "product-${item.id}",
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.network(item.image),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: kDefaultPadding / 2),
                      child: Text(
                        item.name,
                        style: TextStyle(fontWeight: FontWeight.w500, fontSize: 21),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [CounterWidget(), createPriceContainer(currency, item, context)],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Container createPriceContainer(NumberFormat currency, Product item, BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(right: kDefaultPadding),
      child: RichText(
        textAlign: TextAlign.end,
        text: TextSpan(
          children: [
            TextSpan(
              text: "\$ ${currency.format(item.price)} \n",
              style: TextStyle(
                color: kTextLightColor,
                decoration: TextDecoration.lineThrough,
                fontSize: 14,
              ),
            ),
            TextSpan(
              text: "\$ ${currency.format(item.price)}",
              style: TextStyle(
                fontSize: 18,
                color: kTextColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
