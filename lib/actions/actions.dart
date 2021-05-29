import 'package:flutter/widgets.dart';
import 'package:meta/meta.dart';
import 'package:shop/helper/enum.dart';
import 'package:shop/models/entity/Category.dart';

@immutable
class AppLoading {}

@immutable
class NavigationLoading {
  final navigation;

  NavigationLoading(this.navigation);
}

@immutable
class ProductFetch {
  final String key;

  ProductFetch(this.key);
}

@immutable
class ProductValue {
  final dynamic data;

  ProductValue(this.data);
}

@immutable
class CategoryApply {
  final int id;
  final filters;

  CategoryApply(this.id, this.filters);
}

@immutable
class CategoryValue {
  final int id;
  final CategoryEntity entity;

  CategoryValue(this.id, this.entity);
}

@immutable
class CategorySorting {
  final int id;
  final String key;
  final SortBy dir;

  CategorySorting(this.id, this.key, this.dir);
}

@immutable
class CategoryItems {
  final int id;
  final int page;
  final int size;

  CategoryItems(this.id, this.page, this.size);
}

@immutable
class CategoryFetch {
  final int id;

  CategoryFetch(this.id);
}
