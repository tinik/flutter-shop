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

  final Map<String, dynamic> search;

  final Map<String, dynamic> profile;

  AppState copyWith({
    dynamic cart,
    List<Menu>? navigation,
    Map<int, CategoryEntity>? category,
    Map<String, ProductEntity>? products,
    dynamic storeConfig,
    Map<String, dynamic>? search,
    Map<String, dynamic>? profile,
  }) {
    return AppState(
      storeConfig: storeConfig ?? this.storeConfig,
      //
      cart: cart ?? this.cart,
      //
      navigation: navigation ?? this.navigation,
      category: category ?? this.category,
      products: products ?? this.products,
      search: search ?? this.search,
      // profile
      profile: profile ?? this.profile,
    );
  }

  AppState({
    // Store
    required this.storeConfig,
    // Cart
    required this.cart,
    // Menu
    required this.navigation,
    // Catalog
    required this.category,
    required this.products,
    required this.search,
    // Profile
    required this.profile,
  });
}
