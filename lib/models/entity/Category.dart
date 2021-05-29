import 'package:shop/helper/enum.dart';
import 'package:shop/repository/category.dart';

class CategoryEntity {
  // Required information
  final Category data;

  CategoryEntity(this.data);

  // Category in working process
  bool isBusy = false;

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