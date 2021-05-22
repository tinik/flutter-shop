import 'package:shop/repository/category.dart';
import 'package:shop/repository/category/products.dart';

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
  // --- Category Products

  // Category Filters ---
  List aggregations = [];
  Map<String, dynamic> filters = {};
  // --- Category Filters

  get hasMoreItems {
    return count <= items.length;
  }
}