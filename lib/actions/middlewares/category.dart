import 'dart:developer' as developer;

import 'package:redux/redux.dart';
import 'package:shop/actions/actions.dart';
import 'package:shop/actions/state.dart';
import 'package:shop/models/entity/Category.dart';
import 'package:shop/repository/category.dart';
import 'package:shop/repository/category/aggregation.dart';
import 'package:shop/repository/category/products.dart';


Map<String, dynamic> __getCurrentFilters(CategoryEntity category) {
  final Map<String, dynamic>apply = {
    "category_id": {
      "eq": category.data.id.toString()
    }
  };

  final Map<String, dynamic>filters = Map.from(category.filters);
  if (filters.isNotEmpty) {
    if (filters.containsKey('price')) {
      final price = filters['price'];
      apply['price'] = {"from": 0, "to": 100};
      filters.remove('price');
    }

    filters.forEach((key, value) => apply[key] = {"in": value});
  }

  return apply;
}

class CategoryMiddleware extends MiddlewareClass<AppState> {
  @override
  void call(Store<AppState> store, dynamic action, NextDispatcher next) async {
    if (action is CategoryFetch) {
      _loading(store, action.id);
    } else if (action is CategoryApply) {
      _filters(store, action.filters);
    } else if (action is CategoryItems) {
      _product(store, action.page, action.size);
    }

    next(action);
  }

  void _product(store, page, size) async {
    try {
      if (false == (store.state.category is CategoryEntity)) {
        throw Exception("Problems - category is undefined");
      }

      developer.log('Filter - product ${page}:${size}');
      final entity = store.state.category;
      if (entity.hasMoreItems) {
        return;
      }

      final apply = __getCurrentFilters(entity);

      final products = await getProducts(apply, page: page, size: size);
      entity.page = products['page'];
      entity.count = products['count'];
      if (entity.count > entity.items.length) {
        products['items'].forEach((row) => entity.items.add(row));
      }

      store.dispatch(CategoryValue(entity));
    } on Exception catch (err) {
      developer.log('MiddleWares/Category');
      developer.log(err.toString());
    }
  }

  void _filters(Store<AppState> store, Map filters) async {
    try {
      developer.log('Filter - category ${filters}');

      if (false == (store.state.category is CategoryEntity)) {
        throw Exception("Problems - category is undefined");
      }

      final entity = store.state.category;

      entity!.isBusy = true;
      store.dispatch(CategoryValue(entity));

      final id = entity.data.id;
      final Map<String, dynamic> apply = {
        "category_id": {"eq": id}
      };

      if (filters.isNotEmpty) {
        if (filters.containsKey('price')) {
          final price = filters['price'];
          apply['price'] = {"from": 0, "to": 100};
          filters.remove('price');
        }

        filters.forEach((key, value) => apply[key] = {"in": value});
      }

      developer.log('Filter - category ${apply}');

      final products = await getProducts(apply, page: 1, size: 12);
      entity.count = products['count'];
      entity.items = products['items'];

      store.dispatch(CategoryValue(entity));
    } on Exception catch (err) {
      developer.log('MiddleWares/Category');
      developer.log(err.toString());
    }

    if (false == (store.state.category is CategoryEntity)) {
      throw Exception("Problems - category is undefined");
    }

    final entity = store.state.category;
    entity!.isBusy = false;
    store.dispatch(CategoryValue(entity));
  }

  void _loading(Store<AppState> store, int id) async {
    try {
      developer.log('Loading - root category');
      final data = await getCategory(id);

      final entity = CategoryEntity(data);
      entity.isBusy = false;

      store.dispatch(CategoryValue(entity));

      final products = await getProducts({
        "category_id": {
          "eq": id,
        }
      }, page: 1, size: 12);

      entity.page = products['page'];
      entity.count = products['count'];
      entity.items = products['items'];

      store.dispatch(CategoryValue(entity));

      final aggregations = await getAggregations({
        "category_id": {
          "eq": id.toString(),
        }
      });

      entity.aggregations = aggregations;
      store.dispatch(CategoryValue(entity));
    } on Exception catch (err) {
      developer.log('MiddleWares/Category');
      developer.log(err.toString());
    }
  }
}
