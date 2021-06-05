import 'package:shop/helper/enum.dart';
import 'package:shop/helper/mixins/base.dart';
import 'package:shop/repository/category.dart';

class CategoryEntity with Loading {
  // Required information
  final Category data;
  CategoryEntity(this.data);

  // Category Products ---
  int count = 0;
  List items = [];
  Map<String, dynamic> page = {};

  String sortKey = 'relevance';
  SortBy sortDir = SortBy.DESC;
  // --- Category Products

  // Category Filters ---
  List aggregations = [];
  Map<String, dynamic> filters = {};
  // --- Category Filters

  bool get hasMore {
    final int len = items.length;
    return (count > len);
  }
}