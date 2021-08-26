import 'package:flutter/widgets.dart';
import 'package:meta/meta.dart';
import 'package:shop/helper/enum.dart';
import 'package:shop/models/entity/Category.dart';

@immutable
class AppLoading {}


@immutable
class CartId {
  final String value;

  CartId(this.value);
}

@immutable
class CartConfigurable {
  final String sku;
  final String parent;
  final int quantity;

  CartConfigurable(this.sku, this.parent, this.quantity);
}

@immutable
class CartDetails {
  final dynamic value;

  CartDetails(this.value);
}

@immutable
class NavigationLoading {
  final navigation;

  NavigationLoading(this.navigation);
}

@immutable
class ProductFetch {
  final int id;
  final String key;

  ProductFetch(this.id, this.key);
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

// Search
@immutable
class SearchFetch {
  final String search;

  SearchFetch(this.search);
}

@immutable
class SearchValue {
  final String search;
  final dynamic data;

  SearchValue(this.search, this.data);
}
