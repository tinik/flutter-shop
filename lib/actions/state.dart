import 'package:flutter/material.dart';
import 'package:shop/models/entity/Category.dart';
import 'package:shop/repository/navigation.dart';

@immutable
class AppState {
  final List<Menu> navigation;
  final CategoryEntity? category;

  AppState({
    required this.navigation,
    required this.category,
  });

  AppState copyWith({
    List<Menu>? navigation,
    CategoryEntity? category,
  }) {
    return AppState(
      navigation: navigation ?? this.navigation,
      category: category ?? this.category,
    );
  }
}

String chooseOldOrNull(String old, String fresh) {
  if (false == fresh.isEmpty) {
    return old;
  } else if (true == fresh.isEmpty) {
    return '';
  }

  return fresh;
}
