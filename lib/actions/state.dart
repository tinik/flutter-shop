import 'package:flutter/material.dart';
import 'package:shop/models/entity/Category.dart';
import 'package:shop/models/entity/Product.dart';
import 'package:shop/repository/navigation.dart';

@immutable
class AppState {
  final dynamic storeConfig;
  final dynamic cart;
  final List<Menu> navigation;
  final Map<int, CategoryEntity> category;
  final Map<String, ProductEntity> products;

  AppState({
    required this.storeConfig,
    required this.cart,
    required this.navigation,
    required this.category,
    required this.products,
  });

  AppState copyWith({
    dynamic cart,
    List<Menu>? navigation,
    Map<int, CategoryEntity>? category,
    Map<String, ProductEntity>? products,
    dynamic storeConfig,
  }) {
    return AppState(
      cart: cart ?? this.cart,
      navigation: navigation ?? this.navigation,
      category: category ?? this.category,
      products: products ?? this.products,
      storeConfig: storeConfig ?? this.storeConfig,
    );
  }
}
