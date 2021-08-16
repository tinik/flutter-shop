import 'dart:developer' as developer;

import 'package:shop/actions/actions.dart';
import 'package:shop/actions/state.dart';

AppState reduce(AppState state, dynamic action) {
  switch (action.runtimeType) {
    case NavigationLoading:
      developer.log("runtime::AppLoading");
      return state.copyWith(
          navigation: action.navigation,
        );

    case CategoryValue:
      developer.log("runtime::CategoryDetails");

      final category = state.category;
      category[action.id] = action.entity;
      return state.copyWith(
          category: category,
        );

    case ProductValue:
      developer.log("runtime::ProductValue");

      final products = state.products;
      products[action.data.urlKey] = action.data;

      return state.copyWith(
          products: products,
      );

    case CartId:
      developer.log("runtime::CartId");
      final cart = state.cart;
      cart['cartId'] = action.value;

      return state.copyWith(
        cart: cart,
      );

    case CartDetails:
      developer.log("runtime::CartDetails");
      final cart = state.cart;
      cart['details'] = action.value;

      return state.copyWith(
        cart: cart,
      );

    default:
      return state;
  }
}
