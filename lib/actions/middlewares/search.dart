import 'dart:developer' as developer;

import 'package:redux/redux.dart';
import 'package:shop/actions/actions.dart';
import 'package:shop/actions/state.dart';
import 'package:shop/helper/enum.dart';
import 'package:shop/repository/search/products.dart';

class SearchMiddleware extends MiddlewareClass<AppState> {
  @override
  void call(Store<AppState> store, dynamic action, NextDispatcher next) async {
    if (action is SearchFetch) {
      _loading(store, action.search);
    }

    next(action);
  }

  __query(search, filters, int page, int size, String sortKey, SortBy sortDir) async {
    final sKey = sortKey;
    final sDir = sortDir == SortBy.ASC ? "ASC" : "DESC";

    return await getSearchProducts(search, filters, page, size, sKey, sDir);
  }

  void _loading(Store<AppState> store, String search) async {
    try {
      developer.log('Loading - search $search');
      final products = await __query(search, {}, 1, 12, 'relevance', SortBy.ASC);

      await store.dispatch(SearchValue(search, products));
    } on Exception catch (err) {
      developer.log('MiddleWares/Search');
      developer.log(err.toString());
    }
  }
}
