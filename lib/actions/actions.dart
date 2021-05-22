import 'package:flutter/widgets.dart';
import 'package:meta/meta.dart';
import 'package:shop/models/entity/Category.dart';

@immutable
class AppLoading {}

@immutable
class NavigationLoading {
  final navigation;

  NavigationLoading(this.navigation);
}

@immutable
class CategoryClean {}

@immutable
class CategoryApply {
  final filters;

  CategoryApply(this.filters);
}

@immutable
class CategoryValue {
  final CategoryEntity entity;

  CategoryValue(this.entity);
}

@immutable
class CategoryItems {
  final int page;
  final int size;

  CategoryItems(
    this.page,
    this.size,
  );
}

@immutable
class CategoryFetch {
  final int id;

  CategoryFetch(this.id);
}
