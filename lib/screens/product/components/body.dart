import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:intl/intl.dart';
import 'package:redux/redux.dart';
import 'package:shop/actions/actions.dart';
import 'package:shop/actions/state.dart';
import 'package:shop/define.dart';
import 'package:shop/models/entity/Product.dart';
import 'package:shop/repository/category/products.dart';
import 'package:shop/screens/product/components/view-image.dart';

final currency = new NumberFormat("#,##0.00", "en_US");

class _ProductViewModel {
  final products;

  _ProductViewModel({
    required this.products,
  });

  static _ProductViewModel fromState(Store<AppState> store) => _ProductViewModel(
        products: store.state.products,
      );
}

class Data {
  Map<String, dynamic> _value = {};

  get data {
    if (_value.containsKey('entity') && _value['entity'].runtimeType == ProductEntity) {
      return _value['entity'];
    }

    return _value['cache'];
  }

  set cache(data) => _value['cache'] = data;

  set product(data) => _value['entity'] = data;

  set index(value) => _value['index'] = value;

  get index => _value['index'];

  dynamic get(String key, dynamic value) {
    try {
      return data[key];
    } catch (err) {
      return value;
    }
  }
}

class Body extends StatelessWidget {
  late Data _data;
  var product;

  Body({
    Key? key,
    required this.product,
  }) : super(key: key);

  get data => this._data.data;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double sample = size.height * 0.3;

    this._data = Data();
    this._data.cache = this.product;

    final id = this.data.id;
    final key = this.data.urlKey;

    return StoreConnector<AppState, _ProductViewModel>(
      converter: _ProductViewModel.fromState,
      onInit: (store) => store.dispatch(ProductFetch(key)),
      builder: (context, _ProductViewModel vm) {
        final Map collection = vm.products;
        if (collection.containsKey(id)) {
          this._data.product = collection[id];
        }

        return SingleChildScrollView(
          child: Column(
            children: <Widget>[
              ViewImages(
                media: data.media ?? [],
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
                        data.name,
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
                      ],
                    ),

                    // VariantWidget(product: this._data._value['cache']),
                    ExpandableText(data.description ?? ""),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _createHeader() {
    late Map<String, dynamic> status = {"label": "Out of stock", "color": Colors.redAccent};

    final String stockLabel = data.status!.toString().toUpperCase();
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
              data.sku,
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
    final price = data.price;

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
          ),
        ),
        Expanded(
          child: RichText(
            text: TextSpan(
              style: TextStyle(color: kTextColor),
              children: [
                TextSpan(text: "Size\n"),
                TextSpan(
                  text: "22 cm",
                  style: Theme.of(context).textTheme.headline5!.copyWith(
                        fontWeight: FontWeight.bold,
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

// -------------------------------------------
class ExpandableText extends StatefulWidget {
  ExpandableText(this.text);

  final String text;
  bool isExpanded = false;

  @override
  _ExpandableTextState createState() => new _ExpandableTextState();
}

class _ExpandableTextState extends State<ExpandableText> with TickerProviderStateMixin<ExpandableText> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        new AnimatedSize(
          vsync: this,
          duration: Duration(milliseconds: 350),
          alignment: Alignment.topCenter,
          child: ConstrainedBox(
            constraints: widget.isExpanded ? BoxConstraints() : BoxConstraints(maxHeight: 50),
            child: Html(
              data: widget.text,
              shrinkWrap: true,
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.zero,
          padding: EdgeInsets.zero,
          alignment: Alignment.topRight,
          child: widget.isExpanded
              ? TextButton(
                  child: Text('less'),
                  onPressed: () => setState(() => widget.isExpanded = false),
                )
              : TextButton(
                  child: Text('more'),
                  onPressed: () => setState(() => widget.isExpanded = true),
                ),
        ),
      ],
    );
  }
}