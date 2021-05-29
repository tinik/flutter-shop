import 'dart:developer' as developer;

import 'package:redux/redux.dart';
import 'package:shop/actions/actions.dart';
import 'package:shop/actions/state.dart';
import 'package:shop/repository/navigation.dart';
import 'package:shop/repository/storeConfig.dart';

class AppMiddleware extends MiddlewareClass<AppState> {
  @override
  void call(Store<AppState> store, dynamic action, NextDispatcher next) async {
    if (action is AppLoading) {
      _loading(store);
    }

    next(action);
  }

  void _loading(Store<AppState> store) async {
    try {
      developer.log('Loading - root category');
      // final storeConfig = await getStoreConfig();
      // store.dispatch(AppConfig(storeConfig));

      final navigation = await getNavigation();
      store.dispatch(NavigationLoading(navigation));
    } catch (err) {
      developer.log(err.toString());
    }
  }
}
