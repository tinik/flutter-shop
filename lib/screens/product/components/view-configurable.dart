import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:shop/actions/actions.dart';
import 'package:shop/actions/state.dart';
import 'package:shop/define.dart';
import 'package:shop/models/entity/Product.dart';
import 'package:shop/models/entity/Product/Configurable/Variants.dart';
import 'package:shop/screens/product/components/counter.dart';
import 'package:shop/screens/product/components/view-variants.dart';
import 'package:shop/ui/price.dart';

class _ConfigurableViewModel {
  final Function addConfigurable;

  _ConfigurableViewModel({
    required this.addConfigurable,
  });

  static _ConfigurableViewModel fromState(Store<AppState> store) => _ConfigurableViewModel(
        // isBusy: cart
        addConfigurable: (sku, parent, quantity) => store.dispatch(CartConfigurable(sku, parent, quantity)),
      );
}

class ViewConfigurable extends StatefulWidget {
  final ProductEntity product;

  ViewConfigurable({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  _ConfigurableState createState() => _ConfigurableState();
}

class _ConfigurableState extends State<ViewConfigurable> {
  Map<String, dynamic> _values = {};
  int quantity = 1;

  var vm;

  get variant {
    final product = widget.product;
    final List<Variant> variants = product.variants;
    if (this._values.isNotEmpty && variants.length > 0) {
      final needle = variants.first.attributes.length;
      for (final row in variants) {
        final found = [];
        for (final attr in row.attributes) {
          final code = attr['code'];
          if (this._values.containsKey(code) && this._values[code].toString() == attr['value_index'].toString()) {
            found.add(1);
          }
        }

        if (found.length == needle) {
          return row.product;
        }
      }
    }

    return null;
  }

  bool get isAvailable {
    final product = this.variant;
    if (product != null) {
      return product.status == 'IN_STOCK';
    }

    return false;
  }

  String get thumbnail {
    final product = this.variant;
    if (product != null) {
      return 'https://jnz3dtiuj77ca.dummycachetest.com/media/catalog/product/' + product.media.first.file;
    }

    return '';
  }

  @override
  Widget build(BuildContext context) {
    final self = this;
    return StoreConnector<AppState, _ConfigurableViewModel>(
      converter: _ConfigurableViewModel.fromState,
      builder: (context, _ConfigurableViewModel vm) {
        self.vm = vm;
        return _viewConfigurable();
      },
    );
  }

  Widget _viewConfigurable() {
    return Container(
      height: MediaQuery.of(context).copyWith().size.height * 0.90,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(kDefaultPadding),
          topRight: Radius.circular(kDefaultPadding),
        ),
      ),
      child: Column(
        children: [
          // Headers
          _createHeader(context),

          this._viewThumbnail(),

          Flexible(
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: kDefaultPadding,
              ),
              child: Column(
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  VariantWidget(
                    product: widget.product,
                    onChangeValues: (values) => setState(() => _values = values),
                  ),
                  _viewCounter(),
                ],
              ),
            ),
          ),

          // Actions
          _createActions(context),
        ],
      ),
    );
  }

  Widget _viewCounter() {
    if (!this.isAvailable) {
      return Container();
    }

    return Container(
      padding: EdgeInsets.only(top: kDefaultPadding * 1.2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              CounterWidget(
                initCount: quantity,
                onChanged: (value) => setState(() => quantity = value),
              ),
            ],
          ),
          Container(
            alignment: Alignment.centerLeft,
            child: WidgetPrice(
              price: variant.price,
            ),
          )
        ],
      ),
    );
  }

  Widget _createHeader(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: kDefaultPadding,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "CHOICE OPTIONS".toUpperCase(),
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
          IconButton(
            padding: EdgeInsets.symmetric(vertical: kDefaultPadding),
            constraints: BoxConstraints(),
            icon: Icon(Icons.close),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }

  Widget _createActions(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: 10,
        bottom: kDefaultPadding * 1.5,
        left: kDefaultPadding,
        right: kDefaultPadding,
      ),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(color: Theme.of(context).dividerColor),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                side: BorderSide.none,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                primary: kPrimaryColor,
                shadowColor: Colors.transparent,
                padding: const EdgeInsets.symmetric(
                  horizontal: kDefaultPadding / 1.5,
                  vertical: kDefaultPadding / 1.5,
                ),
              ),
              child: Text(
                'ADD PRODUCT'.toUpperCase(),
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onPressed: isAvailable ? () => _toCart(context) : null,
            ),
          ),
        ],
      ),
    );
  }

  Widget _viewThumbnail() {
    if (this.thumbnail.isEmpty) {
      return Container();
    }

    return Container(
      width: 245.0,
      height: 245.0,
      alignment: Alignment.center,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: CachedNetworkImage(
          imageUrl: this.thumbnail,
          errorWidget: (context, url, error) => Icon(Icons.error),
        ),
      ),
    );
  }

  void _toCart(context) {
    this.vm.addConfigurable(variant.sku, widget.product.sku, quantity);
    Navigator.pop(context);
  }
}
