import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:shop/actions/actions.dart';
import 'package:shop/actions/state.dart';
import 'package:shop/define.dart';
import 'package:shop/repository/category/products.dart';
import 'package:shop/screens/product/components/body.dart';
import 'package:shop/ui/back.dart';
import 'package:shop/ui/cart.dart';
import 'package:shop/ui/search.dart';

class _ProductViewModel {
  final products;

  _ProductViewModel({
    required this.products,
  });

  static _ProductViewModel fromState(Store<AppState> store) => _ProductViewModel(
        products: store.state.products,
      );
}

class ScreenProduct extends StatelessWidget {
  final Product product;

  ScreenProduct({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final id = this.product.id;
    final key = this.product.urlKey;

    return StoreConnector<AppState, _ProductViewModel>(
      converter: _ProductViewModel.fromState,
      onInit: (store) => store.dispatch(ProductFetch(key)),
      builder: (context, _ProductViewModel vm) {
        final Map collection = vm.products;
        if (collection.containsKey(id)) {}

        return Scaffold(
          primary: true,
          backgroundColor: Color(0xFFF6F6F6),
          appBar: buildAppBar(context),
          body: Body(
            product: product,
          ),
          persistentFooterButtons: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: kDefaultPadding / 2),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      IconButton(
                        icon: Icon(
                          Icons.favorite_outlined,
                          color: kPrimaryColor,
                        ),
                        // color: kPrimaryColor,
                        onPressed: () => null,
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.favorite_outline,
                          color: kPrimaryColor,
                        ),
                        // color: kPrimaryColor,
                        onPressed: () => null,
                      ),
                    ],
                  ),
                  Container(
                    width: 150,
                    decoration: BoxDecoration(
                      color: kPrimaryColor,
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(color: kPrimaryColor),
                    ),
                    child: TextButton(
                      child: Icon(
                        Icons.shopping_cart,
                        color: kTextLightColor,
                      ),
                      // color: kPrimaryColor,
                      onPressed: () => null,
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
