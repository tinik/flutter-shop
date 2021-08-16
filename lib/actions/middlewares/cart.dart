import 'dart:developer' as developer;

import 'package:redux/redux.dart';
import 'package:shop/actions/actions.dart';
import 'package:shop/actions/state.dart';
import 'package:shop/repository/cart/addConfigurableToCart.dart';
import 'package:shop/repository/cart/create.dart';
import 'package:shop/repository/cart/details.dart';



class CartMiddleware extends MiddlewareClass<AppState> {
  @override
  void call(Store<AppState> store, dynamic action, NextDispatcher next) async {
    if (action is AppLoading && store.state.cart.isEmpty) {
      _loading(store);
    } else if (action is CartConfigurable) {
      final cartId = store.state.cart['cartId'];
      _addConfigurable(store, cartId, action.sku, action.parent, action.quantity);
    }

    next(action);
  }

  void _loading(Store<AppState> store) async {
    try {
      developer.log('Loading - cart initialize');
      final String cartId = (await cartCreate()).toString();

      await store.dispatch(CartId(cartId));

      developer.log('Loading - cart ${cartId}');
      if (cartId.isNotEmpty) {
        _details(store, cartId);
      }
    } catch (err) {
      developer.log(err.toString());
    }
  }

  void _details(Store<AppState> store, String cartId) async {
    try {
      developer.log('Loading - cart details');

      final details = await cartDetails(cartId);
      await store.dispatch(CartDetails(details));
    } catch (err) {
      developer.log(err.toString());
    }
  }

  void _addConfigurable(Store<AppState> store, String cartId, sku, parent, quantity) async {
    try {
      developer.log('Loading - cart configurable');

      await addConfigurableToCart(cartId, parent, sku, quantity);

      _details(store, cartId);
    } catch (err) {
      developer.log(err.toString());
    }
  }
}
