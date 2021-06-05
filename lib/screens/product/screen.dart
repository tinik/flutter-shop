import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:shop/actions/actions.dart';
import 'package:shop/actions/state.dart';
import 'package:shop/define.dart';
import 'package:shop/screens/product/components/body.dart';
import 'package:shop/ui/back.dart';
import 'package:shop/ui/cart.dart';
import 'package:shop/ui/search.dart';

class _ProductViewModel {
  final products;
  final Function(int id, String key) fetchProduct;

  _ProductViewModel({
    required this.products,
    required this.fetchProduct,
  });

  static _ProductViewModel fromState(Store<AppState> store) => _ProductViewModel(
        products: store.state.products,
        fetchProduct: (int id, String key) => store.dispatch(ProductFetch(id, key)),
      );
}

class ScreenProduct extends StatelessWidget {
  final int id;
  final String urlKey;

  ScreenProduct({
    Key? key,
    required this.id,
    required this.urlKey,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ProductViewModel>(
      key: Key("product-store-${this.urlKey}"),
      // Events
      onInitialBuild: (vm) {
        final Map collection = vm.products;
        if (!collection.containsKey(urlKey)) {
          vm.fetchProduct(id, urlKey);
        }
      },
      converter: _ProductViewModel.fromState,
      builder: (context, _ProductViewModel vm) {
        return Scaffold(
          primary: true,
          backgroundColor: Color(0xFFF6F6F6),
          appBar: buildAppBar(context),
          body: _createContent(vm),
          persistentFooterButtons: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: kDefaultPadding / 2),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: kPrimaryColor,
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(color: kPrimaryColor),
                      ),
                      child: TextButton.icon(
                        label: Text(
                          "ADD TO CART",
                          style: TextStyle(
                            color: kTextLightColor,
                          ),
                        ),
                        icon: Icon(
                          Icons.shopping_cart,
                          color: kTextLightColor,
                        ),
                        // color: kPrimaryColor,
                        onPressed: () => null,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _createContent(_ProductViewModel vm) {
    final Map collection = vm.products;
    if (!collection.containsKey(urlKey)) {
      return Center(
        child: Container(
          child: Text(
            'Loading...',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      );
    }

    return Body(
      product: collection[urlKey],
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: BackWidget(),
      actions: <Widget>[
        WidgetSearch(),
        WidgetCart(),
      ],
    );
  }
}
