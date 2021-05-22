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
      return state.copyWith(
          category: action.entity,
        );

    case CategoryClean:
      developer.log("runtime::CategoryClean");
      return state.copyWith(
          category: null,
        );

    default:
      return state;
  }
}
