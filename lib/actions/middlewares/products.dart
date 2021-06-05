import 'dart:developer' as developer;

import 'package:redux/redux.dart';
import 'package:shop/actions/actions.dart';
import 'package:shop/actions/state.dart';
import 'package:shop/repository/product.dart';
import 'package:shop/repository/product/configurable.dart';

class ProductsMiddleware extends MiddlewareClass<AppState> {
  @override
  void call(Store<AppState> store, dynamic action, NextDispatcher next) async {
    if (action is ProductFetch) {
      _loading(store, action);
    }

    next(action);
  }

  void _loading(Store<AppState> store, ProductFetch action) async {
    try {
      developer.log('Loading - product');

      final entity = await getProduct(action.key);
      entity.isLoading = true;
      store.dispatch(ProductValue(entity));

      if (entity.typeId == 'configurable') {
        await getConfigurable(entity);
        store.dispatch(ProductValue(entity));
      }

      entity.isLoading = false;
      store.dispatch(ProductValue(entity));
    } on Exception catch (err) {
      developer.log('MiddleWares/Product');
      developer.log(err.toString());
    }
  }
}
