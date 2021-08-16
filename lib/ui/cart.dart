import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:shop/actions/state.dart';
import 'package:shop/define.dart';
import 'package:shop/screens/cart/screen.dart';


get(data, String path, any) {
  final tree = path.split(".");

  var value = data;
  for (final prop in tree) {
    if (value != null) {
      value = value[prop];
    } else {
      return any;
    }
  }

  return value;
}

class _CartView {
  final quantity;

  _CartView({required this.quantity});

  static _CartView fromState(Store<AppState> store) => _CartView(
        quantity: get(store.state.cart, 'details.total_quantity', 0).toString(),
      );
}

class WidgetCart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _CartView>(
      converter: _CartView.fromState,
      builder: (context, vm) {
        final quantity = int.parse(vm.quantity);

        return TextButton(
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ScreenCart(),
            ),
          ),
          child: viewShopping(quantity),
        );
      },
    );
  }

  Widget viewShoppingIcon() {
    return Icon(
      Icons.shopping_cart,
      color: kTextColor,
    );
  }

  Widget viewShopping(int quantity) {
    if (quantity == 0) {
      return viewShoppingIcon();
    }

    return Badge(
      badgeContent: Text(
        quantity.toString(),
        style: TextStyle(
          color: Colors.white,
          fontSize: 10,
        ),
        textAlign: TextAlign.center,
      ),
      child: viewShoppingIcon(),
    );
  }
}
