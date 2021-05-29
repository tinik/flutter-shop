import 'dart:developer' as developer;

import 'package:redux/redux.dart';
import 'package:shop/actions/actions.dart';
import 'package:shop/actions/state.dart';
import 'package:shop/repository/product.dart';

class ProductsMiddleware extends MiddlewareClass<AppState> {
  @override
  void call(Store<AppState> store, dynamic action, NextDispatcher next) async {
    if (action is ProductFetch) {
      _loading(store, action.key);
    }

    next(action);
  }

  void _loading(Store<AppState> store, String key) async {
    try {
      developer.log('Loading - product');

      final entity = await getProduct(key);
      store.dispatch(ProductValue(entity));

      if (entity.typeId == 'configurable') {
        // @todo: get configurable details
      }
    } on Exception catch (err) {
      developer.log('MiddleWares/Product');
      developer.log(err.toString());
    }
  }
}
