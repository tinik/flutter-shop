import 'dart:developer' as developer;

import 'package:redux/redux.dart';
import 'package:shop/actions/actions.dart';
import 'package:shop/actions/state.dart';
import 'package:shop/helper/enum.dart';
import 'package:shop/models/entity/Category.dart';
import 'package:shop/repository/category.dart';
import 'package:shop/repository/category/aggregation.dart';
import 'package:shop/repository/category/products.dart';

__getCategoryBy(id, store) => store.state.category[id];

Map<String, dynamic> __getCurrentFilters(String category, Map<String, dynamic> values) {
  final Map<String, dynamic> apply = {
    "category_id": {"eq": category}
  };

  final Map<String, dynamic> filters = Map.from(values);
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
      _filters(store, action);
    } else if (action is CategoryItems) {
      _product(store, action);
    } else if (action is CategorySorting) {
      _sorting(store, action);
    }

    next(action);
  }

  __query(filters, int page, int size, String sortKey, SortBy sortDir) async {
    return await getProducts(
      filters,
      page,
      size,
      sortKey,
      sortDir == SortBy.ASC ? "ASC" : "DESC",
    );
  }

  __queryWith(CategoryEntity entity, page, size) async {
    final String entityId = entity.data.id.toString();
    final filters = __getCurrentFilters(entityId, entity.filters);

    return await __query(
      filters,
      page,
      size,
      entity.sortKey,
      entity.sortDir,
    );
  }

  void _sorting(store, CategorySorting action) async {
    try {
      final int id = action.id;
      final entity = __getCategoryBy(id, store);
      if (false == (entity is CategoryEntity)) {
        throw Exception("Problems - category is undefined");
      }

      entity.sortKey = action.key;
      entity.sortDir = action.dir;

      final products = await __queryWith(entity, 1, 12);
      entity.page = products['page'];
      entity.count = products['count'];
      entity.items = products['items'];

      store.dispatch(CategoryValue(id, entity));
    } on Exception catch (err) {
      developer.log('MiddleWares/Category');
      developer.log(err.toString());
    }
  }

  void _product(store, CategoryItems action) async {
    try {
      final int id = action.id;
      final entity = __getCategoryBy(id, store);
      if (false == (entity is CategoryEntity)) {
        throw Exception("Problems - category is undefined");
      }

      if (!entity.hasMore) {
        developer.log('Filter - not has more items');
        return;
      }

      final products = await __queryWith(entity, action.page, action.size);
      entity.page = products['page'];
      entity.count = products['count'];
      if (entity.count > entity.items.length) {
        products['items'].forEach((row) => entity.items.add(row));
      }

      await store.dispatch(CategoryValue(id, entity));
    } on Exception catch (err) {
      developer.log('MiddleWares/Category');
      developer.log(err.toString());
    }
  }

  void _filters(Store<AppState> store, CategoryApply action) async {
    final int id = action.id;
    final Map filters = action.filters;

    try {
      developer.log('Filter - category $filters');

      final entity = __getCategoryBy(id, store);
      if (false == (entity is CategoryEntity)) {
        throw Exception("Problems - category is undefined");
      }

      entity!.isLoading = true;

      entity!.filters.clear();
      filters.forEach((key, value) => entity.filters[key] = value);

      await store.dispatch(CategoryValue(id, entity));

      final String entityId = entity.data.id.toString();
      final apply = __getCurrentFilters(entityId, entity.filters);

      final products = await __query(apply, 1, 12, entity.sortKey, entity.sortDir);
      entity.count = products['count'];
      entity.items = products['items'];

      await store.dispatch(CategoryValue(id, entity));
    } on Exception catch (err) {
      developer.log('MiddleWares/Category');
      developer.log(err.toString());
    }

    final entity = store.state.category[id];
    entity!.isLoading = false;

    store.dispatch(CategoryValue(id, entity));
  }

  void _loading(Store<AppState> store, int id) async {
    try {
      developer.log('Loading - root category');
      final data = await getCategory(id);

      final entity = CategoryEntity(data);
      entity.isLoading = false;

      await store.dispatch(CategoryValue(id, entity));

      final products = await __query({
        "category_id": {"eq": id}
      }, 1, 12, entity.sortKey, entity.sortDir);

      entity.page = products['page'];
      entity.count = products['count'];
      entity.items = products['items'];

      await store.dispatch(CategoryValue(id, entity));

      final aggregations = await getAggregations({
        "category_id": {"eq": id}
      });

      entity.aggregations = aggregations;
      await store.dispatch(CategoryValue(id, entity));
    } on Exception catch (err) {
      developer.log('MiddleWares/Category');
      developer.log(err.toString());
    }
  }
}
